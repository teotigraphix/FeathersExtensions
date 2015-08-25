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

import feathers.skins.IStyleProvider;

public class GridButton extends UIToggleButton
{
    public static var globalStyleProvider:IStyleProvider;

    private var _data:Object;

    override protected function get defaultStyleProvider():IStyleProvider
    {
        return GridButton.globalStyleProvider;
    }

    public function get data():Object
    {
        return _data;
    }

    public function set data(value:Object):void
    {
        _data = value;
    }

    public function GridButton()
    {
    }

    override protected function initialize():void
    {
        super.initialize();
        isLongPressEnabled = true;
    }
}
}
