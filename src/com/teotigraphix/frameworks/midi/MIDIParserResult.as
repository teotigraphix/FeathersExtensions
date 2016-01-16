/**
 * Created by Teoti on 4/9/2015.
 */
package com.teotigraphix.frameworks.midi
{

import com.teotigraphix.core.sdk_internal;
import com.teotigraphix.frameworks.midi.model.MetaItem;

import flash.filesystem.File;

use namespace sdk_internal;

public class MIDIParserResult
{
    //--------------------------------------------------------------------------
    // Private :: Variables
    //--------------------------------------------------------------------------

    private var _manager:MIDIParser;

    private var _file:File;
    private var _midi:MidiFile;

    private var _tracks:Vector.<MIDITrackInfo> = new Vector.<MIDITrackInfo>(16, true);

    //--------------------------------------------------------------------------
    // Public :: Properties
    //--------------------------------------------------------------------------

    public function get tracks():Vector.<MIDITrackInfo>
    {
        return _tracks;
    }

    //----------------------------------
    // file
    //----------------------------------

    public function get file():File
    {
        return _file;
    }

    //----------------------------------
    // midi
    //----------------------------------

    public function get midi():MidiFile
    {
        return _midi;
    }

    //----------------------------------
    // trackCount
    //----------------------------------

    public function get trackCount():int
    {
        var count:int = 0;
        for each (var info:MIDITrackInfo in _tracks)
        {
            if (info != null)
                count++;
        }
        return count;
    }

    //----------------------------------
    // barCount
    //----------------------------------

    /**
     * Returns the max number of bars of all tracks, should be 1, 2, 4 or 8, -1 if an error.
     */
    public function get barCount():int
    {
        var count:int = -1;
        for each (var info:MIDITrackInfo in _tracks)
        {
            if (info != null)
            {
                count = Math.max(count, info.barCount);
            }
        }
        return count;
    }

    //--------------------------------------------------------------------------
    // Constructor
    //--------------------------------------------------------------------------

    public function MIDIParserResult(manager:MIDIParser, file:File, midi:MidiFile)
    {
        _manager = manager;
        _file = file;
        _midi = midi;

        var index:int = 0;
        for (var i:int = 0; i < midi.trackCount; i++)
        {
            var track:MidiTrack = midi.getTrack(i);
            if (track != null && track.hasNotes)
            {
                var info:MIDITrackInfo = new MIDITrackInfo(midi, track);
                _tracks[index] = info;
                index++;
            }
        }
    }

    //--------------------------------------------------------------------------
    // Public :: Methods
    //--------------------------------------------------------------------------

    /**
     * Returns the MidiTrackInfo for the channel index, null if the track does not exist.
     *
     * @param index The track's channel index.
     */
    public function getTrack(index:int):MIDITrackInfo
    {
        return _tracks[index];
    }

    public function channelExists(channel:int):Boolean
    {
        return _tracks[channel] != null;
    }

    public function getChannelName(channel:int):String
    {
        var track:MidiTrack = _midi.getTrack(channel + 1); // XXX Remove when you have MidiTrackInfo
        for (var i:int = 0; i < track.messages.length; i++)
        {
            if (track.messages[i] is MetaItem)
            {
                var item:MetaItem = MetaItem(track.messages[i]);
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
        var track:MIDITrackInfo = getTrack(channel);
        if (track == null)
            return 0;
        return track.notes.length;
    }

    public function getNotes(channel:int):Vector.<MIDINoteInfo>
    {
        var track:MIDITrackInfo = getTrack(channel);
        if (track == null)
            return null;
        return track.notes;
    }

    //sdk_internal function _addNote(channel:int, start:Number, end:Number, pitch:uint, velocity:int):void
    //{
    //    //trace("addNote(" + channel + ") start:" + start + ", end:" + end +
    //    //      ", pitch" + pitch + ", velocity:" + velocity);
    //    var old:int = _barCount;
    //
    //    if (start >= 16)
    //        old = 8;
    //    else if (start >= 8)
    //        old = 4;
    //    else if (start >= 4)
    //        old = 2;
    //
    //    _barCount = Math.max(old, _barCount);
    //
    //    var sub:Vector.<NoteInfo> = _trackNotes[channel];
    //    if (sub == null)
    //    {
    //        _trackNotes[channel] = sub = new <NoteInfo>[];
    //    }
    //
    //    sub[sub.length] = new NoteInfo(channel, start, end, pitch, velocity);
    //}

}
}
