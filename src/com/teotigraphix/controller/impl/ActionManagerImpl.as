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
package com.teotigraphix.controller.impl
{

import com.teotigraphix.controller.IAction;
import com.teotigraphix.controller.IActionManager;
import com.teotigraphix.controller.command.Action;
import com.teotigraphix.controller.command.ActionCategory;

import feathers.controls.List;

import starling.events.Event;

public class ActionManagerImpl extends AbstractController implements IActionManager
{

    private var _categories:Object = {};

    public function ActionManagerImpl()
    {
    }

    override protected function onRegister():void
    {
        super.onRegister();
    }

    public function registerListListener(list:List):void
    {
        list.addEventListener(Event.CHANGE, list_changeHandler);
        list.addEventListener(Event.REMOVED_FROM_STAGE, list_removedFromStageHandler);
    }

    public final function hasActionCategory(categoryID:String):Boolean
    {
        return _categories[categoryID] != null;
    }

    public function findActionCategory(categoryID:String):ActionCategory
    {
        return _categories[categoryID];
    }

    public function getActionCategory(categoryID:String, name:String = null):ActionCategory
    {
        if (hasActionCategory(categoryID))
            return _categories[categoryID];
        var category:ActionCategory = new ActionCategory(categoryID, name);
        _categories[categoryID] = category;
        return category;
    }

    public function invoke(action:IAction):void
    {
        Action(action).invoke();
    }

    private function list_changeHandler(event:Event):void
    {
        const list:List = List(event.target);
        const action:Action = Action(list.selectedItem);
        action.invoke();
    }

    private function list_removedFromStageHandler(event:Event):void
    {
        event.target.addEventListener(Event.CHANGE, list_changeHandler);
        event.target.addEventListener(Event.REMOVED_FROM_STAGE, list_removedFromStageHandler);
    }
}
}
