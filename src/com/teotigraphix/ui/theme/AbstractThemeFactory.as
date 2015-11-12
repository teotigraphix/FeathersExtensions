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

package com.teotigraphix.ui.theme
{

import feathers.controls.SimpleScrollBar;

import starling.textures.TextureAtlas;

public class AbstractThemeFactory
{
    public var theme:AbstractTheme;
    public var properties:ThemeProperties;
    private var _atlas:TextureAtlas;

    public final function get font():FontFactory
    {
        return theme.fonts;
    }

    public final function get shared():SharedFactory
    {
        return theme.shared;
    }

    public function get atlas():TextureAtlas
    {
        return _atlas;
    }

    public function set atlas(value:TextureAtlas):void
    {
        _atlas = value;
    }

    public function AbstractThemeFactory(theme:AbstractTheme)
    {
        this.theme = theme;
    }

    public function initializeScale():void
    {
    }

    public function initializeDimensions():void
    {
    }

    public function initializeFonts():void
    {
    }

    public function initializeTextures():void
    {
    }

    public function initializeGlobals():void
    {
    }

    public function initializeStage():void
    {
    }

    public function initializeStyleProviders():void
    {
    }

    protected function setStyle(clazz:Class, func:Function, name:String = null):void
    {
        if (name != null)
        {
            theme.getStyleProviderForClass(clazz).setFunctionForStyleName(name, func);
        }
        else
        {
            theme.getStyleProviderForClass(clazz).defaultStyleFunction = func;
        }
    }

    protected static function scrollBarFactory():SimpleScrollBar
    {
        return new SimpleScrollBar();
    }

    protected static function size(dimension:Number):Number
    {
        return AssetMap.size(dimension);
    }

}
}
