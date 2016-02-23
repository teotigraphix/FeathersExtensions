package com.teotigraphix.ui
{
import feathers.data.ListCollection;

public interface IUIState
{
    function get applicationToolBarDataProvider():ListCollection;
    
    function createActionDataProvider():ListCollection;
    function createScreenToolsDataProvider(screenID:String):ListCollection;
    function createTransportToolsDataProvider(screenID:String):ListCollection;
    function createStatusToolsDataProvider(screenID:String):ListCollection;
}
}