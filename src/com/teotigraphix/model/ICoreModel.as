package com.teotigraphix.model
{
import com.teotigraphix.app.configuration.ApplicationDescriptor;

public interface ICoreModel
{
    function get descriptor():ApplicationDescriptor;
    
    function get projectModel():IProjectModel;
}
}