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

package com.teotigraphix.app.ui
{

import feathers.controls.StackScreenNavigator;
import feathers.events.FeathersEventType;

import starling.events.Event;

public class BootstrapNavigator extends StackScreenNavigator implements IBootstrapNavigator
{
    public function BootstrapNavigator()
    {
        addEventListener(FeathersEventType.INITIALIZE, this_initializeHandler);
        addEventListener(FeathersEventType.CREATION_COMPLETE, this_creationCompleteHandler);
        addEventListener(Event.ADDED_TO_STAGE, this_addedToStageHandler);
        addEventListener(Event.REMOVED_FROM_STAGE, this_removedToStageHandler);
    }

    private function this_initializeHandler(event:Event):void
    {
        trace("BootstrapNavigator.INITIALIZE()");
    }

    private function this_creationCompleteHandler(event:Event):void
    {
        trace("BootstrapNavigator.CREATION_COMPLETE()");
    }

    private function this_addedToStageHandler(event:Event):void
    {
        trace("BootstrapNavigator.ADDED_TO_STAGE()");
    }

    private function this_removedToStageHandler(event:Event):void
    {
        trace("BootstrapNavigator.REMOVED_FROM_STAGE()");
    }
}
}
