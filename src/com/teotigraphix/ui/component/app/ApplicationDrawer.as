package com.teotigraphix.ui.component.app
{

import com.teotigraphix.app.event.ApplicationEventType;

import feathers.controls.Drawers;
import feathers.controls.ScreenNavigator;
import feathers.core.FeathersControl;

import starling.events.Event;

/**
 * Sets up the main layout of the app whether a screen navigator
 * or a frame layout, dependent on the app impl.
 */
public class ApplicationDrawer extends Drawers
{
    public function get navigator():ScreenNavigator
    {
        return content as ScreenNavigator;
    }

    public function ApplicationDrawer()
    {
        super();
        addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
    }

    protected function createContent():FeathersControl
    {
        return new ScreenNavigator();
    }

    private function addedToStageHandler(event:Event):void
    {
        removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
        trace("ApplicationDrawer.addedToStageHandler() Dispatch ApplicationEventType.APPLICATION_START");
        dispatchEventWith(ApplicationEventType.APPLICATION_START, true, this);
        trace("ApplicationDrawer.createContent() Creating root content (default ScreenNavigator)");
        content = createContent();
    }
}
}
