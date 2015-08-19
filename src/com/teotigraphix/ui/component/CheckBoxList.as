/**
 * Created by Teoti on 5/25/2015.
 */
package com.teotigraphix.ui.component
{

import feathers.controls.Check;
import feathers.controls.LayoutGroup;
import feathers.controls.List;
import feathers.controls.renderers.DefaultListItemRenderer;
import feathers.controls.renderers.IListItemRenderer;
import feathers.data.ListCollection;
import feathers.layout.VerticalLayout;
import feathers.layout.VerticalLayoutData;

import starling.events.Event;

public class CheckBoxList extends LayoutGroup
{
    /**
     * @data item
     */
    public static const EVENT_CHECK_CHANGE:String = "listChange";

    private var _list:List;
    private var _dataProvider:ListCollection;

    public function get dataProvider():ListCollection
    {
        return _dataProvider;
    }

    public function set dataProvider(value:ListCollection):void
    {
        if (_dataProvider != null)
        {
            _dataProvider.dispose(disposeDataProvider);
        }
        _dataProvider = value;
        invalidate(INVALIDATION_FLAG_DATA);
    }

    public function CheckBoxList()
    {
    }

    override protected function initialize():void
    {
        var l:VerticalLayout = new VerticalLayout();
        layout = l;

        super.initialize();

        _list = new List();
        _list.isSelectable = false;
        _list.itemRendererFactory = function ():IListItemRenderer
        {
            var renderer:DefaultListItemRenderer = new DefaultListItemRenderer();
            renderer.labelField = "label";
            renderer.iconField = "control";
            return renderer;
        };
        _list.layoutData = new VerticalLayoutData(100, 100);

        addChild(_list);
    }

    override protected function draw():void
    {
        super.draw();

        if (isInvalid(INVALIDATION_FLAG_DATA))
        {
            if (_dataProvider != null)
            {
                for (var i:int = 0; i < _dataProvider.length; i++)
                {
                    var object:Object = _dataProvider.getItemAt(i);
                    var checkbox:Check = new Check();
                    checkbox.isSelected = object.isSelected;
                    checkbox.addEventListener(Event.CHANGE, check_changeHandler);
                    object.control = checkbox;
                }
            }
            _list.dataProvider = _dataProvider;
        }
    }

    private function disposeDataProvider(item:Object):void
    {
        Check(item.control).dispose();
        item.control = null;
        delete item.control;
    }

    private function getControlIndex(check:Check):int
    {
        for (var i:int = 0; i < _dataProvider.length; i++)
        {
            var object:Object = _dataProvider.getItemAt(i);
            if (object.control == check)
                return i;
        }
        return -1;
    }

    private function check_changeHandler(event:Event):void
    {
        var check:Check = Check(event.currentTarget);
        var index:int = getControlIndex(check);
        var item:Object = _dataProvider.getItemAt(index);
        item.isSelected = check.isSelected;
        dispatchEventWith(EVENT_CHECK_CHANGE, false, item);
    }
}
}
