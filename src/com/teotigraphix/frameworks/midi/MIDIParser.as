/**
 * Created by Teoti on 4/9/2015.
 */
package com.teotigraphix.frameworks.midi
{

import com.teotigraphix.core.sdk_internal;
import com.teotigraphix.util.Files;

import flash.filesystem.File;
import flash.utils.ByteArray;

use namespace sdk_internal;

public class MIDIParser
{
    //--------------------------------------------------------------------------
    // Private :: Variables
    //--------------------------------------------------------------------------

    //--------------------------------------------------------------------------
    // Constructor
    //--------------------------------------------------------------------------

    public function MIDIParser()
    {
    }

    //--------------------------------------------------------------------------
    // Public :: Methods
    //--------------------------------------------------------------------------

    /**
     * Parses a .mid file into a model for use in caustic.
     *
     * @param file The midi file to parse.
     * @return A MIDIParserResult that contains tracks with notes.
     * @see MIDITrackInfo
     * @see MIDINoteInfo
     */
    public function parse(file:File):MIDIParserResult
    {
        const byteArray:ByteArray = Files.readBinaryFile(file);
        const midiFile:MidiFile = new MidiFile(byteArray);

        const result:MIDIParserResult = new MIDIParserResult(this, file, midiFile);

        return result;
    }

    public function getWavFile():void
    {

    }
}
}
