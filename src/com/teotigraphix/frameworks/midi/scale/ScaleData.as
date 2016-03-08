/**
 * Created by Teoti on 3/15/2015.
 */
package com.teotigraphix.frameworks.midi.scale
{

import feathers.data.ListCollection;

public class ScaleData
{
    public static const NOTE_NAMES:Vector.<String> = new <String>[
        "C", "Db", "D", "Eb", "E", "F", "Gb", "G", "Ab", "A", "Bb", "B"
    ];

    private static var intervals:Vector.<ScaleReference>;

    //--------------------------------------------------------------------------
    // Serialized :: API
    //--------------------------------------------------------------------------

    private var _gridSize:int = 8;
    private var _scaleID:int;
    private var _rootKey:int = 0;
    private var _octave:int;

    //--------------------------------------------------------------------------
    // Private :: Variables
    //--------------------------------------------------------------------------

    private var _scales:Vector.<ScaleItem>;
    private var _midiBase:int = 12;

    //----------------------------------
    // gridSize
    //----------------------------------

    public function get gridSize():int
    {
        return _gridSize;
    }

    public function set gridSize(value:int):void
    {
        if (_gridSize == value)
            return;
        
        _gridSize = value;
        
        generateScales();
    }

//    //----------------------------------
//    // scaleIndex
//    //----------------------------------
//
//    public function get scaleIndex():int
//    {
//        return _scaleIndex;
//    }
//
//    public function set scaleIndex(value:int):void
//    {
//        _scaleIndex = value;
//    }

    //----------------------------------
    // scaleId
    //----------------------------------

    public function get scale():ScaleReference
    {
        return ScaleReference.fromId(_scaleID);
    }
    
    public function setScale(value:ScaleReference):void
    {
        var index:int = indexOfScale(value);
        if (index == -1)
            return;
        //_scaleIndex = index;
        //_scale = intervals[_scaleIndex];
    }
    
    public function get scaleID():int
    {
        return _scaleID;
    }

    public function set scaleID(value:int):void
    {
        _scaleID = value;
    }

    //----------------------------------
    // rootKey
    //----------------------------------
    
    public function get rootKeyReference():NoteReference
    {
        return NoteReference.getNote(_rootKey);
    }
    
    public function get rootKeyName():String
    {
        return rootKeyReference.baseName + "" + _octave;
    }
    
    /**
     * Sets the root key, 0 == C.
     */
    public function get rootKey():int
    {
        return _rootKey;
    }

    public function set rootKey(value:int):void
    {
        _rootKey = value;
    }

    //----------------------------------
    // octave
    //----------------------------------

    public function get octave():int
    {
        return _octave;
    }

    public function set octave(value:int):void
    {
        _octave = value;
    }
    
    //----------------------------------
    // midiBase
    //----------------------------------
    
    public function get midiBase():int
    {
        return _midiBase;
    }
    
    public function set midiBase(value:int):void
    {
        _midiBase = value;
    }
    
    //--------------------------------------------------------------------------
    // Internal
    //--------------------------------------------------------------------------
    
    public function get scales():Vector.<ScaleItem>
    {
        return _scales;
    }
    
    public function get noteIndex():int
    {
        return NoteReference.getNoteIndex(getRootKey());
    }
    
    public function ScaleData()
    {
        intervals = ScaleReference.values;
    }

    public function wakeup():void
    {
        generateScales();
    }

    public function getCurrentSequencerRangeText():String
    {
        var sequencerMatrix:Vector.<int> = getNotes();
        return getSequencerRangeText(sequencerMatrix[0],
                                     sequencerMatrix[sequencerMatrix.length - 1]);
    }
    
    public function getNoteNameDataProvider():ListCollection
    {
        var result:ListCollection = new ListCollection();
        var notes:Vector.<int> = getNotes();
        for (var i:int = 0; i < notes.length; i++) 
        {
            result.addItem(formatNoteAndOctave(notes[i], 0) + "");
        }
        return result;
    }

    public function getSequencerRangeText(from:int, to:int):String
    {
        return formatNoteAndOctave(from, 0) + " to " + formatNoteAndOctave(to, 0);
    }

    /**
     * @param note The full MIDI note 0-127
     */
    public function isRootKey(note:int):Boolean
    {
        var difference:int = note - rootKey;
        var n:int = difference % 12;
        if (n == 0)
            return true;
        return false;
    }

    public function formatNoteAndOctave(note:int, octaveOffset:int):String
    {
        return NOTE_NAMES[Math.abs(note % 12)]
                + (int)(Math.floor(note / 12) + octaveOffset - 1);
    }

    /**
     * @param rows The number of row notes eg 8 for Beatbox 47-54.
     * @param midiRoot The midi root value to start at, bottom to top.
     */
    public function getNotes(rows:int = int.MAX_VALUE, midiRoot:int = int.MAX_VALUE):Vector.<int>
    {
        if (rows == int.MAX_VALUE)
            rows = _gridSize;

        if (midiRoot == int.MAX_VALUE)
            midiRoot = _midiBase + (12 * _octave);

        var matrix:Vector.<int> = getActiveMatrix();
        var result:Vector.<int> = new Vector.<int>(rows, true);
        
        for (var note:int = 0; note < rows; note++)
        {
            var n:int = matrix[note] + rootKey + midiRoot;
            result[note] = n < 0 || n > 256 ? -1 : n;
        }
        return result;
    }

    public function getRootKey():NoteReference
    {
        return NoteReference.getNote(_rootKey);
    }

    public function setRootKey(value:NoteReference):void
    {
        _rootKey = value.baseNumber;
    }



    public function formatNote(note:int):String
    {
        return NOTE_NAMES[note % 12] + (int)((2 - Math.floor(note / 12) + _octave));
    }
    
    public function incOctave():void
    {
        var notes:Vector.<int> = getNotes();
        if (notes[notes.length - 1] > 120)
            return;
        octave = _octave + 1;
    }

    public function decOctave():void
    {
        if (_octave == -1)
            return;
        octave = _octave - 1;
    }

    // TODO if performance problem, this could be cached and refreshed when rootKey or scaleIndex changes

    public function getPitch(row:int):int
    {
        var sequencerMatrix:Vector.<int> = getNotes();
        return sequencerMatrix[row];
    }

    public function getActiveMatrix2(scale:ScaleReference):Vector.<int>
    {
        if (_scales == null)
        {
            generateScales();
        }
        for (var i:int = 0; i < _scales.length; i++) 
        {
            if (_scales[i].scaleID == scale.id)
                return _scales[i].matrix;
        }
        return null;
    }
    
    public function getActiveMatrix():Vector.<int>
    {
        return null;//_scales[_scaleIndex].matrix;
    }

    private function indexOfScale(reference:ScaleReference):int
    {
        for (var i:int = 0; i < intervals.length; i++)
        {
            if (intervals[i] == reference)
                return i;
        }
        return -1;
    }
    
    public function getInfoText():String
    {
        return rootKeyReference.baseName + " ";// + _scale.label;
    }
    
    //--------------------------------------------------------------------------
    // Internal :: Methods
    //--------------------------------------------------------------------------
    
    private function generateScales():void
    {
        _scales = new Vector.<ScaleItem>(intervals.length);
        
        var len:int = intervals.length;
        for (var i:int = 0; i < len; i++)
        {
            _scales[i] = createScale(intervals[i]);
        }
    }
    
    
    private function createScale(scale:ScaleReference):ScaleItem
    {
        var capacity:int = _gridSize * _gridSize;
        
        var notes:Vector.<int> = scale.intervals;
        
        var len:int = notes.length;
        var matrix:Vector.<int> = new Vector.<int>(_gridSize);
        
        var shift:int = 3; // figure this out!
        
        var index:int = 0;
        for (var column:int = 0; column < _gridSize; column++)
        {
            var y:int = 0;
            var x:int = column;
            var offset:int = y * shift + x;
            matrix[index] = (int)((Math.floor(offset / len)) * 12 + notes[offset % len]);
            index++;
        }
        return new ScaleItem(scale.name, scale.id, matrix);
    }
    
    public function getNoteNames():Vector.<String>
    {
        var result:Vector.<String> = new <String>[];
        var matrix:Vector.<int> = getNotes();
        for each (var midi:int in matrix)
        {
            result.push(formatNote(midi));
        }
        return result;
    }
}
}
