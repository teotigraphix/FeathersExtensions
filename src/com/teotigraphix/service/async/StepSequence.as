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

package com.teotigraphix.service.async
{

import org.as3commons.async.command.CompositeCommandKind;
import org.as3commons.async.command.ICommand;
import org.as3commons.async.command.ICompositeCommand;
import org.as3commons.async.command.impl.CompositeCommand;
import org.robotlegs.starling.core.IInjector;

public class StepSequence extends CompositeCommand implements IStepSequence, IStepCommand
{
    [Inject]
    public var injector:IInjector;
    
    private var _data:Object;
    
    public function get data():Object
    {
        return _data;
    }
    
    public function set data(value:Object):void
    {
        _data = value;
        result = _data;
    }
    
    public function StepSequence(data:Object = null)
    {
        super(CompositeCommandKind.SEQUENCE);
        this.data = data;
    }
    
    override public function addCommand(command:ICommand):ICompositeCommand
    {
        super.addCommand(command);
        if (command is IStepCommand && !(command is StepSequence))
        {
            IStepCommand(command).data = _data;
        }
        return this;
    }
    
    public function add(clazzOrCommand:*):IStepSequence
    {
        if (clazzOrCommand is Class)
        {
            addCommand(injector.instantiate(clazzOrCommand));
        }
        else
        {
            addCommand(clazzOrCommand);
        }
        return this;
    }
    
    
    
    public function addStep(clazz:Class):IStepSequence
    {
        addCommand(injector.instantiate(clazz));
        return this;
    }
    
    public function commit():*
    {
        for each (var command:ICommand in commands)
        {
            IStepCommand(command).commit();
        }
        
        return result;
    }
    
    protected function super_addCommand(command:ICommand):ICompositeCommand
    {
        return super.addCommand(command);
    }
    
    //
    
    public static function sequence(injector:IInjector, 
                                    data:Object,
                                    completeHandler:Function = null,
                                    cancelHandler:Function = null):IStepSequence
    {
        
        injector.injectInto(data);
        
        const sequence:IStepSequence = injector.instantiate(StepSequence);
        sequence.data = data;
        
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
