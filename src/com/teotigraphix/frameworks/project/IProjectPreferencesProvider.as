package com.teotigraphix.frameworks.project
{
public interface IProjectPreferencesProvider
{
    function get provided():IProjectPreferences;
    
    function set provided(value:IProjectPreferences):void;
}
}