/**
 * Created by Teoti on 3/10/2015.
 */
package com.teotigraphix.ui.component.session
{

import com.teotigraphix.model.session.IClip;
import com.teotigraphix.ui.component.UIBorder;

import feathers.controls.Button;
import feathers.skins.IStyleProvider;

import flash.text.engine.ElementFormat;

import starling.display.DisplayObject;

public class ClipButton extends Button
{
    public static const INVALIDATE_FLAG_CLIP:String = "clip";

    public static const INVALIDATION_FLAG_CLIP_STATE:String = "clipState";

    public static var globalStyleProvider:IStyleProvider;

    public var lockedElementFormat:ElementFormat;
    public var normalElementFormat:ElementFormat;

    public var playIconSkin:DisplayObject;
    public var stopIconSkin:DisplayObject;
    public var queuedIconSkin:DisplayObject;
    public var idleIconSkin:DisplayObject;
    public var recordIconSkin:DisplayObject;

    private var _clip:IClip;
    private var _locked:Boolean = false;
    private var _idleSkin:DisplayObject;
    private var _queuedSkin:DisplayObject;
    private var _dequeuedSkin:DisplayObject;
    private var _playSkin:DisplayObject;
    private var _border:UIBorder;

    override protected function get defaultStyleProvider():IStyleProvider
    {
        return ClipButton.globalStyleProvider;
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

    public function get locked():Boolean
    {
        return _locked;
    }

    public function set locked(value:Boolean):void
    {
        if (value == _locked)
            return;
        _locked = value;
        invalidate(INVALIDATE_FLAG_CLIP);
    }

    public function get clip():IClip
    {
        return _clip;
    }

    public function set clip(value:IClip):void
    {
        //if (value == _clip)
        //    return;
        _clip = value;
        invalidate(INVALIDATE_FLAG_CLIP);
    }

    public function ClipButton()
    {
        super();
    }

    override protected function initialize():void
    {
        super.initialize();
    }

    override protected function draw():void
    {
        super.draw();

        if (isInvalid(INVALIDATE_FLAG_CLIP))
        {
            if (!_locked)
            {
                defaultLabelProperties.elementFormat = normalElementFormat;

                if (_clip != null)
                {
                    commitLabel();
                    label = clip.name;
                    isEnabled = true;
                    _border.color = clip.color;

                    if (_clip.isPlaying)
                    {
                        addChild(playIconSkin);
                        playIconSkin.x = 10;
                        playIconSkin.y = 10;
                    }
                    else
                    {
                        playIconSkin.removeFromParent();
                    }
                }
                else
                {
                    label = "";
                    isEnabled = false;
                    defaultSkin = disabledSkin;
                }
            }
            else
            {
                defaultLabelProperties.elementFormat = lockedElementFormat;
            }
        }

        if (isInvalid(INVALIDATION_FLAG_CLIP_STATE))
        {
            if (_clip != null)
            {
                commitLabel();
            }
        }

        if (_border == null)
        {
            _border = new UIBorder();
            addChild(_border);
            if (labelTextRenderer != null)
                swapChildren(_border, DisplayObject(labelTextRenderer));
        }

        var offset:int = 3;
        if (clip != null && clip.color != 0x393939)
            offset = 2;

        _border.x = offset;
        _border.y = offset;
        _border.setSize(width - (offset * 2), height - (offset * 2));
    }

    public function stateChange():void
    {
        //invalidate(INVALIDATION_FLAG_CLIP_STATE);

        if (_clip != null)
        {
            //commitLabel();
            //XXX label = clip.name;
            isEnabled = true;
            label = clip.name;
            isEnabled = true;
            _border.color = clip.color;

            playIconSkin.removeFromParent();
            stopIconSkin.removeFromParent();
            queuedIconSkin.removeFromParent();
            //recordIconSkin.removeFromParent();

            if (_clip.isPlaying)
            {
                if (_clip.isQueued)
                {
                    addChild(queuedIconSkin);
                    queuedIconSkin.x = 5;
                    queuedIconSkin.y = 5;
                }
                else
                {
                    addChild(playIconSkin);
                    playIconSkin.x = 5;
                    playIconSkin.y = 5;
                }
            }
            else
            {
                if (_clip.hasContent)
                {
                    addChild(idleIconSkin);
                    idleIconSkin.x = 5;
                    idleIconSkin.y = 5;
                }
                else
                {
                    addChild(stopIconSkin);
                    stopIconSkin.x = 5;
                    stopIconSkin.y = 5;
                }
            }
        }
    }

    private function commitLabel():void
    {
        //switch (_clip.state)
        //{
        //    case ClipState.Dequeued:
        //        label = "D";
        //        defaultSkin = _dequeuedSkin;
        //        break;
        //
        //    case ClipState.Idle:
        //        label = _clip.info.name;
        //        defaultSkin = _idleSkin;
        //        break;
        //
        //    case ClipState.Play:
        //        label = "P" + _clip.info.name;
        //        defaultSkin = _playSkin;
        //        break;
        //
        //    case ClipState.Queued:
        //        label = "Q";
        //        defaultSkin = _queuedSkin;
        //        break;
        //}
    }

}
}
