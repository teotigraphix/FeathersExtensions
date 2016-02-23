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
package com.teotigraphix.ui.core
{

import com.teotigraphix.controller.core.AbstractController;
import com.teotigraphix.ui.IUIController;
import com.teotigraphix.ui.IUIFactory;
import com.teotigraphix.ui.IUIState;
import com.teotigraphix.ui.component.event.FrameworkEventType;
import com.teotigraphix.ui.component.file.FileListData;
import com.teotigraphix.ui.dialog.AlertDialog;
import com.teotigraphix.ui.dialog.FileDialog;
import com.teotigraphix.ui.dialog.GetStringDialog;
import com.teotigraphix.ui.dialog.MessageDialog;
import com.teotigraphix.ui.dialog.ProgressDialog;
import com.teotigraphix.ui.dialog.WebViewDialog;
import com.teotigraphix.ui.popup.CenterPopUpContentManager;
import com.teotigraphix.ui.popup.ProgressPopUp;
import com.teotigraphix.ui.theme.AssetMap;

import flash.desktop.NativeApplication;
import flash.filesystem.File;

import feathers.controls.Alert;
import feathers.core.PopUpManager;
import feathers.data.ListCollection;

import starling.animation.Tween;
import starling.core.Starling;
import starling.display.DisplayObject;
import starling.display.DisplayObjectContainer;
import starling.display.Quad;
import starling.events.Event;

public class AbstractUIController extends AbstractController implements IUIController
{
    [Inject]
    public var root:DisplayObjectContainer;

    [Inject]
    public var _factory:IUIFactory;
    
    [Inject]
    public var _state:IUIState;
    
    private var _contentManager:CenterPopUpContentManager;
    
    //--------------------------------------------------------------------------
    // SUBCLASS IMPLEMENTATION
    //--------------------------------------------------------------------------
    
    public function get uiFactory():IUIFactory
    {
        return _factory;
    }
    
    public function get uiState():IUIState 
    {
        return _state;
    }
    
    public function AbstractUIController()
    {
    }

    override protected function onRegister():void
    {
        super.onRegister();
    }
    
    override public function onStartup():void
    {
        super.onStartup();
        
        AbstractUIState(_state).onStartup();
        AbstractUIFactory(_factory).onStartup();
    }
    
    
    
    public function browseForFile(data:FileListData,
                                  okHandler:Function, cancelHandler:Function):FileDialog
    {
        const dialog:FileDialog = FileDialog.show(data);
        dialog.yesLabel = "OK";
        dialog.noLabel = "CANCEL";
        dialog.addEventListener(FrameworkEventType.OK, okHandler);
        dialog.addEventListener(FrameworkEventType.CANCEL, cancelHandler);
        return dialog;
    }
    
    public function showAlert(title:String, message:String, iconSkin:String,
                              okHandler:Function, cancelHandler:Function,
                              yesLabel:String = "OK", noLabel:String = "CANCEL"):Alert
    {
        const alert:Alert = Alert.show(message, title,
            new ListCollection([{label: yesLabel}, {label: noLabel}]));
        if (iconSkin != null)
        {
            alert.icon = AssetMap.createImage(iconSkin);
            alert.icon.width = alert.icon.height = AssetMap.size(60);
        }

        alert.addEventListener(Event.CLOSE, function (event:Event, data:Object):void {
            if (data.label == yesLabel)
                okHandler();
            else
                cancelHandler();
        });
        
        return alert;
    }
    
    public function alert(title:String, message:String, 
                          okHandler:Function, cancelHandler:Function,
                          yesLabel:String = "OK", noLabel:String = "CANCEL"):AlertDialog
    {
        const dialog:AlertDialog = AlertDialog.show(title, message);
        dialog.yesLabel = yesLabel;
        dialog.noLabel = noLabel;
        dialog.addEventListener(FrameworkEventType.OK, okHandler);
        dialog.addEventListener(FrameworkEventType.CANCEL, cancelHandler);
        return dialog;
    }
    
    public function message(message:String):MessageDialog
    {
        const dialog:MessageDialog = MessageDialog.show(message);
        return dialog;
    }
    
    public function progress(status:String = null, percent:int = 0):ProgressDialog
    {
        const dialog:ProgressDialog = ProgressDialog.show(status, percent);
        return dialog;
    }
    
    public function getString(title:String, prompt:String, okHandler:Function, cancelHandler:Function):GetStringDialog
    {
        const dialog:GetStringDialog = GetStringDialog.show(title, prompt);
        dialog.addEventListener(FrameworkEventType.OK, okHandler);
        dialog.addEventListener(FrameworkEventType.CANCEL, cancelHandler);
        return dialog;
    }

    /**
     * Initializes FileListData for directory selection without files.
     */
    public function initDirectoryListData(rootDirectory:File, homeDirectory:File = null):FileListData
    {
        const data:FileListData = new FileListData();
        data.rootDirectory = rootDirectory;
        data.homeDirectory = homeDirectory != null ? homeDirectory : File.documentsDirectory;
        data.showFiles = false;
        data.extensions = null;
        data.directoryDoubleTapEnabled = false;
        return data;
    }

    /**
     * Initializes FileListData for file selection with files and directory double tap.
     */
    public function initFileListData(extensions:Array, rootDirectory:File, homeDirectory:File = null):FileListData
    {
        const data:FileListData = new FileListData();
        data.extensions = extensions;
        data.rootDirectory = rootDirectory;
        data.homeDirectory = homeDirectory != null ? homeDirectory : File.documentsDirectory;
        data.showFiles = true;
        data.directoryDoubleTapEnabled = true;
        return data;
    }


    
    public function createAndShowProgressPopUp(status:String = null, percent:int = 0):ProgressPopUp
    {
        const popup:ProgressPopUp = new ProgressPopUp();
        popup.status = status;
        popup.percent = percent;
        addPopUp(popup, true, true);
        return popup;
    }

    public function notifyToast(message:String, icon:String = null, duration:Number = 3000):void
    {
        //Toast.show(message, duration);
        
        var dialog:MessageDialog = new MessageDialog();
        dialog.message = message;
        dialog.validate();

        PopUpManager.addPopUp(dialog, false, false);
        
        var height:Number = dialog.height;
        var width:Number = dialog.width;
        
        var swidth:Number = Starling.current.stage.width;
        var sheight:Number = Starling.current.stage.height;
        
        dialog.y = sheight + height;
        dialog.x = (swidth - width) / 2;
        
        var t1:Tween = new Tween(dialog, 0.3);
        t1.moveTo(dialog.x, sheight - height - 10);
        
        var t2:Tween = new Tween(dialog, 0.3);
        t2.delay = duration / 1000;
        t2.moveTo(dialog.x, sheight + height);
        t1.nextTween = t2;
        
        t2.onComplete = function ():void {
            PopUpManager.removePopUp(dialog, true);
        };
        
        Starling.juggler.add(t1);
    }

    public function showWebText(title:String, htmlText:String, backHandler:Function):WebViewDialog
    {
        var dialog:WebViewDialog = WebViewDialog.show(title, htmlText);
        dialog.addEventListener(FrameworkEventType.BACK, backHandler);
        return dialog;
    }

    public function addPopUp(popUp:DisplayObject, isModal:Boolean = true,
                             isCentered:Boolean = true, customOverlayFactory:Function = null):void
    {
        PopUpManager.addPopUp(popUp, isModal, isCentered, customOverlayFactory);
    }

    public function removePopUp(popUp:DisplayObject, dispose:Boolean = true):void
    {
        PopUpManager.removePopUp(popUp, dispose);
    }

    public function showCenteredPopUp(content:DisplayObject,
                                      closeEvent:String,
                                      closedHandler:Function = null,
                                      overlayFactory:Function = null):void
    {
        _contentManager = new CenterPopUpContentManager();
        _contentManager.overlayFactory = function ():DisplayObject
        {
            var quad:Quad = new Quad(1, 1, 0xff00ff);
            quad.alpha = 0;
            return quad;
        };

        if (closedHandler != null)
        {
            _contentManager.addEventListener(CenterPopUpContentManager.EVENT_CANCEL, closedHandler);
        }
        _contentManager.addEventListener(CenterPopUpContentManager.EVENT_CANCEL, contentManager_cancelHandler);
        if (closeEvent != null)
        {
            content.addEventListener(closeEvent, list_closeHandler);
        }
        _contentManager.isModal = true;
        _contentManager.open(content, DisplayObject(root));
    }
    
    public function exit():void
    {
        NativeApplication.nativeApplication.exit();
    }

    private function contentManager_cancelHandler(event:Event):void
    {
    }

    private function list_closeHandler(event:Event):void
    {
        _contentManager.close();
        _contentManager = null;
    }
}
}
