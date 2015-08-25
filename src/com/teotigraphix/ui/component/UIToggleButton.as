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

import feathers.controls.ToggleButton;
import feathers.skins.IStyleProvider;

import starling.events.Event;

public class UIToggleButton extends ToggleButton
{
    public static var globalStyleProvider:IStyleProvider;

    override protected function get defaultStyleProvider():IStyleProvider
    {
        return UIToggleButton.globalStyleProvider;
    }

    public function UIToggleButton()
    {
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
        if (this._isSelected == value)
        {
            return;
        }
        this._isSelected = value;
        this.invalidate(INVALIDATION_FLAG_SELECTED);
        this.invalidate(INVALIDATION_FLAG_STATE);
        if (!noChangeEvent)
            this.dispatchEventWith(Event.CHANGE);
    }
}
}
