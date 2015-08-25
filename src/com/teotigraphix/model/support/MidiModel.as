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
