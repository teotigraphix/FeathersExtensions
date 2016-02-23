package com.teotigraphix.frameworks.project
{
import org.robotlegs.starling.core.IInjector;

public class ProjectStateProvider implements IProjectStateProvider
{
    [Inject]
    public var injector:IInjector;
    
    private var _provided:IProjectState;
    
    public function get provided():IProjectState
    {
        return _provided;
    }
    
    public function set provided(value:IProjectState):void
    {
        _provided = value;
        injector.injectInto(_provided);
    }
    
    public function ProjectStateProvider()
    {
    }
}
}