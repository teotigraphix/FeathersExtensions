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

import feathers.core.FeathersControl;
import feathers.core.ToggleGroup;
import feathers.data.ListCollection;
import feathers.events.CollectionEventType;
import feathers.events.FeathersEventType;
import feathers.skins.IStyleProvider;

import flash.text.engine.ElementFormat;
import flash.utils.Dictionary;

import starling.display.DisplayObject;
import starling.events.Event;
import starling.events.Touch;
import starling.events.TouchEvent;
import starling.events.TouchPhase;

/**
 *
 */
public class GridGroup extends FeathersControl
{
    //--------------------------------------------------------------------------
    // Events
    //--------------------------------------------------------------------------

    public static const EVENT_SELECTED_INDEX_CHANGE:String = "selectedIndexChange";
    public static const EVENT_ITEM_DOUBLE_TAP:String = "itemDoubleTap";
    /**
     * {item:dataProvider[n], touch:Touch}
     */
    public static const EVENT_ITEM_LONG_PRESS:String = "itemLongPress";

    //--------------------------------------------------------------------------
    // Flags
    //--------------------------------------------------------------------------

    protected static const INVALIDATION_FLAG_DATA_CHANGE:String = "dataChange";
    protected static const INVALIDATION_FLAG_SELECTED_INDEX_CHANGE:String = "selectedIndex";

    public static var globalStyleProvider:IStyleProvider;

    public var buttonStyleName:String;
    public var isActiveElementStyle:ElementFormat;
    public var isNotActiveElementStyle:ElementFormat;

    //--------------------------------------------------------------------------
    // Private :: Variables
    //--------------------------------------------------------------------------

    protected var _buttons:Dictionary;

    private var _selectedIndex:int = -1;
    private var _toggleGroup:ToggleGroup;
    private var _padding:int;
    private var _gap:int;
    private var _dataProvider:ListCollection;
    private var _numColumns:int;
    private var _numRows:int;
    private var updatingToggleGroup:Boolean;
    private var _touch:Touch;

    override protected function get defaultStyleProvider():IStyleProvider
    {
        return GridGroup.globalStyleProvider;
    }

    //--------------------------------------------------------------------------
    // Public API : Properties
    //--------------------------------------------------------------------------

    //----------------------------------
    // selectedIndex
    //----------------------------------

    public function get selectedIndex():int
    {
        return _selectedIndex;
    }

    public function set selectedIndex(value:int):void
    {
        if (_selectedIndex == value)
            return;
        _selectedIndex = value;
        invalidate(INVALIDATION_FLAG_SELECTED_INDEX_CHANGE);
        dispatchEventWith(EVENT_SELECTED_INDEX_CHANGE, true, _selectedIndex);
    }

    //----------------------------------
    // toggleGroup
    //----------------------------------

    public function get toggleGroup():ToggleGroup
    {
        return _toggleGroup;
    }

    //----------------------------------
    // dataProvider
    //----------------------------------

    public function get dataProvider():ListCollection
    {
        return _dataProvider;
    }

    public function set dataProvider(value:ListCollection):void
    {
        if (_dataProvider != null)
        {
            _dataProvider.removeEventListener(CollectionEventType.RESET, dataProvider_resetHandler);
            _dataProvider.removeEventListener(Event.CHANGE, dataProvider_changeHandler);
        }
        _dataProvider = value;
        if (_dataProvider != null)
        {
            _dataProvider.addEventListener(CollectionEventType.RESET, dataProvider_resetHandler);
            _dataProvider.addEventListener(Event.CHANGE, dataProvider_changeHandler);
        }
        invalidate(INVALIDATION_FLAG_DATA);
        invalidate(INVALIDATION_FLAG_SIZE);
    }

    //----------------------------------
    // numColumns
    //----------------------------------

    public function get numColumns():int
    {
        return _numColumns;
    }

