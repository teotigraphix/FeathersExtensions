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

package com.teotigraphix.ui
{

/**
 * A view implemented this API if it needs to know about orientation changes
 * from portrait to landscape.
 *
 * The AbstractMediator listens for the IDeviceModel's change event and
 * notifies but also sets the isLandscape property of the view if the
 * view implements it. The view is a FeathersControl.
 */
public interface IOrientationAware
{
    /**
     * Whether the app is in landscape of portrait layout, whether phone or tablet.
     *
     * @param isLandscape Landscape or portrait.
     * @param isTablet A tablet or phone.
     * @see com.teotigraphix.model.IDeviceModel#isLandscape
     * @see com.teotigraphix.model.IDeviceModel#isPhone
     * @see com.teotigraphix.model.IDeviceModel#isTablet
     */
    function orientationChange(isLandscape:Boolean, isTablet:Boolean):void;
}
}
