/**
 * Created by Teoti on 3/19/2015.
 */
package com.teotigraphix.service
{

public interface IPreferenceService
{
    // Global preferences shared by all applications

    function get appLastProjectPath():String;

    function set appLastProjectPath(value:String):void

    // API

    function put(key:String, value:Object):void;

    function getString(key:String, defaultValue:String = null):String;

    function getInt(key:String, defaultValue:int = NaN):int;

    function getFloat(key:String, defaultValue:int = NaN):Number;

    function getBoolean(key:String, defaultValue:Boolean = false):Boolean;

    function flush():void;

    function save():void;
}
}
