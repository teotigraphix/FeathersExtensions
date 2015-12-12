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

public class FunctionStep extends StepCommand
{
    private var _func:Function;
    private var _delay:Number;
    private var _object:Object;

    /**
     * Function can return a result that is set in complete().
     *
     * @param func function foo(data:AbstractResult):void
     * @param object
     * @param delay the delay in milliseconds
     */
    public function FunctionStep(func:Function, object:Object, delay:Number = 10)
    {
        _func = func;
        _object = object;
        _delay = delay;
    }

    override public function execute():*
    {
        var result:* = _func(_object);
        complete(result, _delay);
        return result;
    }
}
}
