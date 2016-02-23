package com.teotigraphix.frameworks.project
{
import com.teotigraphix.service.ILogger;

import org.robotlegs.starling.core.IInjector;

import starling.events.EventDispatcher;

public class AbstractProjectConfigurator implements IProjectConfigurator
{
    [Inject]
    public var injector:IInjector;
    
    [Inject]
    public var logger:ILogger;
    
    [Inject]
    public var eventDispatcher:EventDispatcher;
    
    public function AbstractProjectConfigurator()
    {
    }
    
    public function setupNewProject(project:Project):void
    {
    }
    
    public function configureExistingProject(project:Project):void
    {
    }
}
}