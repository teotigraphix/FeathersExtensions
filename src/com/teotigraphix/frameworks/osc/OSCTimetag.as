package com.teotigraphix.frameworks.osc
{

/**
 * An OSCTimetag
 * This is a helperclass for handling OSC timetags
 *
 * @author Immanuel Bauer
 * @author Michael Schmalle
 */
public class OSCTimeTag
{
    public var seconds:uint;
    public var picoseconds:uint;

    public function OSCTimeTag(seconds:uint, picoseconds:uint)
    {
        this.seconds = seconds;
        this.picoseconds = picoseconds;
    }

    public function compareTo(otg:OSCTimeTag):int
    {
        if (this.seconds > otg.seconds)
            return 1;
        else if (this.seconds < otg.seconds)
            return -1;
        else
        {
            if (this.picoseconds > otg.picoseconds)
                return 1;
            else if (this.picoseconds < otg.picoseconds)
                return -1;
            else
                return 0;
        }

        return 0;
    }
}
}