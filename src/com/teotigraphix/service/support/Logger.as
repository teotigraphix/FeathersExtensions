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

package com.teotigraphix.service.support
{

import com.teotigraphix.service.ILogger;

public class Logger implements ILogger
{
    //var logger:org.as3commons.logging.api.ILogger = getLogger("Logger");

    public function Logger()
    {
    }

    public function log(tag:String, message:String):void
    {
        trace("    [Log] {" + tag + "} " + ", " + message);
        //logger
    }

    public function warn(tag:String, message:String):void
    {
        trace("!!! [Warning] {" + tag + "} " + message);
    }

    public function err(tag:String, message:String):void
    {
        trace("!!! [Error] | " + tag + ", " + message);
    }

    public function startup(tag:String, message:String):void
    {
        trace(" [STARTUP] {" + tag + "} " + message);
    }

    public function debug(tag:String, message:String):void
    {
        trace("    [Debug] {" + tag + "} " + message);
    }
}
}