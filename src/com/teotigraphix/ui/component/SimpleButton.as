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

import com.teotigraphix.ui.component.event.FrameworkEventType;
import com.teotigraphix.ui.theme.AssetMap;

import feathers.core.FeathersControl;
import feathers.core.IToggle;
import feathers.core.IValidating;
import feathers.events.FeathersEventType;
import feathers.skins.IStyleProvider;

import flash.geom.Point;
import flash.utils.getTimer;

import starling.display.DisplayObject;
import starling.events.Event;
import starling.events.Touch;
import starling.events.TouchEvent;
import starling.events.TouchPhase;

[Event(name="touchDown", type="starling.events.Event")]
[Event(name="touchUp", type="starling.events.Event")]

[Event(name="triggered", type="starling.events.Event")]

public class SimpleButton extends FeathersControl implements IToggle
{
    //--------------------------------------------------------------------------
    // Constants
    //--------------------------------------------------------------------------

    public static const STATE_UP:String = "up";
    public static const STATE_DOWN:String = "down";
    public static const STATE_HOVER:String = "hover";
    public static const STATE_DISABLED:String = "disabled";
    private static const HELPER_POINT:Point = new Point();

    public static var globalStyleProvider:IStyleProvider;

    //--------------------------------------------------------------------------
    // Public :: Variables
    //--------------------------------------------------------------------------

    public var upSkin:DisplayObject;
    public var downSkin:DisplayObject;
    public var selectedSkin:DisplayObject;

    //--------------------------------------------------------------------------
    // Private :: Variables
    //--------------------------------------------------------------------------

    protected var currentSkin:DisplayObject;
    protected var _currentState:String = STATE_UP;
    protected var _hasLongPressed:Boolean = false;
    protected var _touchBeginTime:int;
    protected var _longPressDuration:Number = 0.5;
    protected var _isToggle:Boolean = false;
    protected var _originalSkinWidth:Number = NaN;
    protected var _originalSkinHeight:Number = NaN;
    protected var _stateToSkinFunction:Function;
    private var _isLongPressEnabled:Boolean;
    private var _isSelected:Boolean;
    private var _data:Object;
    private var touchPointID:int = -1;

    override protected function get defaultStyleProvider():IStyleProvider
    {
        return SimpleButton.globalStyleProvider;
    }

    //--------------------------------------------------------------------------
    // Public :: Properties
    //--------------------------------------------------------------------------

    //----------------------------------
    // data
    //----------------------------------

    public function get data():Object
    {
        return _data;
    }

    public function set data(value:Object):void
    {
        _data = value;
        invalidate(INVALIDATION_FLAG_DATA);
    }

    //----------------------------------
    // isToggle
    //----------------------------------

    public function get isToggle():Boolean
    {
        return _isToggle;
    }

    public function set isToggle(value:Boolean):void
    {
        _isToggle = value;
    }

    //----------------------------------
    // isSelected
    //----------------------------------

    public function get isSelected():Boolean
    {
        return _isSelected;
    }

    public function set isSelected(value:Boolean):void
    {
        if (_isSelected == value)
        {
            return;
        }
        _isSelected = value;
        invalidate(INVALIDATION_FLAG_SELECTED);
        invalidate(INVALIDATION_FLAG_STATE);
        dispatchEventWith(Event.CHANGE, false, _data);
    }

    //----------------------------------
    // isLongPressEnabled
    //----------------------------------

    public function get isLongPressEnabled():Boolean
    {
        return _isLongPressEnabled;
    }

    public function set isLongPressEnabled(value:Boolean):void
    {
        _isLongPressEnabled = value;
        if (!value)
        {
            removeEventListener(Event.ENTER_FRAME, longPress_enterFrameHandler);
        }
    }

    protected function get currentState():String
    {
        return _currentState;
    }

    protected function set currentState(value:String):void
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

    public function SimpleButton()
    {
    }

