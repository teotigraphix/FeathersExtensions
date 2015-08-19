/**
 * Created by Teoti on 3/29/2015.
 */
package com.teotigraphix.ui.theme
{

import feathers.controls.Label;

public class LabelFactory extends AbstractThemeFactory
{
    public function LabelFactory(theme:AbstractTheme)
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

        theme.getStyleProviderForClass(Label).defaultStyleFunction = setLabelStyles;
        theme.getStyleProviderForClass(Label).setFunctionForStyleName(Label.ALTERNATE_STYLE_NAME_HEADING,
                                                                      setHeadingLabelStyles);
        theme.getStyleProviderForClass(Label).setFunctionForStyleName(Label.ALTERNATE_STYLE_NAME_DETAIL,
                                                                      setDetailLabelStyles);
    }

    public function setLabelStyles(label:Label):void
    {
        label.textRendererProperties.elementFormat = theme.fonts.lightElementFormat;
        label.textRendererProperties.disabledElementFormat = theme.fonts.disabledElementFormat;
    }

    public function setHeadingLabelStyles(label:Label):void
    {
        label.textRendererProperties.elementFormat = theme.fonts.largeLightElementFormat;
        label.textRendererProperties.disabledElementFormat = theme.fonts.largeDisabledElementFormat;
    }

    public function setDetailLabelStyles(label:Label):void
    {
        label.textRendererProperties.elementFormat = theme.fonts.smallLightElementFormat;
        label.textRendererProperties.disabledElementFormat = theme.fonts.smallDisabledElementFormat;
    }
}
}
