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