    override protected function initialize():void
    {
        addEventListener(TouchEvent.TOUCH, button_touchHandler);
        super.initialize();
        _stateToSkinFunction = skinToStateFunction;

        upSkin = AssetMap.createImage("button-up-skin");
        downSkin = AssetMap.createImage("button-down-skin");
        selectedSkin = AssetMap.createImage("button-selected-up-skin");
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

        if (stylesInvalid || stateInvalid || dataInvalid || sizeInvalid)
        {
            layoutContent();
        }

    }

    public function setIsSelected(value:Boolean):void
    {
        if (_isSelected == value)
        {
            return;
        }
        _isSelected = value;
        invalidate(INVALIDATION_FLAG_SELECTED);
        invalidate(INVALIDATION_FLAG_STATE);
    }

    protected function layoutContent():void
    {

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

    protected function resetTouchState(touch:Touch = null):void
    {
        touchPointID = -1;
        removeEventListener(Event.ENTER_FRAME, longPress_enterFrameHandler);
        if (_isEnabled)
        {
            currentState = STATE_UP;
        }
        else
        {
            currentState = STATE_DISABLED;
        }
    }

    protected function touchDown():void
    {
        dispatchEventWith(FrameworkEventType.TOUCH_DOWN);
    }

    protected function touchUp():void
    {
        dispatchEventWith(FrameworkEventType.TOUCH_UP);
    }

    protected function trigger():void
    {
        dispatchEventWith(Event.TRIGGERED);
        if (_isToggle)
        {
            isSelected = !_isSelected;
        }
    }

    protected function skinToStateFunction(button:SimpleButton, state:String, oldSkin:DisplayObject):DisplayObject
    {
        var skin:DisplayObject;
        switch (state)
        {
            case STATE_UP:
            case STATE_HOVER:
                skin = _isSelected ? selectedSkin : upSkin;
                break;
            case STATE_DOWN:
                skin = downSkin;
                break;
            case STATE_DISABLED:
                skin = upSkin;
                break;
        }
        return skin;
    }

    /**
     * @private
     */
    protected function button_touchHandler(event:TouchEvent):void
    {
        if (!_isEnabled)
        {
            touchPointID = -1;
            return;
        }

        if (touchPointID >= 0)
        {
            var touch:Touch = event.getTouch(this, null, touchPointID);
            if (!touch)
            {
                //this should never happen
                return;
            }

            touch.getLocation(stage, HELPER_POINT);
            var isInBounds:Boolean = contains(stage.hitTest(HELPER_POINT, true));
            if (touch.phase == TouchPhase.MOVED)
            {
                if (isInBounds/* || keepDownStateOnRollOut*/)
                {
                    currentState = STATE_DOWN;
                }
                else
                {
                    currentState = STATE_UP;
                }
            }
            else if (touch.phase == TouchPhase.ENDED)
            {
                resetTouchState(touch);

                // always dispatch a touchUp even if out of bounds
                touchUp();

                //we we dispatched a long press, then triggered and change
                //won't be able to happen until the next touch begins
                if (!_hasLongPressed && isInBounds)
                {
                    trigger();
                }
            }
            return;
        }
        else //if we get here, we don't have a saved touch ID yet
        {
            touch = event.getTouch(this, TouchPhase.BEGAN);
            if (touch)
            {
                currentState = STATE_DOWN;
                touchPointID = touch.id;
                touchDown();
                if (_isLongPressEnabled)
                {
                    _touchBeginTime = getTimer();
                    _hasLongPressed = false;
                    addEventListener(Event.ENTER_FRAME, longPress_enterFrameHandler);
                }
                return;
            }
            touch = event.getTouch(this, TouchPhase.HOVER);
            if (touch)
            {
                currentState = STATE_HOVER;
                return;
            }

            //end of hover
            currentState = STATE_UP;
        }
    }

    protected function longPress_enterFrameHandler(event:Event):void
    {
        var accumulatedTime:Number = (getTimer() - _touchBeginTime) / 1000;
        if (accumulatedTime >= _longPressDuration)
        {
            removeEventListener(Event.ENTER_FRAME, longPress_enterFrameHandler);
            _hasLongPressed = true;
            dispatchEventWith(FeathersEventType.LONG_PRESS);
        }
    }
}
}
