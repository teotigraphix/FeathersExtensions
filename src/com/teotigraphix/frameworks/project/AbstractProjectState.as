/**
 * Created by Teoti on 3/6/2015.
 */
package com.teotigraphix.frameworks.project
{

import com.teotigraphix.caustic.core.caustic_internal;

public class AbstractProjectState implements IProjectState
{
    //--------------------------------------------------------------------------
    // Serialized API
    //--------------------------------------------------------------------------

    private var _project:Project;

    //--------------------------------------------------------------------------
    // Private :: Variables
    //--------------------------------------------------------------------------

    public function get project():Project
    {
        return _project;
    }

    public function set project(value:Project):void
    {
        _project = value;
    }

    public function AbstractProjectState()
    {
    }

    /**
     * Called when a new project has been created and state needs initialization.
     */
    public function initialize():void
    {
    }

    /**
     * called after a project has been deserialized and rack bytes are loaded.
     */
    public function wakeup():void
    {
    }

    protected function onProjectCreate():void
    {
    }

    caustic_internal function setProject(value:Project):void
    {
        _project = value;
        onProjectCreate();
    }
}
}
