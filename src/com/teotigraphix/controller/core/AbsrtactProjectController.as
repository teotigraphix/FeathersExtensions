package com.teotigraphix.controller.core
{
import com.teotigraphix.app.event.ApplicationEventType;
import com.teotigraphix.frameworks.project.Project;

import starling.events.Event;

public class AbsrtactProjectController extends AbstractController
{
    public function AbsrtactProjectController()
    {
        super();
    }
    
    
    override protected function onRegister():void
    {
        super.onRegister();
        
        addContextListener(ApplicationEventType.PROJECT_CHANGED, context_projectChangedHandler);
    }
    
    private function context_projectChangedHandler(event:Event, project:Project):void
    {
        configureApplicationState(project);
        dispatchWith(ApplicationEventType.STATE_CHANGED, false, project.state);
    }
    
    protected function configureApplicationState(project:Project):void
    {
    }
}
}