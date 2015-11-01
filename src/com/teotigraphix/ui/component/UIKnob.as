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

import feathers.core.FeathersControl;
import feathers.skins.IStyleProvider;

import flash.geom.Point;

import starling.display.DisplayObject;
import starling.display.Sprite;
import starling.events.Event;
import starling.events.Touch;
import starling.events.TouchEvent;
import starling.events.TouchPhase;
import starling.utils.deg2rad;

public class UIKnob extends FeathersControl
{
    public static const EVENT_DOUBLE_TAP:String = "doubleTap";
    public static const EVENT_TOUCH_DOWN_CHANGE:String = "touchDownChange";

    public static const INVALIDATE_FLAG_VALUE:String = "value";

    private static const HELPER_POINT:Point = new Point();

    private static const TOUCH_POINT:Point = new Point();

    public static var globalStyleProvider:IStyleProvider;

    override protected function get defaultStyleProvider():IStyleProvider
    {
        return UIKnob.globalStyleProvider;
    }

    public var backgroundSkin:DisplayObject;
    public var knobThumbSkin:DisplayObject;

    protected var clickOffset:Point;

    private var touchPointID:int = -1;
    private var _value:Number;
    private var _stepSize:Number = 0.01;
    private var _maxValue:Number = 2;
    private var _minValue:Number = 0;

    //----------------------------------
    // Knob logic
    //----------------------------------

    private var originalAngle:Number = 0;
    private var lastAngle:Number = NaN;
    private var currentAngle:Number = NaN;

    private var minimumAngle:Number = 40;

    private var disabled:Boolean = false;

    private var draggingPointer:int = -1;
    private var _sprite:Sprite;

    public function get value():Number
    {
        return _value;
    }

    public function set value(value:Number):void
    {
        if (_value == value)
            return;
        //_value = value;
        setValue(nearestValidValue(value, _stepSize));
        invalidate(INVALIDATE_FLAG_VALUE);
    }

    public function get maxValue():Number
    {
        return _maxValue;
    }

    public function set maxValue(value:Number):void
    {
        _maxValue = value;
    }

    public function get minValue():Number
    {
        return _minValue;
    }

    public function set minValue(value:Number):void
    {
        _minValue = value;
    }

    public function get stepSize():Number
    {
        return _stepSize;
    }

    public function set stepSize(value:Number):void
    {
        _stepSize = value;
    }

    public function UIKnob()
    {
        super();
    }

    override protected function initialize():void
    {
        super.initialize();

        addEventListener(TouchEvent.TOUCH, this_touchHandler);

        invalidate(INVALIDATION_FLAG_SIZE);
    }

    override protected function draw():void
    {
        super.draw();

        if (isInvalid(INVALIDATE_FLAG_VALUE))
        {
            currentAngle = getAngleFromValue(_value);
            //if (isNaN(lastAngle))
            lastAngle = currentAngle;
        }

        var sizeInvalid:Boolean = autoSizeIfNeeded() || isInvalid(INVALIDATION_FLAG_SIZE);

        if (backgroundSkin != null && backgroundSkin.parent == null)
        {
            addChild(backgroundSkin);
            addChild(knobThumbSkin);
        }

        this.autoSizeIfNeeded();

        //trace("actualWidth:" + actualWidth);
        //trace("actualHeight:" + actualHeight);

        if (sizeInvalid)
        {
            backgroundSkin.width = actualWidth;
            backgroundSkin.height = actualWidth;

            knobThumbSkin.scaleX = actualWidth / 60;
            knobThumbSkin.scaleY = actualWidth / 60;

            knobThumbSkin.alignPivot();

            knobThumbSkin.x = actualWidth / 2;
            knobThumbSkin.y = actualWidth / 2;
        }

        knobThumbSkin.rotation = deg2rad(currentAngle);
    }

    public function setValue(value:Number, noEvent:Boolean = false):Boolean
    {
        var oldValue:Number = _value;
        if (value == oldValue)
            return false;

        _value = value;
        //ChangeEvent changeEvent = Pools.obtain(ChangeEvent.class);
        //boolean cancelled = fire(changeEvent);
        var cancelled:Boolean = false;
        if (cancelled)
            _value = oldValue;

        invalidate();

        //// XXX figure out if this affects things and if there is a better way
        //currentAngle = getAngleFromValue(_value);
        //if (isNaN(lastAngle))
        //    lastAngle = currentAngle;

        if (!noEvent)
            dispatchEventWith(Event.CHANGE);

        //Pools.free(changeEvent);
        return !cancelled;
    }

