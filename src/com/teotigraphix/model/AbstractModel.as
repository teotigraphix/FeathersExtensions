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

package com.teotigraphix.model
{

import com.teotigraphix.service.ILogger;

import flash.events.Event;
import flash.events.IEventDispatcher;

import org.robotlegs.starling.core.IInjector;
import org.robotlegs.starling.mvcs.Actor;

import starling.events.EventDispatcher;

public class AbstractModel extends Actor
{
    [Inject]
    public var logger:ILogger;

    private var _injector:IInjector;

    //--------------------------------------------------------------------------
    // Properties
    //--------------------------------------------------------------------------
    
    //----------------------------------
    // injector
    //----------------------------------
    
    [Inject]
    public function get injector():IInjector
    {
        return _injector;
    }

    public function set injector(value:IInjector):void
    {
        _injector = value;
        onInject();
    }
    
    //----------------------------------
    // flashDispatcher
    //----------------------------------
    
    public function get flashDispatcher():IEventDispatcher 
    {
        return injector.getInstance(IEventDispatcher);
    }
    
    //----------------------------------
    // flashDispatcher
    //----------------------------------
    
    [Inject]
    override public function set eventDispatcher(value:EventDispatcher):void
    {
        super.eventDispatcher = value;
        onRegister();
    }

    override protected function dispatchWith(type:String, bubbles:Boolean = false, data:Object = null):void
    {
        super.dispatchWith(type, bubbles, data);
        if (injector.hasMapping(IEventDispatcher))
        {
            flashDispatcher.dispatchEvent(new Event(type, bubbles));
        }
    }
    
    /**
     * Create non circular injects with injector.
     */
    protected function onInject():void
    {
    }

    /**
     * Register context events with the #eventMap.
     */
    protected function onRegister():void
    {
    }
    
    /**
     * Called right after the last step runs in the ApplicationStartupCommand.
     * 
     * All actors that need to initialize once per app session, can do the initialization here. 
     */
    public function onStartup():void
    {
    }
}
}
