////////////////////////////////////////////////////////////////////////////////
// Copyright 2016 Michael Schmalle - Teoti Graphix, LLC
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
package com.teotigraphix.ui.component.renderers
{

import flash.geom.Point;
import flash.utils.getTimer;

import feathers.controls.LayoutGroup;

import starling.events.Event;
import starling.events.Touch;
import starling.events.TouchEvent;
import starling.events.TouchPhase;

public class ItemRendererTouchStrategy
{
    private static const HELPER_POINT:Point = new Point();
    
    public static const STATE_UP:String = "up";
    public static const STATE_DOWN:String = "down";
    public static const STATE_HOVER:String = "hover";
    
    public static const EVENT_DOWN:String = "down";
    public static const EVENT_UP:String = "up";
    public static const EVENT_HOVER:String = "hover";
    public static const EVENT_TRIGGERED:String = "triggered";
    public static const EVENT_LONG_PRESS:String = "longPress";
    
    private var target:LayoutGroup;
    private var _currentState:String;
    
    private var touchPointID:int = -1;
    private var _touchBeginTime:Number;
    private var _hasLongPressed:Boolean;
    
    private var _keepDownStateOnRollOut:Boolean = false;
    private var _isLongPressEnabled:Boolean = false;
    private var _longPressDuration:Number = 0.5;
    
    //----------------------------------
    // keepDownStateOnRollOut
    //----------------------------------
    
    public function get keepDownStateOnRollOut():Boolean
    {
        return _keepDownStateOnRollOut;
    }

    public function set keepDownStateOnRollOut(value:Boolean):void
    {
        _keepDownStateOnRollOut = value;
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
    }
    
    //----------------------------------
    // longPressDuration
    //----------------------------------
    
    public function get longPressDuration():Number
    {
        return _longPressDuration;
    }

    public function set longPressDuration(value:Number):void
    {
        _longPressDuration = value;
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
            return;
        _currentState = value;
        
//        switch(_currentState)
//        {
//            case STATE_UP:
//                target.dispatchEventWith(EVENT_UP, false, target);
//                break;
//                
//            case STATE_DOWN:
//                target.dispatchEventWith(EVENT_DOWN, false, target);
//                break;
//            
//            case STATE_HOVER:
//                target.dispatchEventWith(EVENT_HOVER, false, target);
//                break;
//        }
    }
    
    //--------------------------------------------------------------------------
    // Constructor
    //--------------------------------------------------------------------------
    
    public function ItemRendererTouchStrategy(target:LayoutGroup)
    {
        this.target = target;
        target.addEventListener(TouchEvent.TOUCH, button_touchHandler);
        target.addEventListener(Event.REMOVED_FROM_STAGE, button_removedFromStageHandler);
    }
    
    //--------------------------------------------------------------------------
    // Handlers
    //--------------------------------------------------------------------------
    
    /**
     * @private
     */
    protected function button_removedFromStageHandler(event:Event):void
    {
        resetTouchState();
    }
    
    /**
     * @private
     */
    protected function button_touchHandler(event:TouchEvent):void
    {
        if(!target.isEnabled)
        {
            touchPointID = -1;
            return;
        }
        
        if(touchPointID >= 0)
        {
            var touch:Touch = event.getTouch(target, null, touchPointID);
            if(!touch)
            {
                //this should never happen
                return;
            }
            
            touch.getLocation(target.stage, HELPER_POINT);
            var isInBounds:Boolean = target.contains(target.stage.hitTest(HELPER_POINT));
            if(touch.phase == TouchPhase.MOVED)
            {
                if(isInBounds || _keepDownStateOnRollOut)
                {
                    currentState = STATE_DOWN;
                }
                else
                {
                    currentState = STATE_UP;
                }
            }
            else if(touch.phase == TouchPhase.ENDED)
            {
                resetTouchState(touch);
                //we we dispatched a long press, then triggered and change
                //won't be able to happen until the next touch begins
                if(!_hasLongPressed && isInBounds)
                {
                    trigger(touch);
                }
            }
            return;
        }
        else //if we get here, we don't have a saved touch ID yet
        {
            touch = event.getTouch(target, TouchPhase.BEGAN);
            if(touch)
            {
                currentState = STATE_DOWN;
                target.dispatchEventWith(EVENT_DOWN, false, {touch:touch, target:target});
                touchPointID = touch.id;
                if(_isLongPressEnabled)
                {
                    this._touchBeginTime = getTimer();
                    this._hasLongPressed = false;
                    target.addEventListener(Event.ENTER_FRAME, longPress_enterFrameHandler);
                }
                return;
            }
            // mouseIn
            touch = event.getTouch(target, TouchPhase.HOVER);
            if(touch)
            {
                currentState = STATE_HOVER;
                target.dispatchEventWith(EVENT_HOVER, false, {touch:touch, target:target});
                return;
            }
            
            //end of hover
            currentState = STATE_UP;
        }
    }
    
    protected function trigger(touch:Touch):void
    {
        target.dispatchEventWith(EVENT_TRIGGERED, false, {touch:touch, target:target});
    }
    
    protected function longPress_enterFrameHandler(event:Event):void
    {
        var accumulatedTime:Number = (getTimer() - _touchBeginTime) / 1000;
        if(accumulatedTime >= _longPressDuration)
        {
            target.removeEventListener(Event.ENTER_FRAME, longPress_enterFrameHandler);
            _hasLongPressed = true;
            target.dispatchEventWith(EVENT_LONG_PRESS, false, {touch:null, target:target});
        }
    }
    
    protected function resetTouchState(touch:Touch = null):void
    {
        touchPointID = -1;
        target.removeEventListener(Event.ENTER_FRAME, longPress_enterFrameHandler);
        if(target.isEnabled)
        {
            currentState = STATE_UP;
            target.dispatchEventWith(EVENT_UP, false, {touch:touch, target:target});
        }
        else
        {
            //currentState = STATE_DISABLED;
        }
    }
    
    public function dispose():void
    {
        target.removeEventListener(TouchEvent.TOUCH, button_touchHandler);
        resetTouchState();
        target = null;
    }
}
}