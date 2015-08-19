/**
 * Created by Teoti on 5/12/2015.
 */
package com.teotigraphix.ui.theme
{

import com.teotigraphix.ui.component.Toast;

public class ToastFactory extends AbstractThemeFactory
{

    public function ToastFactory(theme:AbstractTheme)
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

        setStyle(Toast, setToastStyles);
    }

    private function setToastStyles(toast:Toast):void
    {
        toast.backgroundSkin = AssetMap.create9ScaleImage("background-popup-shadow-skin", 8, 8, 16, 16);
    }
}
}
