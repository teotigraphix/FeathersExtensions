package com.teotigraphix.model
{
import com.teotigraphix.app.configuration.ApplicationDescriptor;
import com.teotigraphix.frameworks.project.IProjectPreferences;

public interface ICoreModel
{
    function get descriptor():ApplicationDescriptor;
    
    function get projectModel():IProjectModel;

    function setPreferences(value:IProjectPreferences):void; 
}
}