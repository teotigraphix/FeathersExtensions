/**
 * Created by Teoti on 3/28/2015.
 */
package com.teotigraphix.ui.theme
{

import feathers.controls.Button;
import feathers.controls.Slider;
import feathers.skins.SmartDisplayObjectStateValueSelector;

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

        theme.getStyleProviderForClass(Slider).defaultStyleFunction = this.setSliderStyles;
        theme.getStyleProviderForClass(Button).setFunctionForStyleName(Slider.DEFAULT_CHILD_STYLE_NAME_THUMB,
                                                                       theme.shared.setSimpleButtonStyles);
        theme.getStyleProviderForClass(Button).setFunctionForStyleName(THEME_STYLE_NAME_HORIZONTAL_SLIDER_MINIMUM_TRACK,
                                                                       this.setHorizontalSliderMinimumTrackStyles);
        theme.getStyleProviderForClass(Button).setFunctionForStyleName(THEME_STYLE_NAME_HORIZONTAL_SLIDER_MAXIMUM_TRACK,
                                                                       this.setHorizontalSliderMaximumTrackStyles);
        theme.getStyleProviderForClass(Button).setFunctionForStyleName(THEME_STYLE_NAME_VERTICAL_SLIDER_MINIMUM_TRACK,
                                                                       this.setVerticalSliderMinimumTrackStyles);
        theme.getStyleProviderForClass(Button).setFunctionForStyleName(THEME_STYLE_NAME_VERTICAL_SLIDER_MAXIMUM_TRACK,
                                                                       this.setVerticalSliderMaximumTrackStyles);
    }

    public function setHorizontalSliderMinimumTrackStyles(track:Button):void
    {
        var skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
        skinSelector.defaultValue = theme.shared.backgroundSkinTextures;
        skinSelector.setValueForState(theme.shared.backgroundDisabledSkinTextures, Button.STATE_DISABLED, false);
        skinSelector.displayObjectProperties =
        {
            textureScale: theme.scale
        };
        skinSelector.displayObjectProperties.width = properties.wideControlSize;
        skinSelector.displayObjectProperties.height = properties.controlSize;
        track.stateToSkinFunction = skinSelector.updateValue;
        track.hasLabelTextRenderer = false;
    }

    public function setHorizontalSliderMaximumTrackStyles(track:Button):void
    {
        var skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
        skinSelector.defaultValue = theme.shared.backgroundSkinTextures;
        skinSelector.setValueForState(theme.shared.backgroundDisabledSkinTextures, Button.STATE_DISABLED, false);
        skinSelector.displayObjectProperties =
        {
            textureScale: theme.scale
        };
        skinSelector.displayObjectProperties.width = properties.wideControlSize;
        skinSelector.displayObjectProperties.height = properties.controlSize;
        track.stateToSkinFunction = skinSelector.updateValue;
        track.hasLabelTextRenderer = false;
    }

    public function setVerticalSliderMinimumTrackStyles(track:Button):void
    {
        var skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
        skinSelector.defaultValue = theme.shared.backgroundSkinTextures;
        skinSelector.setValueForState(theme.shared.backgroundDisabledSkinTextures, Button.STATE_DISABLED, false);
        skinSelector.displayObjectProperties =
        {
            textureScale: theme.scale
        };
        skinSelector.displayObjectProperties.width = properties.controlSize;
        skinSelector.displayObjectProperties.height = properties.wideControlSize;
        track.stateToSkinFunction = skinSelector.updateValue;
        track.hasLabelTextRenderer = false;
    }

    public function setVerticalSliderMaximumTrackStyles(track:Button):void
    {
        var skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
        skinSelector.defaultValue = theme.shared.backgroundSkinTextures;
        skinSelector.setValueForState(theme.shared.backgroundDisabledSkinTextures, Button.STATE_DISABLED, false);
        skinSelector.displayObjectProperties =
        {
            textureScale: theme.scale
        };
        skinSelector.displayObjectProperties.width = properties.controlSize;
        skinSelector.displayObjectProperties.height = properties.wideControlSize;
        track.stateToSkinFunction = skinSelector.updateValue;
        track.hasLabelTextRenderer = false;
    }

    protected function setSliderStyles(slider:Slider):void
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
