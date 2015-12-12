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

package com.teotigraphix.model.impl
{

import com.teotigraphix.core.sdk_internal;
import com.teotigraphix.frameworks.midi.MIDIParserResult;
import com.teotigraphix.frameworks.midi.MIDIParser;
import com.teotigraphix.model.*;

import flash.filesystem.File;

import org.as3commons.async.command.IAsyncCommand;

public class MidiModelImpl extends AbstractModel implements IMidiModel
{
    //--------------------------------------------------------------------------
    // Private :: Variables
    //--------------------------------------------------------------------------

    private var _midiManager:MIDIParser;

    public function get midiManager():MIDIParser
    {
        return _midiManager;
    }

    //--------------------------------------------------------------------------
    // Constructor
    //--------------------------------------------------------------------------

    public function MidiModelImpl()
    {
    }

    override protected function onRegister():void
    {
        super.onRegister();

        _midiManager = new MIDIParser();
    }

    //--------------------------------------------------------------------------
    // Public :: Methods
    //--------------------------------------------------------------------------

    public function loadAsync(file:File):IAsyncCommand
    {
        return new LoadMidiFileCommand(file, this);
    }

    sdk_internal function load(file:File):MIDIParserResult
    {
        var result:MIDIParserResult = midiManager.parse(file);
        return result;
    }
}
}

import com.teotigraphix.frameworks.midi.MIDIParserResult;
import com.teotigraphix.model.impl.MidiModelImpl;
import com.teotigraphix.service.async.StepCommand;

import flash.filesystem.File;

import org.as3commons.async.command.IAsyncCommand;

class LoadMidiFileCommand extends StepCommand implements IAsyncCommand
{
    private var _file:File;
    private var _midiModel:MidiModelImpl;

    public function LoadMidiFileCommand(file:File, midiModel:MidiModelImpl)
    {
        _file = file;
        _midiModel = midiModel;
    }

    override public function execute():*
    {
        var result:MIDIParserResult = _midiModel.midiManager.parse(_file);
        complete(result);
        return null;
    }
}
