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

import com.teotigraphix.util.Files;

import feathers.controls.Button;
import feathers.controls.Label;
import feathers.controls.LayoutGroup;
import feathers.controls.List;
import feathers.controls.renderers.IListItemRenderer;
import feathers.data.ListCollection;
import feathers.events.FeathersEventType;
import feathers.layout.HorizontalLayout;
import feathers.layout.VerticalLayout;
import feathers.layout.VerticalLayoutData;
import feathers.skins.IStyleProvider;

import flash.filesystem.File;

import starling.events.Event;

/*
 TODO Add Back/Next navigation stack support
 TODO Add backButton support to FileList

 NativeApplication.nativeApplication.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown, false, 0, true)

 protected function onKeyDown(event:KeyboardEvent):void
 {
 if( event.keyCode == Keyboard.BACK )
 {
 event.preventDefault();
 event.stopImmediatePropagation();
 //handle the button press here.
 }
 }

 */

public class FileList extends LayoutGroup
{
    public static const INVALIDATION_FLAG_SHOW_FILES:String = "showFiles";

    public static const INVALIDATION_FLAG_EXTENSIONS:String = "extensions";

    public static const INVALIDATION_FLAG_HOME_DIRECTORY:String = "homeDirectory";

    public static const INVALIDATION_FLAG_ROOT_DIRECTORY:String = "rootDirectory";

    public static const INVALIDATION_FLAG_ACTION_TEXT:String = "actionText";

    public static const INVALIDATION_FLAG_ICON_FUNCTION:String = "iconFunction";

    public static const NAVIGATE_HOME:int = 0;

    public static const NAVIGATE_UP:int = 1;

    public static const NAVIGATE_BACK:int = 2;

    public static const NAVIGATE_NEXT:int = 3;

    public static var globalStyleProvider:IStyleProvider;

    //--------------------------------------------------------------------------
    // Private :: Variables
    //--------------------------------------------------------------------------

    private var _showFiles:Boolean = true;
    private var _directoryDoubleTapEnabled:Boolean;
    private var _extensions:Array;
    private var _homeDirectory:File = File.documentsDirectory;
    private var _rootDirectory:File;
    private var _actionText:String;
    private var _iconFunction:Function;
    private var _enabledFunction:Function;

    private var actionBar:LayoutGroup;
    private var header:LayoutGroup;
    private var _list:List;

    private var _label:Label;
    private var _homeButton:Button;
    private var _upButton:Button;
    private var _backButton:Button;
    private var _createButton:Button;
    private var _refreshButton:Button;
    private var _nextButton:Button;

    private var _listMinHeight:Number;

    override protected function get defaultStyleProvider():IStyleProvider
    {
        return FileList.globalStyleProvider;
    }

    //--------------------------------------------------------------------------
    // Public API :: Properties
    //--------------------------------------------------------------------------

    //----------------------------------
    // showFiles
    //----------------------------------

    public function get showFiles():Boolean
    {
        return _showFiles;
    }

    public function set showFiles(value:Boolean):void
    {
        if (_showFiles == value)
            return;

        _showFiles = value;
        invalidate(INVALIDATION_FLAG_SHOW_FILES);
    }

    //----------------------------------
    // directoryDoubleTapEnabled
    //----------------------------------

    public function get directoryDoubleTapEnabled():Boolean
    {
        return _directoryDoubleTapEnabled;
    }

    //----------------------------------
    // rootDirectory
    //----------------------------------

    public function set directoryDoubleTapEnabled(value:Boolean):void
    {
        _directoryDoubleTapEnabled = value;
    }

    public function get extensions():Array
    {
        return _extensions;
    }

    //----------------------------------
    // homeDirectory
    //----------------------------------

    public function set extensions(value:Array):void
    {
        if (_extensions == value)
            return;

        _extensions = value;
        invalidate(INVALIDATION_FLAG_EXTENSIONS);
    }

    public function get homeDirectory():File
    {
        return _homeDirectory;
    }

    //----------------------------------
    // rootDirectory
    //----------------------------------

    public function set homeDirectory(value:File):void
    {
        if (_homeDirectory == value)
            return;

        _homeDirectory = value;
        invalidate(INVALIDATION_FLAG_HOME_DIRECTORY);
    }

    public function get rootDirectory():File
    {
        return _rootDirectory;
    }

    //----------------------------------
    // actionText
    //----------------------------------

    public function set rootDirectory(value:File):void
    {
        if (_rootDirectory == value)
            return;

        _rootDirectory = value;
        dispatchEventWith(FileListEvent.ROOT_DIRECTORY_CHANGE, true, _rootDirectory);
        invalidate(INVALIDATION_FLAG_ROOT_DIRECTORY);
    }

    public function get actionText():String
    {
        return _actionText;
    }

    //----------------------------------
    // iconFunction
    //----------------------------------

