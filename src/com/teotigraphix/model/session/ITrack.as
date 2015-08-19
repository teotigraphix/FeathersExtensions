/**
 * Created by Teoti on 4/8/2015.
 */
package com.teotigraphix.model.session
{

public interface ITrack
{
    function get index():int;

    function get name():String;

    //function set name(value:String):void;

    function get color():uint;

    function get isSelected():Boolean;

}
}
