/**
 * Created by Teoti on 4/10/2015.
 */
package com.teotigraphix.ui.theme.framework
{

import com.teotigraphix.ui.component.HGroup;
import com.teotigraphix.ui.component.file.FileList;
import com.teotigraphix.ui.theme.AbstractTheme;
import com.teotigraphix.ui.theme.AbstractThemeFactory;
import com.teotigraphix.ui.theme.AssetMap;

import flash.filesystem.File;

import feathers.controls.Label;
import feathers.controls.LayoutGroup;
import feathers.controls.List;
import feathers.layout.FlowLayout;
import feathers.layout.HorizontalLayout;

import starling.display.DisplayObject;

public class FileListFactory extends AbstractThemeFactory
{
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

        setStyle(List, setListStyles, FileList.LIST_STYLE_NAME);
        setStyle(Label, setStatusStyles, FileList.STATUS_STYLE_NAME);
        setStyle(LayoutGroup, set_ActionHeaderStyles, FileList.STYLE_ACTION_GROUP);
    }

    public function set_ActionHeaderStyles(group:LayoutGroup):void
    {
        FlowLayout(group.layout).padding = 8;
    }

    public function set_HeaderStyles(group:HGroup):void
    {
        group.verticalAlign = HorizontalLayout.VERTICAL_ALIGN_MIDDLE;
        group.horizontalAlign = HorizontalLayout.HORIZONTAL_ALIGN_LEFT;
        group.backgroundSkin = AssetMap.create9ScaleImage('application-header-skin', 5, 5, 50, 50);
        group.padding = 16;
    }

    public function setListStyles(list:List):void
    {
        theme.list.setListStyles(list);
    }

    public function setStatusStyles(label:Label):void
    {
        theme.label.set_label20Dark(label);
        label.padding = 4;
    }

    public function setFileListStyles(list:FileList):void
    {
        //list.rootDirectory = file;
        list.directoryDoubleTapEnabled = false;
        list.homeDirectory = File.documentsDirectory;
        //list.extensions = ["caustic"];
        list.showFiles = true;
        //list.iconFunction = iconFunction;

        list.homeButton.defaultIcon = AssetMap.createImage("file-list-folder-home-icon");

        list.upButton.defaultIcon = AssetMap.createImage("file-list-up-icon");
        list.upButton.disabledIcon = AssetMap.createImage("file-list-up-disabled-icon");

        //list.backButton.defaultIcon = AssetMap.createScaledImage("file-list-back-icon");
        //list.backButton.disabledIcon = AssetMap.createScaledImage("file-list-back-disabled-icon");
        //
        //list.nextButton.defaultIcon = AssetMap.createScaledImage("file-list-forward-icon");
        //list.nextButton.disabledIcon = AssetMap.createScaledImage("file-list-forward-disabled-icon");

        list.newButton.defaultIcon = AssetMap.createImage("file-list-folder-new-icon");
        list.newButton.disabledIcon = AssetMap.createImage("file-list-folder-new-disabled-icon");

        list.refreshButton.defaultIcon = AssetMap.createImage("file-list-refresh-icon");

        sizeFileListIcon(list.homeButton.defaultIcon);

        sizeFileListIcon(list.upButton.defaultIcon);
        sizeFileListIcon(list.upButton.disabledIcon);

        //sizeFileListIcon(list.backButton.defaultIcon);
        //sizeFileListIcon(list.backButton.disabledIcon);
        //
        //sizeFileListIcon(list.nextButton.defaultIcon);
        //sizeFileListIcon(list.nextButton.disabledIcon);

        sizeFileListIcon(list.newButton.defaultIcon);
        sizeFileListIcon(list.newButton.disabledIcon);

        sizeFileListIcon(list.refreshButton.defaultIcon);

        const iconMap:Object = {};
        iconMap["defaultFolderIcon"] = AssetMap.getTexture("file-list-folder-icon");
        iconMap["defaultFileIcon"] = AssetMap.getTexture("file-list-file-icon");
        list.iconMap = iconMap;
    }

    public function sizeFileListIcon(skin:DisplayObject):void
    {
        //skin.width = fileListIconWidth * properties.scale;
        //skin.height = fileListIconHeight * properties.scale;
    }

}
}
