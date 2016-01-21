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
import com.teotigraphix.ui.component.IScreenNavigator;
import com.teotigraphix.ui.component.event.FrameworkEventType;
import com.teotigraphix.ui.component.file.FileListData;
import com.teotigraphix.ui.screen.FrameworkScreens;
import com.teotigraphix.ui.screen.IScreenLauncher;
import com.teotigraphix.ui.screen.data.AlertScreenData;
import com.teotigraphix.ui.screen.impl.AlertScreen;
import com.teotigraphix.ui.screen.impl.DialogScreen;
import com.teotigraphix.ui.screen.impl.FileExplorerScreen;
import com.teotigraphix.ui.screen.impl.dialog.GetStringScreen;

import flash.errors.IllegalOperationError;

import feathers.controls.IScreen;
import feathers.controls.StackScreenNavigatorItem;

import org.robotlegs.starling.base.MediatorMap;
import org.robotlegs.starling.core.IMediatorMap;
import org.robotlegs.starling.core.IReflector;

import starling.display.DisplayObjectContainer;

public class AbstractScreenLauncher extends AbstractController implements IScreenLauncher
{
    //--------------------------------------------------------------------------
    // Private :: Inject
    //--------------------------------------------------------------------------

    [Inject]
    public var _mediatorMap:IMediatorMap;

    [Inject]
    public var _navigator:IScreenNavigator;

    [Inject]
    public var root:DisplayObjectContainer;

    [Inject]
    public var reflector:IReflector;

    private var _popupMediatorMap:IMediatorMap;
    private var _applicationScreenID:String;

    protected var rootScreen:String;
    
    //--------------------------------------------------------------------------
    // Private :: Variables
    //--------------------------------------------------------------------------

    /**
     * Returns whether the Back button is enabled for a screen or certain UI state such as
     * a popup etc.
     */
    public function get isBackEnabled():Boolean
    {
        return false;
    }

    //--------------------------------------------------------------------------
    // API :: Properties
    //--------------------------------------------------------------------------

    //----------------------------------
    // isBackEnabled
    //----------------------------------

    public function get applicationScreenID():String
    {
        return _applicationScreenID;
    }

    //----------------------------------
    // applicationScreen
    //----------------------------------

    public function AbstractScreenLauncher()
    {
    }

    override protected function onRegister():void
    {
        super.onRegister();

        _popupMediatorMap = new MediatorMap(root.stage, injector, reflector);

        configureFramework(_navigator);
        configure(_navigator);
        configureControls(_mediatorMap);
        configurePopUpControls(_popupMediatorMap);
    }

    public function backTo(screenID:String):void
    {
        for (var i:int = 0; i < 10; i++)
        {
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
        if (rootScreen == _navigator.activeScreenID)
        {
            throw new IllegalOperationError("Already at root, back() cannot be called");
        }
        
        if (rootScreen == _navigator.activeScreenID && !sdk_internal::inExitAlert)
        {
            var sequence:StepSequence = new StepSequence();
            sequence.addCommand(injector.instantiate(ShowAlertExitStep));
            sequence.execute();
        }
        else
        {
            var lastScreen:IScreen = IScreen(_navigator.popScreen());
            logger.log("AbstractScreenLauncher", "Back screen [{0}] created as {1}", _navigator.activeScreenID,
                       lastScreen);

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
                              cancelHandler:Function):GetStringScreen
    {
        var screen:GetStringScreen = GetStringScreen(sdk_internal::setApplicationScreen(
                FrameworkScreens.GET_STRING));
        screen.title = title;
        screen.prompt = prompt;
        screen.addEventListener(DialogScreen.EVENT_OK, okHandler);
        screen.addEventListener(DialogScreen.EVENT_CANCEL, cancelHandler);
        return screen;
    }

    public function goToAlert(message:String,
                              title:String,
                              okHandler:Function,
                              cancelHandler:Function):AlertScreen
    {
        var screen:AlertScreen = AlertScreen(
                sdk_internal::setApplicationScreen(FrameworkScreens.ALERT));
        screen.data = new AlertScreenData(message, title);
        screen.addEventListener(DialogScreen.EVENT_OK, okHandler);
        screen.addEventListener(DialogScreen.EVENT_CANCEL, cancelHandler);
        return screen;
    }

    public function goToFileExplorer(data:FileListData):FileExplorerScreen
    {
        var screen:FileExplorerScreen = FileExplorerScreen(
                sdk_internal::setApplicationScreen(FrameworkScreens.FILE_EXPLORER));
        screen.data = data;
        return screen;
    }

    public function redraw():void
    {
        dispatchWith(FrameworkEventType.SCREEN_REDRAW, false, new ScreenRedrawData(_navigator.activeScreen));
    }
    
    protected function configureFramework(navigator:IScreenNavigator):void
    {
        navigator.addScreen(FrameworkScreens.GET_STRING,
                            create(GetStringScreen, null));

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

    protected function configurePopUpControls(mediatorMap:IMediatorMap):void
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
    protected function setInternalScreenID(screenID:String):void
    {
        _applicationScreenID = screenID;
    }

    sdk_internal var inExitAlert:Boolean = false;

    /**
     * Sets the current screenID for the application and passes the optional screen data to be
     * set int he IScreenProvider.
     *
     * @param screenID The String screenID.
     */
    sdk_internal function setApplicationScreen(screenID:String):IScreen
    {
        if (_applicationScreenID == screenID)
            return null;

        setInternalScreenID(screenID);

        logger.log("AbstractScreenLauncher", "creating screen [{0}]", screenID);
        var screen:IScreen = IScreen(_navigator.pushScreen(_applicationScreenID));
        injector.injectInto(screen);

        logger.log("AbstractScreenLauncher", "screen [{0}] created as {1}", screenID, screen);
        //dispatchWith(ApplicationModelEventType.APPLICATION_SCREEN_CHANGE, false, data);
        return screen;
    }
}
}

import com.teotigraphix.core.sdk_internal;
import com.teotigraphix.service.async.StepCommand;
import com.teotigraphix.ui.screen.IScreenLauncher;
import com.teotigraphix.ui.screen.core.AbstractScreenLauncher;

import flash.desktop.NativeApplication;

import feathers.controls.Alert;
import feathers.data.ListCollection;

import starling.events.Event;

use namespace sdk_internal;

final class ShowAlertExitStep extends StepCommand
{
    [Inject]
    public var screenLauncher:IScreenLauncher;

    override public function execute():*
    {
        AbstractScreenLauncher(screenLauncher).sdk_internal::inExitAlert = true;

        var alert:Alert = Alert.show("Are you sure you want to exit application?",
                                     "Exit Caustic Guide",
                                     new ListCollection([
                                         {label: "YES"}, {label: "NO"}
                                     ]));
        alert.addEventListener(Event.CLOSE, alert_closeHandler);
        return super.execute();
    }

    private function alert_closeHandler(event:Event):void
    {
        AbstractScreenLauncher(screenLauncher).sdk_internal::inExitAlert = false;

        if (event.data.label == "YES")
        {
            NativeApplication.nativeApplication.exit();
        }
        complete();
    }
}