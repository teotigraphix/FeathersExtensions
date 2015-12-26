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

import feathers.controls.text.StageTextTextEditor;
import feathers.controls.text.TextBlockTextRenderer;
import feathers.core.FeathersControl;

import flash.text.TextFormat;
import flash.text.engine.CFFHinting;
import flash.text.engine.ElementFormat;
import flash.text.engine.FontDescription;
import flash.text.engine.FontLookup;
import flash.text.engine.FontPosture;
import flash.text.engine.FontWeight;
import flash.text.engine.RenderingMode;

public class FontFactory extends AbstractThemeFactory
{
    public static const LIGHT_TEXT_COLOR:uint = 0xe5e5e5;
    public static const DARK_TEXT_COLOR:uint = 0x1a1816;
    public static const SELECTED_TEXT_COLOR:uint = 0xff9900;
    public static const DISABLED_TEXT_COLOR:uint = 0x8a8a8a;
    public static const DARK_DISABLED_TEXT_COLOR:uint = 0x383430;

    /**
     * The name of the embedded font used by controls in this theme. Comes
     * in normal and bold weights.
     */
    public static var FONT_NAME:String = "SourceSansPro";

    /**
     * A smaller font size for details.
     */
    public var smallFontSize:int;

    /**
     * A normal font size.
     */
    public var regularFontSize:int;

    /**
     * A larger font size for headers.
     */
    public var largeFontSize:int;

    /**
     * An extra large font size.
     */
    public var extraLargeFontSize:int;

    /**
     * An extra large font size. (48)
     */
    public var extraExtraLargeFontSize:int;

    //----------------------------------
    // ElementFormat
    //----------------------------------

    public var defaultButtonElementFormat:ElementFormat;
    public var defaultButtonDisableElementFormat:ElementFormat;

    /**
     * The FTE FontDescription used for text of a normal weight.
     */
    public var regularFontDescription:FontDescription;

    /**
     * The FTE FontDescription used for text of a bold weight.
     */
    public var boldFontDescription:FontDescription;

    /**
     * ScrollText uses TextField instead of FTE, so it has a separate TextFormat.
     */
    public var scrollTextTextFormat:TextFormat;

    /**
     * ScrollText uses TextField instead of FTE, so it has a separate disabled TextFormat.
     */
    public var scrollTextDisabledTextFormat:TextFormat;

    /**
     * An ElementFormat used for Header components.
     */
    public var headerElementFormat:ElementFormat;
    public var headerDarkElementFormat:ElementFormat;

    /**
     * An ElementFormat with a dark tint meant for UI controls.
     */
    public var darkUIElementFormat:ElementFormat;

    /**
     * An ElementFormat with a light tint meant for UI controls.
     */
    public var lightUIElementFormat:ElementFormat;

    /**
     * An ElementFormat with a highlighted tint meant for selected UI controls.
     */
    public var selectedUIElementFormat:ElementFormat;

    /**
     * An ElementFormat with a light tint meant for disabled UI controls.
     */
    public var lightUIDisabledElementFormat:ElementFormat;

    /**
     * An ElementFormat with a dark tint meant for disabled UI controls.
     */
    public var darkUIDisabledElementFormat:ElementFormat;

    /**
     * An ElementFormat with a dark tint meant for larger UI controls.
     */
    public var largeUIDarkElementFormat:ElementFormat;

    /**
     * An ElementFormat with a light tint meant for larger UI controls.
     */
    public var largeUILightElementFormat:ElementFormat;

    /**
     * An ElementFormat with a highlighted tint meant for larger UI controls.
     */
    public var largeUISelectedElementFormat:ElementFormat;

    /**
     * An ElementFormat with a dark tint meant for larger disabled UI controls.
     */
    public var largeUIDarkDisabledElementFormat:ElementFormat;

    /**
     * An ElementFormat with a light tint meant for larger disabled UI controls.
     */
    public var largeUILightDisabledElementFormat:ElementFormat;

    /**
     * An ElementFormat with a dark tint meant for larger text.
     */
    public var largeDarkElementFormat:ElementFormat;

    /**
     * An ElementFormat with a light tint meant for larger text.
     */
    public var largeLightElementFormat:ElementFormat;

    /**
     * An ElementFormat meant for larger disabled text.
     */
    public var largeDisabledElementFormat:ElementFormat;

    /**
     * An ElementFormat with a dark tint meant for regular text.
     */
    public var darkElementFormat:ElementFormat;

    /**
     * An ElementFormat with a light tint meant for regular text.
     */
    public var lightElementFormat:ElementFormat;

    /**
     * An ElementFormat meant for regular, disabled text.
     */
    public var disabledElementFormat:ElementFormat;

    public var smallDarkElementFormat:ElementFormat;

    /**
     * An ElementFormat with a light tint meant for smaller text.
     */
    public var smallLightElementFormat:ElementFormat;

