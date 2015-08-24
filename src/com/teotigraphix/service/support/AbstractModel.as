/**
 * Created by Teoti on 3/19/2015.
 */
package com.teotigraphix.service.support
{

import com.teotigraphix.service.ILogger;

import org.robotlegs.starling.core.IInjector;
import org.robotlegs.starling.mvcs.Actor;

import starling.events.EventDispatcher;

public class AbstractModel extends Actor
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

    /**
     * App specific ApplicationController must call this method.
     * @param project
     */
    //public function onProjectChange(project:Project):void
    //{
    //}

    /**
     * Register context events with the #eventMap.
     */
    protected function onRegister():void
    {
    }
}
}
