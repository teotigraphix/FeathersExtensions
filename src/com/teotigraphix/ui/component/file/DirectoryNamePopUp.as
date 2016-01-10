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
package com.teotigraphix.ui.component.file
{

import com.teotigraphix.ui.popup.NamePopUp;

import starling.events.Event;

public class DirectoryNamePopUp extends NamePopUp
{

    public function DirectoryNamePopUp()
    {
    }

    override protected function buttonGroup_triggeredHandler(event:Event, data:Object):void
    {
        super.buttonGroup_triggeredHandler(event, data);
    }

}
}
