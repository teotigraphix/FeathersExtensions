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

import feathers.display.Scale9Image;
import feathers.textures.Scale9Textures;
import feathers.themes.StyleNameFunctionTheme;

import flash.geom.Rectangle;
import flash.utils.Dictionary;

import starling.display.Image;
import starling.textures.Texture;
import starling.textures.TextureAtlas;

public final class AssetMap
{

    public static var atlas:TextureAtlas;

    public static var scale:Number;

    public static var densityPixelRatio:Number;

    public static var theme:StyleNameFunctionTheme;

    //public static var scaleManager:ScreenDensityScaleFactorManager;

    private static var _textures:Dictionary = new Dictionary();

    private static var _scale9Textures:Dictionary = new Dictionary();

    //
    //public static function getDebugBackgroundImage():Scale9Image
    //{
    //    var t:Scale9Textures = new Scale9Textures(theme.backgroundDebugSkinTexture, new Rectangle(2, 2, 28, 28));
    //    return new Scale9Image(t, scale);
    //}

    public static function createImage(name:String):Image
    {
        var texture:Texture = getTexture(name);
        return new Image(texture);
    }

    public static function createScaledImage(name:String):Image
    {
        const image:Image = AssetMap.createImage(name);
        image.scaleX = image.scaleY = AssetMap.scale;
        return image;
    }

    public static function createScale9Textures(name:String, rectangle:Rectangle):Scale9Textures
    {
        if (_scale9Textures[name] != null)
            return _scale9Textures[name];

        var texture:Texture = getTexture(name);
        var t:Scale9Textures = new Scale9Textures(texture, rectangle);
        _scale9Textures[name] = t;
        return _scale9Textures[name]
    }

    public static function create9ScaleImage(name:String, x:int, y:int, width:int, height:int):Scale9Image
    {
        var t:Scale9Textures = getScale9Textures(name, x, y, width, height);
        return new Scale9Image(t, scale);
    }

    public static function getScale9Textures(name:String, x:int, y:int, width:int, height:int):Scale9Textures
    {
        if (_scale9Textures[name] != null)
            return _scale9Textures[name];

        var texture:Texture = getTexture(name);
        var t:Scale9Textures = new Scale9Textures(texture, new Rectangle(x, y, width, height));
        _scale9Textures[name] = t;
        return t;
    }

    public static function getTexture(name:String):Texture
    {
        if (_textures[name] != null)
            return _textures[name];
        var t:Texture = atlas.getTexture(name);
        _textures[name] = t;
        return t;
    }

    public static function size(size:Number):Number
    {
        return Math.round(size * scale);
    }

    public static function dp(size:Number):Number
    {
        return Math.round(size * densityPixelRatio);
    }
}
}
