/**
 * Created by Teoti on 5/9/2015.
 */
package com.teotigraphix.ui.component.instrument
{

import com.teotigraphix.frameworks.midi.scale.NoteReference;
import com.teotigraphix.frameworks.midi.scale.ScaleData;
import com.teotigraphix.frameworks.midi.scale.ScaleItem;
import com.teotigraphix.ui.component.SimpleButton;
import com.teotigraphix.ui.component.instrument.support.KeyBoarKeyData;
import com.teotigraphix.ui.component.instrument.support.KeyBoardKey;
import com.teotigraphix.ui.theme.AssetMap;

import feathers.controls.LayoutGroup;
import feathers.controls.PickerList;
import feathers.data.ListCollection;

import flash.utils.Dictionary;

import starling.display.DisplayObject;
import starling.events.Event;
import starling.events.Touch;
import starling.events.TouchEvent;
import starling.events.TouchPhase;

public class KeyBoard extends LayoutGroup
{
    public static const EVENT_OCTAVE_UP_TRIGGERED:String = "octaveUpTriggered";
    public static const EVENT_OCTAVE_DOWN_TRIGGERED:String = "octaveDownTriggered";
    public static const EVENT_NOTE_ON_TRIGGERED:String = "noteOnTriggered";
    public static const EVENT_NOTE_OFF_TRIGGERED:String = "noteOffTriggered";
    public static const EVENT_SCALE_PICKER_CHANGED:String = "scalePickerChanged";
    public static const EVENT_ROOT_KEY_PICKER_CHANGED:String = "rootKeyPickerChanged";

    public static const OCTAVE_UP_BUTTON_STYLE_NAME:String = "octave-up-button";
    public static const OCTAVE_DOWN_BUTTON_STYLE_NAME:String = "octave-down-button";

    public static const LAYOUT_MODE_NORMAL:String = "normal";
    public static const LAYOUT_MODE_COMPACT:String = "compact";

    //--------------------------------------------------------------------------
    // Property :: Variables
    //--------------------------------------------------------------------------

    private var _layoutMode:String = LAYOUT_MODE_NORMAL;
    private var _scaleData:ScaleData;

    //--------------------------------------------------------------------------
    // Touch :: Variables
    //--------------------------------------------------------------------------

    private var _idToKeyMap:Dictionary = new Dictionary();
    private var _currentTouches:Dictionary = new Dictionary();

    //--------------------------------------------------------------------------
    // Private :: Variables
    //--------------------------------------------------------------------------

    private var _sharpHeightPercent:Number = 0.5;
    private var _sharpWidthPercent:Number = 0.9;
    private var _octaveButtonWidth:Number = 50;
    private var _noteNameDisplayMode:String = "all"; // all, octave, none

    private var _keyLayout:Array = [0, 1, 0, 1, 0, 0, 1, 0, 1, 0, 1, 0];

    //--------------------------------------------------------------------------
    // UI
    //--------------------------------------------------------------------------

    private var _keys:Vector.<KeyBoardKey> = new <KeyBoardKey>[];
    private var _whiteKeys:Vector.<KeyBoardKey> = new <KeyBoardKey>[];
    private var _blackKeys:Vector.<KeyBoardKey> = new <KeyBoardKey>[];

    private var _scalePickerList:PickerList;
    private var _rootKeyPickerList:PickerList;
    private var octaveUpButton:SimpleButton;
    private var octaveDownButton:SimpleButton;

    //--------------------------------------------------------------------------
    // Public API :: Properties
    //--------------------------------------------------------------------------

    //----------------------------------
    // layoutMode
    //----------------------------------

    public function get layoutMode():String
    {
        return _layoutMode;
    }

    public function set layoutMode(value:String):void
    {
        if (_layoutMode == value)
            return;
        _layoutMode = value;
        invalidateData();
    }

    //----------------------------------
    // scaleData
    //----------------------------------

    public function get scaleData():ScaleData
    {
        return _scaleData;
    }

    public function set scaleData(value:ScaleData):void
    {
        _scaleData = value;
    }

    //--------------------------------------------------------------------------
    // Constructor
    //--------------------------------------------------------------------------

    public function KeyBoard()
    {
    }

    //--------------------------------------------------------------------------
    // Overridden :: Methods
    //--------------------------------------------------------------------------

    override protected function initialize():void
    {
        super.initialize();

        backgroundSkin = AssetMap.create9ScaleImage("background-skin", 8, 8, 16, 16);

        addEventListener(TouchEvent.TOUCH, button_touchHandler);

        var pitches:Vector.<int> = _scaleData.getNotes();
        var names:Vector.<String> = _scaleData.getNoteNames();

        var tempKeys:Array = [];
        var numKeys:int = _scaleData.gridSize;

        var i:int;
        var cursor:int = 0;
        for (i = 0; i < numKeys; i++)
        {
            var key:KeyBoardKey = new KeyBoardKey();
            key.styleNameList.add("");
            //key.data = new KeyBoarKeyData(i, pitches[i], names[i]);
            key.isFlat = _keyLayout[cursor] == 1;
            _keys.push(key);

            if (!key.isFlat)
            {
                _whiteKeys.push(key);
            }
            else
            {
                _blackKeys.push(key);
            }

            cursor = (cursor < 11) ? cursor + 1 : 0;
        }

        // add white keys
        for (i = 0; i < numKeys; i++)
        {
            if (!_keys[i].isFlat)
            {
                addChild(_keys[i]);
            }
        }

        // add flats on top of white keys
        for (i = 0; i < numKeys; i++)
        {
            if (_keys[i].isFlat)
            {
                addChild(_keys[i]);
            }
        }

        octaveUpButton = new SimpleButton();
        octaveDownButton = new SimpleButton();
        octaveUpButton.addEventListener(Event.TRIGGERED, octaveUpButton_triggeredHandler);
        octaveDownButton.addEventListener(Event.TRIGGERED, octaveDownButton_triggeredHandler);

        addChild(octaveUpButton);
        addChild(octaveDownButton);

        _scalePickerList = new PickerList();
        _scalePickerList.dataProvider = new ListCollection(_scaleData.scales);
        _scalePickerList.addEventListener(Event.CHANGE, scalePickerList_changeHandler);
        addChild(_scalePickerList);

        _rootKeyPickerList = new PickerList();
        _rootKeyPickerList.dataProvider = new ListCollection(NoteReference.values);
        _rootKeyPickerList.addEventListener(Event.CHANGE, rootKeyPickerList_changeHandler);
        addChild(_rootKeyPickerList);
    }

    override protected function draw():void
    {
        super.draw();

        trace("actualWidth : " + actualWidth + ", actualHeight : " + actualHeight);

        var headerHeight:Number = 50;

        var contentHeight:Number = actualHeight - headerHeight;

        var calcX:Number = 0;
        var calcY:Number = headerHeight;

        var whiteKeyWidth:Number = (actualWidth - _octaveButtonWidth) / _whiteKeys.length;
        var blackKeyWidth:Number = whiteKeyWidth * _sharpWidthPercent;
        var blackKeyHalfWidth:Number = blackKeyWidth / 2;

        var numKeys:int = _scaleData.gridSize;

        for (var i:int = 0; i < numKeys; i++)
        {
            var key:KeyBoardKey = _keys[i];

            if (!key.isFlat)
            {
                key.x = calcX;
                key.y = calcY;
                key.setSize(whiteKeyWidth, contentHeight);
                calcX += whiteKeyWidth;
            }
            else
            {
                // key.x = (calcX - whiteKeyWidth) + blackKeyWidth + blackKeyHalfWidth;
                key.x = calcX - blackKeyHalfWidth;
                key.y = calcY;
                key.setSize(blackKeyWidth, contentHeight * _sharpHeightPercent);
            }
        }

        if (octaveUpButton != null)
        {
            octaveUpButton.setSize(_octaveButtonWidth, contentHeight / 2);
            octaveUpButton.move(actualWidth - _octaveButtonWidth, calcY);
        }
        if (octaveDownButton != null)
        {
            octaveDownButton.setSize(_octaveButtonWidth, contentHeight / 2);
            octaveDownButton.move(actualWidth - _octaveButtonWidth, calcY + (contentHeight / 2));
        }

        if (_scalePickerList != null)
        {
            _scalePickerList.setSize(200, 50);
            _scalePickerList.move(0, 0);
        }

        if (_rootKeyPickerList != null)
        {
            _rootKeyPickerList.setSize(100, 50);
            _rootKeyPickerList.move(200, 0);
        }

        if (isInvalid(INVALIDATION_FLAG_DATA))
        {
            refreshKeyData();

            _scalePickerList.selectedIndex = _scaleData.scaleIndex;
            _rootKeyPickerList.selectedIndex = _scaleData.noteIndex;
        }

        if (isInvalid(INVALIDATION_FLAG_SIZE))
        {
            setSizeInternal(200, 200, false);
        }
    }

    public function invalidateData():void
    {
        invalidate(INVALIDATION_FLAG_DATA);
    }

    private function refreshKeyData():void
    {
        var pitches:Vector.<int> = _scaleData.getNotes();
        var names:Vector.<String> = _scaleData.getNoteNames();
        var numKeys:int = _scaleData.gridSize;

        if (_layoutMode == LAYOUT_MODE_NORMAL)
        {
            var base:int = 60;//pitches[0] + _scaleData.getRootKey().baseNumber;
            for (var j:int = 0; j < numKeys; j++)
            {
                var key:KeyBoardKey = _keys[j];
                if (pitches.indexOf(base + j) != -1)
                {
                    key.data = new KeyBoarKeyData(j, pitches[j], names[j]);
                }
                else
                {
                    key.data = null;
                }
            }
        }
        else if (_layoutMode == LAYOUT_MODE_COMPACT)
        {
            for (var i:int = 0; i < numKeys; i++)
            {
                var key2:KeyBoardKey = _keys[i];
                key2.data = new KeyBoarKeyData(i, pitches[i], names[i]);
            }
        }

    }

    //private var scaleContainsPitch

    private function handleTouch(touch:Touch):void
    {
        var displayObject:DisplayObject = hitTest(touch.getLocation(this));
        if (displayObject == null)
        {
            // touch out of keys
            touchEnd(touch);
            return;
        }

        var key:KeyBoardKey = displayObject.parent as KeyBoardKey;
        if (key == null || key.currentState == KeyBoardKey.STATE_DISABLED)
        {
            return; // octave button
        }

        var id:int = touch.id;

        /*
        - if id in map
          - state down
          - add id:key

         */

        if (touch.phase == TouchPhase.BEGAN)
        {
            trace("BEGAN");

            trace(key.data.name);
            //key.currentState = KeyBoardKey.STATE_DOWN;
            _currentTouches[id] = true;
        }
        else if (touch.phase == TouchPhase.MOVED)
        {
            trace("MOVED");
            // this needs to be here for touch down, out side component, then back in
            // with touch still down
            _currentTouches[id] = true;
        }
        else if (touch.phase == TouchPhase.ENDED)
        {
            trace("ENDED");
            touchEnd(touch);
        }

        if (_currentTouches[id] != null)
        {
            var last:KeyBoardKey = _idToKeyMap[id];
            if (last != key)
            {
                // touch over has changed
                if (last != null)
                {
                    last.currentState = KeyBoardKey.STATE_UP;
                    dispatchEventWith(EVENT_NOTE_OFF_TRIGGERED, false, last.data);
                }

                key.currentState = KeyBoardKey.STATE_DOWN;
                dispatchEventWith(EVENT_NOTE_ON_TRIGGERED, false, key.data);
                _idToKeyMap[id] = key;
            }
        }
    }

    private function touchEnd(touch:Touch):void
    {

        var id:int = touch.id;

        _currentTouches[id] = null;
        delete _currentTouches[id];

        var key:KeyBoardKey = _idToKeyMap[id] as KeyBoardKey;
        if (key == null)
            return;

        key.currentState = KeyBoardKey.STATE_UP;
        dispatchEventWith(EVENT_NOTE_OFF_TRIGGERED, false, key.data);
        _idToKeyMap[id] = null;
        delete _idToKeyMap[id];
    }

    protected function button_touchHandler(event:TouchEvent):void
    {
        if (!_isEnabled)
        {

            return;
        }

        var touches:Vector.<Touch> = event.getTouches(this);
        if (touches.length > 0)
        {
            for each (var touch:Touch in touches)
            {
                handleTouch(touch);
            }
        }
        else
        {

        }
    }

    private function scalePickerList_changeHandler(event:Event):void
    {
        dispatchEventWith(EVENT_SCALE_PICKER_CHANGED, false, ScaleItem(_scalePickerList.selectedItem).scaleID);
    }

    private function rootKeyPickerList_changeHandler(event:Event):void
    {
        dispatchEventWith(EVENT_ROOT_KEY_PICKER_CHANGED, false,
                          NoteReference(_rootKeyPickerList.selectedItem).baseNumber);
    }

    private function octaveUpButton_triggeredHandler(event:Event):void
    {
        dispatchEventWith(EVENT_OCTAVE_UP_TRIGGERED);
    }

    private function octaveDownButton_triggeredHandler(event:Event):void
    {
        dispatchEventWith(EVENT_OCTAVE_DOWN_TRIGGERED);
    }

}
}
