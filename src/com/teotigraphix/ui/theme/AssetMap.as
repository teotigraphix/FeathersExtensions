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

import feathers.themes.StyleNameFunctionTheme;

import starling.display.Image;
import starling.textures.Texture;
import starling.textures.TextureAtlas;

public final class AssetMap
{
    
    public static var atlas:TextureAtlas;
    public static var runtimeAtlas:TextureAtlas;
    
    public static var theme:StyleNameFunctionTheme;
    
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
    
    public static function create9ScaleImageFrom(name:String, rectangle:Rectangle, isRuntime:Boolean = false):Image
    {
        var image:Image = createImage(name, isRuntime);
        image.scale9Grid = rectangle;
        return image;
    }
    
    public static function create9ScaleImage(name:String, x:int, y:int, width:int, height:int, isRuntime:Boolean = false):Image
    {
        return create9ScaleImageFrom(name, new Rectangle(x, y, width, height), isRuntime);
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
}
}
