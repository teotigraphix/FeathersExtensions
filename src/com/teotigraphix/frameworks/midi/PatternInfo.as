package com.teotigraphix.frameworks.midi
{

[Serializable]
public class PatternInfo
{
    private var _channel:int;
    private var _barCount:int;
    private var _notes:Vector.<MIDINoteInfo>;
    
    //----------------------------------
    // channel
    //----------------------------------
    
    public function get channel():int
    {
        return _channel;
    }
    
    public function set channel(value:int):void
    {
        _channel = value;
    }
    
    //----------------------------------
    // barCout
    //----------------------------------
    
    public function get barCount():int
    {
        return _barCount;
    }
    
    public function set barCount(value:int):void
    {
        _barCount = value;
    }
    
    //----------------------------------
    // notes
    //----------------------------------
    
    public function get notes():Vector.<MIDINoteInfo>
    {
        return _notes;
    }
    
    public function set notes(value:Vector.<MIDINoteInfo>):void
    {
        _notes = value;
    }
    
    //--------------------------------------------------------------------------
    // Constructor
    //--------------------------------------------------------------------------
    
    public function PatternInfo(track:MIDITrackInfo = null)
    {
        if (track == null)
            return;
        
        _channel = track.channel;
        _barCount = track.barCount;
        _notes = track.notes.concat(); // create copy
    }
}
}