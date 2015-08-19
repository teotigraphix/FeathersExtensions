/**
 * Created by Teoti on 4/4/2015.
 */
package com.teotigraphix.ui.component
{

import feathers.core.FeathersControl;

import starling.display.Quad;

public class UIBorder extends FeathersControl
{
    private static const INVALIDATE_FLAG_COLOR:String = "color";

    private var _color:uint = 0x000000;
    private var _quad:Quad;

    [Bindable]
    public function get color():uint
    {
        return _color;
    }

    public function set color(value:uint):void
    {
        if (_color == value)
            return;
        _color = value;
        invalidate(INVALIDATE_FLAG_COLOR);
    }

    public function UIBorder()
    {
        super();
    }

    override protected function initialize():void
    {
        super.initialize();

        _quad = new Quad(25, 25, _color);
        addChild(_quad);
    }

    override protected function draw():void
    {
        super.draw();

        if (isInvalid(INVALIDATE_FLAG_COLOR))
        {
            _quad.color = _color;
        }

        if (isInvalid(INVALIDATION_FLAG_SIZE))
        {
            _quad.width = width;
            _quad.height = height;
        }
    }
}
}
