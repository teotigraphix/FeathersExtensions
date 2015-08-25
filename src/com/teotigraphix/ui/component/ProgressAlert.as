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

package com.teotigraphix.ui.component
{

import feathers.controls.Alert;
import feathers.controls.ProgressBar;

public class ProgressAlert extends Alert
{
    public static const INVALIDATE_FLAG_PROGRESS:String = "progress";

    private var _progress:int;
    private var _progressBar:ProgressBar;

    public function get progress():int
    {
        return _progress;
    }

    public function set progress(value:int):void
    {
        if (value == _progress)
            return;
        _progress = value;
        invalidate(INVALIDATE_FLAG_PROGRESS);
    }

    public function ProgressAlert()
    {
        super();
    }

    override protected function initialize():void
    {
        super.initialize();

        _progressBar = new ProgressBar();
        _progressBar.minimum = 0;
        _progressBar.maximum = 100;
        addChild(_progressBar);
    }

    override protected function draw():void
    {
        super.draw();

        if (isInvalid(INVALIDATE_FLAG_PROGRESS))
        {
            _progressBar.value = _progress;
        }
    }
}
}
