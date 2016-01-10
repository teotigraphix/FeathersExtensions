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
package com.teotigraphix.ui.control
{

import com.teotigraphix.ui.component.HGroup;

import feathers.controls.IScreen;

import feathers.skins.IStyleProvider;

public class ActionBar extends HGroup
{
    public static var globalStyleProvider:IStyleProvider;

    override protected function get defaultStyleProvider():IStyleProvider
    {
        return ActionBar.globalStyleProvider;
    }

    private var _hasBackButton:Boolean = false;
    private var _screen:IScreen;
    private var _title:String;

    public function get hasBackButton():Boolean
    {
        return _hasBackButton;
    }

    public function set hasBackButton(value:Boolean):void
    {
        _hasBackButton = value;
    }

    public function get screen():IScreen
    {
        return _screen;
    }

    public function set screen(value:IScreen):void
    {
        _screen = value;
    }

    //[Bindable]
    public function get title():String
    {
        return _title;
    }

    public function set title(value:String):void
    {
        _title = value;
        invalidate("title");
    }

    public function ActionBar()
    {
    }

    override protected function initialize():void
    {
        super.initialize();

        verticalAlign = "middle"
    }

    override protected function draw():void
    {
        super.draw();

        if (isInvalid("title"))
        {
            commitTitle();
        }
    }

    protected function commitTitle():void
    {

    }
}
}