    public function set numColumns(value:int):void
    {
        if (_numColumns == value)
            return;
        _numColumns = value;
        invalidate(INVALIDATION_FLAG_LAYOUT);
    }

    //----------------------------------
    // numRows
    //----------------------------------

    public function get numRows():int
    {
        return _numRows;
    }

    public function set numRows(value:int):void
    {
        if (_numRows == value)
            return;
        _numRows = value;
        invalidate(INVALIDATION_FLAG_LAYOUT);
    }

    //----------------------------------
    // padding
    //----------------------------------

    public function get padding():int
    {
        return _padding;
    }

    public function set padding(value:int):void
    {
        if (_padding == value)
            return;
        _padding = value;
        invalidate(INVALIDATION_FLAG_LAYOUT);
    }

    //----------------------------------
    // gap
    //----------------------------------

    public function get gap():int
    {
        return _gap;
    }

    public function set gap(value:int):void
    {
        if (_gap == value)
            return;
        _gap = value;
        invalidate(INVALIDATION_FLAG_LAYOUT);
    }

    //--------------------------------------------------------------------------
    // Constructor
    //--------------------------------------------------------------------------

    public function GridGroup()
    {
    }

    //--------------------------------------------------------------------------
    // Overridden Protected :: Methods
    //--------------------------------------------------------------------------

    override protected function initialize():void
    {
        super.initialize();

        _toggleGroup = new ToggleGroup();
        _toggleGroup.addEventListener(Event.CHANGE, toggleGroup_changeHandler);
    }

    override protected function draw():void
    {
        super.draw();

        const dataInvalid:Boolean = isInvalid(INVALIDATION_FLAG_DATA);

        if (dataInvalid && _dataProvider != null)
        {
            commitData();
        }

        if (isInvalid(INVALIDATION_FLAG_DATA_CHANGE) && _dataProvider != null)
        {
            refreshData();
        }

        if (isInvalid(INVALIDATION_FLAG_SELECTED_INDEX_CHANGE))
        {
            _toggleGroup.selectedIndex = _selectedIndex;
        }

        const layoutInvalid:Boolean = isInvalid(INVALIDATION_FLAG_LAYOUT);
        const sizeInvalid:Boolean = autoSizeIfNeeded() || isInvalid(INVALIDATION_FLAG_SIZE);

        if (sizeInvalid || layoutInvalid || dataInvalid)
        {
            layoutChildren();
        }
    }

    protected function autoSizeIfNeeded():Boolean
    {
        var needsWidth:Boolean = this.explicitWidth !== this.explicitWidth; //isNaN
        var needsHeight:Boolean = this.explicitHeight !== this.explicitHeight; //isNaN
        if (!needsWidth && !needsHeight)
        {
            return false;
        }

        var newWidth:Number = this.explicitWidth;
        var newHeight:Number = this.explicitHeight;

        if (needsWidth)
        {
            newWidth = (25 * _numColumns) + (_gap * (_numColumns - 1)) + (_padding * 2);

        }

        if (needsHeight)
        {
            newHeight = (25 * _numRows) + (_gap * (_numRows - 1)) + (_padding * 2);
        }

        return setSizeInternal(newWidth, newHeight, false);
    }

    //--------------------------------------------------------------------------
    // Protected :: Methods
    //--------------------------------------------------------------------------

    protected function commitData():void
    {
        removeChildren();

        updatingToggleGroup = true;
        _toggleGroup.removeAllItems();

        _buttons = new Dictionary();

        var index:int = 0;
        for (var i:int = 0; i < _numRows; i++)
        {
            for (var j:int = 0; j < _numColumns; j++)
            {
                var data:Object = _dataProvider.getItemAt(index);
                var child:GridButton = createButton(index, data);

                refreshButton(child, data);
                addChild(child);

                index++;
            }
        }

        toggleGroup.selectedIndex = _selectedIndex;

        updatingToggleGroup = false;
    }

