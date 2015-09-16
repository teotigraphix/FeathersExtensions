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

import feathers.skins.IStyleProvider;

import starling.display.DisplayObject;

public class Led extends SimpleButton
{
    public static const STATE_LIT:String = "lit";
    public static const STATE_UNLIT:String = "unlit";

    //--------------------------------------------------------------------------
    // Constants
    //--------------------------------------------------------------------------
    public static const STATE_CURRENT:String = "current";
    public static var globalStyleProvider:IStyleProvider;
    private var _isLit:Boolean;
    private var _isCurrent:Boolean;
    private var _isCurrentSkin:DisplayObject;

    // Skins
    private var _isLitSkin:DisplayObject;
    private var _isUnLitSkin:DisplayObject;

    override protected function get defaultStyleProvider():IStyleProvider
    {
        return Led.globalStyleProvider;
    }

    override protected function set currentState(value:String):void
    {
        if (value == STATE_CURRENT || value == STATE_LIT || value == STATE_UNLIT)
        {
            super.currentState = value;
        }
    }

    //--------------------------------------------------------------------------
    // Public :: Properties
    //--------------------------------------------------------------------------

    //----------------------------------
    // isLit
    //----------------------------------

    public function get isLit():Boolean
    {
        return _isLit;
    }

    public function set isLit(value:Boolean):void
    {
        _isLit = value;
        updateState();
    }

    //----------------------------------
    // isCurrent
    //----------------------------------

    public function get isCurrent():Boolean
    {
        return _isCurrent;
    }

    //----------------------------------
    // isCurrentSkin
    //----------------------------------

    public function set isCurrent(value:Boolean):void
    {
        _isCurrent = value;
        updateState();
    }

    public function get isCurrentSkin():DisplayObject
    {
        return _isCurrentSkin;
    }

    //----------------------------------
    // isLitSkin
    //----------------------------------

    public function set isCurrentSkin(value:DisplayObject):void
    {
        _isCurrentSkin = value;
    }

    public function get isLitSkin():DisplayObject
    {
        return _isLitSkin;
    }

    //----------------------------------
    // isUnLitSkin
    //----------------------------------

    public function set isLitSkin(value:DisplayObject):void
    {
        _isLitSkin = value;
    }

    public function get isUnLitSkin():DisplayObject
    {
        return _isUnLitSkin;
    }

    public function set isUnLitSkin(value:DisplayObject):void
    {
        _isUnLitSkin = value;
    }

    //--------------------------------------------------------------------------
    // Constructor
    //--------------------------------------------------------------------------

    public function Led()
    {
    }

    //--------------------------------------------------------------------------
    // Methods
    //--------------------------------------------------------------------------

    override protected function initialize():void
    {
        super.initialize();
    }

    override protected function draw():void
    {
        super.draw();

        //_border.move(2, 2);
        //_border.setSize(actualWidth - 4, actualHeight - 4);
        //
        //if (isInvalid(INVALIDATE_FLAG_COLOR))
        //{
        //    var color:uint = _isLit ? _litColor : _unlitColor;
        //    if (_isCurrent)
        //        color = _currentColor;
        //    _border.color = color;
        //}
    }

    override protected function skinToStateFunction(button:SimpleButton,
                                                    state:String,
                                                    oldSkin:DisplayObject):DisplayObject
    {
        var skin:DisplayObject;
        switch (state)
        {
            case STATE_CURRENT:
                skin = isCurrentSkin;
                break;
            case STATE_LIT:
                skin = isLitSkin;
                break;
            case STATE_UNLIT:
                skin = isUnLitSkin;
                break;
            //case STATE_DISABLED:
            //    skin = upSkin;
            //    break;
        }
        return skin;
    }

    private function updateState():void
    {
        if (_isCurrent)
        {
            currentState = STATE_CURRENT;
        }
        else if (_isLit)
        {
            currentState = STATE_LIT;
        }
        else
        {
            currentState = STATE_UNLIT;
        }
    }
}
}
