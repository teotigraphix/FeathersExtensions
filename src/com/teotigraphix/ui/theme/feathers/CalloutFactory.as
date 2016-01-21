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
import com.teotigraphix.ui.theme.framework.FrameworkSkinNames;

import feathers.controls.Callout;
import feathers.display.Scale9Image;

import starling.display.Image;
import starling.textures.Texture;

public class CalloutFactory extends AbstractThemeFactory
{
    public var calloutTopArrowSkinTexture:Texture;
    public var calloutRightArrowSkinTexture:Texture;
    public var calloutBottomArrowSkinTexture:Texture;
    public var calloutLeftArrowSkinTexture:Texture;

    protected var calloutBackgroundMinSize:int;

    public function CalloutFactory(theme:AbstractTheme)
    {
        super(theme);
    }

    override public function initializeGlobals():void
    {
        super.initializeGlobals();

        Callout.stagePadding = properties.smallGutterSize;
    }

    override public function initializeDimensions():void
    {
        super.initializeDimensions();

        calloutBackgroundMinSize = Math.round(11 * properties.scale);
    }

    override public function initializeTextures():void
    {
        super.initializeTextures();

        calloutTopArrowSkinTexture = atlas.getTexture(FrameworkSkinNames.CALLOUT_ARROW_TOP_SKIN);
        calloutRightArrowSkinTexture = atlas.getTexture(FrameworkSkinNames.CALLOUT_ARROW_RIGHT_SKIN);
        calloutBottomArrowSkinTexture = atlas.getTexture(FrameworkSkinNames.CALLOUT_ARROW_BOTTOM_SKIN);
        calloutLeftArrowSkinTexture = atlas.getTexture(FrameworkSkinNames.CALLOUT_ARROW_LEFT_SKIN);
    }

    override public function initializeStyleProviders():void
    {
        super.initializeStyleProviders();

        setStyle(Callout, setCalloutStyles);
    }

    public function setCalloutStyles(callout:Callout):void
    {
        var backgroundSkin:Scale9Image = create9ScaleImage(
            FrameworkSkinNames.BACKGROUND_POPUP_SHADOW_SKIN, 6, 6, 20, 18);
        backgroundSkin.width = this.calloutBackgroundMinSize;
        backgroundSkin.height = this.calloutBackgroundMinSize;
        callout.backgroundSkin = backgroundSkin;

        var topArrowSkin:Image = new Image(this.calloutTopArrowSkinTexture);
        topArrowSkin.scaleX = topArrowSkin.scaleY = properties.scale;
        callout.topArrowSkin = topArrowSkin;

        var rightArrowSkin:Image = new Image(this.calloutRightArrowSkinTexture);
        rightArrowSkin.scaleX = rightArrowSkin.scaleY = properties.scale;
        callout.rightArrowSkin = rightArrowSkin;

        var bottomArrowSkin:Image = new Image(this.calloutBottomArrowSkinTexture);
        bottomArrowSkin.scaleX = bottomArrowSkin.scaleY = properties.scale;
        callout.bottomArrowSkin = bottomArrowSkin;

        var leftArrowSkin:Image = new Image(this.calloutLeftArrowSkinTexture);
        leftArrowSkin.scaleX = leftArrowSkin.scaleY = properties.scale;
        callout.leftArrowSkin = leftArrowSkin;

        callout.padding = dp(4);//properties.smallGutterSize;
    }
}
}