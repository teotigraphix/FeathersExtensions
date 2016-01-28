package com.teotigraphix.frameworks.project
{
import org.robotlegs.starling.core.IInjector;
import org.robotlegs.starling.mvcs.Actor;

public class ProjectPreferencesProvider extends Actor implements IProjectPreferencesProvider
{
    [Inject]
    public var injector:IInjector;
    
    private var _provided:IProjectPreferences;
    
    public function get provided():IProjectPreferences
    {
        return _provided;
    }
    
    public function set provided(value:IProjectPreferences):void
    {
        _provided = value;
        injector.injectInto(_provided);
    }
    
    public function ProjectPreferencesProvider()
    {
    }
}
}