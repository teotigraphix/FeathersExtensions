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
package com.teotigraphix.ui.control._mediators
{

import com.teotigraphix.ui.IScreenLauncher;
import com.teotigraphix.ui.control.*;
import com.teotigraphix.ui.mediator.AbstractMediator;

import starling.events.Event;

public class BackButtonControlMediator extends AbstractMediator
{
    [Inject]
    public var control:BackButtonControl;

    [Inject]
    public var screenLauncher:IScreenLauncher;

    public function BackButtonControlMediator()
    {
    }

    override public function onRegister():void
    {
        super.onRegister();

        addViewListener(Event.TRIGGERED, view_triggeredHandler);
    }

    override public function onRemove():void
    {
        super.onRemove();
    }

    override protected function onOrientationChange(isLandscape:Boolean, isTablet:Boolean):void
    {
        super.onOrientationChange(isLandscape, isTablet);
    }

    private function view_triggeredHandler(event:Event):void
    {
        screenLauncher.back();
    }
}
}
