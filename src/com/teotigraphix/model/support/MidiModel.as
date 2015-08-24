/**
 * Created by Teoti on 4/9/2015.
 */
package com.teotigraphix.model.support
{

import com.teotigraphix.core.sdk_internal;
import com.teotigraphix.frameworks.midi.MIDILoadResult;
import com.teotigraphix.frameworks.midi.MIDIManager;
import com.teotigraphix.model.*;

import flash.filesystem.File;

import org.as3commons.async.command.IAsyncCommand;

public class MidiModel extends AbstractModel implements IMidiModel
{
    //--------------------------------------------------------------------------
    // Private :: Variables
    //--------------------------------------------------------------------------

    private var _midiManager:MIDIManager;

    public function get midiManager():MIDIManager
    {
        return _midiManager;
    }

    //--------------------------------------------------------------------------
    // Constructor
    //--------------------------------------------------------------------------

    public function MidiModel()
    {
    }

    override protected function onRegister():void
    {
        super.onRegister();

        _midiManager = new MIDIManager();
    }

    //--------------------------------------------------------------------------
    // Public :: Methods
    //--------------------------------------------------------------------------

    public function loadAsync(file:File):IAsyncCommand
    {
        return new LoadMidiFileCommand(file, this);
    }

    sdk_internal function load(file:File):MIDILoadResult
    {
        var result:MIDILoadResult = midiManager.load(file);
        return result;
    }
}
}

import com.teotigraphix.frameworks.midi.MIDILoadResult;
import com.teotigraphix.model.support.MidiModel;
import com.teotigraphix.service.async.StepCommand;

import flash.filesystem.File;

import org.as3commons.async.command.IAsyncCommand;

class LoadMidiFileCommand extends StepCommand implements IAsyncCommand
{
    private var _file:File;
    private var _midiModel:MidiModel;

    public function LoadMidiFileCommand(file:File, midiModel:MidiModel)
    {
        _file = file;
        _midiModel = midiModel;
    }

    override public function execute():*
    {
        var result:MIDILoadResult = _midiModel.midiManager.load(_file);
        complete(result);
        return null;
    }
}
