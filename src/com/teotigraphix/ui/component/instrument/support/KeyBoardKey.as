////////////////////////////////////////////////////////////////////////////////
// Copyright 2015 Michael Schmalle - Teoti Graphix, LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License
//
// Author: Michael Schmalle, Principal Architect
// mschmalle at teotigraphix dot com
////////////////////////////////////////////////////////////////////////////////

package com.teotigraphix.ui.component.instrument.support
{

import feathers.controls.Label;
import feathers.core.FeathersControl;
import feathers.core.IValidating;
import feathers.skins.IStyleProvider;

import starling.display.DisplayObject;

public class KeyBoardKey extends FeathersControl
{
    public static const STATE_UP:String = "up";
    public static const STATE_DOWN:String = "down";
    public static const STATE_HOVER:String = "hover";
    public static const STATE_DISABLED:String = "disabled";

    public static var globalStyleProvider:IStyleProvider;

    public var upSkin:DisplayObject;
    public var downSkin:DisplayObject;
    public var disabledSkin:DisplayObject;
    //public var selectedSkin:DisplayObject;

    protected var currentSkin:DisplayObject;
    protected var _currentState:String = STATE_UP;
    protected var _originalSkinWidth:Number = NaN;
    protected var _originalSkinHeight:Number = NaN;
    protected var _stateToSkinFunction:Function;

    private var _data:KeyBoarKeyData;
    private var _isFlat:Boolean;
    private var _textRenderer:Label;

    override protected function get defaultStyleProvider():IStyleProvider
    {
        return KeyBoardKey.globalStyleProvider;
    }

    //----------------------------------
    // data
    //----------------------------------

    public function get data():KeyBoarKeyData
    {
        return _data;
    }

    public function set data(value:KeyBoarKeyData):void
    {
        _data = value;

        currentState = _data == null ? STATE_DISABLED : STATE_UP;

        invalidate(INVALIDATION_FLAG_DATA);
        invalidate(INVALIDATION_FLAG_SIZE);
    }

    //----------------------------------
    // isFlat
    //----------------------------------

    public function get isFlat():Boolean
    {
        return _isFlat;
    }

    public function set isFlat(value:Boolean):void
    {
        _isFlat = value;
    }

    //----------------------------------
    // currentState
    //----------------------------------

    public function get currentState():String
    {
        return _currentState;
    }

    public function set currentState(value:String):void
    {
        if (_currentState == value)
        {
            return;
        }
        //if(stateNames.indexOf(value) < 0)
        //{
        //    throw new ArgumentError("Invalid state: " + value + ".");
        //}
        _currentState = value;
        invalidate(INVALIDATION_FLAG_STATE);
    }

    public function KeyBoardKey()
    {
    }

    override protected function initialize():void
    {
        super.initialize();
        _stateToSkinFunction = skinToStateFunction;
    }

    override protected function draw():void
    {
        super.draw();

        var dataInvalid:Boolean = isInvalid(INVALIDATION_FLAG_DATA);
        var stylesInvalid:Boolean = isInvalid(INVALIDATION_FLAG_STYLES);
        var sizeInvalid:Boolean = isInvalid(INVALIDATION_FLAG_SIZE);
        var stateInvalid:Boolean = isInvalid(INVALIDATION_FLAG_STATE);

        if (stylesInvalid || stateInvalid)
        {
            refreshSkin();
            //refreshIcon();
        }

        if (stylesInvalid || stateInvalid || sizeInvalid)
        {
            scaleSkin();
        }

        if (isInvalid(INVALIDATION_FLAG_DATA))
        {
            _textRenderer.visible = _data != null;
            if (_data != null)
            {
                _textRenderer.text = _data.name;
            }
            else
            {
                _textRenderer.text = "";
            }
        }

        if (stylesInvalid || stateInvalid || dataInvalid || sizeInvalid)
        {
            layoutContent();
        }
    }

    protected function layoutContent():void
    {
        if (_textRenderer != null)
        {
            _textRenderer.validate();
            _textRenderer.move((actualWidth - _textRenderer.width) / 2,
                               actualHeight - _textRenderer.height - 15);
        }
    }

    protected function skinToStateFunction(button:KeyBoardKey, state:String, oldSkin:DisplayObject):DisplayObject
    {
        var skin:DisplayObject;
        switch (state)
        {
            case STATE_UP:
            case STATE_HOVER:
                //skin = _isSelected ? selectedSkin : upSkin;
                skin = upSkin;
                break;
            case STATE_DOWN:
                skin = downSkin;
                break;
            case STATE_DISABLED:
                skin = disabledSkin;
                break;
        }
        return skin;
    }

    protected function refreshSkin():void
    {
        var oldSkin:DisplayObject = currentSkin;
        //if(_stateToSkinFunction != null)
        //{
        //    currentSkin = DisplayObject(_stateToSkinFunction(this, _currentState, oldSkin));
        //}
        //else
        //{
        //    currentSkin = DisplayObject(_skinSelector.updateValue(this, _currentState,
        // currentSkin)); }
        currentSkin = DisplayObject(_stateToSkinFunction(this, _currentState, oldSkin));
        if (currentSkin != oldSkin)
        {
            if (oldSkin)
            {
                removeChild(oldSkin, false);
            }
            if (currentSkin)
            {
                addChildAt(currentSkin, 0);
            }
        }
        if (currentSkin &&
                (_originalSkinWidth !== _originalSkinWidth || //isNaN
                _originalSkinHeight !== _originalSkinHeight))
        {
            if (currentSkin is IValidating)
            {
                IValidating(currentSkin).validate();
            }
            _originalSkinWidth = currentSkin.width;
            _originalSkinHeight = currentSkin.height;
        }

        if (_textRenderer == null)
        {
            _textRenderer = new Label();
            _textRenderer.styleNameList.add("key-label-" + (isFlat ? "black" : "white"));
            addChild(_textRenderer);
        }

        setChildIndex(_textRenderer, numChildren - 1);
    }

    protected function scaleSkin():void
    {
        if (!currentSkin)
        {
            return;
        }
        currentSkin.x = 0;
        currentSkin.y = 0;
        if (currentSkin.width != actualWidth)
        {
            currentSkin.width = actualWidth;
        }
        if (currentSkin.height != actualHeight)
        {
            currentSkin.height = actualHeight;
        }
        if (currentSkin is IValidating)
        {
            IValidating(currentSkin).validate();
        }
    }
}
}
