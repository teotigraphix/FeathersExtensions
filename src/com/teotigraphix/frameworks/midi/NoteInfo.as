/**
 * Created by Teoti on 4/9/2015.
 */
package com.teotigraphix.frameworks.midi
{

public final class NoteInfo
{
    public var channel:int;
    public var start:Number;
    public var end:Number;
    public var pitch:uint;
    public var velocity:int;

    public function NoteInfo(channel:int, start:Number, end:Number, pitch:uint, velocity:int)
    {
        this.channel = channel;
        this.start = start;
        this.end = end;
        this.pitch = pitch;
        this.velocity = velocity;
    }
}
}
