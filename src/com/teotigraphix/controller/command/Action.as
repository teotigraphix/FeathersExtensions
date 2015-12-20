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
package com.teotigraphix.controller.command
{

import com.teotigraphix.controller.IAction;

public class Action implements IAction
{
    protected var _id:String;

    protected var _name:String;

    protected var _category:ActionCategory;

    protected var _label:String;

    protected var _func:Function;

    private var _isEnabledProvider:Function;

    public function get id():String
    {
        return _id;
    }

    public function get name():String
    {
        return _name;
    }

    public function get category():ActionCategory
    {
        return _category;
    }

    public function get label():String
    {
        return _label;
    }

    public function get isEnabled():Boolean
    {
        if (_isEnabledProvider == null)
            return true;
        return _isEnabledProvider();
    }

    public function Action(id:String,
                           name:String,
                           category:ActionCategory,
                           label:String,
                           func:Function,
                           isEnabledProvider:Function = null)
    {
        _id = id;
        _name = name;
        _category = category;
        _label = label;
        _func = func;
        _isEnabledProvider = isEnabledProvider;
    }

    public function invoke(data:Object = null):void
    {
        _func(data);
    }

}
}
