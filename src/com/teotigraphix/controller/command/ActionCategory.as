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

import feathers.data.ListCollection;

public class ActionCategory
{
    private var _id:String;

    private var _name:String;

    private var _actions:Vector.<IAction> = new <IAction>[];

    public function get id():String
    {
        return _id;
    }

    public function get name():String
    {
        return _name;
    }

    public function get actions():Vector.<IAction>
    {
        return _actions;
    }

    public function ActionCategory(id:String, name:String)
    {
        _id = id;
        _name = name;
    }

    public function clear():void
    {
        _actions = new <IAction>[];
    }

    public function addAction(id:String, label:String, func:Function, isEnabledFunction:Function = null):IAction
    {
        var action:IAction = new Action(id, null, this, label, func, isEnabledFunction);
        actions.push(action);
        return action;
    }

    public function findAction(actionID:String):IAction
    {
        for each (var action:IAction in _actions)
        {
            if (action.id == actionID)
                return action;
        }
        return null;
    }

    public function toDataProvider():ListCollection
    {
        return new ListCollection(actions);
    }

}
}
