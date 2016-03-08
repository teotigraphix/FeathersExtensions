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
import com.teotigraphix.ui.component.ColorChipPicker;
import com.teotigraphix.ui.component.file.FileListData;
import com.teotigraphix.ui.dialog.FileDialog;
import com.teotigraphix.ui.dialog.GetStringDialog;
import com.teotigraphix.ui.dialog.ProgressDialog;

import feathers.controls.Alert;

import starling.display.DisplayObject;

public interface IUIController
{
    function browseForFile(data:FileListData, yesHandler:Function, noHandler:Function):FileDialog;
    
    function showAlert(title:String, message:String, iconSkin:String,
                       okHandler:Function, cancelHandler:Function,
                       yesLabel:String = "OK", noLabel:String = "CANCEL"):Alert;
    
    function progress(status:String = null, percent:int = 0):ProgressDialog;
    
    function getString(title:String, prompt:String, yesHandler:Function, noHandler:Function):GetStringDialog;
    
    function notifyToast(message:String, icon:String = null, duration:Number = 3000):void;
    
    function showCalloutColorChipPicker(origin:DisplayObject, 
                                        changeHandler:Function, 
                                        closeHandler:Function):ColorChipPicker;
    
    /**
     *  Exists the native application.
     */
    function exit():void;
}
}
