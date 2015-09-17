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
package com.teotigraphix.ui.component
{

import feathers.skins.IStyleProvider;

import starling.display.DisplayObject;

public class Led extends SimpleButton
{

    //--------------------------------------------------------------------------
    // Constants
    //--------------------------------------------------------------------------

    public static const STATE_FOCUS:String = "current";
    public static const STATE_LIT:String = "lit";
    public static const STATE_UNLIT:String = "unlit";
    public static const STATE_HIGHLIGHT:String = "highlight";


    public static var globalStyleProvider:IStyleProvider;

    private var _isLit:Boolean;
    private var _isFocus:Boolean;
    private var _isHighlight:Boolean;

    // Skins
    private var _focusedSkin:DisplayObject;
    private var _litSkin:DisplayObject;
    private var _unLitSkin:DisplayObject;
    private var _highlightSkin:DisplayObject;

    override protected function get defaultStyleProvider():IStyleProvider
    {
        return Led.globalStyleProvider;
    }

    override protected function set currentState(value:String):void
    {
        if (value == STATE_FOCUS || value == STATE_LIT || value == STATE_UNLIT || value == STATE_HIGHLIGHT)
        {
            super.currentState = value;
        }
    }

    //--------------------------------------------------------------------------
    // Public :: Properties
    //--------------------------------------------------------------------------

    //----------------------------------
    // isLit
    //----------------------------------

    public function get isLit():Boolean
    {
        return _isLit;
    }

    public function set isLit(value:Boolean):void
    {
        _isLit = value;
        updateState();
    }

    //----------------------------------
    // isFocus
    //----------------------------------

    public function get isFocus():Boolean
    {
        return _isFocus;
    }

    public function set isFocus(value:Boolean):void
    {
        _isFocus = value;
        updateState();
    }

    //----------------------------------
    // isHighlight
    //----------------------------------

    public function get isHighlight():Boolean
    {
        return _isHighlight;
    }

    public function set isHighlight(value:Boolean):void
    {
        _isHighlight = value;
        updateState();
    }

    //----------------------------------
    // focusedSkin
    //----------------------------------

    public function get focusedSkin():DisplayObject
    {
        return _focusedSkin;
    }

    public function set focusedSkin(value:DisplayObject):void
    {
        _focusedSkin = value;
    }

    //----------------------------------
    // litSkin
    //----------------------------------

    public function get litSkin():DisplayObject
    {
        return _litSkin;
    }

    public function set litSkin(value:DisplayObject):void
    {
        _litSkin = value;
    }

    //----------------------------------
    // unLitSkin
    //----------------------------------

    public function get unLitSkin():DisplayObject
    {
        return _unLitSkin;
    }

    public function set unLitSkin(value:DisplayObject):void
    {
        _unLitSkin = value;
    }

    //----------------------------------
    // highlightSkin
    //----------------------------------

    public function get highlightSkin():DisplayObject
    {
        return _highlightSkin;
    }

    public function set highlightSkin(value:DisplayObject):void
    {
        _highlightSkin = value;
    }

    //--------------------------------------------------------------------------
    // Constructor
    //--------------------------------------------------------------------------

    public function Led()
    {
    }

    //--------------------------------------------------------------------------
    // Methods
    //--------------------------------------------------------------------------

    override protected function initialize():void
    {
        super.initialize();
    }

    override protected function draw():void
    {
        super.draw();

        //_border.move(2, 2);
        //_border.setSize(actualWidth - 4, actualHeight - 4);
        //
        //if (isInvalid(INVALIDATE_FLAG_COLOR))
        //{
        //    var color:uint = _isLit ? _litColor : _unlitColor;
        //    if (_isCurrent)
        //        color = _currentColor;
        //    _border.color = color;
        //}
    }

    override protected function skinToStateFunction(button:SimpleButton,
                                                    state:String,
                                                    oldSkin:DisplayObject):DisplayObject
    {
        var skin:DisplayObject;
        switch (state)
        {
            case STATE_FOCUS:
                skin = focusedSkin;
                break;
            case STATE_LIT:
                skin = litSkin;
                break;
            case STATE_UNLIT:
                skin = unLitSkin;
                break;
            case STATE_HIGHLIGHT:
                skin = highlightSkin;
                break;
            //case STATE_DISABLED:
            //    skin = upSkin;
            //    break;
        }
        return skin;
    }

    private function updateState():void
    {
        if (_isHighlight)
        {
            currentState = STATE_HIGHLIGHT;
        }
        else if (_isFocus)
        {
            currentState = STATE_FOCUS;
        }
        else if (_isLit)
        {
            currentState = STATE_LIT;
        }
        else
        {
            currentState = STATE_UNLIT;
        }
    }
}
}
