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

package com.teotigraphix.ui.component.file
{

import feathers.controls.renderers.DefaultListItemRenderer;

import starling.display.Image;
import starling.events.Touch;
import starling.events.TouchEvent;
import starling.events.TouchPhase;

public class FileListItemRenderer extends DefaultListItemRenderer
{
    public static const EVENT_ICON_DOUBLE_TAP:String = "FileListItemRenderer/iconDoubleTap";
    
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
                if (event.target is Image)
                {
                    dispatchEventWith(EVENT_ICON_DOUBLE_TAP, true, data);
                }
                else
                {
                    dispatchEventWith("itemDoubleTap", false, data);
                }
            }
        }
    }
}
}
