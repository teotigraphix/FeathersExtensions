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

package com.teotigraphix.model.support
{

import com.teotigraphix.model.AbstractModel;
import com.teotigraphix.model.IDeviceModel;
import com.teotigraphix.model.event.DeviceModelEventType;

import feathers.system.DeviceCapabilities;

import flash.display.Stage;
import flash.events.StageOrientationEvent;

import starling.core.Starling;

public class DeviceModel extends AbstractModel implements IDeviceModel
{
    //--------------------------------------------------------------------------
    // Variables
    //--------------------------------------------------------------------------

    private var _stage:Stage = new Stage();

    private var _beforeOrientation:String;
    private var _afterOrientation:String;

    //--------------------------------------------------------------------------
    // Public :: Properties
    //--------------------------------------------------------------------------

    //----------------------------------
    // isLandscape
    //----------------------------------

    public function get isLandscape():Boolean
    {
        return _stage.fullScreenWidth > _stage.fullScreenHeight;
    }

    //----------------------------------
    // isTablet
    //----------------------------------

    public function get isTablet():Boolean
    {
        return DeviceCapabilities.isTablet(_stage);
    }

    //----------------------------------
    // isPhone
    //----------------------------------

    public function get isPhone():Boolean
    {
        return DeviceCapabilities.isPhone(_stage);
    }

    //----------------------------------
    // orientation
    //----------------------------------

    /**
     * (default, upsideDown[portrait]) (rotatedRight, rotatedLeft[landscape])
     */
    public function get orientation():String
    {
        return _stage.orientation;
    }

    //----------------------------------
    // supportedOrientations
    //----------------------------------

    public function get supportedOrientations():Vector.<String>
    {
        return _stage.supportedOrientations;
    }

    //----------------------------------
    // stage
    //----------------------------------

    public function get stage():Stage
    {
        return _stage;
    }

    //--------------------------------------------------------------------------
    // Constructor
    //--------------------------------------------------------------------------

    public function DeviceModel()
    {
    }

    //--------------------------------------------------------------------------
    // Methods
    //--------------------------------------------------------------------------

    override protected function onRegister():void
    {
        super.onRegister();

        var current:Starling = Starling.current;

        _stage = current.nativeStage;
        _stage.addEventListener(StageOrientationEvent.ORIENTATION_CHANGE, stage_orientationChangeHandler);
        _stage.addEventListener(StageOrientationEvent.ORIENTATION_CHANGING, stage_orientationChangingHandler);
    }

    //--------------------------------------------------------------------------
    // Handlers
    //--------------------------------------------------------------------------
    
    private function stage_orientationChangingHandler(event:StageOrientationEvent):void
    {
        //trace("stage_orientationChangingHandler()");
    }

    private function stage_orientationChangeHandler(event:StageOrientationEvent):void
    {
        //trace("stage_orientationChangeHandler()");

        _beforeOrientation = event.afterOrientation;
        _afterOrientation = event.beforeOrientation;

        dispatchWith(DeviceModelEventType.ORIENTATION_CHANGE, false, this);
    }
}
}
