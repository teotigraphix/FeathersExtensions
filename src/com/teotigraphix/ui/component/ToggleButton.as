/**
 * Created by Teoti on 3/29/2015.
 */
package com.teotigraphix.ui.component
{

import feathers.controls.ToggleButton;
import feathers.skins.IStyleProvider;

import starling.events.Event;

public class ToggleButton extends feathers.controls.ToggleButton
{
    public static var globalStyleProvider:IStyleProvider;

    override protected function get defaultStyleProvider():IStyleProvider
    {
        return com.teotigraphix.ui.component.ToggleButton.globalStyleProvider;
    }

    override public function set isSelected(value:Boolean):void
    {
        super.isSelected = value;
    }

    /**
     * Sets the #isSelected property with the option to skip the CHANGE event, noChangeEvent = true.
     *
     * <p>Use this when needing to refresh UI from external model, but do not want to trigger
     * changes to Mediator handlers.</p>
     *
     * @param value Whether selected
     * @param noChangeEvent true, no CHANGE event, false dispatch CHANGE event.
     */
    public function setIsSelected(value:Boolean, noChangeEvent:Boolean = true):void
    {
        if(this._isSelected == value)
        {
            return;
        }
        this._isSelected = value;
        this.invalidate(INVALIDATION_FLAG_SELECTED);
        this.invalidate(INVALIDATION_FLAG_STATE);
        if (!noChangeEvent)
            this.dispatchEventWith(Event.CHANGE);
    }

    public function ToggleButton()
    {
    }
}
}
