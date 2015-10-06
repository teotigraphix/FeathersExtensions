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

public class MIDIManager
{
    //--------------------------------------------------------------------------
    // Private :: Variables
    //--------------------------------------------------------------------------

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

        var result:MIDILoadResult = new MIDILoadResult(this, file, midiFile);

        return result;
    }

    public function getWavFile():void
    {

    }
}
}
