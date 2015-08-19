/**
 * Created by Teoti on 4/8/2015.
 */
package com.teotigraphix.ui.component.track
{

import com.teotigraphix.ui.component.UIBorder;
import com.teotigraphix.ui.theme.AssetMap;

import feathers.controls.Label;
import feathers.controls.LayoutGroup;
import feathers.layout.HorizontalLayout;
import feathers.layout.VerticalLayout;
import feathers.layout.VerticalLayoutData;
import feathers.skins.IStyleProvider;

import starling.display.DisplayObject;

public class TrackItemHeader extends LayoutGroup
{
    public static const STYLE_NAME_LABEL:String = "track-item-header-label";

    private static const INVALIDATE_FLAG_SELECTED:String = "selected";
    private static const INVALIDATE_FLAG_TRACK_NAME:String = "trackName";
    private static const INVALIDATE_FLAG_TRACK_COLOR:String = "trackColor";

    public static var globalStyleProvider:IStyleProvider;

    public var backgroundNormalSkin:DisplayObject;
    public var backgroundSelectedSkin:DisplayObject;
    public var iconSkin:DisplayObject;

    private var _trackNameLabel:Label;
    private var _trackColorBorder:UIBorder;
    private var _index:int = -1;
    private var _selected:Boolean;
    private var _trackName:String = " ";
    private var _trackColor:Number;

    override protected function get defaultStyleProvider():IStyleProvider
    {
        return TrackItemHeader.globalStyleProvider;
    }

    public function get index():int
    {
        return _index;
    }

    public function set index(value:int):void
    {
        _index = value;
    }

    public function get selected():Boolean
    {
        return _selected;
    }

    public function set selected(value:Boolean):void
    {
        if (_selected == value)
            return;
        _selected = value;
        invalidate(INVALIDATE_FLAG_SELECTED);
    }

    public function get trackName():String
    {
        return _trackName;
    }

    public function set trackName(value:String):void
    {
        if (_trackName == value)
            return;
        _trackName = value;
        invalidate(INVALIDATE_FLAG_TRACK_NAME);
    }

    public function get trackColor():Number
    {
        return _trackColor;
    }

    public function set trackColor(value:Number):void
    {
        if (_trackColor == value)
            return;
        _trackColor = value;
        invalidate(INVALIDATE_FLAG_TRACK_COLOR);
    }

    public function TrackItemHeader()
    {
    }

    override protected function initialize():void
    {
        var vl:VerticalLayout = new VerticalLayout();
        vl.gap = AssetMap.getSize(10);
        vl.paddingTop = AssetMap.getSize(6);
        vl.horizontalAlign = VerticalLayout.HORIZONTAL_ALIGN_CENTER;
        layout = vl;

        super.initialize();

        createHeader();
        createBody();
    }

    override protected function draw():void
    {
        if (isInvalid(INVALIDATE_FLAG_SELECTED))
        {
            if (_selected)
            {
                backgroundSkin = backgroundSelectedSkin;
            }
            else
            {
                backgroundSkin = backgroundNormalSkin;
            }
        }

        super.draw();

        if (isInvalid(INVALIDATE_FLAG_TRACK_NAME))
        {
            _trackNameLabel.text = _trackName;
        }

        if (isInvalid(INVALIDATE_FLAG_TRACK_COLOR))
        {
            _trackColorBorder.color = _trackColor;
        }
    }

    private function createHeader():void
    {
        _trackColorBorder = new UIBorder();
        _trackColorBorder.minHeight = AssetMap.getSize(20);
        _trackColorBorder.layoutData = new VerticalLayoutData(100);
        _trackColorBorder.color = _trackColor;
        addChild(_trackColorBorder);
    }

    private function createBody():void
    {
        var stack:LayoutGroup = new LayoutGroup();

        if (iconSkin != null)
            stack.addChild(iconSkin);

        var bodyGroup:LayoutGroup = new LayoutGroup();
        var hl:HorizontalLayout = new HorizontalLayout();
        hl.gap = 4;
        hl.verticalAlign = HorizontalLayout.VERTICAL_ALIGN_MIDDLE;
        bodyGroup.layoutData = new VerticalLayoutData(100);
        bodyGroup.layout = hl;

        bodyGroup.addChild(stack);

        _trackNameLabel = new Label();
        _trackNameLabel.styleNameList.add("track-item-header-label");
        _trackNameLabel.text = "Track";
        _trackNameLabel.layoutData = new VerticalLayoutData(100);
        bodyGroup.addChild(_trackNameLabel);

        addChild(bodyGroup);
    }

}
}
