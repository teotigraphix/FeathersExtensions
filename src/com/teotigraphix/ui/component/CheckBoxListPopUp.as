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

import com.teotigraphix.ui.theme.AssetMap;

import feathers.controls.Button;
import feathers.controls.Header;
import feathers.controls.LayoutGroup;
import feathers.controls.Panel;
import feathers.data.ListCollection;
import feathers.layout.AnchorLayout;
import feathers.layout.AnchorLayoutData;
import feathers.layout.HorizontalLayout;

import starling.display.DisplayObject;
import starling.events.Event;

public class CheckBoxListPopUp extends Panel
{
    public static const EVENT_OK_TAP:String = "okTap";
    public static const EVENT_CANCEL_TAP:String = "cancelTap";

    private var _dataProvider:ListCollection;

    // title, dataProvider, selectAll, unSelectAll
    // OK, Cancel
    private var _checkBoxList:CheckBoxList;
    private var _selectAllButton:Button;
    private var _selectNoneButton:Button;
    private var _okButton:Button;
    private var _cancelButton:Button;

    public function get dataProvider():ListCollection
    {
        return _dataProvider;
    }

    public function set dataProvider(value:ListCollection):void
    {
        _dataProvider = value;
        invalidate(INVALIDATION_FLAG_DATA);
    }

    public function CheckBoxListPopUp()
    {
    }

    override protected function initialize():void
    {
        var l:AnchorLayout = new AnchorLayout();
        layout = l;

        super.initialize();

        backgroundSkin = AssetMap.create9ScaleImage("background-popup-shadow-skin", 8, 8, 16, 16);

        headerFactory = function ():Header
        {
            var header:Header = new Header();

            _selectAllButton = new Button();
            _selectAllButton.label = "All";
            _selectAllButton.width = 100;

            _selectNoneButton = new Button();
            _selectNoneButton.label = "None";
            _selectNoneButton.width = 100;

            _selectAllButton.addEventListener(Event.TRIGGERED, selectAllButton_triggeredHandler);
            _selectNoneButton.addEventListener(Event.TRIGGERED, selectNoneButton_triggeredHandler);

            header.rightItems = new <DisplayObject>[_selectAllButton, _selectNoneButton];

            return header;
        };

        _checkBoxList = new CheckBoxList();
        _checkBoxList.layoutData = new AnchorLayoutData(10, 10, 10, 10);
        addChild(_checkBoxList);

        footerFactory = function ():LayoutGroup
        {
            var footer:LayoutGroup = new LayoutGroup();
            var fl:HorizontalLayout = new HorizontalLayout();
            fl.horizontalAlign = HorizontalLayout.HORIZONTAL_ALIGN_CENTER;
            fl.padding = 10;
            footer.layout = fl;

            _okButton = new Button();
            _okButton.label = "OK";
            _okButton.width = 200;

            _cancelButton = new Button();
            _cancelButton.label = "Cancel";
            _cancelButton.width = 200;

            footer.addChild(_okButton);
            footer.addChild(_cancelButton);

            _okButton.addEventListener(Event.TRIGGERED, okButton_triggeredHandler);
            _cancelButton.addEventListener(Event.TRIGGERED, cancelButton_triggeredHandler);

            //footer.styleNameList.add( LayoutGroup.ALTERNATE_STYLE_NAME_TOOLBAR );
            return footer;
        };

    }

    override protected function draw():void
    {
        super.draw();

        if (isInvalid(INVALIDATION_FLAG_DATA))
        {
            _checkBoxList.dataProvider = _dataProvider;
        }
    }

    private function selectAllButton_triggeredHandler(event:Event):void
    {
        for (var i:int = 0; i < _dataProvider.length; i++)
        {
            var object:Object = _dataProvider.getItemAt(i);
            object.isSelected = true;
            object.control.isSelected = true;
        }
    }

    private function selectNoneButton_triggeredHandler(event:Event):void
    {
        for (var i:int = 0; i < _dataProvider.length; i++)
        {
            var object:Object = _dataProvider.getItemAt(i);
            object.isSelected = false;
            object.control.isSelected = false;
        }
    }

    private function okButton_triggeredHandler(event:Event):void
    {
        dispatchEventWith(EVENT_OK_TAP);
    }

    private function cancelButton_triggeredHandler(event:Event):void
    {
        dispatchEventWith(EVENT_CANCEL_TAP);
    }

}
}
