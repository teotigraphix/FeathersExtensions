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

import com.teotigraphix.ui.theme.feathers.AlertFactory;
import com.teotigraphix.ui.theme.feathers.AutoCompleteFactory;
import com.teotigraphix.ui.theme.feathers.ButtonFactory;
import com.teotigraphix.ui.theme.feathers.ButtonGroupFactory;
import com.teotigraphix.ui.theme.feathers.CalloutFactory;
import com.teotigraphix.ui.theme.feathers.CheckFactory;
import com.teotigraphix.ui.theme.feathers.DefaultItemRendererFactory;
import com.teotigraphix.ui.theme.feathers.DrawersFactory;
import com.teotigraphix.ui.theme.feathers.GroupedListFactory;
import com.teotigraphix.ui.theme.feathers.HeaderFactory;
import com.teotigraphix.ui.theme.feathers.LabelFactory;
import com.teotigraphix.ui.theme.feathers.LayoutGroupFactory;
import com.teotigraphix.ui.theme.feathers.ListFactory;
import com.teotigraphix.ui.theme.feathers.NumericStepperFactory;
import com.teotigraphix.ui.theme.feathers.PageIndicatorFactory;
import com.teotigraphix.ui.theme.feathers.PanelFactory;
import com.teotigraphix.ui.theme.feathers.PickerListFactory;
import com.teotigraphix.ui.theme.feathers.ProgressBarFactory;
import com.teotigraphix.ui.theme.feathers.RadioFactory;
import com.teotigraphix.ui.theme.feathers.ScrollContainerFactory;
import com.teotigraphix.ui.theme.feathers.ScrollScreenFactory;
import com.teotigraphix.ui.theme.feathers.ScrollTextFactory;
import com.teotigraphix.ui.theme.feathers.ScrollerFactory;
import com.teotigraphix.ui.theme.feathers.SimpleScrollBarFactory;
import com.teotigraphix.ui.theme.feathers.SliderFactory;
import com.teotigraphix.ui.theme.feathers.SpinnerListFactory;
import com.teotigraphix.ui.theme.feathers.TabBarFactory;
import com.teotigraphix.ui.theme.feathers.TextAreaFactory;
import com.teotigraphix.ui.theme.feathers.TextInputFactory;
import com.teotigraphix.ui.theme.feathers.ToggleButtonFactory;
import com.teotigraphix.ui.theme.feathers.ToggleSwitchFactory;
import com.teotigraphix.ui.theme.framework.FormLabelFactory;
import com.teotigraphix.ui.theme.framework.FrameworkDefaultsFactory;
import com.teotigraphix.ui.theme.framework.GridGroupFactory;
import com.teotigraphix.ui.theme.framework.LedFactory;
import com.teotigraphix.ui.theme.framework.ToastFactory;

import feathers.system.DeviceCapabilities;
import feathers.themes.StyleNameFunctionTheme;

import flash.display.Stage;

import starling.core.Starling;
import starling.textures.TextureAtlas;

public class AbstractTheme extends StyleNameFunctionTheme
{

    public var scale:Number = 1;

    public var properties:ThemeProperties;
    public var fonts:FontFactory;
    public var shared:SharedFactory;

    public var alert:AlertFactory;
    public var autoComplete:AutoCompleteFactory;
    public var button:ButtonFactory;
    public var buttonGroup:ButtonGroupFactory;
    public var callout:CalloutFactory;
    public var check:CheckFactory;
    public var defaultItemRenderer:DefaultItemRendererFactory;
    public var drawers:DrawersFactory;
    public var groupedList:GroupedListFactory;
    public var header:HeaderFactory;
    public var label:LabelFactory;
    public var layoutGroup:LayoutGroupFactory;
    public var list:ListFactory;
    public var numericStepper:NumericStepperFactory;
    public var pageIndicator:PageIndicatorFactory;
    public var panel:PanelFactory;
    public var pickerList:PickerListFactory;
    public var progressBar:ProgressBarFactory;
    public var radio:RadioFactory;
    public var scroller:ScrollerFactory;
    public var scrollContainer:ScrollContainerFactory;
    public var scrollScreen:ScrollScreenFactory;
    public var scrollText:ScrollTextFactory;
    public var simpleScrollbar:SimpleScrollBarFactory;
    public var slider:SliderFactory;
    public var spinnerList:SpinnerListFactory;
    public var tabBar:TabBarFactory;
    public var textArea:TextAreaFactory;
    public var textInput:TextInputFactory;
    public var toggleButton:ToggleButtonFactory;
    public var toggleSwitch:ToggleSwitchFactory;

    // Framework
    public var framework:FrameworkDefaultsFactory;
    public var led:LedFactory;
    public var gridGroup:GridGroupFactory;
    public var toast:ToastFactory;
    public var formLabel:FormLabelFactory;
    protected var _dp:Number;
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

