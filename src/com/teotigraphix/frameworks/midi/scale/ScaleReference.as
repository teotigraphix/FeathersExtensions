/**
 * Created by Teoti on 3/15/2015.
 */
package com.teotigraphix.frameworks.midi.scale
{

public class ScaleReference
{
    // Has to be on TOP!
    private static var _values:Vector.<ScaleReference> = new Vector.<ScaleReference>();

    public static const Chromatic:ScaleReference = new ScaleReference(
            0, "Chromatic", new <int>[0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11]);

    public static const Major:ScaleReference = new ScaleReference(
            1, "Major", new <int>[0, 2, 4, 5, 7, 9, 11]);

    public static const Minor:ScaleReference = new ScaleReference(
            2, "Minor", new <int>[0, 2, 3, 5, 7, 8, 10]);

    public static const Dorian:ScaleReference = new ScaleReference(
            3, "Dorian", new <int>[0, 2, 3, 5, 7, 9, 10]);

    public static const Mixolydian:ScaleReference = new ScaleReference(
            4, "Mixolydian", new <int>[0, 2, 4, 5, 7, 9, 10]);

    public static const Lydian:ScaleReference = new ScaleReference(
            5, "Lydian", new <int>[0, 2, 4, 6, 7, 9, 11]);

    public static const Phrygian:ScaleReference = new ScaleReference(
            6, "Phrygian", new <int>[0, 1, 3, 5, 7, 8, 10]);

    public static const Locrian:ScaleReference = new ScaleReference(
            7, "Locrian", new <int>[0, 1, 3, 5, 6, 8, 10]);

    public static const Diminished:ScaleReference = new ScaleReference(
            8, "Diminished", new <int>[0, 1, 3, 4, 6, 7, 9]);

    public static const WholeHalf:ScaleReference = new ScaleReference(
            9, "Whole-half", new <int>[0, 2, 3, 5, 6, 8, 9]);

    public static const WholeTone:ScaleReference = new ScaleReference(
            10, "Whole Tone", new <int>[ 0, 2, 4, 6, 8, 10]);

    public static const MinorBlues:ScaleReference = new ScaleReference(
            11, "Minor Blues", new <int>[0, 3, 5, 6, 7, 10]);

    public static const MinorPentatonic:ScaleReference = new ScaleReference(
            12, "Minor Pentatonic", new <int>[0, 3, 5, 7, 10]);

    public static const MajorPentatonic:ScaleReference = new ScaleReference(
            13, "Major Pentatonic", new <int>[0, 2, 4, 7, 9]);

    public static const HarmonicMinor:ScaleReference = new ScaleReference(
            14, "Harmonic Minor", new <int>[0, 2, 3, 5, 7, 8, 11]);

    public static const MelodicMinor:ScaleReference = new ScaleReference(
            15, "Melodic Minor", new <int>[0, 2, 3, 5, 7, 9, 11]);

    public static const SuperLocrian:ScaleReference = new ScaleReference(
            16, "Super Locrian", new <int>[0, 1, 3, 4, 6, 8, 10]);

    public static const Bhairav:ScaleReference = new ScaleReference(
            17, "Bhairav", new <int>[0, 1, 4, 5, 7, 8, 11]);

    public static const HungarianMinor:ScaleReference = new ScaleReference(
            18, "Hungarian Minor", new <int>[0, 2, 3, 6, 7, 8, 11]);

    public static const MinorGypsy:ScaleReference = new ScaleReference(
            19, "Minor Gypsy", new <int>[0, 1, 4, 5, 7, 8, 10]);

    public static const Hirojoshi:ScaleReference = new ScaleReference(
            20, "Hirojoshi", new <int>[0, 4, 6, 7, 11]);

    public static const InSen:ScaleReference = new ScaleReference(
            21, "In-Sen", new <int>[0, 4, 6, 7, 11]);

    public static const Iwato:ScaleReference = new ScaleReference(
            22, "Iwato", new <int>[0, 1, 5, 6, 10]);

    public static const Kumoi:ScaleReference = new ScaleReference(
            23, "Kumoi", new <int>[0, 2, 3, 7, 9]);

    public static const Pelog:ScaleReference = new ScaleReference(
            24, "Pelog", new <int>[0, 1, 3, 7, 8]);

    public static const Spanish:ScaleReference = new ScaleReference(
            25, "Spanish", new <int>[0, 1, 4, 5, 7, 9, 10]);

    {
        _values.push(Bhairav);
        _values.push(Chromatic);
        _values.push(Diminished);
        _values.push(Dorian);
        _values.push(HarmonicMinor);
        _values.push(Hirojoshi);
        _values.push(HungarianMinor);
        _values.push(InSen);
        _values.push(Iwato);
        _values.push(Kumoi);
        _values.push(Locrian);
        _values.push(Lydian);
        _values.push(Major);
        _values.push(MajorPentatonic);
        _values.push(MelodicMinor);
        _values.push(Minor);
        _values.push(MinorBlues);
        _values.push(MinorGypsy);
        _values.push(MinorPentatonic);
        _values.push(Mixolydian);
        _values.push(Pelog);
        _values.push(Phrygian);
        _values.push(Spanish);
        _values.push(SuperLocrian);
        _values.push(WholeHalf);
        _values.push(WholeTone);
    }

    private var _id:int;

    private var _name:String;

    private var _intervals:Vector.<int>;

    public function get id():int
    {
        return _id;
    }

    public function get name():String
    {
        return _name;
    }

    public static function get values():Vector.<ScaleReference>
    {
        return _values;
    }

    /**
     * Gets the integer array containing the scale degrees of the scale. For
     * instance, at any octave let the base note of the scale equal 0, the
     * degrees for a major scale would then be {0, 2, 4, 5, 7, 9, 11}
     *
     * @return int array containing the degrees between 0 - 12 representing the
     *         scale
     */
    public function get intervals():Vector.<int>
    {
        return _intervals;
    }

    public function ScaleReference(id:int, name:String, intervals:Vector.<int>)
    {
        _id = id;
        _name = name;
        _intervals = intervals;
    }

    public static function fromId(id:int):ScaleReference
    {
        for each (var scale:ScaleReference in values)
        {
            if (scale.id == id)
                return scale;
        }
        return null;
    }

    public static function fromName(scaleName:String):ScaleReference
    {
        for each (var scale:ScaleReference in values)
        {
            if (scale.name == scaleName)
                return scale;
        }
        return null;
    }
}
}
