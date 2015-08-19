/**
 * Created by Teoti on 3/22/2015.
 */
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

    public static var theme:StyleNameFunctionTheme;

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

    public static function getSize(size:int):Number
    {
        return size * scale;
    }

    public static function getWidth(width:int):Number
    {
        return width * scale;
    }

    public static function getHeight(height:int):Number
    {
        return height * scale;
    }
}
}