    public function get dp():Number
    {
        return _dp;
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

        _dp = calculateScaleFactor();

        properties = new ThemeProperties(this);
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
        fonts = new FontFactory(this);
        shared = new SharedFactory(this);

        alert = new AlertFactory(this);
        autoComplete = new AutoCompleteFactory(this);
        button = new ButtonFactory(this);
        buttonGroup = new ButtonGroupFactory(this);
        callout = new CalloutFactory(this);
        check = new CheckFactory(this);
        defaultItemRenderer = new DefaultItemRendererFactory(this);
        drawers = new DrawersFactory(this);
        groupedList = new GroupedListFactory(this);
        header = new HeaderFactory(this);
        label = new LabelFactory(this);
        layoutGroup = new LayoutGroupFactory(this);
        list = new ListFactory(this);
        numericStepper = new NumericStepperFactory(this);
        pageIndicator = new PageIndicatorFactory(this);
        panel = new PanelFactory(this);
        pickerList = new PickerListFactory(this);
        progressBar = new ProgressBarFactory(this);
        radio = new RadioFactory(this);
        scroller = new ScrollerFactory(this);
        scrollContainer = new ScrollContainerFactory(this);
        scrollScreen = new ScrollScreenFactory(this);
        scrollText = new ScrollTextFactory(this);
        simpleScrollbar = new SimpleScrollBarFactory(this);
        slider = new SliderFactory(this);
        spinnerList = new SpinnerListFactory(this);
        tabBar = new TabBarFactory(this);
        textArea = new TextAreaFactory(this);
        textInput = new TextInputFactory(this);
        toggleButton = new ToggleButtonFactory(this);
        toggleSwitch = new ToggleSwitchFactory(this);

        // Framework
        framework = new FrameworkDefaultsFactory(this);
        led = new LedFactory(this);
        toast = new ToastFactory(this);
        gridGroup = new GridGroupFactory(this);
        formLabel = new FormLabelFactory(this);
    }

    protected function addFactories():void
    {
        _factories.push(fonts);
        _factories.push(shared);

        _factories.push(alert);
        _factories.push(autoComplete);
        _factories.push(button);
        _factories.push(buttonGroup);
        _factories.push(callout);
        _factories.push(check);
        _factories.push(defaultItemRenderer);
        _factories.push(drawers);
        _factories.push(groupedList);
        _factories.push(header);
        _factories.push(label);
        _factories.push(layoutGroup);
        _factories.push(list);
        _factories.push(numericStepper);
        _factories.push(pageIndicator);
        _factories.push(panel);
        _factories.push(pickerList);
        _factories.push(progressBar);
        _factories.push(radio);
        _factories.push(scroller);
        _factories.push(scrollContainer);
        _factories.push(scrollScreen);
        _factories.push(scrollText);
        _factories.push(simpleScrollbar);
        _factories.push(slider);
        _factories.push(spinnerList);
        _factories.push(tabBar);
        _factories.push(textArea);
        _factories.push(textInput);
        _factories.push(toggleButton);
        _factories.push(toggleSwitch);

        // Framework
        _factories.push(framework);
        _factories.push(led);
        _factories.push(gridGroup);
        _factories.push(toast);
        _factories.push(formLabel);

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
        Starling.current.stage.color = SharedFactory.PRIMARY_BACKGROUND_COLOR;
        Starling.current.nativeStage.color = SharedFactory.PRIMARY_BACKGROUND_COLOR;

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
        AssetMap.densityPixelRatio = dp;
        var scaledDPI:int = DeviceCapabilities.dpi / Starling.contentScaleFactor;
        this._originalDPI = scaledDPI;
        if (_scaleToDPI)
        {
            if (DeviceCapabilities.isTablet(Starling.current.nativeStage))
            {
                _originalDPI = SharedFactory.ORIGINAL_DPI_IPAD_RETINA;
            }
            else
            {
                _originalDPI = SharedFactory.ORIGINAL_DPI_IPHONE_RETINA;
            }
        }
        scale = scaledDPI / _originalDPI;
        if (scale < 0.3)
        {
           // scale = 1;
           // AssetMap.densityPixelRatio = _dp = 1.5;
        }
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

    protected function calculateScaleFactor():Number
    {
        var nativeStage:Stage = Starling.current.nativeStage;
        var screenDensity:Number = DeviceCapabilities.dpi;
        //workaround because these rules derived from Android's behavior
        //would "incorrectly" give iPads a lower scale factor than iPhones
        //when both devices have the same scale factor natively.
        //if(Capabilities.version.indexOf("IOS") >= 0 && DeviceCapabilities.isTablet(nativeStage))
        //{
        //    screenDensity *= IOS_TABLET_DENSITY_SCALE_FACTOR;
        //}
        var bucket:ScreenDensityBucket = BUCKETS[0];
        if (screenDensity <= bucket.density)
        {
            return bucket.scale;
        }
        var previousBucket:ScreenDensityBucket = bucket;
        var bucketCount:int = BUCKETS.length;
        for (var i:int = 1; i < bucketCount; i++)
        {
            bucket = BUCKETS[i];
            if (screenDensity > bucket.density)
            {
                previousBucket = bucket;
                continue;
            }
            var midDPI:Number = (bucket.density + previousBucket.density) / 2;
            if (screenDensity < midDPI)
            {
                return previousBucket.scale;
            }
            return bucket.scale;
        }
        return bucket.scale;
    }
}
}

class ScreenDensityBucket
{
    public function ScreenDensityBucket(dpi:Number, scale:Number)
    {
        this.density = dpi;
        this.scale = scale;
    }

    public var density:Number;
    public var scale:Number;
}

var BUCKETS:Vector.<ScreenDensityBucket> = new <ScreenDensityBucket>
        [
            new ScreenDensityBucket(120, 0.75), //ldpi
            new ScreenDensityBucket(160, 1), //mdpi
            new ScreenDensityBucket(240, 1.5), //hdpi
            new ScreenDensityBucket(320, 2), //xhdpi
            new ScreenDensityBucket(480, 3), //xxhdpi
            new ScreenDensityBucket(640, 4) ///xxxhpi
        ];