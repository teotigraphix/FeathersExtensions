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

package com.teotigraphix.app.configuration
{

public class Version
{
    public static const CURRENT:Version = new Version("0.0.0");

    private var _vid:String;
    private var _tag:String;
    
    //--------------------------------------------------------------------------
    // Properties
    //--------------------------------------------------------------------------
    
    //----------------------------------
    // vid
    //----------------------------------
    
    public function get vid():String
    {
        return _vid;
    }

    public function set vid(value:String):void
    {
        _vid = value;
    }
    
    //----------------------------------
    // tag
    //----------------------------------
    
    public function get tag():String
    {
        return _tag;
    }
    
    public function set tag(value:String):void
    {
        _tag = value;
    }
    
    //--------------------------------------------------------------------------
    // Constructor
    //--------------------------------------------------------------------------

    public function Version(version:String = null, tag:String = null)
    {
        _vid = version;
        _tag = tag;
    }

    //--------------------------------------------------------------------------
    // Public :: Methods
    //--------------------------------------------------------------------------
    
    public function compareTo(that:Version):int
    {
        if (that == null)
            return 1;

        var thisParts:Array = _vid.split(".");
        var thatParts:Array = that.vid.split(".");
        var length:int = Math.max(thisParts.length, thatParts.length);

        for (var i:int = 0; i < length; i++)
        {
            var thisPart:int = i < thisParts.length ? parseInt(thisParts[i]) : 0;
            var thatPart:int = i < thatParts.length ? parseInt(thatParts[i]) : 0;
            if (thisPart < thatPart)
                return -1;
            if (thisPart > thatPart)
                return 1;
        }
        
        // TODO impl Version compareTo() 
//        if (_tag != that.tag)
//            return 1;

        return 0;
    }

    public function equals(that:Version):Boolean
    {
        if (this == that)
            return true;
        if (that == null)
            return false;
        return compareTo(that) == 0;
    }

    public function toString():String
    {
        if (_tag != null)
            return _vid + "-" + _tag;
        return _vid;
    }
}
}
