package com.teotigraphix.service
{

public interface ILogger
{
    function startup(tag:String, message:String):void;

	function log(tag:String, message:String):void;

	function warn(tag:String, message:String):void;
	
	function err(tag:String, message:String):void;

	function debug(tag:String, message:String):void;
}
}