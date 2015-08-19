/**
 * Created by Teoti on 4/4/2015.
 */
package com.teotigraphix.ui.component
{

import feathers.controls.Slider;
import feathers.events.FeathersEventType;
import feathers.utils.math.clamp;
import feathers.utils.math.roundToNearest;

import flash.geom.Point;

import starling.display.DisplayObject;
import starling.events.Event;
import starling.events.Touch;
import starling.events.TouchEvent;
import starling.events.TouchPhase;

public class UISlider extends Slider
{
    private static const HELPER_POINT:Point = new Point();

    override public function set value(newValue:Number):void
    {
        super.value = newValue;
    }

    public function UISlider()
    {
    }

    public function setValue(newValue:Number):void
    {
        if (this._step != 0 && newValue != this._maximum && newValue != this._minimum)
        {
            newValue = roundToNearest(newValue - this._minimum, this._step) + this._minimum;
        }
        newValue = clamp(newValue, this._minimum, this._maximum);
        if (this._value == newValue)
        {
            return;
        }
        this._value = newValue;
        this.invalidate(INVALIDATION_FLAG_DATA);
    }

    override protected function track_touchHandler(event:TouchEvent):void
    {
        if (!this._isEnabled)
        {
            this._touchPointID = -1;
            return;
        }

        var track:DisplayObject = DisplayObject(event.currentTarget);
        if (this._touchPointID >= 0)
        {
            var touch:Touch = event.getTouch(track, null, this._touchPointID);
            if (!touch)
            {
                return;
            }
            if (/*!this._showThumb && */touch.phase == TouchPhase.MOVED)
            {
                touch.getLocation(this, HELPER_POINT);
                this.value = this.locationToValue(HELPER_POINT);
            }
            else if (touch.phase == TouchPhase.ENDED)
            {
                if (this._repeatTimer)
                {
                    this._repeatTimer.stop();
                }
                this._touchPointID = -1;
                this.isDragging = false;
                if (!this.liveDragging)
                {
                    this.dispatchEventWith(Event.CHANGE);
                }
                this.dispatchEventWith(FeathersEventType.END_INTERACTION);
            }
        }
        else
        {
            touch = event.getTouch(track, TouchPhase.BEGAN);
            if (!touch)
            {
                return;
            }
            touch.getLocation(this, HELPER_POINT);
            this._touchPointID = touch.id;
            if (this._direction == DIRECTION_VERTICAL)
            {
                this._thumbStartX = HELPER_POINT.x;
                this._thumbStartY = Math.min(this.actualHeight - this.thumb.height,
                                             Math.max(0, HELPER_POINT.y - this.thumb.height / 2));
            }
            else //horizontal
            {
                this._thumbStartX = Math.min(this.actualWidth - this.thumb.width,
                                             Math.max(0, HELPER_POINT.x - this.thumb.width / 2));
                this._thumbStartY = HELPER_POINT.y;
            }
            this._touchStartX = HELPER_POINT.x;
            this._touchStartY = HELPER_POINT.y;
            this._touchValue = this.locationToValue(HELPER_POINT);
            this.isDragging = true;
            this.dispatchEventWith(FeathersEventType.BEGIN_INTERACTION);
            if (this._showThumb && this._trackInteractionMode == TRACK_INTERACTION_MODE_BY_PAGE)
            {
                this.adjustPage();
                this.startRepeatTimer(this.adjustPage);
            }
            else
            {
                this.value = this._touchValue;
            }
        }
    }

}
}
