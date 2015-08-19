package com.teotigraphix.ui.component.file
{

import com.teotigraphix.ui.theme.AssetMap;

import feathers.controls.Button;
import feathers.controls.ButtonGroup;
import feathers.controls.LayoutGroup;
import feathers.data.ListCollection;
import feathers.layout.VerticalLayout;
import feathers.layout.VerticalLayoutData;
import feathers.skins.IStyleProvider;

import flash.utils.Dictionary;

import starling.events.Event;

public class FileListPopUp extends LayoutGroup
{
    public static const EVENT_OK_TAP:String = "okTap";
    public static const EVENT_CANCEL_TAP:String = "cancelTap";

    public static var globalStyleProvider:IStyleProvider;
    //public var defaultFolderIcon:Texture;
    //public var defaultFileIcon:Texture;
    //public var defaultCausticIcon:Texture;
    private var _fileListProperties:FileListData;
    private var cachedIcons:Dictionary = new Dictionary(true);
    private var _fileList:FileList;
    private var _buttonGroup:ButtonGroup;

    override protected function get defaultStyleProvider():IStyleProvider
    {
        return FileListPopUp.globalStyleProvider;
    }

    public function get fileListProperties():FileListData
    {
        return _fileListProperties;
    }

    public function set fileListProperties(value:FileListData):void
    {
        _fileListProperties = value;
        invalidate(INVALIDATION_FLAG_DATA);
    }

    public function get okButton():Button
    {
        return Button(_buttonGroup.getChildAt(0));
    }

    public function get cancelButton():Button
    {
        return Button(_buttonGroup.getChildAt(1));
    }

    public function FileListPopUp()
    {
        super();
    }

    override protected function initialize():void
    {
        super.initialize();

        var vl:VerticalLayout = new VerticalLayout();
        vl.horizontalAlign = VerticalLayout.HORIZONTAL_ALIGN_CENTER;
        layout = vl;

        createFileList();
        createFooter();
    }

    override protected function draw():void
    {
        super.draw();

        if (isInvalid(INVALIDATION_FLAG_DATA))
        {
            if (_fileListProperties != null)
            {
                _fileListProperties.copyTo(_fileList);
            }
        }
    }

    private function createFileList():void
    {
        _fileList = new FileList();
        _fileList.layoutData = new VerticalLayoutData(100, 100);
        addChild(_fileList);
    }

    private function createFooter():void
    {
        _buttonGroup = new ButtonGroup();
        _buttonGroup.layoutData = new VerticalLayoutData(100);
        _buttonGroup.distributeButtonSizes = false;

        _buttonGroup.horizontalAlign = ButtonGroup.HORIZONTAL_ALIGN_CENTER;
        _buttonGroup.padding = AssetMap.getSize(10);
        _buttonGroup.gap = AssetMap.getSize(15);
        _buttonGroup.direction = ButtonGroup.DIRECTION_HORIZONTAL;
        _buttonGroup.dataProvider = new ListCollection([
            {label: "OK"}, {label: "Cancel"}
        ]);
        _buttonGroup.buttonInitializer = function (button:Button, item:Object):void
        {
            button.label = item.label;
            button.width = AssetMap.getWidth(200);
            if (item.label == "OK")
            {
                button.isEnabled = false;
                button.addEventListener(Event.TRIGGERED, okButton_triggeredHandler);
            }
            else
            {
                button.addEventListener(Event.TRIGGERED, cancelButton_triggeredHandler);
            }

        };
        addChild(_buttonGroup);
    }

    private function okButton_triggeredHandler(event:Event):void
    {
        dispatchEventWith(EVENT_OK_TAP);
    }

    private function cancelButton_triggeredHandler(event:Event):void
    {
        dispatchEventWith(EVENT_CANCEL_TAP);
    }
}
}
