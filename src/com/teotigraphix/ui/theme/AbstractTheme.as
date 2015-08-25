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

package com.teotigraphix.ui.theme
{

import feathers.system.DeviceCapabilities;
import feathers.themes.StyleNameFunctionTheme;

import starling.core.Starling;
import starling.textures.TextureAtlas;

public class AbstractTheme extends StyleNameFunctionTheme
{

    protected static var PRIMARY_BACKGROUND_COLOR:uint = 0x4a4137;

    protected static var DRAWER_OVERLAY_COLOR:uint = 0x29241e;
    protected static var DRAWER_OVERLAY_ALPHA:Number = 0.4;

    /**
     * The screen density of an iPhone with Retina display. The textures
     * used by this theme are designed for this density and scale for other
     * densities.
     */
    internal static const ORIGINAL_DPI_IPHONE_RETINA:int = 326;

    /**
     * The screen density of an iPad with Retina display. The textures used
     * by this theme are designed for this density and scale for other
     * densities.
     */
    internal static const ORIGINAL_DPI_IPAD_RETINA:int = 264;

    public var scale:Number = 1;

    public var properties:ThemeProperties;
    public var fonts:FontFactory;
    public var shared:SharedFactory;
    public var buttons:ButtonFactory;
    public var alerts:AlertFactory;
    public var scrollers:ScrollerFactory;
    public var sliders:SliderFactory;
    public var labels:LabelFactory;
    public var headers:HeaderFactory;
    public var lists:ListFactory;
    public var progressbars:ProgressBarFactory;
    public var numericsteppers:NumericStepperFactory;
    public var toasts:ToastFactory;
    public var gridGroups:GridGroupFactory;
    public var text:TextInputFactory;
    public var check:CheckFactory;

    internal var _originalDPI:int;
    internal var _scaleToDPI:Boolean;

    private var _factories:Vector.<AbstractThemeFactory> = new <AbstractThemeFactory>[];
    private var _atlas:TextureAtlas;

    public function get factories():Vector.<AbstractThemeFactory>
    {
        return _factories;
    }

    public function get atlas():TextureAtlas
    {
        return _atlas;
    }

    public function set atlas(value:TextureAtlas):void
    {
        _atlas = value;
        for each (var factory:AbstractThemeFactory in _factories)
            factory.atlas = _atlas;
    }

    /**
     * The original screen density used for scaling.
     */
    public function get originalDPI():int
    {
        return this._originalDPI;
    }

    /**
     * Indicates if the theme scales skins to match the screen density of
     * the device.
     */
    public function get scaleToDPI():Boolean
    {
        return this._scaleToDPI;
    }

    /**
     * Constructor.
     *
     * @param scaleToDPI Determines if the theme's skins will be scaled based on the screen density and content scale
     *     factor.
     */
    public function AbstractTheme(scaleToDPI:Boolean = true)
    {
        _scaleToDPI = scaleToDPI;

        createFactories();
        addFactories();

        for each (var factory:AbstractThemeFactory in _factories)
            factory.properties = properties;
    }

    /**
     * Disposes the atlas before calling super.dispose()
     */
    override public function dispose():void
    {
        if (atlas)
        {
            atlas.dispose();
            atlas = null;
        }

        //don't forget to call super.dispose()!
        super.dispose();
    }

    protected function createFactories():void
    {
        properties = new ThemeProperties(this);
        fonts = new FontFactory(this);
        shared = new SharedFactory(this);
        buttons = new ButtonFactory(this);
        alerts = new AlertFactory(this);
        scrollers = new ScrollerFactory(this);
        sliders = new SliderFactory(this);
        labels = new LabelFactory(this);
        headers = new HeaderFactory(this);
        lists = new ListFactory(this);
        progressbars = new ProgressBarFactory(this);
        numericsteppers = new NumericStepperFactory(this);
        toasts = new ToastFactory(this);
        gridGroups = new GridGroupFactory(this);
        text = new TextInputFactory(this);
        check = new CheckFactory(this);
    }

    protected function addFactories():void
    {
        _factories.push(fonts);
        _factories.push(shared);
        _factories.push(buttons);
        _factories.push(alerts);
        _factories.push(scrollers);
        _factories.push(sliders);
        _factories.push(labels);
        _factories.push(headers);
        _factories.push(lists);
        _factories.push(progressbars);
        _factories.push(numericsteppers);
        _factories.push(toasts);
        _factories.push(gridGroups);
        _factories.push(text);
        _factories.push(check);
    }

    /**
     * Initializes the theme. Expected to be called by subclasses after the
     * assets have been loaded and the skin texture atlas has been created.
     */
    protected function initialize():void
    {
        initializeScale();
        properties.initialize();
        initializeDimensions();
        initializeFonts();
        initializeTextures();
        initializeGlobals();
        initializeStage();
        initializeStyleProviders();
    }

    /**
     * Sets the stage background color.
     */
    protected function initializeStage():void
    {
        Starling.current.stage.color = PRIMARY_BACKGROUND_COLOR;
        Starling.current.nativeStage.color = PRIMARY_BACKGROUND_COLOR;

        for each (var factory:AbstractThemeFactory in _factories)
            factory.initializeStage();
    }

    /**
     * Initializes global variables (not including global style providers).
     */
    protected function initializeGlobals():void
    {
        for each (var factory:AbstractThemeFactory in _factories)
            factory.initializeGlobals();
    }

    /**
     * Initializes the scale value based on the screen density and content
     * scale factor.
     */
    protected function initializeScale():void
    {
        var scaledDPI:int = DeviceCapabilities.dpi / Starling.contentScaleFactor;
        this._originalDPI = scaledDPI;
        if (_scaleToDPI)
        {
            if (DeviceCapabilities.isTablet(Starling.current.nativeStage))
            {
                _originalDPI = ORIGINAL_DPI_IPAD_RETINA;
            }
            else
            {
                _originalDPI = ORIGINAL_DPI_IPHONE_RETINA;
            }
        }
        scale = scaledDPI / _originalDPI;
        properties.scale = scale;
        for each (var factory:AbstractThemeFactory in _factories)
            factory.initializeScale();
    }

    /**
     * Initializes common values used for setting the dimensions of components.
     */
    protected function initializeDimensions():void
    {
        for each (var factory:AbstractThemeFactory in _factories)
            factory.initializeDimensions();
    }

    /**
     * Initializes font sizes and formats.
     */
    protected function initializeFonts():void
    {
        for each (var factory:AbstractThemeFactory in _factories)
            factory.initializeFonts();
    }

    /**
     * Initializes the textures by extracting them from the atlas and
     * setting up any scaling grids that are needed.
     */
    protected function initializeTextures():void
    {
        for each (var factory:AbstractThemeFactory in _factories)
            factory.initializeTextures();
    }

    /**
     * Sets global style providers for all components.
     */
    protected function initializeStyleProviders():void
    {
        for each (var factory:AbstractThemeFactory in _factories)
            factory.initializeStyleProviders();
    }

}
}
