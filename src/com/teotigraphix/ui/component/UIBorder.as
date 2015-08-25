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

import starling.display.Quad;

public class UIBorder extends FeathersControl
{
    private static const INVALIDATE_FLAG_COLOR:String = "color";

    private var _color:uint = 0x000000;
    private var _quad:Quad;

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
