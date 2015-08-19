/**
 * Created by Teoti on 3/9/2015.
 */
package com.teotigraphix.ui.component.session
{

import com.teotigraphix.model.session.ITrack;
import com.teotigraphix.ui.component.UIToggleButton;
import com.teotigraphix.ui.component.track.TrackItemHeader;

import feathers.controls.LayoutGroup;
import feathers.layout.AnchorLayout;
import feathers.layout.AnchorLayoutData;
import feathers.layout.HorizontalLayout;
import feathers.layout.HorizontalLayoutData;
import feathers.layout.VerticalLayout;
import feathers.layout.VerticalLayoutData;

public class ClipLauncher extends LayoutGroup
{
    /**
     * data - index
     */
    public static const EVENT_PATTERN_PAGE_CHANGE:String = "patternPageChange";

    /**
     *
     */
    public static const EVENT_TRACK_LEFT_CHANGE:String = "trackLeftChange";

    /**
     *
     */
    public static const EVENT_TRACK_RIGHT_CHANGE:String = "trackRightChange";

    /**
     * data Scene
     */
    public static const EVENT_SCENE_TAP:String = "sceneTap";

    /**
     * data Scene
     */
    public static const EVENT_SCENE_LONG_PRESS:String = "sceneLongPress";

    /**
     * data Clip
     */
    public static const EVENT_CLIP_TAP:String = "clipTap";

    private var _clipLauncherGrid:ClipLauncherGrid;
    private var _sceneList:SceneList;
    private var _headerItems:Vector.<TrackItemHeader> = new <TrackItemHeader>[];
    private var _automationButton:UIToggleButton;
    private var _overdubButton:UIToggleButton;

    public function get clipLauncherGrid():ClipLauncherGrid
    {
        return _clipLauncherGrid;
    }

    public function get sceneList():SceneList
    {
        return _sceneList;
    }

    public function get headerItems():Vector.<TrackItemHeader>
    {
        return _headerItems;
    }

    public function ClipLauncher()
    {
        super();
    }

    override protected function initialize():void
    {
        layout = new AnchorLayout();

        super.initialize();

        var mainContent:LayoutGroup = new LayoutGroup();
        mainContent.layout = new VerticalLayout();
        mainContent.layoutData = new AnchorLayoutData(NaN, NaN, NaN, NaN, 0, 0);

        createHeader(mainContent);
        createContent(mainContent);
        createFooter(mainContent);

        addChild(mainContent);
    }

    override protected function draw():void
    {
        super.draw();
    }

    public function advanceTime(tracks:Vector.<ITrack>):void
    {
        for each (var track:ITrack in tracks)
        {
            var item:TrackItemHeader = _headerItems[track.index - 1];
            item.visible = track.name != "";
            item.trackColor = track.color;
            item.trackName = track.name;
            item.selected = track.isSelected;
        }
    }

    protected function createHeader(parent:LayoutGroup):void
    {
        var header:LayoutGroup = new LayoutGroup();
        var hl:HorizontalLayout = new HorizontalLayout();
        hl.gap = 2;
        hl.paddingLeft = 2;
        header.layout = hl;
        header.height = 50;
        header.layoutData = new VerticalLayoutData(100, NaN);

        for (var i:int = 0; i < 8; i++)
        {
            var item:TrackItemHeader = new TrackItemHeader();
            item.width = 100;
            item.height = 50;
            header.addChild(item);
            _headerItems.push(item);
        }

        createHeaderRight(header);

        parent.addChild(header);
    }

    protected function createHeaderRight(header:LayoutGroup):void
    {
        //_automationButton = new UIToggleButton();
        //_automationButton.styleNameList.add("automation-button");
        //_automationButton.width = 50;
        //_automationButton.height = 50;
        //_automationButton.addEventListener(Event.CHANGE, automation_changedHandler);
        //header.addChild(_automationButton);
        //
        //_overdubButton = new UIToggleButton();
        //_overdubButton.styleNameList.add("overdub-button");
        //_overdubButton.addEventListener(Event.CHANGE, overdub_changedHandler);
        //header.addChild(_overdubButton);
    }

    protected function createContent(parent:LayoutGroup):void
    {
        var content:LayoutGroup = new LayoutGroup();
        content.layout = new HorizontalLayout();

        parent.addChild(content);

        _clipLauncherGrid = new ClipLauncherGrid();
        content.addChild(_clipLauncherGrid);

        _sceneList = new SceneList();
        _sceneList.width = 100;
        _sceneList.layoutData = new HorizontalLayoutData(NaN, 100);
        content.addChild(_sceneList);
    }

    protected function createFooter(parent:LayoutGroup):void
    {
        // XXX FIGURE OUT ClipLauncherFooter
        //var footer:ClipLauncherFooter = new ClipLauncherFooter();
        //footer.height = 30;
        //footer.layoutData = new VerticalLayoutData(100, NaN);
        //parent.addChild(footer);
    }
}
}
