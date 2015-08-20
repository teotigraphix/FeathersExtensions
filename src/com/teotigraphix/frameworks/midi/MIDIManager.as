/**
 * Created by Teoti on 4/9/2015.
 */
package com.teotigraphix.frameworks.midi
{

import com.teotigraphix.caustic.core.caustic_internal;
import com.teotigraphix.frameworks.midi.model.MessageList;
import com.teotigraphix.frameworks.midi.model.NoteItem;
import com.teotigraphix.util.Files;

import flash.filesystem.File;
import flash.utils.ByteArray;

use namespace caustic_internal;

public class MIDIManager
{
    //--------------------------------------------------------------------------
    // Private :: Variables
    //--------------------------------------------------------------------------

    private var _midiLoadResult:MIDILoadResult;

    //--------------------------------------------------------------------------
    // Constructor
    //--------------------------------------------------------------------------

    public function MIDIManager()
    {
    }

    //--------------------------------------------------------------------------
    // Public :: Methods
    //--------------------------------------------------------------------------

    public function load(file:File):MIDILoadResult
    {
        var byteArray:ByteArray = Files.readBinaryFile(file);
        var midiFile:MidiFile = new MidiFile(byteArray);

        _midiLoadResult = new MIDILoadResult(file, midiFile);

        for (var i:int = 0; i < midiFile.tracks; i++)
        {
            var track:MidiTrack = midiFile.track(i);
            var list:MessageList = track.msgList;
            for each (var event:Object in list)
            {
                if (event is NoteItem)
                {
                    var note:NoteItem = NoteItem(event);
                    var messageName:String = MidiEnum.getMessageName(note.kind);

                    var tick:int = note.timeline;
                    var start:Number = 0;
                    var duration:Number = 0;
                    var end:Number = 0;

                    start = tick / midiFile.division;
                    duration = note.duration / midiFile.division;
                    end = start + duration;

                    _midiLoadResult.addNote(track.trackChannel, start, end, note.pitch, note.velocity);
                }
            }
        }

        return _midiLoadResult;
    }

    public function getWavFile():void
    {

    }
}
}