    protected function refreshData():void
    {
        if (numChildren == 0)
            return;

        var index:int = 0;
        for (var i:int = 0; i < _numRows; i++)
        {
            for (var j:int = 0; j < _numColumns; j++)
            {
                var data:Object = _dataProvider.getItemAt(index);
                var child:GridButton = _buttons[data];

                refreshButton(child, data);
                index++;
            }
        }
    }

    protected function createButton(index:int, data:Object):GridButton
    {
        var child:GridButton = new GridButton();
        child.addEventListener(FeathersEventType.LONG_PRESS, button_longPressHandler);
        child.addEventListener(TouchEvent.TOUCH, button_touchHandler);
        if (data.hasOwnProperty("index"))
        {
            data.index = index;
        }
        child.data = data;
        child.styleNameList.add(buttonStyleName);
        child.label = data.label;
        _buttons[data] = child;
        _toggleGroup.addItem(child);
        return child;
    }

    protected function refreshButton(button:GridButton, data:Object):void
    {
        if (data.hasOwnProperty("isEnabled"))
        {
            button.isEnabled = data.isEnabled;
        }
        if (data.hasOwnProperty("isActive"))
        {
            button.defaultLabelProperties.elementFormat = data.isActive ?
                    isActiveElementStyle : isNotActiveElementStyle;
        }
    }

    protected function childSizeChanged(child:DisplayObject):void
    {

    }

    private function layoutChildren():void
    {
        if (numChildren == 0)
            return;

        var contentWidth:Number = actualWidth - (_gap * (_numColumns - 1)) - (_padding * 2);
        var contentHeight:Number = actualHeight - (_gap * (_numRows - 1)) - (_padding * 2);

        trace("layoutChildren " + contentWidth + ", " + contentHeight);

        var calcWidth:Number = contentWidth / _numColumns;
        var calcHeight:Number = contentHeight / _numRows;

        trace("calcWidth/calcHeight " + calcWidth + ", " + calcHeight);

        var calcX:Number = _padding;
        var calcY:Number = _padding;

        var index:int = 0;
        for (var i:int = 0; i < _numRows; i++)
        {
            for (var j:int = 0; j < _numColumns; j++)
            {
                var child:DisplayObject = DisplayObject(getChildAt(index));
                child.x = calcX;
                child.y = calcY;
                child.width = calcWidth;
                child.height = calcHeight;
                childSizeChanged(child);
                calcX += calcWidth + _gap;
                index++;
            }
            calcX = _padding;
            calcY += calcHeight + _gap;
        }
    }

    //--------------------------------------------------------------------------
    // EventHandlers
    //--------------------------------------------------------------------------

    private function toggleGroup_changeHandler(event:Event):void
    {
        if (updatingToggleGroup)
            return;
        selectedIndex = _toggleGroup.selectedIndex;
    }

    private function button_touchHandler(event:TouchEvent):void
    {
        _touch = event.getTouch(this);
        if (_touch != null)
        {
            var button:GridButton = event.target as GridButton;
            if (_touch.phase == TouchPhase.ENDED)
            {
                if (_touch.tapCount == 2)
                {
                    //var data:Object = {item: button.data, touch: _touch};
                    dispatchEventWith(EVENT_ITEM_DOUBLE_TAP, false, button.data);
                }
            }
        }
    }

    private function button_longPressHandler(event:Event):void
    {
        var button:GridButton = event.target as GridButton;
        button.isSelected = true;
        var data:Object = {item: button.data, touch: _touch};
        dispatchEventWith(EVENT_ITEM_LONG_PRESS, false, data);
    }

    private function dataProvider_resetHandler(event:Event):void
    {
        invalidate(INVALIDATION_FLAG_DATA);
    }

    private function dataProvider_changeHandler(event:Event):void
    {
        invalidate(INVALIDATION_FLAG_DATA_CHANGE);
    }

}
}
