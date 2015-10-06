/**
 * Copyright(C) 2008 Efishocean
 *
 * This file is part of Midias.
 *
 * Midias is an ActionScript3 midi lib developed by Efishocean.
 * Midias was extracted from my project 'ocean' which purpose to
 * impletement a commen audio formats libray.
 * More infos might appear on my blog http://www.tan66.cn
 *
 * Midias is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 3 of the License, or
 * (at your option) any later version.
 *
 * Midias is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>
 */

package com.teotigraphix.frameworks.midi.model
{

/**
 * Represents a note on/off command.
 */
public class NoteItem extends MessageItem
{
    private static const _pitchName:Array = ["C", "Db", "D", "Eb", "E", "F", "F#", "G", "G#", "A", "Bb", "B"];

    private var _pitch:uint;
    private var _velocity:uint;
    private var _duration:uint;
    private var _channel:uint;

    public function get channel():uint
    {
        return _channel;
    }

    public function set channel(value:uint):void
    {
        _channel = value;
    }

    public function get pitch():uint
    {
        return _pitch;
    }

    public function set pitch(value:uint):void
    {
        _pitch = value;
    }

    public function get pitchName():String
    {
        var level:uint = (_pitch / 12 >> 0);
        var result:String = _pitchName[_pitch % 12] + (level ? level : "");
        return result;
    }

    public function get duration():uint
    {
        return _duration;
    }

    public function set duration(value:uint):void
    {
        _duration = value;
    }

    public function get velocity():uint
    {
        return _velocity;
    }

    public function set velocity(value:uint):void
    {
        _velocity = value;
    }

    public function NoteItem(channel:uint = 0, pitch:uint = 67, velocity:uint = 127, duration:uint = 120):void
    {
        super();
        _channel = _channel & 0x0F;
        _pitch = pitch & 0x7F;
        _velocity = velocity & 0x7F;
        _duration = duration;
    }

    override public function clone():MessageItem
    {
        var item:NoteItem = new NoteItem();
        item.kind = this.kind;
        item.timeline = this.timeline;
        item.channel = _channel;
        item.duration = _duration;
        item.pitch = _pitch;
        item.velocity = _velocity;
        return item;
    }
}

}
