package com.teotigraphix.frameworks.project
{

public class AbstractProjectPreferencesChild
{
    private var _owner:IProjectPreferences;

    //----------------------------------
    // owner
    //----------------------------------
    
    public function get owner():IProjectPreferences
    {
        return _owner;
    }
    
    public function set owner(value:IProjectPreferences):void
    {
        _owner = value;
    }
    
    protected function get preferences():AbstractProjectPreferences
    {
        return _owner as AbstractProjectPreferences;
    }

    //--------------------------------------------------------------------------
    // Constructor
    //--------------------------------------------------------------------------
    
    public function AbstractProjectPreferencesChild(owner:IProjectPreferences)
    {
        _owner = owner;
    }
    
    //--------------------------------------------------------------------------
    // Internal :: Methods
    //--------------------------------------------------------------------------
    
    protected function onPropertyChange(eventName:String = null, data:Object = null):void
    {
        if (_owner == null)
            return;
        
        preferences.onPropertyChange(eventName, data); 
    }
}
}