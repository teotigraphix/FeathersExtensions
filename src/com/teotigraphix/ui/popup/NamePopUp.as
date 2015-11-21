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

import com.teotigraphix.ui.theme.AssetMap;

import feathers.controls.ButtonGroup;
import feathers.controls.Header;
import feathers.controls.Panel;
import feathers.controls.TextInput;
import feathers.data.ListCollection;
import feathers.layout.AnchorLayout;
import feathers.layout.AnchorLayoutData;

import starling.display.DisplayObject;
import starling.events.Event;

public class NamePopUp extends Panel
{

    public static const EVENT_OK:String = "ok";
    public static const EVENT_CANCEL:String = "cancel";

    private var _textInput:TextInput;
    private var _buttonGroup:ButtonGroup;

    private var _prompt:String;
    private var _text:String;

    //----------------------------------
    // presetName
    //----------------------------------

    public function get prompt():String
    {
        return _prompt;
    }

    public function set prompt(value:String):void
    {
        _prompt = value;
        invalidate(INVALIDATION_FLAG_DATA);
    }

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

    override protected function initialize():void
    {
        super.initialize();

        layout = new AnchorLayout();

        const padding:Number = AssetMap.size(10);

        _textInput = new TextInput();
        _textInput.layoutData = new AnchorLayoutData(padding, padding, padding, padding);
        _textInput.prompt = _prompt;
        _textInput.addEventListener(Event.CHANGE, textInput_changeHandler);
        addChild(_textInput);

        _buttonGroup = new ButtonGroup();
        _buttonGroup.direction = ButtonGroup.DIRECTION_HORIZONTAL;
        _buttonGroup.dataProvider = new ListCollection([{label: "OK", isEnabled:false}, {label: "Cancel"}]);
        _buttonGroup.addEventListener(Event.TRIGGERED, buttonGroup_triggeredHandler);

        footerFactory = function ():Header
        {
            var header:Header = new Header();
            header.centerItems = new <DisplayObject>[_buttonGroup];
            return header;
        }
    }

    override protected function draw():void
    {
        super.draw();

        if (isInvalid(INVALIDATION_FLAG_DATA))
        {
            _textInput.prompt = _prompt;
            _textInput.text = _text;
        }
    }

    protected function buttonGroup_triggeredHandler(event:Event, data:Object):void
    {
        if (data.label == "OK")
        {
            _text = _textInput.text;
            dispatchEventWith(EVENT_OK, false, _text);
        }
        else
        {
            dispatchEventWith(EVENT_CANCEL);
        }
    }

    protected function textInput_changeHandler(event:Event):void
    {
        var dp:ListCollection = _buttonGroup.dataProvider;
        _buttonGroup.dataProvider.getItemAt(0).isEnabled = (_text != null && _text != "");
        _buttonGroup.dataProvider.updateItemAt(0);
        _buttonGroup.dataProvider = dp;
    }
}
}
