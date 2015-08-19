/**
 * Created by Teoti on 5/17/2015.
 */
package com.teotigraphix.ui.component
{

import feathers.skins.IStyleProvider;

public class GridButton extends UIToggleButton
{
    public static var globalStyleProvider:IStyleProvider;

    private var _data:Object;

    override protected function get defaultStyleProvider():IStyleProvider
    {
        return GridButton.globalStyleProvider;
    }

    public function get data():Object
    {
        return _data;
    }

    public function set data(value:Object):void
    {
        _data = value;
    }

    public function GridButton()
    {
    }

    override protected function initialize():void
    {
        super.initialize();
        isLongPressEnabled = true;
    }
}
}
