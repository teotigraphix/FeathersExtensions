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

import com.teotigraphix.controller.ICommandLauncher;
import com.teotigraphix.controller.impl.AbstractCommandLauncher;
import com.teotigraphix.service.ILogger;
import com.teotigraphix.service.async.IStepSequence;
import com.teotigraphix.service.async.StepSequence;

import org.robotlegs.starling.mvcs.Command;

import starling.events.Event;

public class AbstractCommand extends Command
{
    [Inject]
    public var event:Event;

    [Inject]
    public var commands:ICommandLauncher;

    [Inject]
    public var logger:ILogger;

    override public function execute():void
    {
    }

    /**
     *
     * @param data Can contain injections.
     * @return
     */
    protected final function sequence(data:Object,
                                      completeHandler:Function = null,
                                      cancelHandler:Function = null):IStepSequence
    {

        injector.injectInto(data);
        var sequence:IStepSequence = AbstractCommandLauncher(commands).instantiateSequence(data);
        if (completeHandler != null)
            sequence.addCompleteListener(completeHandler);
        if (cancelHandler != null)
        {
            StepSequence(sequence).failOnFault = true;
            //StepSequence(sequence).addCancelListener(completeHandler);
        }

        return sequence;
    }
}
}
