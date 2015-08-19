/**
 * Created by Teoti on 3/14/2015.
 */
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
