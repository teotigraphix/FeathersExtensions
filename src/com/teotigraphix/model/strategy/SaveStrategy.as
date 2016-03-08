package com.teotigraphix.model.strategy
{
import com.teotigraphix.app.event.ApplicationEventType;
import com.teotigraphix.frameworks.project.IProjectPreferencesProvider;
import com.teotigraphix.model.IProjectModel;
import com.teotigraphix.model.ISaveStrategy;
import com.teotigraphix.model.event.CoreModelEventType;
import com.teotigraphix.service.ILogger;
import com.teotigraphix.service.IProjectService;
import com.teotigraphix.service.async.IStepSequence;

import org.as3commons.async.operation.event.OperationEvent;
import org.robotlegs.starling.mvcs.Actor;

import starling.events.Event;

public class SaveStrategy extends Actor implements ISaveStrategy
{
    public static const TAG:String = "SaveStrategy";
    
    [Inject]
    public var logger:ILogger;
    
    [Inject]
    public var projectPreferencesProvider:IProjectPreferencesProvider;
    
    [Inject]
    public var projectService:IProjectService;
        
    [Inject]
    public var projectModel:IProjectModel;
    
    private var _isDirty:Boolean;
    private var _dirtyEvents:Vector.<String>;

    //--------------------------------------------------------------------------
    // API :: Properties
    //--------------------------------------------------------------------------
    
    //----------------------------------
    // isDirty
    //----------------------------------
    
    public function get isDirty():Boolean
    {
        return _isDirty;
    }
    
    public function set isDirty(value:Boolean):void
    {
        if (_isDirty == value)
            return;
        _isDirty = value;
        dispatchWith(CoreModelEventType.IS_DIRTY_CHANGE, false, _isDirty);
    }
    
    //----------------------------------
    // dirtyEvents
    //----------------------------------
    
    public function get dirtyEvents():Vector.<String>
    {
        return _dirtyEvents;
    }
    
    public function set dirtyEvents(value:Vector.<String>):void
    {
        if (_dirtyEvents == value)
            return;
        _dirtyEvents = value;
        
        for each (var eventName:String in _dirtyEvents) 
        {
            eventMap.mapListener(eventDispatcher, eventName, context_dirtyEventHandler);
        }
    }
    
    //--------------------------------------------------------------------------
    // Constructor
    //--------------------------------------------------------------------------
    
    public function SaveStrategy()
    {
        super();
    }

    //--------------------------------------------------------------------------
    // API :: Methods
    //--------------------------------------------------------------------------
    
    public function dirty():void
    {
        isDirty = true;
    }
    
    public function resetDirty():void
    {
        _isDirty = false;
    }
    
    public function saveAsync():IStepSequence
    {
        logger.log(TAG, "saveAsync()");
        dispatchWith(ApplicationEventType.APPLICATION_PRE_SAVE);
        
        var sequence:IStepSequence = projectService.saveAsync(projectModel.project);
        sequence.addCompleteListener(this_saveCompleteHandler);
        return sequence;
    }
    
    public function saveQuick():void
    {
        //projectPreferencesProvider.provided
    }
    
    //--------------------------------------------------------------------------
    // Handlers
    //--------------------------------------------------------------------------
    
    private function this_saveCompleteHandler(event:OperationEvent):void
    {
        isDirty = false;
        dispatchWith(ApplicationEventType.APPLICATION_SAVE_COMPLETED);
    }
    
    private function context_dirtyEventHandler(event:Event):void
    {
        logger.log(TAG, "dirty {0} event recieved", event.type);
        isDirty = true;
    }
}
}