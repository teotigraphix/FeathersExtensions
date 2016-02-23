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

package com.teotigraphix.app.ui
{

import com.teotigraphix.app.event.ApplicationEventData;
import com.teotigraphix.app.event.ApplicationEventType;

import flash.events.KeyboardEvent;
import flash.ui.Keyboard;

import feathers.controls.StackScreenNavigator;
import feathers.events.FeathersEventType;
import feathers.utils.display.getDisplayObjectDepthFromStage;

import starling.core.Starling;
import starling.events.Event;
import starling.events.EventDispatcher;


public class BootstrapNavigator extends StackScreenNavigator implements IBootstrapNavigator
{
    public var backButtonHandler:Function;
    public var menuButtonHandler:Function;
    public var searchButtonHandler:Function;
    
    private var _eventDispatcher:EventDispatcher;    

    [Bindable("eventDispatcherChange")]
    public function get eventDispatcher():EventDispatcher
    {
        return _eventDispatcher;
    }

    public function set eventDispatcher(value:EventDispatcher):void
    {
        _eventDispatcher = value;
        dispatchEventWith("eventDispatcherChange");
    }

    public function BootstrapNavigator()
    {
        this.addEventListener(Event.ADDED_TO_STAGE, screen_addedToStageHandler);

        addEventListener(FeathersEventType.INITIALIZE, this_initializeHandler);
        addEventListener(FeathersEventType.CREATION_COMPLETE, this_creationCompleteHandler);
        addEventListener(Event.ADDED_TO_STAGE, this_addedToStageHandler);
        addEventListener(Event.REMOVED_FROM_STAGE, this_removedToStageHandler);
        
        backButtonHandler = this_backButtonHandler;
    }

    /**
     * @private
     */
    protected function screen_addedToStageHandler(event:Event):void
    {
        if (event.target != this)
        {
            return;
        }
        addEventListener(Event.REMOVED_FROM_STAGE, screen_removedFromStageHandler);
        //using priority here is a hack so that objects higher up in the
        //display list have a chance to cancel the event first.
        var priority:int = -getDisplayObjectDepthFromStage(this);
        Starling.current.nativeStage.addEventListener(KeyboardEvent.KEY_DOWN, screen_nativeStage_keyDownHandler, false,
                                                      priority, true);
    }

    /**
     * @private
     */
    protected function screen_removedFromStageHandler(event:Event):void
    {
        if (event.target != this)
        {
            return;
        }
        removeEventListener(Event.REMOVED_FROM_STAGE, screen_removedFromStageHandler);
        Starling.current.nativeStage.removeEventListener(KeyboardEvent.KEY_DOWN, screen_nativeStage_keyDownHandler);
    }

    protected function screen_nativeStage_keyDownHandler(event:KeyboardEvent):void
    {
        if (event.isDefaultPrevented())
        {
            //someone else already handled this one
            return;
        }
        if (backButtonHandler != null &&
                event.keyCode == Keyboard.BACK)
        {
            event.preventDefault();
            backButtonHandler();
        }

        if (menuButtonHandler != null &&
                event.keyCode == Keyboard.MENU)
        {
            event.preventDefault();
            menuButtonHandler();
        }

        if (searchButtonHandler != null &&
                event.keyCode == Keyboard.SEARCH)
        {
            event.preventDefault();
            searchButtonHandler();
        }
    }

    private function this_backButtonHandler():void
    {
        trace("BootstrapNavigator.this_backButtonHandler()");
        var data:ApplicationEventData = ApplicationEventData.create();
        eventDispatcher.dispatchEventWith(ApplicationEventType.BACK_CHANGE, false, data);
        eventDispatcher.dispatchEventWith(ApplicationEventType.BACK_CHANGED, false, data);
    }
    
    private function this_initializeHandler(event:Event):void
    {
        trace("BootstrapNavigator.INITIALIZE()");
    }

    private function this_creationCompleteHandler(event:Event):void
    {
        trace("BootstrapNavigator.CREATION_COMPLETE()");
    }

    private function this_addedToStageHandler(event:Event):void
    {
        trace("BootstrapNavigator.ADDED_TO_STAGE()");
    }

    private function this_removedToStageHandler(event:Event):void
    {
        trace("BootstrapNavigator.REMOVED_FROM_STAGE()");
    }
}
}
