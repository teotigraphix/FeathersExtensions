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

/**
 * Interface used to call methods on instance' creation,
 * serialization and deserialization cycle.
 */
public interface ISerialize
{
    /**
     * Called when the parent project has just been created.
     */
    function create():void;

    /**
     * Called when the parent project has just been deserialized.
     */
    function wakeup():void;

    /**
     * Called when the parent project is getting ready to serialize, preSleep (true) or right after
     * the project has been serialized, preSleep (true).
     *
     * @param preSleep Before serialization (false), after serialization (true).
     */
    function sleep(preSleep:Boolean = false):void;
}
}
