/**
 * Created by Teoti on 2/28/2015.
 */
package com.teotigraphix.ui.component.app
{

import com.teotigraphix.app.StarlingApplication;
import com.teotigraphix.app.event.ApplicationEventType;

import flash.desktop.NativeApplication;
import flash.display.Loader;
import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageOrientation;
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.filesystem.File;
import flash.filesystem.FileMode;
import flash.filesystem.FileStream;
import flash.geom.Rectangle;
import flash.utils.ByteArray;

import starling.core.Starling;

public class StarlingRootSprite extends Sprite
{
    private var starling:Starling;

    private var _application:StarlingApplication;
    private var _launchImage:Loader;
    private var _savedAutoOrients:Boolean;
    private var _splashFilePath:String;

    public function get splashFilePath():String
    {
        return _splashFilePath;
    }

    public function set splashFilePath(value:String):void
    {
        _splashFilePath = value;
    }

    public function StarlingRootSprite()
    {
        super();
        trace("StarlingRootSprite Construct");

        NativeApplication.nativeApplication.addEventListener(Event.EXITING, existingHandler);

        if (stage)
        {
            stage.scaleMode = StageScaleMode.NO_SCALE;
            stage.align = StageAlign.TOP_LEFT;
        }

        mouseEnabled = mouseChildren = false;
        //showLaunchImage();
        loaderInfo.addEventListener(Event.COMPLETE, loaderInfo_completeHandler);
    }

    protected function createApplication():StarlingApplication
    {
        throw new Error("Illegal operation StarlingRootSprite.createApplication()");
    }

    private function showLaunchImage():void
    {
        var isPortraitOnly:Boolean = false;

        if (_splashFilePath)
        {
            var file:File = File.applicationDirectory.resolvePath(_splashFilePath);
            if (file.exists)
            {
                var bytes:ByteArray = new ByteArray();
                var stream:FileStream = new FileStream();
                stream.open(file, FileMode.READ);
                stream.readBytes(bytes, 0, stream.bytesAvailable);
                stream.close();
                _launchImage = new Loader();
                _launchImage.loadBytes(bytes);
                addChild(this._launchImage);
                _savedAutoOrients = stage.autoOrients;
                stage.autoOrients = false;
                if (isPortraitOnly)
                {
                    stage.setOrientation(StageOrientation.DEFAULT);
                }
            }
        }
    }

    private function starling_rootCreatedHandler(event:Object):void
    {
        trace("StarlingRootSprite.starling_rootCreatedHandler() - Remove splash image");

        if (_launchImage)
        {
            removeChild(_launchImage);
            _launchImage.unloadAndStop(true);
            _launchImage = null;
            stage.autoOrients = _savedAutoOrients;
        }
    }

    private function existingHandler(event:Event):void
    {
        trace("NativeApplication EXITING");
        starling.dispatchEventWith(ApplicationEventType.APPLICATION_EXIT);
    }

    private function loaderInfo_completeHandler(event:Event):void
    {
        trace("StarlingRootSprite.loaderInfo_completeHandler()");

        Starling.handleLostContext = true;
        Starling.multitouchEnabled = true;

        _application = createApplication();

        starling = new Starling(_application.rootClass, stage);
        _application.startup(starling);
        starling.start();

        starling.addEventListener("rootCreated", starling_rootCreatedHandler);

        stage.addEventListener(Event.RESIZE, stage_resizeHandler, false, int.MAX_VALUE, true);
        stage.addEventListener(Event.DEACTIVATE, stage_deactivateHandler, false, 0, true);
    }

    private function stage_deactivateHandler(event:Event):void
    {
        trace("StarlingRootSprite.stage_deactivateHandler()");
        //starling.stop();
        stage.addEventListener(Event.ACTIVATE, stage_activateHandler, false, 0, true);
        starling.dispatchEventWith(ApplicationEventType.APPLICATION_DEACTIVATE);
    }

    private function stage_activateHandler(event:Event):void
    {
        trace("StarlingRootSprite.stage_activateHandler()");
        stage.removeEventListener(Event.ACTIVATE, stage_activateHandler);
        starling.dispatchEventWith(ApplicationEventType.APPLICATION_ACTIVATE);
        //starling.start();
    }

    private function stage_resizeHandler(event:Event):void
    {
        trace("StarlingRootSprite.stage_resizeHandler()");

        starling.stage.stageWidth = stage.stageWidth;
        starling.stage.stageHeight = stage.stageHeight;

        const viewPort:Rectangle = starling.viewPort;
        viewPort.width = stage.stageWidth;
        viewPort.height = stage.stageHeight;
        try
        {
            this.starling.viewPort = viewPort;
        }
        catch (error:Error)
        {
        }
        //starling.showStatsAt(HAlign.LEFT, VAlign.BOTTOM);
    }
}
}
