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

package com.teotigraphix.controller.support
{

import com.teotigraphix.app.event.ApplicationEventType;
import com.teotigraphix.controller.AbstractController;
import com.teotigraphix.controller.IProjectChangeListener;
import com.teotigraphix.frameworks.project.Project;
import com.teotigraphix.model.IDeviceModel;

import feathers.data.ListCollection;

import starling.events.Event;

/**
 * Base implementation for Application level controllers, listens for Project changes.
 *
 * @see com.teotigraphix.app.event.ApplicationEventType.PROJECT_CHANGED
 */
public class AbstractApplicationController extends AbstractController
{
    [Inject]
    public var deviceModel:IDeviceModel;

    private var _listeners:ListCollection = new ListCollection();

    public function AbstractApplicationController()
    {
    }

    override protected function onRegister():void
    {
        super.onRegister();

        addContextListener(ApplicationEventType.PROJECT_CHANGED, context_projectChanged);
    }

    protected final function addListener(listener:Object):void
    {
        _listeners.addItem(listener);
    }

    protected final function removeListener(listener:Object):void
    {
        _listeners.removeItem(listener);
    }

    private function context_projectChanged(event:Event, project:Project):void
    {
        var i:int;
        var listener:Object;
        const len:int = _listeners.length;

        for (i = 0; i < len; i++)
        {
            listener = _listeners.getItemAt(i);
            if (listener is IProjectChangeListener)
                IProjectChangeListener(listener).projectChanged(project, null);
        }

        for (i = 0; i < len; i++)
        {
            listener = _listeners.getItemAt(i);
            if (listener is IProjectChangeListener)
                IProjectChangeListener(listener).projectChangeComplete(project);
        }
    }
}
}
