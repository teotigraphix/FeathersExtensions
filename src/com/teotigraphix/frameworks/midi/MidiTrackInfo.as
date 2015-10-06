////////////////////////////////////////////////////////////////////////////////
// Copyright 2015 Michael Schmalle - Teoti Graphix, LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License
//
// Author: Michael Schmalle, Principal Architect
// mschmalle at teotigraphix dot com
////////////////////////////////////////////////////////////////////////////////
package com.teotigraphix.frameworks.midi
{

import com.teotigraphix.frameworks.midi.model.NoteItem;

public class MidiTrackInfo
{
    private var _track:MidiTrack;
    private var _barCount:int = 0;
    private var _notes:Vector.<NoteInfo> = new <NoteInfo>[];

    public function get name():String
    {
        return _track.name;
    }

    public function get channel():uint
    {
        return _track.channel;
    }

    public function get patch():uint
    {
        return _track.patch;
    }

    public function get hasNotes():Boolean
    {
        return _track.hasNotes;
    }

    public function get noteItems():Vector.<NoteItem>
    {
        return _track.notes;
    }

    public function get barCount():int
    {
        return _barCount;
    }

    /**
     * Returns the NoteInfo items used to add Notes to a caustic Pattern.
     */
    public function get notes():Vector.<NoteInfo>
    {
        return _notes;
    }

    public function MidiTrackInfo(midiFile:MidiFile, track:MidiTrack)
    {
        _track = track;

        for each (var note:NoteItem in noteItems)
        {
            var messageName:String = MidiEnum.getMessageName(note.kind);

            var tick:int = note.timeline;
            var start:Number = 0;
            var duration:Number = 0;
            var end:Number = 0;

            start = tick / midiFile.division;
            duration = note.duration / midiFile.division;
            end = start + duration;

            addNote(_track.channel, start, end, note.pitch, note.velocity / 127);
        }
    }

    private function addNote(channel:int, start:Number, end:Number, pitch:uint, velocity:Number):void
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

        _notes[_notes.length] = new NoteInfo(channel, start, end, pitch, velocity);
    }
}
}
