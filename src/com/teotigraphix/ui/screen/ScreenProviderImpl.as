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
package com.teotigraphix.ui.screen
{

import com.teotigraphix.ui.IScreenProvider;

public class ScreenProviderImpl implements IScreenProvider
{
    //--------------------------------------------------------------------------
    // Variables
    //--------------------------------------------------------------------------

    private var _data:*;
    private var _dataMap:Array = [];

    //--------------------------------------------------------------------------
    // API :: Properties
    //--------------------------------------------------------------------------

    //----------------------------------
    // data
    //----------------------------------

    /**
     * @inheritDoc
     */
    public function get data():*
    {
        return _data;
    }

    public function set data(value:*):void
    {
        _data = value;
    }

    //--------------------------------------------------------------------------
    // Constructor
    //--------------------------------------------------------------------------

    public function ScreenProviderImpl()
    {
    }

    //--------------------------------------------------------------------------
    // API :: Methods
    //--------------------------------------------------------------------------

    /**
     * @inheritDoc
     */
    public function push(data:*):void
    {
        _dataMap.push(data);
        _data = data;
    }

    /**
     * @inheritDoc
     */
    public function pop():void
    {
        _dataMap.pop();
        _data = _dataMap[_dataMap.length - 1];
    }
}
}
