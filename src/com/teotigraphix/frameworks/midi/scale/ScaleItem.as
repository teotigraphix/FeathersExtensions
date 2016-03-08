////////////////////////////////////////////////////////////////////////////////
// Copyright 2016 Michael Schmalle - Teoti Graphix, LLC
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
package com.teotigraphix.frameworks.midi.scale
{

public class ScaleItem
{
    private var _name:String;
    private var _scaleID:int;
    private var _matrix:Vector.<int>;
    
    //----------------------------------
    // scaleID
    //----------------------------------
    
    public function get name():String
    {
        return _name;
    }
    
    //----------------------------------
    // scaleID
    //----------------------------------
    
    public function get scaleID():int
    {
        return _scaleID;
    }
    
    //----------------------------------
    // matrix
    //----------------------------------
    
    public function get matrix():Vector.<int>
    {
        return _matrix;
    }

    //--------------------------------------------------------------------------
    // Constructor
    //--------------------------------------------------------------------------
    
    public function ScaleItem(name:String = null, scaleID:int = -1, matrix:Vector.<int> = null)
    {
        _name = name;
        _scaleID = scaleID;
        _matrix = matrix;
    }
}
}
