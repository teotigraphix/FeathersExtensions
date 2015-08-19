/**
 * Created by Teoti on 3/7/2015.
 */
package com.teotigraphix.ui.component
{

import feathers.core.FeathersControl;
import feathers.core.PopUpManager;

import starling.animation.Transitions;
import starling.animation.Tween;
import starling.core.Starling;

public class PopUpManagerTransitioner
{
    private var _popUp:FeathersControl;
    private var _duration:Number;

    public function PopUpManagerTransitioner()
    {
    }

    public function execute():void
    {
        var tween:Tween = new Tween(_popUp, _duration, Transitions.EASE_IN_OUT);
        tween.fadeTo(0);
        tween.onComplete = onComplete;
        Starling.juggler.add(tween);
    }

    private function onComplete(cancelTransition:Boolean = false):void
    {
        PopUpManager.removePopUp(_popUp, true);
    }

    /**
     *
     * @param popUp
     * @param duration tenths of a second eg 0.4, 4 tenths or 400 milliseconds
     */
    public static function removePopUp(popUp:FeathersControl, duration:Number):void
    {
        var transitioner:PopUpManagerTransitioner = new PopUpManagerTransitioner();
        transitioner._popUp = popUp;
        transitioner._duration = duration;
        transitioner.execute();
    }
}
}
