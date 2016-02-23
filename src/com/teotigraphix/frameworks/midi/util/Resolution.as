/**
 * Created by Teoti on 3/16/2015.
 */
package com.teotigraphix.frameworks.midi.util
{

public class Resolution
{
    // Has to be on TOP!
    {
        _values = new Vector.<Resolution>();
        _values.push(Whole);
        _values.push(Half);
        _values.push(Quarter);
        _values.push(Eigth);
        _values.push(Sixteenth);
        _values.push(ThirtySecond);
        _values.push(SixtyFourth);
    }
    public static const Whole:Resolution = new Resolution(0, 1);

    public static const Half:Resolution = new Resolution(1, 0.5);

    public static const Quarter:Resolution = new Resolution(2, 0.25);

    public static const Eigth:Resolution = new Resolution(3, 0.125);

    public static const Sixteenth:Resolution = new Resolution(4, 0.0625);

    public static const ThirtySecond:Resolution = new Resolution(5, 0.03125);

    public static const SixtyFourth:Resolution = new Resolution(6, 0.015625); // 1 / 0.015625f = 64
    public static const BEATS_PER_MEASURE:int = 4;
    private static var _values:Vector.<Resolution>;
    private static var beatsInMeasure:int = 4;

    public static function get values():Vector.<Resolution>
    {
        return _values;
    }

    private var _id:int;
    private var _value:Number;

    public function get id():int
    {
        return _id;
    }

    public function get value():Number
    {
        return _value;
    }

    public function Resolution(id:int, value:Number)
    {
        _id = id;
        _value = value;
    }

    public static function fromId(id:int):Resolution
    {
        for each (var resolution:Resolution in _values)
        {
            if (resolution.id == id)
                return resolution;
        }
        return null;
    }

    /**
     * Returns (0..7) possibly and determines where the beat is within a pattern.
     *
     * @param beat
     * @param numBars
     * @return
     */
    public static function toBarPosition(beat:Number, numBars:int):int
    {
        var localBeat:Number = toLocalBeat(beat, numBars);
        return int(Math.floor(localBeat / BEATS_PER_MEASURE));
    }

    /**
     * Returns the beat within a measure (0-3).
     *
     * @param beat The full beat (0-31).
     */
    public static function toMeasureBeat(beat:Number):Number
    {
        var r:Number = (beat % 4);
        return r;
    }

    /**
     * Returns a beat within the length.
     *
     * @param beat The full beat (0-31).
     * @param numBars The bar length of the pattern.
     */
    public static function toLocalBeat(beat:Number, numBars:Number):Number
    {
        //var totalBeats:Number = (numBars * 4);
        //return (beat * BEATS_PER_MEASURE) / totalBeats;
        var r:Number = (beat % (numBars * 4));
        return r;
    }

    public static function toStepDecimalString(stepFraction:Number):String
    {
        return String(BEATS_PER_MEASURE * stepFraction);
    }

    /**
     * Returns a local step based off the pattern length and resolution.
     *
     * @param beat (0..31)
     * @param barCount (1,2,4,8)
     * @param resolution
     */
    public static function getLocalStep(beat:Number, barCount:int, resolution:Resolution):int
    {
        var localBeat:Number = toMeasureBeat(beat);
        var step:int = Resolution.toStep(localBeat, resolution);
        return step;
    }

    public static function getGlobalStep(beat:Number, barCount:int, resolution:Resolution):int
    {
        var localBeat:Number = toLocalBeat(beat, barCount);
        return toStep(localBeat, resolution);
    }
    
    public static function getGlobalPercentage(startBeat:Number, beat:Number, barCount:int, resolution:Resolution):Number
    {
        var step:int = Resolution.getGlobalStep(beat - startBeat, barCount, resolution);
        return  step / (barCount * Resolution.toSteps(resolution));
    }

    /**
     * Will return -1 of the step is not contained in the current measure, else returns 0..15.
     * Used for highlighting the current step within a bar's view of 0..16.
     *
     * @param beat The float beat.
     * @param numBars The number of bars in the pattern.
     * @param resolution The pattern resolution.
     * @param selectedBar The current bar in the playing pattern.
     */
    public static function getMeasureStep(beat:Number, numBars:int, resolution:Resolution, selectedBar:int):int
    {
        const numStepsInBar:int = toSteps(resolution);
        const globalStep:int = getGlobalStep(beat, numBars, resolution);
        const start:int = selectedBar * numStepsInBar;
        if (globalStep >= start && globalStep < start + numStepsInBar)
            return getLocalStep(beat, numBars, resolution);
        return -1;
    }

    /**
     * Returns the amount of steps in a measure for the given phrase
     * resolution.
     *
     * @param resolution The note resolution.
     * @return The number of steps in a measure for the given phrase
     *         resolution.
     */
    public static function toSteps(resolution:Resolution):int
    {
        return int(1 / resolution.value);
    }

    public static function toStep(beat:Number, resolution:Resolution):int
    {
        // (beat(5) / 0.0625) / 4
        return int((beat / resolution.value) / beatsInMeasure);
    }

    public static function toBeat(step:int, resolution:Resolution):Number
    {
        return (step * resolution.value) * beatsInMeasure;
    }
}
}
