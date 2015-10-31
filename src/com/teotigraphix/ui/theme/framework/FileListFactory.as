/**
 * Created by Teoti on 4/10/2015.
 */
package com.teotigraphix.ui.theme.framework
{

import com.teotigraphix.ui.theme.*;

import com.teotigraphix.ui.component.file.FileList;
import com.teotigraphix.ui.component.file.FileListPopUp;

import flash.filesystem.File;

import starling.display.DisplayObject;

public class FileListFactory extends AbstractThemeFactory
{
    private var fileListIconWidth:int = 55;
    private var fileListIconHeight:int = 55;

    public function FileListFactory(theme:AbstractTheme)
    {
        super(theme);
    }

    override public function initializeTextures():void
    {
        super.initializeTextures();
    }

    override public function initializeStyleProviders():void
    {
        super.initializeStyleProviders();

        setStyle(FileList, setFileListStyles);

        setStyle(FileListPopUp, setFileListPopUpStyles);
       //setStyle(FileListPopUp, setRootSelectorFileListPopUpStyles, "root-selector");
        //setStyle(FileListPopUp, setPresetSelectorFileListPopUpStyles, "preset-selector");
    }

    public function setFileListPopUpStyles(popup:FileListPopUp):void
    {
        popup.backgroundSkin = AssetMap.create9ScaleImage("background-skin", 5, 5, 22, 22);
        //popup.defaultCausticIcon = AssetMap.getTexture("mimetype_caustic");
        //popup.defaultFolderIcon = AssetMap.getTexture("filesystem_folder");
        //popup.defaultFileIcon = AssetMap.getTexture("mimetype_misc");
    }

    public function setRootSelectorFileListPopUpStyles(popup:FileListPopUp):void
    {
        setFileListPopUpStyles(popup);

        //var fileList:FileList = popup.fileList;
        //
        //fileList.list.minHeight = 0;
        //fileList.showFiles = false;
        //fileList.extensions = [];
        //fileList.directoryDoubleTapEnabled = true;
    }

    // CausticLive
    //private function setPresetSelectorFileListPopUpStyles(popup:FileListPopUp):void
    //{
    //    setFileListPopUpStyles(popup);
    //
    //    var fileList:FileList = popup.fileList;
    //
    //    fileList.list.minHeight = 0;
    //    fileList.showFiles = true;
    //    fileList.extensions = [];
    //    for each (var type:MachineType in MachineType.values)
    //    {
    //        fileList.extensions.push(type.extension);
    //    }
    //    fileList.directoryDoubleTapEnabled = false;
    //}

    public function setFileListStyles(list:FileList):void
    {
        //list.rootDirectory = file;
        list.directoryDoubleTapEnabled = false;
        list.homeDirectory = File.documentsDirectory;
        //list.extensions = ["caustic"];
        list.showFiles = true;
        //list.iconFunction = iconFunction;

        list.homeButton.defaultIcon = AssetMap.createImage("filesystem_folder_home2");

        list.upButton.defaultIcon = AssetMap.createImage("action_up");
        list.upButton.disabledIcon = AssetMap.createImage("action_up_disabled");

        list.backButton.defaultIcon = AssetMap.createImage("action_back");
        list.backButton.disabledIcon = AssetMap.createImage("action_back_disabled");

        list.nextButton.defaultIcon = AssetMap.createImage("action_forward");
        list.nextButton.disabledIcon = AssetMap.createImage("action_forward_disabled");

        list.createButton.defaultIcon = AssetMap.createImage("filesystem_folder_create");
        list.createButton.disabledIcon = AssetMap.createImage("filesystem_folder_create_disabled");

        list.refreshButton.defaultIcon = AssetMap.createImage("quick_restart");

        sizeFileListIcon(list.homeButton.defaultIcon);

        sizeFileListIcon(list.upButton.defaultIcon);
        sizeFileListIcon(list.upButton.disabledIcon);

        sizeFileListIcon(list.backButton.defaultIcon);
        sizeFileListIcon(list.backButton.disabledIcon);

        sizeFileListIcon(list.nextButton.defaultIcon);
        sizeFileListIcon(list.nextButton.disabledIcon);

        sizeFileListIcon(list.createButton.defaultIcon);
        sizeFileListIcon(list.createButton.disabledIcon);

        sizeFileListIcon(list.refreshButton.defaultIcon);
    }

    public function sizeFileListIcon(skin:DisplayObject):void
    {
        //skin.width = fileListIconWidth * properties.scale;
        //skin.height = fileListIconHeight * properties.scale;
    }

}
}
