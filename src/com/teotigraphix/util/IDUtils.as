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

package com.teotigraphix.util
{

import flash.utils.ByteArray;

public class IDUtils
{

    /**
     *  @private
     *  Char codes for 0123456789ABCDEF
     */
    private static const ALPHA_CHAR_CODES:Array = [
        48, 49, 50, 51, 52, 53, 54,
        55, 56, 57, 65, 66, 67, 68, 69, 70
    ];

    private static const DASH:int = 45;       // dash ascii
    private static const UIDBuffer:ByteArray = new ByteArray();       // static ByteArray used for UID generation to
                                                                      // save memory allocation cost

    /**
     *  Generates a UID (unique identifier) based on ActionScript's
     *  pseudo-random number generator and the current time.
     *
     *  <p>The UID has the form
     *  <code>"XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX"</code>
     *  where X is a hexadecimal digit (0-9, A-F).</p>
     *
     *  <p>This UID will not be truly globally unique; but it is the best
     *  we can do without player support for UID generation.</p>
     *
     *  @return The newly-generated UID.
     *
     *  @langversion 3.0
     *  @playerversion Flash 9
     *  @playerversion AIR 1.1
     *  @productversion Flex 3
     */
    public static function createUID():String
    {
        UIDBuffer.position = 0;

        var i:int;
        var j:int;

        for (i = 0; i < 8; i++)
        {
            UIDBuffer.writeByte(ALPHA_CHAR_CODES[int(Math.random() * 16)]);
        }

        for (i = 0; i < 3; i++)
        {
            UIDBuffer.writeByte(DASH);
            for (j = 0; j < 4; j++)
            {
                UIDBuffer.writeByte(ALPHA_CHAR_CODES[int(Math.random() * 16)]);
            }
        }

        UIDBuffer.writeByte(DASH);

        var time:uint = new Date().getTime(); // extract last 8 digits
        var timeString:String = time.toString(16).toUpperCase();
        // 0xFFFFFFFF milliseconds ~= 3 days, so timeString may have between 1 and 8 digits, hence we need to pad with
        // 0s to 8 digits
        for (i = 8; i > timeString.length; i--)
            UIDBuffer.writeByte(48);
        UIDBuffer.writeUTFBytes(timeString);

        for (i = 0; i < 4; i++)
        {
            UIDBuffer.writeByte(ALPHA_CHAR_CODES[int(Math.random() * 16)]);
        }

        return UIDBuffer.toString();
    }
}
}
