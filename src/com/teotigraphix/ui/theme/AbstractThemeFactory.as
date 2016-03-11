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

import flash.display.DisplayObject;
import flash.geom.Rectangle;

import feathers.controls.SimpleScrollBar;

import org.as3commons.lang.StringUtils;

import starling.display.Image;
import starling.events.EventDispatcher;
import starling.textures.Texture;
import starling.textures.TextureAtlas;

public class AbstractThemeFactory extends EventDispatcher
{
    public var theme:AbstractTheme;
    public var properties:ThemeProperties;
    private var _atlas:TextureAtlas;
    private var _runtimeAtlas:TextureAtlas;
    

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
    
    public function get runtimeAtlas():TextureAtlas
    {
        return _runtimeAtlas;
    }
    
    public function set runtimeAtlas(value:TextureAtlas):void
    {
        _runtimeAtlas = value;
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
    
    public function initializeSkins(skins:Vector.<DisplayObject>):void
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
    
    protected static function createImage(name:String, isRuntime:Boolean = false):Image
    {
        return AssetMap.createImage(name, isRuntime);
    }

    protected static function create9ScaleImageFrom(name:String, rectangle:Rectangle, isRuntime:Boolean = false):Image
    {
        return AssetMap.create9ScaleImageFrom(name, rectangle, isRuntime);
    }
    
    protected static function create9ScaleImage(name:String, x:int, y:int, width:int, height:int, isRuntime:Boolean = false):Image
    {
        return AssetMap.create9ScaleImage(name, x, y, width, height, isRuntime);
    }

    protected static function getTexture(name:String, isRuntime:Boolean = false):Texture
    {
        return AssetMap.getTexture(name, isRuntime);
    }
    
    // NOT IMPL
    
    public function loadPartsAs9ScaleImage(instance:Object, clazz:Class, rectangle:Rectangle):void
    {
        for each (var partName:String in clazz["parts"])
        {
            var styleName:String = capitalizeDash(partName);
            instance[styleName] = AssetMap.create9ScaleImage(clazz["cssName"] + "-" + partName + "-skin",
                rectangle.x, rectangle.y, rectangle.width,
                rectangle.height);
        }
    }
    
    public function loadPartsAsImage(instance:Object, clazz:Class):void
    {
        for each (var partName:String in clazz["parts"])
        {
            var styleName:String = capitalizeDash(partName);
            instance[styleName] = AssetMap.createImage(clazz["cssName"] + "-" + partName + "-skin");
        }
    }
    
    public static function capitalizeDash(text:String):String
    {
        var split:Array = text.split("-");
        if (split.length == 1)
            return text + "Skin";
        
        var result:String = split.shift();
        for each (var chunk:String in split)
        {
            result += StringUtils.titleize(chunk);
        }
        return result + "Skin";
    }

}
}
