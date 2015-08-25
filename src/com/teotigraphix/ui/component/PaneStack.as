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

import feathers.controls.LayoutGroup;

public class PaneStack extends LayoutGroup
{
    public static const INVALIDATE_FLAG_SELECTED_INDEX:String = "selectedIndex";

    private var _selectedIndex:int = -1;

    public function get selectedIndex():int
    {
        return _selectedIndex;
    }

    public function set selectedIndex(value:int):void
    {
        if (_selectedIndex == value)
            return;
        _selectedIndex = value;
        invalidate(INVALIDATE_FLAG_SELECTED_INDEX);
    }

    public function PaneStack()
    {
    }

    override protected function initialize():void
    {
        super.initialize();
    }

    override protected function draw():void
    {
        super.draw();

        if (isInvalid(INVALIDATE_FLAG_SELECTED_INDEX))
        {
            for (var i:int = 0; i < numChildren; i++)
            {
                getChildAt(i).visible = false;
            }

            if (_selectedIndex != -1)
            {
                getChildAt(_selectedIndex).visible = true;
            }
        }
    }
}
}
