package com.teotigraphix.model
{

import com.teotigraphix.service.async.IStepSequence;

public interface ISaveStrategy
{
    function get isDirty():Boolean;
    
    function get dirtyEvents():Vector.<String>;
    
    function set dirtyEvents(value:Vector.<String>):void;
    
    /**
     * Resets the isDirty flag without an event. 
     */
    function resetDirty():void;
    
    function saveAsync():IStepSequence;
    
    function saveQuick():void;
}
}