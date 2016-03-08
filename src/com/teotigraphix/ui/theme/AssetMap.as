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

import flash.geom.Rectangle;
import flash.utils.Dictionary;

import feathers.display.Scale9Image;
import feathers.textures.Scale9Textures;
import feathers.themes.StyleNameFunctionTheme;

import starling.display.Image;
import starling.textures.Texture;
import starling.textures.TextureAtlas;

public final class AssetMap
{
    
    public static var atlas:TextureAtlas;
    public static var runtimeAtlas:TextureAtlas;
    
    
    public static var scale:Number;
    
    public static var densityPixelRatio:Number;
    
    public static var theme:StyleNameFunctionTheme;
    
    //public static var scaleManager:ScreenDensityScaleFactorManager;
    
    private static var _textures:Dictionary = new Dictionary();
    private static var _scale9Textures:Dictionary = new Dictionary();
    
    private static var _runtimeTextures:Dictionary = new Dictionary();
    private static var _runtimeScale9Textures:Dictionary = new Dictionary();
    
    //
    //public static function getDebugBackgroundImage():Scale9Image
    //{
    //    var t:Scale9Textures = new Scale9Textures(theme.backgroundDebugSkinTexture, new Rectangle(2, 2, 28, 28));
    //    return new Scale9Image(t, scale);
    //}
    
    public static function createImage(name:String, isRuntime:Boolean = false):Image
    {
        var texture:Texture = getTexture(name, isRuntime);
        return new Image(texture);
    }
    
    public static function createScaledImage(name:String, isRuntime:Boolean = false):Image
    {
        const image:Image = createImage(name, isRuntime);
        image.scaleX = image.scaleY = AssetMap.scale;
        return image;
    }
    
    public static function createScale9Textures(name:String, rectangle:Rectangle, isRuntime:Boolean = false):Scale9Textures
    {
        var textures:Dictionary = isRuntime ? _runtimeScale9Textures : _scale9Textures;
        if (textures[name] != null)
            return textures[name];
        
        var texture:Texture = getTexture(name, isRuntime);
        textures[name] = new Scale9Textures(texture, rectangle);
        return textures[name]
    }
    
    public static function create9ScaleImage(name:String, x:int, y:int, width:int, height:int, isRuntime:Boolean = false):Scale9Image
    {
        var t:Scale9Textures = getScale9Textures(name, x, y, width, height, isRuntime);
        return new Scale9Image(t, scale);
    }
    
    public static function getScale9Textures(name:String, x:int, y:int, width:int, height:int, isRuntime:Boolean = false):Scale9Textures
    {
        var textures:Dictionary = isRuntime ? _runtimeScale9Textures : _scale9Textures;
        if (textures[name] != null)
            return textures[name];
        
        var texture:Texture = getTexture(name, isRuntime);
        textures[name] = new Scale9Textures(texture, new Rectangle(x, y, width, height));
        return textures[name];
    }
    
    public static function getTexture(name:String, isRuntime:Boolean = false):Texture
    {
        var textures:Dictionary = isRuntime ? _runtimeTextures : _textures;
        var selectedAtlas:TextureAtlas = isRuntime ? runtimeAtlas : atlas;
        
        if (textures[name] != null)
            return textures[name];
        var t:Texture = selectedAtlas.getTexture(name);
        textures[name] = t;
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
