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

package com.teotigraphix.service.impl
{

import com.teotigraphix.service.ILogger;

public class LoggerImpl implements ILogger
{
    public function LoggerImpl()
    {
    }

    public function log(tag:String, message:String, ...rest):void
    {
        trace("    [Log] {" + tag + "} " + replaceTokens(message, rest));
    }

    public function warn(tag:String, message:String, ...rest):void
    {
        trace("!!! [Warning] {" + tag + "} " + replaceTokens(message, rest));
    }

    public function err(tag:String, message:String, ...rest):void
    {
        trace("!!! [Error] | " + tag + ", " + replaceTokens(message, rest));
    }

    public function startup(tag:String, message:String, ...rest):void
    {
        trace(" [STARTUP] {" + tag + "} " + replaceTokens(message, rest));
    }

    public function debug(tag:String, message:String, ...rest):void
    {
        trace("    [Debug] {" + tag + "} " + replaceTokens(message, rest));
    }

    private static function replaceTokens(message:String, tokens:Array):String
    {
        if (tokens.length > 0)
        {
            for (var i:int = 0; i < tokens.length; i++)
            {
                message = message.replace("{" + i + "}", tokens[i]);
            }
        }
        return message;
    }
}
}