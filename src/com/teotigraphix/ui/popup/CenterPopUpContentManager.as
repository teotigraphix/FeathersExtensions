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
package com.teotigraphix.ui.popup
{

import feathers.controls.popups.DropDownPopUpContentManager;
import feathers.core.PopUpManager;

import starling.display.DisplayObject;
import starling.display.DisplayObjectContainer;
import starling.display.Stage;

import starling.events.Event;
import starling.events.Touch;
import starling.events.TouchEvent;
import starling.events.TouchPhase;

public class CenterPopUpContentManager extends DropDownPopUpContentManager
{
    public static const EVENT_CANCEL:String = "cancel";

    public function CenterPopUpContentManager()
    {
    }

    override protected function content_resizeHandler(event:Event):void
    {
    }

    override protected function layout():void
    {
       PopUpManager.centerPopUp(content);
    }

    override protected function stage_touchHandler(event:TouchEvent):void
    {
        // Copied from super
        var target:DisplayObject = DisplayObject(event.target);
        if(this.content == target || (this.content is DisplayObjectContainer && DisplayObjectContainer(this.content).contains(target)))
        {
            return;
        }
        if(this.source == target || (this.source is DisplayObjectContainer && DisplayObjectContainer(this.source).contains(target)))
        {
            return;
        }
        if(!PopUpManager.isTopLevelPopUp(this.content))
        {
            return;
        }
        //any began touch is okay here. we don't need to check all touches
        var stage:Stage = Stage(event.currentTarget);
        var touch:Touch = event.getTouch(stage, TouchPhase.BEGAN);
        if(!touch)
        {
            return;
        }

        if (touch.target.parent == stage)
        {
            dispatchEventWith(EVENT_CANCEL);
        }

        this.close();


    }
}
}
