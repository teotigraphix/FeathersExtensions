/**
 * Created by Teoti on 4/27/2015.
 */
package com.teotigraphix.ui.component
{

import feathers.controls.LayoutGroup;

public class PaneStack extends LayoutGroup
{
    public static const INVALIDATE_FLAG_SELECTED_INDEX:String = "selectedIndex";

    private var _selectedIndex:int = -1;

    public function get selectedIndex():int
    {
        return _selectedIndex;
    }

    public function set selectedIndex(value:int):void
    {
        if (_selectedIndex == value)
            return;
        _selectedIndex = value;
        invalidate(INVALIDATE_FLAG_SELECTED_INDEX);
    }

    public function PaneStack()
    {
    }

    override protected function initialize():void
    {
        super.initialize();
    }

    override protected function draw():void
    {
        super.draw();

        if (isInvalid(INVALIDATE_FLAG_SELECTED_INDEX))
        {
            for (var i:int = 0; i < numChildren; i++)
            {
                getChildAt(i).visible = false;
            }

            if (_selectedIndex != -1)
            {
                getChildAt(_selectedIndex).visible = true;
            }
        }
    }
}
}
