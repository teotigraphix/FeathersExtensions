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

package com.teotigraphix.controller.core
{

import com.teotigraphix.service.ILogger;

import org.robotlegs.starling.core.IInjector;
import org.robotlegs.starling.mvcs.Actor;

import starling.events.EventDispatcher;

public class AbstractController extends Actor
{
    [Inject]
    public var logger:ILogger;
    
    [Inject]
    public var injector:IInjector;
    
    [Inject]
    override public function set eventDispatcher(value:EventDispatcher):void
    {
        super.eventDispatcher = value;
        onRegister();
    }
    
    public function AbstractController()
    {
    }
    
    /**
     * Removes a listener from the eventMap.
     *
     * @param type The event type.
     * @param listener The event listener Function.
     */
    protected function addContextListener(type:String, listener:Function):void
    {
        eventMap.mapListener(eventDispatcher, type, listener);
    }
    
    /**
     * Adds a listener to the eventMap.
     *
     * @param type The event type.
     * @param listener The event listener Function.
     */
    protected function removeContextListener(type:String, listener:Function):void
    {
        eventMap.unmapListener(eventDispatcher, type, listener);
    }
    
    /**
     * Register context events with the #eventMap.
     *
     * Called when the eventDispatcher is injected on this controller.
     */
    protected function onRegister():void
    {
    }
    
    /**
     * Called at the end of the startup sequence, create racks, model data providers
     * or restore from fully loaded project state.
     */
    public function onStartup():void
    {
        
    }
}
}