    public function set actionText(value:String):void
    {
        if (_actionText == value)
            return;

        _actionText = value;
        invalidate(INVALIDATION_FLAG_ACTION_TEXT);
    }

    public function get iconFunction():Function
    {
        return _iconFunction;
    }

    //----------------------------------
    // buttons
    //----------------------------------

    public function set iconFunction(value:Function):void
    {
        if (_iconFunction == value)
            return;

        _iconFunction = value;
        invalidate(INVALIDATION_FLAG_ICON_FUNCTION);
    }

    public function get enabledFunction():Function
    {
        return _enabledFunction;
    }

    public function set enabledFunction(value:Function):void
    {
        if (_enabledFunction == value)
            return;
        _enabledFunction = value;
        invalidate(INVALIDATION_FLAG_ICON_FUNCTION);
    }

    public function get homeButton():Button
    {
        return _homeButton;
    }

    public function get upButton():Button
    {
        return _upButton;
    }

    public function get backButton():Button
    {
        return _backButton;
    }

    public function get createButton():Button
    {
        return _createButton;
    }

    public function get refreshButton():Button
    {
        return _refreshButton;
    }

    public function get list():List
    {
        return _list;
    }

    //--------------------------------------------------------------------------
    // Constructor
    //--------------------------------------------------------------------------

    public function get nextButton():Button
    {
        return _nextButton;
    }

    //--------------------------------------------------------------------------
    // Overridden :: Methods
    //--------------------------------------------------------------------------

    public function get listMinHeight():Number
    {
        return _listMinHeight;
    }

    public function set listMinHeight(value:Number):void
    {
        _listMinHeight = value;
    }

    public function FileList()
    {
        super();
    }

    override protected function initialize():void
    {
        super.initialize();

        var vl:VerticalLayout = new VerticalLayout();
        vl.padding = 6;
        layout = vl;

        createActionBar(); // local action bar
        createHeader();
        createBody();

        _list.addEventListener(Event.CHANGE, list_changeHandler);
        _list.addEventListener(FeathersEventType.RENDERER_ADD, list_rendererAddHandler);
        _list.addEventListener(FeathersEventType.RENDERER_REMOVE, list_rendererRemoveHandler);

        _backButton.isEnabled = false;
        _nextButton.isEnabled = false;
        _createButton.isEnabled = false;
    }

    override protected function draw():void
    {
        super.draw();

        if (isInvalid(INVALIDATION_FLAG_ICON_FUNCTION))
        {
            commitItemRendererFactory();
        }

        if (isInvalid(INVALIDATION_FLAG_HOME_DIRECTORY))
        {
            // N/A
        }

        if (isInvalid(INVALIDATION_FLAG_EXTENSIONS) ||
                isInvalid(INVALIDATION_FLAG_ROOT_DIRECTORY) ||
                isInvalid(INVALIDATION_FLAG_SHOW_FILES))
        {
            commitRootDirectory();
        }

        if (isInvalid(INVALIDATION_FLAG_ACTION_TEXT))
        {
            commitActionText();
        }
    }

    override public function dispose():void
    {
        super.dispose();

        _list.removeEventListener(Event.CHANGE, list_changeHandler);
        _list.removeEventListener(FeathersEventType.RENDERER_ADD, list_rendererAddHandler);
        _list.removeEventListener(FeathersEventType.RENDERER_REMOVE, list_rendererRemoveHandler);
    }

    public function navigateHome():void
    {
        navigate(NAVIGATE_HOME);
    }

    public function navigateUp():void
    {
        navigate(NAVIGATE_UP);
    }

    public function navigateBack():void
    {
        navigate(NAVIGATE_BACK);
    }

    //--------------------------------------------------------------------------
    // Public API :: Methods
    //--------------------------------------------------------------------------

    public function naviagateNext():void
    {
        navigate(NAVIGATE_NEXT);
    }

    public function refresh():void
    {
        var currentRoot:File = _rootDirectory;
        _rootDirectory = null;
        rootDirectory = currentRoot;
    }

    public function navigate(direction:int):void
    {
        switch (direction)
        {
            case NAVIGATE_BACK:
                // XXX FileList needs stack
                break;

            case NAVIGATE_HOME:
                rootDirectory = _homeDirectory;
                break;

            case NAVIGATE_NEXT:
                // XXX FileList needs stack
                break;

            case NAVIGATE_UP:
                var parent:File = _rootDirectory.parent;
                if (parent != null)
                    rootDirectory = parent;
                break;
        }
    }

    //--------------------------------------------------------------------------
    // Internal :: Methods
    //--------------------------------------------------------------------------

    protected function commitRootDirectory():void
    {
        if (_rootDirectory == null)
        {
            _upButton.isEnabled = false;
            _list.dataProvider = null;
            actionText = "";
            _upButton.isEnabled = false;
            return;
        }

        actionText = _rootDirectory.nativePath;

        _upButton.isEnabled = _rootDirectory.parent != null;

        var result:Vector.<File> = getFileListing();
        var dataProvider:ListCollection = new ListCollection(result);
        _list.dataProvider = dataProvider;
    }

