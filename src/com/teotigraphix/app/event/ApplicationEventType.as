/**
 * Created by Teoti on 3/6/2015.
 */
package com.teotigraphix.app.event
{

public final class ApplicationEventType
{
    /**
     * Dispatched through Starling when the "rootCreated" event is fired
     * after LoaderInfo.COMPLETE and Starling.startup() have been called.
     *
     * <p>data - StarlingRootSprite</p>
     *
     * @see StarlingRootSprite
     */
    public static const APPLICATION_START:String = "applicationStart";

    public static const APPLICATION_ACTIVATE:String = "applicationActivate";

    public static const APPLICATION_DEACTIVATE:String = "applicationDeactivate";

    /**
     * Dispatched when the application is being disposed, fires after deactivate.
     */
    public static const APPLICATION_EXIT:String = "applicationExit";

    /**
     * Dispatched after the MVC model and Project state have been initialized and loaded.
     *
     * <p>When this event is fired, all state is ready and the main application will
     * be show in the view, tearing down the loading image.</p>
     */
    public static const APPLICATION_COMPLETE:String = "applicationComplete";

    /**
     * Dispatched after a Project has been loaded and set on the ProjectModel.
     *
     * <p>data - Project</p>
     */
    public static const PROJECT_CHANGED:String = "projectChanged";

}
}
