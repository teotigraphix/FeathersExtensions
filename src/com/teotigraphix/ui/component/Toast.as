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

package com.teotigraphix.ui.component
{

import feathers.controls.Label;
import feathers.controls.LayoutGroup;
import feathers.core.PopUpManager;
import feathers.layout.AnchorLayout;
import feathers.layout.AnchorLayoutData;
import feathers.skins.IStyleProvider;

import flash.events.TimerEvent;
import flash.utils.Timer;

import starling.events.Event;

public class Toast extends LayoutGroup
{
    protected static const DEFAULT_DELAY:int = 3000;
    public static const SHORT:Number = 1000;
    public static const LONG:Number = 3000;
    public static var globalStyleProvider:IStyleProvider;
    private var _message:String;
    private var _duration:Number = DEFAULT_DELAY;
    private var _label:Label;
    private var _timer:Timer;

    override protected function get defaultStyleProvider():IStyleProvider
    {
        return Toast.globalStyleProvider;
    }

    public function Toast()
    {
        super();
        addEventListener(Event.ADDED_TO_STAGE, toast_addedToStageHandler);
    }

    override protected function initialize():void
    {
        layout = new AnchorLayout();
        super.initialize();

        _label = new Label();
        _label.layoutData = new AnchorLayoutData(10, 10, 10, 10);
        _label.text = this._message;
        addChild(_label);
    }

    override protected function draw():void
    {
        super.draw();
    }

    protected function startTimer():void
    {
        if (this._timer)
        {
            this._timer.start();
        }
    }

    /**
     *
     * @param message
     * @param duration In milliseconds IE 1 second == 1000
     */
    public static function show(message:String, duration:Number):void
    {
        var instance:Toast = new Toast();
        instance._message = message;
        instance._duration = duration;
        PopUpManager.addPopUp(instance, false, true);
    }

    protected function toast_addedToStageHandler(event:Event):void
    {
        _timer = new Timer(_duration, 1);
        _timer.addEventListener(TimerEvent.TIMER_COMPLETE, onDelayComplete);

        startTimer();
    }

    protected function onDelayComplete(event:TimerEvent):void
    {
        PopUpManagerTransitioner.removePopUp(this, 1);
    }
}
}
