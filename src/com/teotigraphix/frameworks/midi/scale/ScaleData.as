/**
 * Created by Teoti on 3/15/2015.
 */
package com.teotigraphix.frameworks.midi.scale
{

public class ScaleData
{
    public static const NOTE_NAMES:Vector.<String> = new <String>[
        "C", "Db", "D", "Eb", "E", "F", "Gb", "G", "Ab", "A", "Bb", "B"
    ];

    private static var intervals:Vector.<ScaleReference>;

    //--------------------------------------------------------------------------
    // Serialized :: API
    //--------------------------------------------------------------------------

    private var _gridSize:int;
    private var _scaleIndex:int;
    private var _scale:ScaleReference;
    private var _rootKey:int = 0;
    private var _octave:int;
    private var _midiBase:int = 24;

    //--------------------------------------------------------------------------
    // Private :: Variables
    //--------------------------------------------------------------------------

    private var _scales:Vector.<ScaleItem>;

    private var _shift:int;
    private var _initialized:Boolean;

    //----------------------------------
    // gridSize
    //----------------------------------

    public function get gridSize():int
    {
        return _gridSize;
    }

    public function set gridSize(value:int):void
    {
        _gridSize = value;
    }

    //----------------------------------
    // scaleIndex
    //----------------------------------

    public function get scaleIndex():int
    {
        return _scaleIndex;
    }

    public function set scaleIndex(value:int):void
    {
        _scaleIndex = value;
    }

    //----------------------------------
    // scaleId
    //----------------------------------

    /**
     * @see com.teotigraphix.frameworks.midi.scale.ScaleReference#id
     */
    public function get scaleId():int
    {
        return _scale.id;
    }

    public function set scaleId(value:int):void
    {
        _scale = ScaleReference.fromId(value);
    }

    //----------------------------------
    // rootKey
    //----------------------------------

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

    internal function get rootNoteReference():NoteReference
    {
        return NoteReference.getNote(_rootKey);
    }

    internal function get rootNoteName():String
    {
        return rootNoteReference.baseName + "" + _octave;
    }

    public function ScaleData()
    {
    }

    public function initialize(gridSize:int):void
    {
        _gridSize = gridSize;
        generateScales();
        setScale(ScaleReference.Major);
        setRootKey(NoteReference.C);
        octave = 0;
        _shift = 3; // TODO figure out how this works when creating scales
    }

    public function wakeup():void
    {
        generateScales();
    }

    public function getSequencerRangeTextV2():String
    {
        var sequencerMatrix:Vector.<int> = getNotes();
        return getSequencerRangeText(sequencerMatrix[0],
                                     sequencerMatrix[sequencerMatrix.length - 1]);
    }

    public function getSequencerRangeText(from:int, to:int):String
    {
        return formatNoteAndOctave(from, 0) + " to " + formatDrumNote(to/*, -2*/);
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
                + int(Math.floor(note / 12) + octaveOffset - 2);
    }

    public function formatNoteAndOctave2(note:int):String
    {
        return NOTE_NAMES[Math.abs(note % 12)]
                + "" + int(Math.floor(note / 12) - 1);
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
        var noteMap:Vector.<int> = initArray(-1, rows);
        for (var note:int = 0; note < rows; note++)
        {
            var n:int = matrix[note] + rootKey + midiRoot;
            noteMap[note] = n < 0 || n > 256 ? -1 : n;
        }
        return noteMap;
    }

    public function getNoteNames():Vector.<String>
    {
        var result:Vector.<String> = new <String>[];
        var matrix:Vector.<int> = getNotes();
        for each (var midi:int in matrix)
        {
            result.push(formatNoteAndOctave2(midi));
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

    public function getScale():ScaleReference
    {
        return _scale;
    }

    public function setScale(value:ScaleReference):void
    {
        var index:int = indexOfScale(value);
        if (index == -1)
            return;
        _scaleIndex = index;
        _scale = intervals[_scaleIndex];
    }

    public function incOctave():void
    {
        octave = _octave + 1;
    }

    public function decOctave():void
    {
        octave = _octave - 1;
    }

    internal function formatNote(note:int):String
    {
        return NOTE_NAMES[note % 12] + (int)((2 - Math.floor(note / 12) + _octave));
    }

    // XXX if performance problem, this could be cached and refreshed when rootKey or scaleIndex changes

    internal function formatDrumNote(note:int):String
    {
        return formatNoteAndOctave(note, 0);
    }

    internal function getPitch(row:int):int
    {
        var sequencerMatrix:Vector.<int> = getNotes();
        return sequencerMatrix[row];
    }

    internal function getActiveMatrix():Vector.<int>
    {
        if (!_initialized)
            generateScales();
        //return _chromatic ? _scales[_scaleIndex].chromaticMatrix : _scales[_scaleIndex].matrix;
        return _scales[_scaleIndex].matrix;
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

    private function createScale(scale:ScaleReference):ScaleItem
    {
        var capacity:int = _gridSize * _gridSize;

        var notes:Vector.<int> = scale.intervals;

        var len:int = notes.length;
        var matrix:Vector.<int> = new Vector.<int>(_gridSize);
        //var chromaticMatrix:Vector.<int> = new Vector.<int>(capacity);

        var index:int = 0;
        //for (var row:int = 0; row < _gridSize; row++)
        //{
        for (var column:int = 0; column < _gridSize; column++)
        {
            var y:int = 0;//row;
            var x:int = column;
            var offset:int = y * _shift + x;
            matrix[index] = (int)((Math.floor(offset / len)) * 12 + notes[offset % len]);
            // XXX chromaticMatrix[index] = (y * (_shift == _gridSize ? _gridSize : notes[_shift % len]) + x);
            index++;
        }
        //}
        return new ScaleItem(scale.id, scale.name, matrix, null);
    }

    private function generateScales():void
    {
        intervals = ScaleReference.values;
        _scales = new Vector.<ScaleItem>(intervals.length);
        for (var i:int = 0; i < intervals.length; i++)
            _scales[i] = createScale(intervals[i]);
        _initialized = true;
    }

    private static function initArray(value:int, length:int):Vector.<int>
    {
        var result:Vector.<int> = new Vector.<int>(length, true);
        for (var i:int = 0; i < length; i++)
        {
            result[i] = value;
        }
        return result;
    }
}
}
