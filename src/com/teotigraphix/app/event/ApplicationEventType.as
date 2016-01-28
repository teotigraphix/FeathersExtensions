////////////////////////////////////////////////////////////////////////////////
// Copyright 2015 Michael Schmalle - Teoti Graphix, LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License
//
// Author: Michael Schmalle, Principal Architect
// mschmalle at teotigraphix dot com
////////////////////////////////////////////////////////////////////////////////

package com.teotigraphix.app.event
{

/**
 * The event type for the top level Application model.
 */
public final class ApplicationEventType
{

    ///**
    // * Dispatched through Starling when the "rootCreated" event is fired
    // * after LoaderInfo.COMPLETE and Starling.startup() have been called.
    // *
    // * <p>data - StarlingRootSprite</p>
    // *
    // * @see StarlingRootSprite
    // */
    //public static const APPLICATION_START:String = "applicationStart";
    //
    //public static const APPLICATION_ACTIVATE:String = "applicationActivate";
    //
    //public static const APPLICATION_DEACTIVATE:String = "applicationDeactivate";
    //
    ///**
    // * Dispatched when the application is being disposed, fires after deactivate.
    // */
    //public static const APPLICATION_EXIT:String = "applicationExit";

    /**
     * Dispatched last int he startup routine, project will be loaded, rack state loaded from disk,
     * the project state will be completly restored. So if any controllers/models need to create
     * machines, create data providers, this is the time to do it. 
     */
    public static const CONTROLLER_STARTUP:String = "ApplicationEventType/controllerStartup";
    
    /**
     * Dispatched after the MVC model and Project state have been initialized and loaded.
     *
     * <p>When this event is fired, all state is ready and the main application will
     * be show in the view, tearing down the loading image.</p>
     *
     * <p>The usual listener of this event is the MainNavigatorMediator. When it receives
     * this event, it will show the first application screen, where a loading screen may
     * have been shown.</p>
     *
     * <p>All loading and startup logic needs to be placed inside the ApplicationStartupCommand
     * which is an IOperation and async. The startup is completed in progressive steps until
     * that last step is complete, when that step is complete, the command will fire this
     * event type on the context event dispatcher.</p>
     *
     * @data <code>null</code>
     */
    public static const APPLICATION_COMPLETE:String = "ApplicationEventType/applicationComplete";

    /**
     * Dispatched after a Project has been loaded and set on the ProjectModel.
     *
     * @data <code>com.teotigraphix.frameworks.project.Project</code>
     */
    public static const PROJECT_CHANGED:String = "ApplicationEventType/projectChanged";

    public static const BACK:String = "ApplicationEventType/back";
    public static const BACK_TO:String = "ApplicationEventType/backTo";
}
}