    protected function commitItemRendererFactory():void
    {
        _list.itemRendererFactory = function ():FileListItemRenderer //IListItemRenderer
        {
            var renderer:FileListItemRenderer = new FileListItemRenderer();
            renderer.iconFunction = _iconFunction;
            renderer.itemHasEnabled = true;
            renderer.enabledFunction = _enabledFunction;
            renderer.labelField = "name";
            renderer.gap = 10;
            return renderer;
        };
    }

    protected function commitActionText():void
    {
        _label.text = _actionText;
    }

    private function getFileListing():Vector.<File>
    {
        if (_showFiles)
        {
            return Files.listFiles(_rootDirectory, _extensions, false, true);
        }
        else
        {
            return Files.listDirectories(_rootDirectory, false);
        }
    }

    private function list_rendererAddHandler(event:Event, itemRenderer:IListItemRenderer):void
    {
        itemRenderer.addEventListener("itemDoubleTap", itemRenderer_itemDoubleTapHandler);
        //itemRenderer.addEventListener("itemSwipeRight", itemRenderer_itemSwipeRightHandler);
    }

    private function list_rendererRemoveHandler(event:Event, itemRenderer:IListItemRenderer):void
    {
        itemRenderer.removeEventListener("itemDoubleTap", itemRenderer_itemDoubleTapHandler);
        //itemRenderer.removeEventListener("itemSwipeRight", itemRenderer_itemSwipeRightHandler);

    }

    private function createActionBar():void
    {
        actionBar = new LayoutGroup();

        var hl:HorizontalLayout = new HorizontalLayout();
        hl.paddingLeft = 6;
        hl.paddingRight = 6;
        hl.paddingBottom = 6;
        actionBar.layout = hl;

        _label = new Label();
        actionBar.addChild(_label);

        addChild(actionBar);
    }

    private function createHeader():void
    {
        header = new LayoutGroup();

        var hl:HorizontalLayout = new HorizontalLayout();
        hl.distributeWidths = true;
        hl.paddingLeft = 4;
        hl.paddingRight = 4;
        hl.paddingBottom = 6;
        header.layout = hl;

        _homeButton = create("Home", FileListEvent.HOME);
        _upButton = create("Up", FileListEvent.UP);
        _backButton = create("Back", FileListEvent.BACK);
        _nextButton = create("Next", FileListEvent.NEXT);
        _createButton = create("Create", FileListEvent.CREATE);
        _refreshButton = create("Refresh", FileListEvent.REFRESH);

        addChild(header);
    }

    private function create(label:String, actionType:int):Button
    {
        var button:Button = new Button();
        button.label = label;
        button.addEventListener(Event.TRIGGERED, function (event:Event):void
        {
            actionExecuteHandler(actionType);
        });
        button.iconPosition = Button.ICON_POSITION_TOP;
        header.addChild(button);
        return button;
    }

    private function createBody():void
    {
        _list = new List();
        _list.layoutData = new VerticalLayoutData(100, 100);
        addChild(_list);
    }

    private function actionExecuteHandler(actionType:int):void
    {
        switch (actionType)
        {
            case FileListEvent.BACK:
                navigate(NAVIGATE_BACK);
                break;

            case FileListEvent.NEXT:
                navigate(NAVIGATE_NEXT);
                break;

            case FileListEvent.CREATE:

                break;

            case FileListEvent.HOME:
                navigate(NAVIGATE_HOME);
                break;

            case FileListEvent.REFRESH:
                refresh();
                break;

            case FileListEvent.UP:
                navigate(NAVIGATE_UP);
                break;
        }
    }

    private function itemRenderer_itemDoubleTapHandler(event:Event):void
    {
        var itemRenderer:IListItemRenderer = IListItemRenderer(event.currentTarget);
        var file:File = File(itemRenderer.data);

        if (file.isDirectory)
        {
            dispatchEventWith(FileListEvent.DIRECTORY_DOUBLE_TAP, true, file);
            if (_directoryDoubleTapEnabled)
            {
                rootDirectory = file;
            }
        }
        else
        {
            dispatchEventWith(FileListEvent.FILE_DOUBLE_TAP, true, file);
        }
    }

    private function list_changeHandler(event:Event):void
    {
        var list:List = List(event.currentTarget);
        if (list.selectedIndex == -1)
            return;

        var file:File = list.selectedItem as File;

        // no double tap, drill into directory
        if (file.isDirectory && !_directoryDoubleTapEnabled)
        {
            rootDirectory = file;
        }

        dispatchEventWith(file.isDirectory ?
                                  FileListEvent.DIRECTORY_SELECT : FileListEvent.FILE_SELECT, true, file);

    }
}
}