    protected function autoSizeIfNeeded():Boolean
    {
        var needsWidth:Boolean = this.explicitWidth !== this.explicitWidth; //isNaN
        var needsHeight:Boolean = this.explicitHeight !== this.explicitHeight; //isNaN
        if (!needsWidth && !needsHeight)
        {
            return false;
        }
        var newWidth:Number = needsWidth ? 60 : this.explicitWidth;
        var newHeight:Number = newWidth;//needsHeight ? 60 : this.explicitHeight;
        return this.setSizeInternal(newWidth, newHeight, false);
    }

    protected function resetTouchState(touch:Touch = null):void
    {
        this.touchPointID = -1;
        //lastButton = null;
        //this.removeEventListener(Event.ENTER_FRAME, longPress_enterFrameHandler);
        if (this._isEnabled)
        {
            //this.currentState = STATE_UP;
            //trace("STATE_UP " + HELPER_POINT.toString());
        }
        else
        {
            //this.currentState = STATE_DISABLED;
        }
    }

    protected function calculatePositionAndValue(x:Number, y:Number):Boolean
    {
        var p:Point = new Point(x, y);

        var newValue:Number = pointToValue(p.x - clickOffset.x, p.y - clickOffset.y);
        var valueSet:Boolean = setValue(nearestValidValue(newValue, _stepSize));
        invalidate();

        return valueSet;
    }

    protected function pointToValue(x:Number, y:Number):Number
    {
        var delta:Number = x;

        var result:Number;

        currentAngle = originalAngle + delta;

        if (currentAngle < 0)
        {
            if (Math.abs(currentAngle) >= 180 - minimumAngle)
                currentAngle = -(180 - minimumAngle);
        }
        else
        {
            if (currentAngle >= 180 - minimumAngle)
                currentAngle = 180 - minimumAngle;
        }

        // 280 degrees to min/mx
        var spanAngle:Number = 360 - (minimumAngle * 2);
        var spanValue:Number = (currentAngle + spanAngle - 140);

        result = _minValue + (spanValue / spanAngle) * (_maxValue - _minValue);

        return result;
    }

    protected function getAngleFromValue(value:Number):Number
    {
        if (value < _minValue || value > _maxValue)
        {
            throw new Error('Invalid value found when attempting to retrieve angle.');
        }

        var valuePercentage:Number = (value - _minValue) / (_maxValue - _minValue);
        var maxRotation:Number = 360 - (minimumAngle * 2);
        var angleForValue:Number = valuePercentage * maxRotation;
        return angleForValue - 140;
    }

    private function nearestValidValue(value:Number, interval:Number):Number
    {
        if (interval == 0)
            return Math.max(_minValue, Math.min(_maxValue, value));

        var maxValue:Number = _maxValue - _minValue;
        var scale:Number = 1;

        value -= _minValue;

        // If interval isn't an integer, there's a possibility that the floating point
        // approximation of value or value/interval will be slightly larger or smaller
        // than the real value. This can lead to errors in calculations like
        // floor(value/interval)*interval, which one might expect to just equal value,
        // when value is an exact multiple of interval. Not so if value=0.58 and
        // interval=0.01, in that case the calculation yields 0.57! To avoid problems,
        // we scale by the implicit precision of the interval and then round. For
        // example if interval=0.01, then we scale by 100.

        if (interval != Math.round(interval))
        {
            var v:String = 1 + "" + interval;

            var parts:Array = v.split(".");
            scale = Math.pow(10, parts[1].length);
            maxValue *= scale;
            value = Math.round(value * scale);
            interval = Math.round(interval * scale);
        }

        var lower:Number = Math.max(0, Math.floor(value / interval) * interval);
        var upper:Number = Math.min(maxValue, Math.floor((value + interval) / interval) * interval);
        var validValue:Number = ((value - lower) >= ((upper - lower) / 2)) ? upper : lower;

        var rv:Number = (validValue / scale) + _minValue;
        return rv;
    }

    //protected function nearestValidValue(value:Number, interval:Number):Number
    //{
    //    if(isNaN(value))
    //        value = 0;
    //
    //    if (interval == 0)
    //        return Math.max(minimum, Math.min(maximum, value));
    //
    //    var maxValue:Number = maximum - minimum;
    //    var scale:Number = 1;
    //    var offset:Number = minimum; // the offset from 0.
    //
    //    // If interval isn't an integer, there's a possibility that the floating point
    //    // approximation of value or value/interval will be slightly larger or smaller
    //    // than the real value.  This can lead to errors in calculations like
    //    // floor(value/interval)*interval, which one might expect to just equal value,
    //    // when value is an exact multiple of interval.  Not so if value=0.58 and
    //    // interval=0.01, in that case the calculation yields 0.57!  To avoid problems,
    //    // we scale by the implicit precision of the interval and then round.  For
    //    // example if interval=0.01, then we scale by 100.
    //
    //    if (interval != Math.round(interval))
    //    {
    //        // calculate scale and compute new scaled values.
    //        const parts:Array = (new String(1 + interval)).split(".");
    //        scale = Math.pow(10, parts[1].length);
    //        maxValue *= scale;
    //        offset *= scale;
    //        interval = Math.round(interval * scale);
    //        value = Math.round((value * scale) - offset);
    //    }
    //    else
    //    {
    //        value -= offset;
    //    }
    //
    //    var lower:Number = Math.max(0, Math.floor(value / interval) * interval);
    //    var upper:Number = Math.min(maxValue, Math.floor((value + interval) / interval) * interval);
    //    var validValue:Number = ((value - lower) >= ((upper - lower) / 2)) ? upper : lower;
    //
    //    return (validValue + offset) / scale;
    //}

