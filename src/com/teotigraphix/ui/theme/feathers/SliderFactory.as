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

package com.teotigraphix.ui.theme.feathers
{

import com.teotigraphix.ui.theme.AbstractTheme;
import com.teotigraphix.ui.theme.AbstractThemeFactory;
import com.teotigraphix.ui.theme.SharedFactory;

import feathers.controls.Button;
import feathers.controls.Slider;
import feathers.skins.ImageSkin;

public class SliderFactory extends AbstractThemeFactory
{
    /**
     * The default value added to the <code>styleNameList</code> of the thumb.
     *
     * @see feathers.core.FeathersControl#styleNameList
     */
    public static const DEFAULT_CHILD_STYLE_NAME_THUMB:String = "feathers-slider-thumb";

    /**
     * @private
     * The theme's custom style name for the minimum track of a horizontal slider.
     */
    protected static const THEME_STYLE_NAME_HORIZONTAL_SLIDER_MINIMUM_TRACK:String = "metal-works-mobile-horizontal-slider-minimum-track";

    /**
     * @private
     * The theme's custom style name for the maximum track of a horizontal slider.
     */
    protected static const THEME_STYLE_NAME_HORIZONTAL_SLIDER_MAXIMUM_TRACK:String = "metal-works-mobile-horizontal-slider-maximum-track";

    /**
     * @private
     * The theme's custom style name for the minimum track of a vertical slider.
     */
    protected static const THEME_STYLE_NAME_VERTICAL_SLIDER_MINIMUM_TRACK:String = "metal-works-mobile-vertical-slider-minimum-track";

    /**
     * @private
     * The theme's custom style name for the maximum track of a vertical slider.
     */
    protected static const THEME_STYLE_NAME_VERTICAL_SLIDER_MAXIMUM_TRACK:String = "metal-works-mobile-vertical-slider-maximum-track";

    public function SliderFactory(theme:AbstractTheme)
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

        setStyle(Slider, setSliderStyles);
        setStyle(Button, theme.shared.setSimpleButtonStyles, Slider.DEFAULT_CHILD_STYLE_NAME_THUMB);
        setStyle(Button, setHorizontalSliderMinimumTrackStyles, THEME_STYLE_NAME_HORIZONTAL_SLIDER_MINIMUM_TRACK);
        setStyle(Button, setHorizontalSliderMaximumTrackStyles, THEME_STYLE_NAME_HORIZONTAL_SLIDER_MAXIMUM_TRACK);
        setStyle(Button, setVerticalSliderMinimumTrackStyles, THEME_STYLE_NAME_VERTICAL_SLIDER_MINIMUM_TRACK);
        setStyle(Button, setVerticalSliderMaximumTrackStyles, THEME_STYLE_NAME_VERTICAL_SLIDER_MAXIMUM_TRACK);
    }

    public function setHorizontalSliderMinimumTrackStyles(track:Button):void
    {
        var skin:ImageSkin = new ImageSkin(shared.backgroundSkinTexture);
        skin.disabledTexture = shared.backgroundDisabledSkinTexture;
        skin.scale9Grid = SharedFactory.DEFAULT_BACKGROUND_SCALE9_GRID;
        skin.width = properties.wideControlSize;
        skin.height = properties.controlSize;
        track.defaultSkin = skin;
        
        track.hasLabelTextRenderer = false;
    }

    public function setHorizontalSliderMaximumTrackStyles(track:Button):void
    {
        var skin:ImageSkin = new ImageSkin(shared.backgroundSkinTexture);
        skin.disabledTexture = shared.backgroundDisabledSkinTexture;
        skin.scale9Grid = SharedFactory.DEFAULT_BACKGROUND_SCALE9_GRID;
        skin.width = properties.wideControlSize;
        skin.height = properties.controlSize;
        track.defaultSkin = skin;
        
        track.hasLabelTextRenderer = false;
    }

    public function setVerticalSliderMinimumTrackStyles(track:Button):void
    {
        var skin:ImageSkin = new ImageSkin(shared.backgroundSkinTexture);
        skin.disabledTexture = shared.backgroundDisabledSkinTexture;
        skin.scale9Grid = SharedFactory.DEFAULT_BACKGROUND_SCALE9_GRID;
        skin.width = properties.controlSize;
        skin.height = properties.wideControlSize;
        track.defaultSkin = skin;
        
        track.hasLabelTextRenderer = false;
    }

    public function setVerticalSliderMaximumTrackStyles(track:Button):void
    {
        var skin:ImageSkin = new ImageSkin(shared.backgroundSkinTexture);
        skin.disabledTexture = shared.backgroundDisabledSkinTexture;
        skin.scale9Grid = SharedFactory.DEFAULT_BACKGROUND_SCALE9_GRID;
        skin.width = properties.controlSize;
        skin.height = properties.wideControlSize;
        track.defaultSkin = skin;
        
        track.hasLabelTextRenderer = false;
    }

    public function setSliderStyles(slider:Slider):void
    {
        slider.trackLayoutMode = Slider.TRACK_LAYOUT_MODE_MIN_MAX;
        if (slider.direction == Slider.DIRECTION_VERTICAL)
        {
            slider.customMinimumTrackStyleName = THEME_STYLE_NAME_VERTICAL_SLIDER_MINIMUM_TRACK;
            slider.customMaximumTrackStyleName = THEME_STYLE_NAME_VERTICAL_SLIDER_MAXIMUM_TRACK;
        }
        else
        {
            slider.customMinimumTrackStyleName = THEME_STYLE_NAME_HORIZONTAL_SLIDER_MINIMUM_TRACK;
            slider.customMaximumTrackStyleName = THEME_STYLE_NAME_HORIZONTAL_SLIDER_MAXIMUM_TRACK;
        }
    }
}
}
