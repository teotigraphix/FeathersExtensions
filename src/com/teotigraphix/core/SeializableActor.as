package com.teotigraphix.core
{
import com.teotigraphix.service.ILogger;
import com.teotigraphix.util.ISerialize;

import org.robotlegs.starling.base.EventMap;
import org.robotlegs.starling.core.IEventMap;
import org.robotlegs.starling.core.IInjector;

import starling.events.EventDispatcher;

public class SeializableActor implements ISerialize
{
    [Transient]
    [Inject]
    public var injector:IInjector;
    
    [Transient]
    [Inject]
    public var logger:ILogger;

    private var _eventDispatcher:EventDispatcher;
    private var _eventMap:EventMap;
    
    //----------------------------------
    // eventDispatcher
    //----------------------------------
    
    [Transient]
    [Inject]
    public function get eventDispatcher():EventDispatcher
    {
        return _eventDispatcher;
    }

    public function set eventDispatcher(value:EventDispatcher):void
    {
        _eventDispatcher = value;
        if (_eventDispatcher != null)
        {
            onRegister();
        }   
        else
        {
            onRemove();
        }
    }
    
    //----------------------------------
    // eventMap
    //----------------------------------
    
    protected function get eventMap():IEventMap
    {
        return _eventMap || (_eventMap = new EventMap(eventDispatcher));
    }
    
    //--------------------------------------------------------------------------
    // Constructor
    //--------------------------------------------------------------------------
    
    public function SeializableActor()
    {
    }
    
    //--------------------------------------------------------------------------
    // ISerialize API :: Methods
    //--------------------------------------------------------------------------
    
    public function create():void
    {
    }
    
    public function deserialize(preSleep:Boolean=false):void
    {
    }
    
    public function serialize():void
    {
    }
    
    //--------------------------------------------------------------------------
    // Internal :: Methods
    //--------------------------------------------------------------------------
    
    /**
     * Add context listeners.
     */
    public function onRegister():void
    {
    }
    
    /**
     * Call super to remove mapped events.
     */
    public function onRemove():void
    {
        eventMap.unmapListeners();
    }
    
    /**
     * Dispatch helper method with pooling
     *
     * @param type The <code>Event</code> type to dispatch on the <code>IContext</code>'s <code>EventDispatcher</code>
     * @param bubbles Whether the event bubbles
     * @param data The payload to include with the event
     */
    protected function dispatchWith(type:String, bubbles:Boolean = false, data:Object = null):void
    {
        if (_eventDispatcher != null)
            _eventDispatcher.dispatchEventWith(type, bubbles, data);
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
}
}