    /**
     * An ElementFormat meant for smaller, disabled text.
     */
    public var smallDisabledElementFormat:ElementFormat;

    public function FontFactory(theme:AbstractTheme)
    {
        super(theme);
    }

    /**
     * Initializes font sizes and formats.
     */
    override public function initializeFonts():void
    {
        smallFontSize = Math.round(20 * theme.scale);
        regularFontSize = Math.round(24 * theme.scale);
        largeFontSize = Math.round(28 * theme.scale);
        extraLargeFontSize = Math.round(36 * theme.scale);
        extraExtraLargeFontSize = Math.round(48 * theme.scale);

        //these are for components that don't use FTE
        scrollTextTextFormat = new TextFormat("_sans", regularFontSize, LIGHT_TEXT_COLOR);
        scrollTextDisabledTextFormat = new TextFormat("_sans", regularFontSize, DISABLED_TEXT_COLOR);

        regularFontDescription = new FontDescription(FONT_NAME, FontWeight.NORMAL, FontPosture.NORMAL,
                                                     FontLookup.EMBEDDED_CFF, RenderingMode.CFF, CFFHinting.NONE);
        boldFontDescription = new FontDescription(FONT_NAME, FontWeight.BOLD, FontPosture.NORMAL,
                                                  FontLookup.EMBEDDED_CFF, RenderingMode.CFF, CFFHinting.NONE);

        headerElementFormat = new ElementFormat(boldFontDescription, extraLargeFontSize, LIGHT_TEXT_COLOR);
        headerDarkElementFormat = new ElementFormat(boldFontDescription, extraLargeFontSize, DARK_TEXT_COLOR);

        darkUIElementFormat = new ElementFormat(boldFontDescription, regularFontSize, DARK_TEXT_COLOR);
        lightUIElementFormat = new ElementFormat(boldFontDescription, regularFontSize, LIGHT_TEXT_COLOR);
        selectedUIElementFormat = new ElementFormat(boldFontDescription, regularFontSize, SELECTED_TEXT_COLOR);
        lightUIDisabledElementFormat = new ElementFormat(boldFontDescription, regularFontSize, DISABLED_TEXT_COLOR);
        darkUIDisabledElementFormat = new ElementFormat(boldFontDescription, regularFontSize, DARK_DISABLED_TEXT_COLOR);

        largeUIDarkElementFormat = new ElementFormat(boldFontDescription, largeFontSize, DARK_TEXT_COLOR);
        largeUILightElementFormat = new ElementFormat(boldFontDescription, largeFontSize, LIGHT_TEXT_COLOR);
        largeUISelectedElementFormat = new ElementFormat(boldFontDescription, largeFontSize, SELECTED_TEXT_COLOR);
        largeUIDarkDisabledElementFormat = new ElementFormat(boldFontDescription, largeFontSize,
                                                             DARK_DISABLED_TEXT_COLOR);
        largeUILightDisabledElementFormat = new ElementFormat(boldFontDescription, largeFontSize, DISABLED_TEXT_COLOR);

        darkElementFormat = new ElementFormat(regularFontDescription, regularFontSize, DARK_TEXT_COLOR);
        lightElementFormat = new ElementFormat(regularFontDescription, regularFontSize, LIGHT_TEXT_COLOR);
        disabledElementFormat = new ElementFormat(regularFontDescription, regularFontSize, DISABLED_TEXT_COLOR);

        smallLightElementFormat = new ElementFormat(regularFontDescription, smallFontSize, LIGHT_TEXT_COLOR);
        smallDarkElementFormat = new ElementFormat(boldFontDescription, smallFontSize, DARK_TEXT_COLOR);
        smallDisabledElementFormat = new ElementFormat(regularFontDescription, smallFontSize, DISABLED_TEXT_COLOR);

        largeDarkElementFormat = new ElementFormat(regularFontDescription, largeFontSize, DARK_TEXT_COLOR);
        largeLightElementFormat = new ElementFormat(regularFontDescription, largeFontSize, LIGHT_TEXT_COLOR);
        largeDisabledElementFormat = new ElementFormat(regularFontDescription, largeFontSize, DISABLED_TEXT_COLOR);

        // ME
        defaultButtonElementFormat = darkUIElementFormat;
        defaultButtonDisableElementFormat = darkUIDisabledElementFormat;
    }

    override public function initializeGlobals():void
    {
        FeathersControl.defaultTextRendererFactory = textRendererFactory;
        FeathersControl.defaultTextEditorFactory = textEditorFactory;
    }

    /**
     * The default global text renderer factory for this theme creates a
     * TextBlockTextRenderer.
     */
    protected static function textRendererFactory():TextBlockTextRenderer
    {
        return new TextBlockTextRenderer();
    }

    /**
     * The default global text editor factory for this theme creates a
     * StageTextTextEditor.
     */
    protected static function textEditorFactory():StageTextTextEditor
    {
        return new StageTextTextEditor();
    }
}
}
