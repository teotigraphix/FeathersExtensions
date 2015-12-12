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

import com.teotigraphix.controller.*;
import com.teotigraphix.service.async.IStepSequence;
import com.teotigraphix.service.async.StepSequence;

import org.robotlegs.starling.core.ICommandMap;

public class AbstractCommandLauncher extends AbstractController implements ICommandLauncher
{
    [Inject]
    public var commandMap:ICommandMap;

    public function AbstractCommandLauncher()
    {
    }

    override protected function onRegister():void
    {
        super.onRegister();
    }

    public function execute(commandID:String, data:Object = null):void
    {
        if (data == null)
        {
            //data = {};
        }

        dispatchWith(commandID, false, data);
    }

    public function instantiateSequence(data:Object):IStepSequence
    {
        const sequence:IStepSequence = injector.instantiate(StepSequence);
        sequence.data = data;
        return sequence;
    }

    protected function map(commandClazz:Class):void
    {
        commandMap.mapEvent(commandClazz["ID"], commandClazz);
    }
}
}
