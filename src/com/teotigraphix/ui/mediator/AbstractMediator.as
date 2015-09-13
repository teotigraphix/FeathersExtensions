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

package com.teotigraphix.ui.mediator
{

import com.teotigraphix.model.IDeviceModel;
import com.teotigraphix.model.event.DeviceModelEventType;
import com.teotigraphix.service.ILogger;
import com.teotigraphix.ui.IOrientationAware;

import org.robotlegs.starling.core.IInjector;
import org.robotlegs.starling.mvcs.Mediator;

import starling.events.Event;

public class AbstractMediator extends Mediator
{
    [Inject]
    public var injector:IInjector;

    [Inject]
    public var logger:ILogger;

    [Inject]
    public var deviceModel:IDeviceModel;

    public function AbstractMediator()
    {
    }

    /**
     * Called creationComplete on the view.
     *
     * <p>The view's creationComplete handler is called before the onRegister() call.</p>
     */
    override public function onRegister():void
    {
        super.onRegister();

        addContextListener(DeviceModelEventType.ORIENTATION_CHANGE, context_orientationChange);

        onOrientationChange(deviceModel.isLandscape, deviceModel.isTablet);
    }

    override public function onRemove():void
    {
        super.onRemove();
    }

    protected function onOrientationChange(isLandscape:Boolean, isTablet:Boolean):void
    {
        if (viewComponent is IOrientationAware)
            IOrientationAware(viewComponent).orientationChange(isLandscape, isTablet);
    }

    private function context_orientationChange(event:Event, model:IDeviceModel):void
    {
        onOrientationChange(deviceModel.isLandscape, deviceModel.isTablet);
    }
}
}
