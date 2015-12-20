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
package com.teotigraphix.ui.screen.core
{

import com.teotigraphix.controller.impl.AbstractController;
import com.teotigraphix.core.sdk_internal;
import com.teotigraphix.service.async.StepSequence;
import com.teotigraphix.ui.component.file.FileListData;
import com.teotigraphix.ui.screen.*;
import com.teotigraphix.ui.screen.data.AlertScreenData;
import com.teotigraphix.ui.screen.impl.AlertScreen;
import com.teotigraphix.ui.screen.impl.FileExplorerScreen;
import com.teotigraphix.ui.screen.impl.dialog.GetStringDialog;

import feathers.controls.IScreen;
import feathers.controls.StackScreenNavigatorItem;

import org.robotlegs.starling.core.IMediatorMap;

public class AbstractScreenLauncher extends AbstractController implements IScreenLauncher
{
    //--------------------------------------------------------------------------
    // Private :: Inject
    //--------------------------------------------------------------------------

    [Inject]
    public var _mediatorMap:IMediatorMap;

    [Inject]
    public var _screenProvider:IScreenProvider;

    [Inject]
    public var _navigator:IScreenNavigator;

    //--------------------------------------------------------------------------
    // Private :: Variables
    //--------------------------------------------------------------------------

    private var _applicationScreenID:String;

    //--------------------------------------------------------------------------
    // API :: Properties
    //--------------------------------------------------------------------------

    //----------------------------------
    // applicationScreen
    //----------------------------------

    public function get applicationScreenID():String
    {
        return _applicationScreenID;
    }

    public function AbstractScreenLauncher()
    {
    }

    override protected function onRegister():void
    {
        super.onRegister();
        configureFramework(_navigator);
        configure(_navigator);
        configureControls(_mediatorMap);
    }

    public function backTo(screenID:String):void
    {
        for (var i:int = 0; i < 10; i++)
        {
            _screenProvider.pop();

            var lastScreen:IScreen = IScreen(_navigator.popScreen());

            if (_navigator.activeScreenID == screenID)
            {
                setInternalScreenID(_navigator.activeScreenID);
                break;
            }
        }
    }

    public function back():void
    {
        if (_screenProvider.isEmpty)
        {
            var sequence:StepSequence = new StepSequence();
            sequence.addCommand(injector.instantiate(ShowAlertExitStep));
            sequence.execute();
        }
        else
        {
            _screenProvider.pop();

            var lastScreen:IScreen = IScreen(_navigator.popScreen());

            setInternalScreenID(_navigator.activeScreenID);
        }
    }

    /**
     *
     * @param title
     * @param prompt
     * @param okHandler Result {string:String}
     * @param cancelHandler
     * @return
     */
    public function getString(title:String,
                              prompt:String,
                              okHandler:Function,
                              cancelHandler:Function):GetStringDialog
    {
        var screen:GetStringDialog = GetStringDialog(sdk_internal::setApplicationScreen(
                FrameworkScreens.GET_STRING, {}));
        screen.title = title;
        screen.prompt = prompt;
        screen.addEventListener(GetStringDialog.EVENT_OK, okHandler);
        screen.addEventListener(GetStringDialog.EVENT_CANCEL, cancelHandler);
        return screen;
    }

    public function goToAlert(message:String,
                              title:String,
                              okHandler:Function,
                              cancelHandler:Function):AlertScreen
    {
        var screen:AlertScreen = AlertScreen(
                sdk_internal::setApplicationScreen(FrameworkScreens.ALERT, null));
        screen.data = new AlertScreenData(message, title);
        screen.addEventListener(AlertScreen.EVENT_OK, okHandler);
        screen.addEventListener(AlertScreen.EVENT_CANCEL, cancelHandler);
        return screen;
    }

    public function goToFileExplorer(data:FileListData):FileExplorerScreen
    {
        var screen:FileExplorerScreen = FileExplorerScreen(
                sdk_internal::setApplicationScreen(FrameworkScreens.FILE_EXPLORER, data));
        screen.data = data;
        return screen;
    }

    protected function configureFramework(navigator:IScreenNavigator):void
    {
        navigator.addScreen(FrameworkScreens.GET_STRING,
                            create(GetStringDialog, null));

        navigator.addScreen(FrameworkScreens.ALERT,
                            create(AlertScreen, null));

        navigator.addScreen(FrameworkScreens.FILE_EXPLORER,
                            create(FileExplorerScreen, null));
    }

    protected function configure(navigator:IScreenNavigator):void
    {
    }

    protected function configureControls(mediatorMap:IMediatorMap):void
    {

    }

    protected function create(screen:Object,
                              mediatorClass:Class,
                              pushEvents:Object = null,
                              popEvent:String = null,
                              properties:Object = null):StackScreenNavigatorItem
    {
        if (mediatorClass != null)
        {
            _mediatorMap.mapView(screen, mediatorClass);
        }

        var item:StackScreenNavigatorItem = new StackScreenNavigatorItem(screen, pushEvents, popEvent, properties);
        return item;
    }

    /**
     * Resets the correct screenID from a back/pop event.
     *
     * @param screenID The current screen id.
     */
    private function setInternalScreenID(screenID:String):void
    {
        _applicationScreenID = screenID;
    }

    /**
     * Sets the current screenID for the application and passes the optional screen data to be
     * set int he IScreenProvider.
     *
     * @param screenID The String screenID.
     * @param data The optional screen data.
     */
    sdk_internal function setApplicationScreen(screenID:String, data:*):IScreen
    {
        if (_applicationScreenID == screenID)
            return null;

        setInternalScreenID(screenID);

        _screenProvider.push(data);

        var screen:IScreen = IScreen(_navigator.pushScreen(_applicationScreenID));
        injector.injectInto(screen);

        //dispatchWith(ApplicationModelEventType.APPLICATION_SCREEN_CHANGE, false, data);
        return screen;
    }
}
}

import com.teotigraphix.service.async.StepCommand;

import feathers.controls.Alert;
import feathers.data.ListCollection;

import flash.desktop.NativeApplication;

import starling.events.Event;

final class ShowAlertExitStep extends StepCommand
{

    override public function execute():*
    {
        var alert:Alert = Alert.show("Are you sure you want to exit application?",
                                     "Exit Caustic Guide",
                                     new ListCollection([
                                         {label: "Yes"}, {label: "No"}
                                     ]));
        alert.addEventListener(Event.CLOSE, alert_closeHandler);
        return super.execute();
    }

    private function alert_closeHandler(event:Event):void
    {
        if (event.data.label == "Yes")
        {
            NativeApplication.nativeApplication.exit();
        }
        complete();
    }
}