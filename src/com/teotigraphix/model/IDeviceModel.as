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

package com.teotigraphix.model
{

/**
 * Tracks low level device capabilities.
 *
 * @see feathers.system.DeviceCapabilities
 * @see com.teotigraphix.ui.IOrientationAware
 */
public interface IDeviceModel
{
    /**
     * Whether the device is in landscape or portrait mode.
     */
    function get isLandscape():Boolean;

    /**
     * Whether the device is a tablet.
     *
     * @see feathers.system.DeviceCapabilities#isTablet()
     */
    function get isTablet():Boolean;

    /**
     * Whether the device is a phone.
     *
     * @see feathers.system.DeviceCapabilities#isPhone()
     */
    function get isPhone():Boolean;

    /**
     * (default, upsideDown[portrait]) (rotatedRight, rotatedLeft[landscape])
     */
    function get orientation():String;

    function get supportedOrientations():Vector.<String>;
}
}
