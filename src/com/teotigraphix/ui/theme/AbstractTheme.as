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
    public var gridGroups:GridGroupFactory;
    public var toasts:ToastFactory;

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
        toasts = new ToastFactory(this);
        gridGroups = new GridGroupFactory(this);
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
        _factories.push(gridGroups);
        _factories.push(toasts);
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
