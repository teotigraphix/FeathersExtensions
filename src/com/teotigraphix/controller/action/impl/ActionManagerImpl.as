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
package com.teotigraphix.controller.action.impl
{

import com.teotigraphix.controller.action.IAction;
import com.teotigraphix.controller.action.IActionID;
import com.teotigraphix.controller.action.IActionManager;
import com.teotigraphix.controller.action.core.Action;
import com.teotigraphix.controller.action.core.ActionCategory;
import com.teotigraphix.controller.core.AbstractController;

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

    public function findAction(categoryID:String, actionID:String):IAction
    {
        return findActionCategory(categoryID).findAction(actionID);
    }

    public function findActionByID(actionID:IActionID):IAction
    {
        return findActionCategory(actionID.category).findAction(actionID.id);
    }

    public function invoke(action:IAction, data:Object = null):void
    {
        Action(action).invoke(data);
    }

    public function fire(actionID:IActionID, data:Object = null):void
    {
        invoke(findActionCategory(actionID.category).findAction(actionID.id), data);
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
