/**
 * Created by Teoti on 3/10/2015.
 */
package com.teotigraphix.ui.component.session
{

import com.teotigraphix.model.session.IScene;

import feathers.controls.Button;
import feathers.skins.IStyleProvider;

import starling.display.DisplayObject;
import starling.events.Event;

public class SceneButton extends Button
{
    public static const INVALIDATE_FLAG_SCENE:String = "scene";

    public static const INVALIDATION_FLAG_CLIP_STATE:String = "clipState";

    public static const EVENT_SCENE_TAP:String = "sceneTap";

    public static var globalStyleProvider:IStyleProvider;

    private var _scene:IScene;
    private var _idleSkin:DisplayObject;
    private var _queuedSkin:DisplayObject;
    private var _dequeuedSkin:DisplayObject;
    private var _playSkin:DisplayObject;

    override protected function get defaultStyleProvider():IStyleProvider
    {
        return SceneButton.globalStyleProvider;
    }

    public function set idleSkin(value:DisplayObject):void
    {
        _idleSkin = value;
    }

    public function set queuedSkin(value:DisplayObject):void
    {
        _queuedSkin = value;
    }

    public function set dequeuedSkin(value:DisplayObject):void
    {
        _dequeuedSkin = value;
    }

    public function set playSkin(value:DisplayObject):void
    {
        _playSkin = value;
    }

    public function get scene():IScene
    {
        return _scene;
    }

    public function set scene(value:IScene):void
    {
        if (value == _scene)
            return;
        _scene = value;
        invalidate(INVALIDATE_FLAG_SCENE);
    }

    public function SceneButton()
    {
        super();
    }

    override protected function initialize():void
    {
        super.initialize();

        addEventListener(Event.TRIGGERED, triggeredHandler);
    }

    override protected function draw():void
    {
        super.draw();

        if (isInvalid(INVALIDATE_FLAG_SCENE))
        {
            isEnabled = _scene != null;// && _scene.hasClips;

            if (_scene != null)
            {
                commitLabel();
                label = scene.name;
            }
            else
            {
                label = "";
                isEnabled = false;
                defaultSkin = disabledSkin;
            }
        }

        if (isInvalid(INVALIDATION_FLAG_CLIP_STATE))
        {
            if (_scene != null)
            {
                commitLabel();
            }
        }
    }

    public function stateChange():void
    {
        invalidate(INVALIDATION_FLAG_CLIP_STATE);
    }

    private function commitLabel():void
    {
        //label = _scene.name;
        //
        //if (_scene.isQueded)
        //{
        //    defaultSkin = _queuedSkin;
        //}
        //else if (_scene.isDequeded)
        //{
        //    defaultSkin = _dequeuedSkin;
        //}
        //else if (_scene.isPlaying)
        //{
        //    defaultSkin = _playSkin;
        //}
        //else if (_scene.hasClips)
        //{
        //    defaultSkin = _idleSkin;
        //}
        //
        //if (!_scene.hasClips)
        //{
        //    label = "";
        //}
    }

    private function triggeredHandler(event:Event):void
    {
        dispatchEventWith(EVENT_SCENE_TAP, true, _scene);
    }
}
}
