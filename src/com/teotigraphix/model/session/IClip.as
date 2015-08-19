/**
 * Created by Teoti on 4/8/2015.
 */
package com.teotigraphix.model.session
{

public interface IClip
{
    function get index():int;

    function get name():String;

    function get color():uint;

    function get isSelected():Boolean;

    function get isPlaying():Boolean;

    function get isQueued():Boolean;

    function get isDequeued():Boolean;

    function get hasContent():Boolean;

}
}
