/**
 * Created by Teoti on 4/9/2015.
 */
package com.teotigraphix.frameworks.midi
{

import com.teotigraphix.core.sdk_internal;
import com.teotigraphix.frameworks.midi.model.MetaItem;

import flash.filesystem.File;

use namespace sdk_internal;

public class MIDILoadResult
{
    //--------------------------------------------------------------------------
    // Private :: Variables
    //--------------------------------------------------------------------------

    private var _file:File;
    private var _midi:MidiFile;
    private var _barCount:int = 1;

    private var _trackNotes:Vector.<Vector.<NoteInfo>> = new Vector.<Vector.<NoteInfo>>(16, true);

    //--------------------------------------------------------------------------
    // Public :: Properties
    //--------------------------------------------------------------------------

    //----------------------------------
    // file
    //----------------------------------

    public function get file():File
    {
        return _file;
    }

    public function get midi():MidiFile
    {
        return _midi;
    }

    //----------------------------------
    // trackCount
    //----------------------------------

    public function get trackCount():int
    {
        return _trackNotes.length;
    }

    public function get barCount():int
    {
        return _barCount;
    }

    //--------------------------------------------------------------------------
    // Constructor
    //--------------------------------------------------------------------------

    public function MIDILoadResult(file:File, midi:MidiFile)
    {
        _file = file;
        _midi = midi;
    }

    //--------------------------------------------------------------------------
    // Public :: Methods
    //--------------------------------------------------------------------------

    public function channelExists(channel:int):Boolean
    {
        return _trackNotes[channel] != null;
    }

    public function getChannelName(channel:int):String
    {
        var track:MidiTrack = _midi.track(channel + 1); // XXX Remove when you have MidiTrackInfo
        for (var i:int = 0; i < track.msgList.length; i++)
        {
            if (track.msgList[i] is MetaItem)
            {
                var item:MetaItem = MetaItem(track.msgList[i]);
                if (item.type == MidiEnum.SEQ_TRK_NAME)
                {
                    if (item.text.length == 0)
                        return null;
                    else
                        return item.text.readUTFBytes(item.text.length);
                }
            }
        }
        return null;
    }

    public function getNumNotes(channel:int):int
    {
        var sub:Vector.<NoteInfo> = _trackNotes[channel];
        if (sub == null)
            return 0;
        return sub.length;
    }

    public function getNotes(channel:int):Vector.<NoteInfo>
    {
        return _trackNotes[channel];
    }

    sdk_internal function addNote(channel:int, start:Number, end:Number, pitch:uint, velocity:int):void
    {
        //trace("addNote(" + channel + ") start:" + start + ", end:" + end +
        //      ", pitch" + pitch + ", velocity:" + velocity);
        var old:int = _barCount;

        if (start >= 16)
            old = 8;
        else if (start >= 8)
            old = 4;
        else if (start >= 4)
            old = 2;

        _barCount = Math.max(old, _barCount);

        var sub:Vector.<NoteInfo> = _trackNotes[channel];
        if (sub == null)
        {
            _trackNotes[channel] = sub = new <NoteInfo>[];
        }

        sub[sub.length] = new NoteInfo(channel, start, end, pitch, velocity);
    }

}
}
