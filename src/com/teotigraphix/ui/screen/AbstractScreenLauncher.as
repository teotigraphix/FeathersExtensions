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
package com.teotigraphix.ui.screen
{

import com.teotigraphix.controller.AbstractController;
import com.teotigraphix.ui.IScreenNavigator;
import com.teotigraphix.ui.IScreenProvider;

import feathers.controls.IScreen;
import feathers.controls.StackScreenNavigatorItem;

import org.robotlegs.starling.core.IMediatorMap;

public class AbstractScreenLauncher extends AbstractController
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
        configure(_navigator);
    }

    /**
     * Sets the current screenID for the application and passes the optional screen data to be
     * set int he IScreenProvider.
     *
     * @param screenID The String screenID.
     * @param data The optional screen data.
     */
    public function setApplicationScreen(screenID:String, data:*):void
    {
        setInternalScreenID(screenID);

        _screenProvider.push(data);

        var screen:IScreen = IScreen(_navigator.pushScreen(_applicationScreenID));

        //dispatchWith(ApplicationModelEventType.APPLICATION_SCREEN_CHANGE, false, data);
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
        _screenProvider.pop();

        var lastScreen:IScreen = IScreen(_navigator.popScreen());

        setInternalScreenID(_navigator.activeScreenID);
    }

    protected function configure(navigator:IScreenNavigator):void
    {
    }

    protected function create(screen:Object,
                              mediatorClass:Class,
                              pushEvents:Object = null,
                              popEvent:String = null,
                              properties:Object = null):StackScreenNavigatorItem
    {
        _mediatorMap.mapView(screen, mediatorClass);

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
}
}
