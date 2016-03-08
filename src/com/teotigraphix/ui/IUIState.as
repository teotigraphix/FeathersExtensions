package com.teotigraphix.ui
{
import feathers.data.ListCollection;

public interface IUIState
{
    function get applicationToolBarDataProvider():ListCollection;
    
    function contentScreenIndexToID(contentScreenIndex:int):String;
    
    function createActionDataProvider(screenID:String):ListCollection;
    function createContentToolsDataProvider(screenID:String):ListCollection;
    function createScreenToolsDataProvider(screenID:String):ListCollection;
    function createStatusLeftToolsDataProvider(screenID:String):ListCollection;
    function createStatusCenterToolsDataProvider(screenID:String):ListCollection;
    function createStatusRightToolsDataProvider(screenID:String):ListCollection;
}
}