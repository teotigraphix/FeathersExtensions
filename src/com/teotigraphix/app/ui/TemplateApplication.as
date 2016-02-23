////////////////////////////////////////////////////////////////////////////////
// Copyright 2016 Michael Schmalle - Teoti Graphix, LLC
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

import flash.desktop.NativeApplication;
import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.ui.Keyboard;

import feathers.core.StackScreenNavigatorApplication;
import feathers.events.FeathersEventType;
import feathers.utils.display.getDisplayObjectDepthFromStage;

import org.robotlegs.starling.mvcs.Context;

import starling.core.Starling;
import starling.events.Event;

/*

Template has 

- LoadingScreeen
- MainScreen
- SettingsScreen

LoadingScreeen
- Image

MainScreen is the template
- (top)    ApplicationActionBar
- (left)   ApplicationToolBar
- (center) StackScreenNavigator
- (right)  ApplicationContentToolBar
- (bottom) ApplicationStatusBar

SettingsScreen
- Eventually data provider with group list for all ApplicationSettings

*/

public class TemplateApplication extends StackScreenNavigatorApplication 
    implements IBootstrapApplication, IBootstrapNavigator
{
    public var backButtonHandler:Function;
    public var menuButtonHandler:Function;
    public var searchButtonHandler:Function;
    
    private var _context:Context;
    
    //----------------------------------
    // context
    //----------------------------------
    
    public function get context():Context
    {
        return _context;
    }
    
    public function set context(value:Context):void
    {
        _context = value;
        _context.contextView = this;
    }

    //--------------------------------------------------------------------------
    // Constructor
    //--------------------------------------------------------------------------
    
    public function TemplateApplication()
    {
        super();
        
        addEventListener(starling.events.Event.ADDED, this_addedHandler);
        addEventListener(FeathersEventType.INITIALIZE, this_initializeHandler);
        addEventListener(FeathersEventType.CREATION_COMPLETE, this_creationCompleteHandler);
        addEventListener(starling.events.Event.ADDED_TO_STAGE, this_addedToStageHandler);
        addEventListener(starling.events.Event.REMOVED_FROM_STAGE, this_removedToStageHandler);
        
        var application:NativeApplication = NativeApplication.nativeApplication;
        application.addEventListener(/*flash.events.Event.EXITING*/"exiting", closingHandler);
        
        
        ///
        
        
        this.addEventListener(flash.events.Event.ADDED_TO_STAGE, screen_addedToStageHandler);

        
        backButtonHandler = this_backButtonHandler;
    }
    
    private function this_backButtonHandler():void
    {
        trace("BootstrapNavigator.this_backButtonHandler()");
        var data:ApplicationEventData = ApplicationEventData.create();
        //eventDispatcher.dispatchEventWith(ApplicationEventType.BACK_CHANGE, false, data);
        //eventDispatcher.dispatchEventWith(ApplicationEventType.BACK_CHANGED, false, data);
    }
    
    private function this_addedHandler(event:starling.events.Event):void
    {
        if (event.target != this)
            return;
        
        trace("TemplateApplication.ADDED_TO_STAGE()");
        trace("Start context");
        context.startup();
        context.eventDispatcher.dispatchEventWith("showLoadingScreen");
        trace("<<<<<<<<<<<<<<<<<<<<<<< Start context");
    }
    
    private function this_initializeHandler(event:starling.events.Event):void
    {
        trace("TemplateApplication.INITIALIZE()");
    }
    
    private function this_creationCompleteHandler(event:starling.events.Event):void
    {
        trace("TemplateApplication.CREATION_COMPLETE()");
    }
    
    private function this_addedToStageHandler(event:starling.events.Event):void
    {
        trace("TemplateApplication.ADDED_TO_STAGE()");
    }
    
    private function this_removedToStageHandler(event:flash.events.Event):void
    {
        trace("TemplateApplication.REMOVED_FROM_STAGE()");
    }
    
    private function closingHandler(event:flash.events.Event):void
    {
    }
    //
    
    /**
     * @private
     */
    protected function screen_addedToStageHandler(event:starling.events.Event):void
    {
        if (event.target != this)
        {
            return;
        }
        addEventListener(flash.events.Event.REMOVED_FROM_STAGE, screen_removedFromStageHandler);
        //using priority here is a hack so that objects higher up in the
        //display list have a chance to cancel the event first.
        var priority:int = -getDisplayObjectDepthFromStage(this);
        Starling.current.nativeStage.addEventListener(KeyboardEvent.KEY_DOWN, screen_nativeStage_keyDownHandler, false,
            priority, true);
    }
    
    /**
     * @private
     */
    protected function screen_removedFromStageHandler(event:starling.events.Event):void
    {
        if (event.target != this)
        {
            return;
        }
        removeEventListener(flash.events.Event.REMOVED_FROM_STAGE, screen_removedFromStageHandler);
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
}
}