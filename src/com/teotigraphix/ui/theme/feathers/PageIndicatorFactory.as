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

import com.teotigraphix.ui.theme.*;

import feathers.controls.ImageLoader;
import feathers.controls.PageIndicator;

import starling.display.DisplayObject;
import starling.textures.Texture;

public class PageIndicatorFactory extends AbstractThemeFactory
{
    protected var pageIndicatorNormalSkinTexture:Texture;
    protected var pageIndicatorSelectedSkinTexture:Texture;

    public function PageIndicatorFactory(theme:AbstractTheme)
    {
        super(theme);
    }

    override public function initializeTextures():void
    {
        super.initializeTextures();

        pageIndicatorSelectedSkinTexture = atlas.getTexture("page-indicator-selected-skin");
        pageIndicatorNormalSkinTexture = atlas.getTexture("page-indicator-normal-skin");
    }

    override public function initializeStyleProviders():void
    {
        super.initializeStyleProviders();

        setStyle(PageIndicator, setPageIndicatorStyles);
    }

    public function setPageIndicatorStyles(pageIndicator:PageIndicator):void
    {
        pageIndicator.normalSymbolFactory = this.pageIndicatorNormalSymbolFactory;
        pageIndicator.selectedSymbolFactory = this.pageIndicatorSelectedSymbolFactory;
        pageIndicator.gap = properties.smallGutterSize;
        pageIndicator.padding = properties.smallGutterSize;
        pageIndicator.minTouchWidth = properties.smallControlSize * 2;
        pageIndicator.minTouchHeight = properties.smallControlSize * 2;
    }

    protected function pageIndicatorNormalSymbolFactory():DisplayObject
    {
        var symbol:ImageLoader = new ImageLoader();
        symbol.source = pageIndicatorNormalSkinTexture;
        return symbol;
    }

    protected function pageIndicatorSelectedSymbolFactory():DisplayObject
    {
        var symbol:ImageLoader = new ImageLoader();
        symbol.source = pageIndicatorSelectedSkinTexture;
        return symbol;
    }
}
}