/**
 * Created by Teoti on 3/15/2015.
 */
package com.teotigraphix.frameworks.midi.scale
{

public class NoteReference
{
    // Has to be on TOP!
    {
        _values.push(C);
        _values.push(Dflat);
        _values.push(D);
        _values.push(Eflat);
        _values.push(E);
        _values.push(F);
        _values.push(Gflat);
        _values.push(G);
        _values.push(Aflat);
        _values.push(A);
        _values.push(Bflat);
        _values.push(B);
    }
    public static const C:NoteReference = new NoteReference(0, "C");

    //public static const Csharp:NoteReference = new NoteReference(1, "C#");

    public static const Dflat:NoteReference = new NoteReference(1, "Db");

    public static const D:NoteReference = new NoteReference(2, "D");

    //public static const Dsharp:NoteReference = new NoteReference(3, "D#");

    public static const Eflat:NoteReference = new NoteReference(3, "Eb");

    public static const E:NoteReference = new NoteReference(4, "E");

    public static const F:NoteReference = new NoteReference(5, "F");

    //public static const Fsharp:NoteReference = new NoteReference(6, "F#");

    public static const Gflat:NoteReference = new NoteReference(6, "Gb");

    public static const G:NoteReference = new NoteReference(7, "G");

    //public static const Gsharp:NoteReference = new NoteReference(8, "G#");

    public static const Aflat:NoteReference = new NoteReference(8, "Ab");

    public static const A:NoteReference = new NoteReference(9, "A");

    //public static const Asharp:NoteReference = new NoteReference(10, "A#");

    public static const Bflat:NoteReference = new NoteReference(10, "Bb");

    public static const B:NoteReference = new NoteReference(11, "B");
    private static var _values:Vector.<NoteReference> = new Vector.<NoteReference>();

    public static function get values():Vector.<NoteReference>
    {
        return _values;
    }

    private var _baseNumber:int;

    private var _baseName:String;

    /**
     * This method gets the base note number of the note at octave 0. As an
     * example G has a base note number of 7.
     *
     * @return the integer of the note at octave 0
     */
    public function get baseNumber():int
    {
        return _baseNumber;
    }

    public function get baseName():String
    {
        return _baseName;
    }

    public function get label():String
    {
        return _baseName;
    }

    public function NoteReference(baseNumber:int, baseName:String)
    {
        _baseNumber = baseNumber;
        _baseName = baseName;
    }

    public static function getNote(baseNumber:int):NoteReference
    {
        for each (var noteReference:NoteReference in _values)
        {
            if (noteReference.baseNumber == baseNumber)
                return noteReference;
        }
        return null;
    }

    public static function getNoteIndex(note:NoteReference):int
    {
        return _values.indexOf(note);
    }

    public static function getNoteFromString(noteName:String):NoteReference
    {
        var note:String;
        var result:NoteReference;
        var split:Array = noteName.split("");
        if (split.length == 2)
        {
            note = split[0];
        }
        else if (split.length == 3)
        {
            // flat
            note = split[0] + split[1];
        }

        for each (var noteReference:NoteReference in _values)
        {
            if (noteReference.baseName == note)
                return noteReference;
        }

        return null;
    }

    /**
     * @param noteName C4, Bb5 etc.
     */
    public static function getMidiNoteFromString(noteName:String):int
    {
        var note:NoteReference = getNoteFromString(noteName);
        var octave:int;
        var split:Array = noteName.split("");

        if (split.length == 2)
        {
            octave = int(split[1]);
        }
        else if (split.length == 3)
        {
            // flat
            octave = int(split[1]);
        }

        // C0 == 12
        return 12 + (note.baseNumber + (octave * 12));
    }
}
}
