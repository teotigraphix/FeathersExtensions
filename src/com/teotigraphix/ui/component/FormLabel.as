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
import feathers.layout.AnchorLayout;
import feathers.layout.AnchorLayoutData;
import feathers.skins.IStyleProvider;

public class FormLabel extends LayoutGroup
{
    public static var globalStyleProvider:IStyleProvider;

    private var _text:String;

    private var _textLabel:Label;

    override protected function get defaultStyleProvider():IStyleProvider
    {
        return FormLabel.globalStyleProvider;
    }

    public function get textLabel():Label
    {
        return _textLabel;
    }

    //--------------------------------------------------------------------------
    // API :: Properties
    //--------------------------------------------------------------------------

    //----------------------------------
    // text
    //----------------------------------

    public function get text():String
    {
        return _text;
    }

    public function set text(value:String):void
    {
        _text = value;
        invalidate(INVALIDATION_FLAG_DATA);
    }

    public function FormLabel()
    {
    }

    override protected function draw():void
    {
        super.draw();

        if (isInvalid(INVALIDATION_FLAG_DATA))
        {
            _textLabel.text = _text;
        }
    }

    override protected function initialize():void
    {
        super.initialize();

        var al:AnchorLayout = new AnchorLayout();
        layout = al;

        _textLabel = new Label();
        _textLabel.layoutData = new AnchorLayoutData(NaN, 0);

        addChild(_textLabel);
    }
}
}
