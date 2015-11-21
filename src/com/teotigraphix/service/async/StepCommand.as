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

package com.teotigraphix.service.async
{

import com.teotigraphix.service.ILogger;

import flash.events.TimerEvent;
import flash.utils.Timer;

import org.as3commons.async.operation.ICancelableOperation;
import org.as3commons.async.operation.event.CancelableOperationEvent;
import org.as3commons.async.operation.impl.AbstractProgressOperation;
import org.robotlegs.starling.core.IInjector;

import starling.events.EventDispatcher;

/**
 * An operation that "may" not be async but needs to be treated that way
 * from the client's perspective.
 *
 * <p>Call #complete() in constructor if there is no async complete/error events.</p>
 */
public class StepCommand extends AbstractProgressOperation implements IStepCommand, ICancelableOperation
{
    [Inject]
    public var logger:ILogger;

    [Inject]
    public var injector:IInjector;

    [Inject]
    public var eventDispatcher:EventDispatcher;

    private var _data:Object;
    private var timer:Timer;
    private var loopTimer:Timer;
    private var _monitoredData:Object;

    public function get data():Object
    {
        return _data;
    }

    public function set data(value:Object):void
    {
        _data = value;
    }

    public function StepCommand(timeoutInMilliseconds:int = 0, autoStartTimeout:Boolean = true)
    {
        super(timeoutInMilliseconds, autoStartTimeout);
    }

    public function execute():*
    {
        return null;
    }

    public function commit():*
    {
        return null;
    }

    public function cancel():void
    {
        dispatchEvent(new CancelableOperationEvent(CancelableOperationEvent.CANCELED, this));
    }

    public function addCancelListener(listener:Function,
                                      useCapture:Boolean = false,
                                      priority:int = 0,
                                      useWeakReference:Boolean = false):void
    {
        addEventListener(CancelableOperationEvent.CANCELED, listener, useCapture, priority, useWeakReference);
    }

    public function removeCancelListener(listener:Function, useCapture:Boolean = false):void
    {
        removeEventListener(CancelableOperationEvent.CANCELED, listener, useCapture);
    }

    protected function complete(result:* = null, delay:Number = 10, repeatCount:int = 1):void
    {
        this.result = result;
        timer = new Timer(delay, repeatCount);
        timer.addEventListener(TimerEvent.TIMER_COMPLETE, timer_timerCompleteHandler);
        timer.start();
    }

    protected function monitorForComplete(monitoredData:Object, delay:Number = 0, repeatCount:int = 1):void
    {
        _monitoredData = monitoredData;

        loopTimer = new Timer(delay, repeatCount);
        loopTimer.addEventListener(TimerEvent.TIMER, loopTimer_timerHandler);
        loopTimer.addEventListener(TimerEvent.TIMER_COMPLETE, loopTimer_timerCompleteHandler);
        loopTimer.start();
    }

    /**
     * Checks that the operation has completed such as file saving or other things
     * that do not dispatch events.
     * <p>The override should set the result or error when returning true.
     * @return
     */
    protected function checkComplete():Boolean
    {
        return false;
    }

    protected function cleanupComplete():void
    {
    }

    private function loopTimer_timerHandler(event:TimerEvent):void
    {
        if (checkComplete())
        {
            loopTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, loopTimer_timerCompleteHandler);
            loopTimer.stop();
            loopTimer = null;
            cleanupComplete();
            complete(_monitoredData);
        }
    }

    private function loopTimer_timerCompleteHandler(event:TimerEvent):void
    {
        loopTimer.stop();
        loopTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, timer_timerCompleteHandler);
        loopTimer = null;
        _monitoredData = null;

        dispatchTimeoutEvent();
        dispatchErrorEvent(error);
    }

    private function timer_timerCompleteHandler(event:TimerEvent):void
    {
        timer.stop();
        timer.removeEventListener(TimerEvent.TIMER_COMPLETE, timer_timerCompleteHandler);
        timer = null;
        cleanupComplete();
        dispatchCompleteEvent();
    }
}
}