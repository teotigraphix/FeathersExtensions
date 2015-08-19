/**
 * Created by Teoti on 4/9/2015.
 */
package com.teotigraphix.ui.component
{

import com.teotigraphix.ui.theme.AssetMap;

import flash.display.Bitmap;
import flash.geom.Point;

import starling.display.Image;
import starling.display.Sprite;
import starling.events.Event;
import starling.events.Touch;
import starling.events.TouchEvent;
import starling.events.TouchPhase;
import starling.textures.Texture;
import starling.utils.deg2rad;

public class Knob extends Sprite
{
    //[Embed(source = "../assets/dragger.png")]
    //private static var Dragger : Class;

    private var _container:Sprite;
    private var dragger:Image;
    private var draggerTexture:Texture;
    private var draggerBmp:Bitmap;
    private var position:Point;

    public function Knob()
    {
        this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
    }

    private function onAddedToStage(event:Event):void
    {
        this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);

        _container = new Sprite();
        this.addChild(_container);

        //draggerBmp = new Dragger();
        //draggerTexture = Texture.fromBitmap(draggerBmp);
        dragger = AssetMap.createImage("knob-thumb-skin");
        dragger.pivotX = 50;
        dragger.pivotY = 50;
        dragger.x = 0;
        dragger.y = 0;
        _container.addChild(dragger);

        dragger.addEventListener(TouchEvent.TOUCH, touchHandler);
    }

    private function touchHandler(event:TouchEvent):void
    {
        var touch:Touch = event.getTouch(stage);
        position = touch.getLocation(stage);

        if (touch.phase == TouchPhase.BEGAN)
        {
            var posBegan:Number = Math.atan2(position.y - dragger.y, position.x - dragger.x);
            var angleBegan:Number = (posBegan / Math.PI) * 180;
            var a2rBegan:Number = deg2rad(angleBegan + 90);
            dragger.rotation = a2rBegan;
        }
        if (touch.phase == TouchPhase.MOVED)
        {
            var posMoved:Number = Math.atan2(position.y - dragger.y, position.x - dragger.x);
            var angleMoved:Number = (posMoved / Math.PI) * 180;
            var a2rMoved:Number = deg2rad(angleMoved + 90);
            dragger.rotation = a2rMoved;
        }
    }
}
}

