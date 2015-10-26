/**
 * Created by Teoti on 4/9/2015.
 */
package com.teotigraphix.frameworks.midi
{

public final class MIDINoteInfo
{
    public var channel:int;
    public var start:Number;
    public var end:Number;
    public var pitch:uint;
    public var velocity:Number;

    public function MIDINoteInfo(channel:int, start:Number, end:Number, pitch:uint, velocity:Number)
    {
        this.channel = channel;
        this.start = start;
        this.end = end;
        this.pitch = pitch;
        this.velocity = velocity;
    }
}
}
