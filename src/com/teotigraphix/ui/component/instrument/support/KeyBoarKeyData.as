/**
 * Created by Teoti on 5/9/2015.
 */
package com.teotigraphix.ui.component.instrument.support
{

public class KeyBoarKeyData
{
    public var pitch:int;
    public var name:String;
    public var index:int;

    public function KeyBoarKeyData(index:int, pitch:int, name:String)
    {
        this.index = index;
        this.pitch = pitch;
        this.name = name;
    }
}
}