    private function refreshButtonState(point:Point):void
    {
    }

    private function touchUpHandler(touch:Touch):void
    {
        if (touch.id != draggingPointer)
            return;

        draggingPointer = -1;

        lastAngle = currentAngle;

        if (!calculatePositionAndValue(touch.globalX, touch.globalY))
        {
            // Fire an event on touchUp even if the value didn't change,
            // so listeners can see when a drag ends via isDragging.
            //ChangeEvent changeEvent = Pools.obtain(ChangeEvent.class);
            //fire(changeEvent);
            //Pools.free(changeEvent);
        }

        currentAngle = getAngleFromValue(value);

        dispatchEventWith(EVENT_TOUCH_DOWN_CHANGE, true, false);
    }

    private function touchDragHandler(touch:Touch):void
    {
        calculatePositionAndValue(touch.globalX, touch.globalY);
        currentAngle = getAngleFromValue(value);
    }

    private function touchDownHandler(touch:Touch):void
    {
        if (!isEnabled)
            return;

        if (draggingPointer != -1)
            return;

        dispatchEventWith(EVENT_TOUCH_DOWN_CHANGE, true, true);

        //  this.touchPointID = touch.id;
        draggingPointer = touch.id;

        originalAngle = lastAngle;
        clickOffset = new Point(touch.globalX, touch.globalY);
    }

    private function this_touchHandler(event:TouchEvent):void
    {
        if (!isEnabled)
        {
            touchPointID = -1;
            return;
        }

        event.stopImmediatePropagation();

        if (this.touchPointID >= 0)
        {
            var touch:Touch = event.getTouch(this, null, this.touchPointID);
            if (!touch)
            {
                //this should never happen
                return;
            }

            touch.getLocation(this.stage, HELPER_POINT);

            globalToLocal(HELPER_POINT, TOUCH_POINT);

            var isInBounds:Boolean = this.contains(this.stage.hitTest(HELPER_POINT, true));
            if (touch.phase == TouchPhase.MOVED)
            {
                if (isInBounds /*|| this.keepDownStateOnRollOut*/)
                {
                    //this.currentState = STATE_DOWN;
                    //trace("STATE_DOWN MOVED " + TOUCH_POINT.toString());
                    refreshButtonState(TOUCH_POINT);
                }
                else
                {
                    //this.currentState = STATE_UP;
                    //trace("STATE_UP MOVED" + HELPER_POINT.toString());
                }

                touchDragHandler(touch);
            }
            else if (touch.phase == TouchPhase.ENDED)
            {
                this.resetTouchState(touch);
                touchUpHandler(touch);

                //we we dispatched a long press, then triggered and change
                //won't be able to happen until the next touch begins
                //if(!this._hasLongPressed && isInBounds)
                //{
                //    this.trigger();
                //}
            }
            return;
        }
        else
        {
            touch = event.getTouch(this, TouchPhase.BEGAN);

            if (touch)
            {
                if (touch.tapCount == 2)
                {
                    dispatchEventWith(EVENT_DOUBLE_TAP);
                    return;
                }

                touch.getLocation(this.stage, HELPER_POINT);

                globalToLocal(HELPER_POINT, TOUCH_POINT);

                //this.currentState = STATE_DOWN;

                this.touchPointID = touch.id;
                //trace("STATE_DOWN " + HELPER_POINT.toString());
                refreshButtonState(TOUCH_POINT);
                touchDownHandler(touch);

                //if(this._isLongPressEnabled)
                //{
                //    this._touchBeginTime = getTimer();
                //    this._hasLongPressed = false;
                //    this.addEventListener(Event.ENTER_FRAME, longPress_enterFrameHandler);
                //}
                return;
            }
            touch = event.getTouch(this, TouchPhase.HOVER);
            if (touch)
            {
                //this.currentState = STATE_HOVER;
                return;
            }

            //end of hover
            //this.currentState = STATE_UP;
        }

    }
}
}
