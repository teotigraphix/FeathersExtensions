package com.teotigraphix.app.ui
{
import flash.display.Loader;
import flash.display.StageOrientation;
import flash.events.Event;
import flash.events.UncaughtErrorEvent;
import flash.filesystem.File;
import flash.filesystem.FileMode;
import flash.filesystem.FileStream;
import flash.geom.Rectangle;
import flash.ui.Multitouch;
import flash.ui.MultitouchInputMode;
import flash.utils.ByteArray;
import flash.utils.getQualifiedClassName;

import feathers.core.StarlingBootstrap;

import starling.core.Starling;
import starling.events.Event;
import starling.utils.RectangleUtil;

public class AbstractApplicationBootstrap extends feathers.core.StarlingBootstrap
{
    private static var HELPER_RECTANGLE:Rectangle = new Rectangle();
    private static var HELPER_RECTANGLE2:Rectangle = new Rectangle();
    
    private var _info:Object;
    private var _launchImage:Loader;
    private var _savedAutoOrients:Boolean;
    
    private var _mainClass:Class;
    private var _themeClass:Class;
    private var _loadingImagePath:String;

    //--------------------------------------------------------------------------
    // API :: Properties
    //--------------------------------------------------------------------------
    
    //----------------------------------
    // mainClass
    //----------------------------------
    
    public function get mainClass():Class
    {
        return _mainClass;
    }

    public function set mainClass(value:Class):void
    {
        _mainClass = value;
    }
    
    //----------------------------------
    // themeClass
    //----------------------------------
    
    public function get themeClass():Class
    {
        return _themeClass;
    }

    public function set themeClass(value:Class):void
    {
        _themeClass = value;
    }
    
    //----------------------------------
    // loadingImagePath
    //----------------------------------
    
    public function get loadingImagePath():String
    {
        return _loadingImagePath;
    }
    
    public function set loadingImagePath(value:String):void
    {
        _loadingImagePath = value;
    }
    
    //--------------------------------------------------------------------------
    // Constructor
    //--------------------------------------------------------------------------
    
    public function AbstractApplicationBootstrap()
    {
        super();
        showLaunchImage();
    }
    
    //--------------------------------------------------------------------------
    // Methods
    //--------------------------------------------------------------------------
    
    protected function showLaunchImage():void
    {
        var isPortraitOnly:Boolean = false;
        
        if (_loadingImagePath != null)
        {
            var file:File = File.applicationDirectory.resolvePath(_loadingImagePath);
            if (file.exists)
            {
                var bytes:ByteArray = new ByteArray();
                var stream:FileStream = new FileStream();
                stream.open(file, FileMode.READ);
                stream.readBytes(bytes, 0, stream.bytesAvailable);
                stream.close();
                
                _launchImage = new Loader();
                //_launchImage.addEventListener(flash.events.Event.INIT, image_initHandler);
                _launchImage.loadBytes(bytes);
                addChild(_launchImage);
                sizeImage(_launchImage);
                
                //_savedAutoOrients = stage.autoOrients;
                //stage.autoOrients = false;
                
                if (isPortraitOnly)
                {
                    stage.setOrientation(StageOrientation.DEFAULT);
                }
            }
        }
    }
    
    protected function image_initHandler(event:flash.events.Event):void
    {
        sizeImage(_launchImage);
    }
    
    private function sizeImage(image:Loader):void
    {
        var stageWidth:Number = stage.stageWidth;
        var stageHeight:Number = stage.stageHeight;
        var imageWidth:Number = 800;//_launchImage.width;
        var imageHeight:Number = 800;//_launchImage.height;
        var textureScale:Number = 1;
        
        HELPER_RECTANGLE.x = 0;
        HELPER_RECTANGLE.y = 0;
        HELPER_RECTANGLE.width = imageWidth * textureScale;
        HELPER_RECTANGLE.height = imageHeight * textureScale;
        
        HELPER_RECTANGLE2.x = 0;
        HELPER_RECTANGLE2.y = 0;
        HELPER_RECTANGLE2.width = stageWidth;
        HELPER_RECTANGLE2.height = stageHeight;
        RectangleUtil.fit(HELPER_RECTANGLE, HELPER_RECTANGLE2, "showAll", false, HELPER_RECTANGLE);
        
//        image.x = HELPER_RECTANGLE.x;
//        image.y = HELPER_RECTANGLE.y;
//        image.width = HELPER_RECTANGLE.width;
//        image.height = HELPER_RECTANGLE.height;
        image.x = 0;
        image.y = 0;
        image.scaleX = 0.5;
        image.scaleY = 0.5;
    }
    
    override protected function loaderInfo_completeHandler(event:flash.events.Event):void
    {
        trace("   ");
        trace("------------------------------------------------------------");
        trace("loaderInfo_completeHandler()");
        super.loaderInfo_completeHandler(event);
        
        loaderInfo.uncaughtErrorEvents.addEventListener(
            UncaughtErrorEvent.UNCAUGHT_ERROR, uncaughtErrorEvents_uncaughtErrorEventHandler);
        
        stage.addEventListener(flash.events.Event.DEACTIVATE, stage_deactivateHandler, false, 0, true);
    }
    
    protected function uncaughtErrorEvents_uncaughtErrorEventHandler(event:UncaughtErrorEvent):void
    {
        trace("uncaughtErrorEvents_uncaughtErrorEventHandler()");
    }
    
    override protected function starling_context3DCreateHandler(event:starling.events.Event):void
    {
        trace("   ");
        trace("------------------------------------------------------------");
        trace("starling_context3DCreateHandler()");
        super.starling_context3DCreateHandler(event);
    }
    
    override protected function starling_rootCreatedHandler(event:starling.events.Event):void
    {
        trace("   ");
        trace("------------------------------------------------------------");
        // Drawers has been added to this as a child
        trace("starling_rootCreatedHandler()");
        if (_launchImage)
        {
            removeChild(_launchImage);
            _launchImage.unloadAndStop(true);
            _launchImage = null;
            //stage.autoOrients = _savedAutoOrients;
        }
        super.starling_rootCreatedHandler(event);
        stage_resizeHandler(null);
        trace("============================================================");
    }
    
    override protected function setupScaling():void
    {
        super.setupScaling();
        trace("setupScaling()");
    }
    
    override protected function stage_resizeHandler(event:flash.events.Event):void
    {
        super.stage_resizeHandler(event);
        var viewPort:Rectangle = _starling.viewPort;
        trace("stage_resizeHandler()", viewPort.width, viewPort.height);
    }
    
    override protected function createStarling():Starling
    {
        Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
        //Starling.current.simulateMultitouch = true;
        Starling.multitouchEnabled = true;

        var starling:Starling = super.createStarling();
        return starling;
    }
    
    override public function info():Object
    {
        if (!_info)
        {
            var main:String = getQualifiedClassName(_mainClass);
            var theme:String = getQualifiedClassName(_themeClass);
            main = main.split(":").pop();
            theme = theme.split("::").join(".");
            _info = {
                rootClassName: main,
                themeClassName: theme
            };
        }
        
        return _info;
    }
    
    protected function stage_deactivateHandler(event:flash.events.Event):void
    {
        //trace("stage_deactivateHandler()");
        //_starling.stop();
        stage.addEventListener(flash.events.Event.ACTIVATE, stage_activateHandler, false, 0, true);
    }
    
    protected function stage_activateHandler(event:flash.events.Event):void
    {
        //trace("stage_activateHandler()");
        stage.removeEventListener(flash.events.Event.ACTIVATE, stage_activateHandler);
        //_starling.start();
    }
}
}