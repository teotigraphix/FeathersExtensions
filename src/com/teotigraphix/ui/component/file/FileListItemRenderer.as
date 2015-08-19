/**
 * Created by Teoti on 3/1/2015.
 */
package com.teotigraphix.ui.component.file
{

import feathers.controls.renderers.DefaultListItemRenderer;

import flash.filesystem.File;

import starling.events.Touch;
import starling.events.TouchEvent;
import starling.events.TouchPhase;

public class FileListItemRenderer extends DefaultListItemRenderer
{
    protected var _padding:Number = 0;

    private var globalX:Number;

    private var pendingTouch:Touch;

    public function FileListItemRenderer()
    {
        super();
    }

    override protected function initialize():void
    {
        addEventListener(TouchEvent.TOUCH, touch);
//
//        layout = new AnchorLayout();
//
//        var labelLayoutData:AnchorLayoutData = new AnchorLayoutData();
//        labelLayoutData.top = 0;
//        labelLayoutData.right = 0;
//        labelLayoutData.bottom = 0;
//        labelLayoutData.left = 0;
//
//        _label = new Label();
//        _label.layoutData = labelLayoutData;
//
//        addChild(_label);
    }

    override protected function commitData():void
    {
        super.commitData();
        if (_data)
        {
            if (File(_data).isDirectory)
            {
                styleNameList.add("custom-label");
            }
            else
            {
                styleNameList.remove("custom-label");
            }
        }
        else
        {

        }
    }

//    override protected function preLayout():void
//    {
//        var labelLayoutData:AnchorLayoutData = AnchorLayoutData(_label.layoutData);
//        labelLayoutData.top = _padding;
//        labelLayoutData.right = _padding;
//        labelLayoutData.bottom = _padding;
//        labelLayoutData.left = _padding;
//
//        if (isSelected)
//        {
//            var texture:Texture = Texture.fromEmbeddedAsset(bitmapData);
//            var rect:Rectangle = new Rectangle(10, 10, 20, 20);
//            var textures:Scale9Textures = new Scale9Textures(texture, rect);
//            backgroundSkin = new Scale9Image(textures);
//        }
//        else
//        {
//            backgroundSkin = null;
//        }
//    }

    override public function dispose():void
    {
        super.dispose();

        removeEventListener(TouchEvent.TOUCH, touch);
    }

    private function touch(event:TouchEvent):void
    {
        var touch:Touch = event.getTouch(this);
        if (touch != null)
        {
            if (touch.phase == TouchPhase.BEGAN)
            {
                globalX = touch.globalX;
            }
            else if (touch.phase == TouchPhase.ENDED && touch.tapCount < 2)
            {
                if (touch.globalX - 50 > globalX)
                    dispatchEventWith("itemSwipeRight", false, data);
            }
            else if (touch.phase == TouchPhase.ENDED && touch.tapCount == 2)
            {
                dispatchEventWith("itemDoubleTap", false, data);
            }
        }
    }
}
}
