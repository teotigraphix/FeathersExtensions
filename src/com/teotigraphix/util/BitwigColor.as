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

public class BitwigColor
{
    public static const DarkGrey:BitwigColor = new BitwigColor("DarkGrey", 0.3294117748737335,
                                                               0.3294117748737335,
                                                               0.3294117748737335, 1);

    public static const Gray:BitwigColor = new BitwigColor("Gray", 0.47843137383461,
                                                           0.47843137383461,
                                                           0.47843137383461, 2);

    public static const LightGray:BitwigColor = new BitwigColor("LightGray", 0.7882353067398071,
                                                                0.7882353067398071,
                                                                0.7882353067398071, 3);

    public static const Silver:BitwigColor = new BitwigColor("Silver", 0.5254902243614197,
                                                             0.5372549295425415,
                                                             0.6745098233222961, 40);

    public static const DarkBrown:BitwigColor = new BitwigColor("DarkBrown", 0.6392157077789307,
                                                                0.4745098054409027,
                                                                0.26274511218070984, 11);

    public static const Brown:BitwigColor = new BitwigColor("Brown", 0.7764706015586853,
                                                            0.6235294342041016,
                                                            0.43921568989753723, 12);

    public static const DarkBlue:BitwigColor = new BitwigColor("DarkBlue", 0.34117648005485535,
                                                               0.3803921639919281,
                                                               0.7764706015586853, 42);

    public static const Lavendar:BitwigColor = new BitwigColor("Lavendar", 0.5176470875740051,
                                                               0.5411764979362488,
                                                               0.8784313797950745, 44);

    public static const Purple:BitwigColor = new BitwigColor("Purple", 0.5843137502670288,
                                                             0.2862745225429535,
                                                             0.7960784435272217, 58);

    public static const Pink:BitwigColor = new BitwigColor("Pink", 0.8509804010391235,
                                                           0.21960784494876862,
                                                           0.4431372582912445, 57);

    public static const Red:BitwigColor = new BitwigColor("Red", 0.8509804010391235,
                                                          0.18039216101169586,
                                                          0.1411764770746231, 6);

    public static const Orange:BitwigColor = new BitwigColor("Orange", 1,
                                                             0.34117648005485535,
                                                             0.0235294122248888, 60);

    public static const LightOrange:BitwigColor = new BitwigColor("LightOrange", 0.8509804010391235,
                                                                  0.615686297416687,
                                                                  0.062745101749897, 62);

    public static const Green:BitwigColor = new BitwigColor("Green", 0.45098039507865906,
                                                            0.5960784554481506,
                                                            0.0784313753247261, 18);

    public static const DarkGreen:BitwigColor = new BitwigColor("DarkGreen", 0,
                                                                0.615686297416687,
                                                                0.27843138575553894, 26);

    public static const Teal:BitwigColor = new BitwigColor("Teal", 0,
                                                           0.6509804129600525,
                                                           .5803921818733215, 30);

    public static const ElectricBlue:BitwigColor = new BitwigColor("ElectricBlue", 0,
                                                                   0.6000000238418579,
                                                                   0.8509804010391235, 37);

    public static const LightPurple:BitwigColor = new BitwigColor("LightPurple", 0.7372549176216125,
                                                                  0.4627451002597809,
                                                                  0.9411764740943909, 48);

    public static const LightPink:BitwigColor = new BitwigColor("LightPink", 0.8823529481887817,
                                                                0.4000000059604645,
                                                                0.5686274766921997, 56);

    public static const Skin:BitwigColor = new BitwigColor("Skin", 0.9254902005195618,
                                                           0.3803921639919281,
                                                           0.34117648005485535, 4);

    public static const Peach:BitwigColor = new BitwigColor("Peach", 1,
                                                            0.5137255191802979,
                                                            0.24313725531101227, 10);

    public static const BurntOrange:BitwigColor = new BitwigColor("BurntOrange", 0.8941176533699036,
                                                                  0.7176470756530762,
                                                                  0.30588236451148987, 61);

    public static const OliveGreen:BitwigColor = new BitwigColor("OliveGreen", 0.6274510025978088,
                                                                 0.7529411911964417,
                                                                 0.2980392277240753, 18);

    public static const MintGreen:BitwigColor = new BitwigColor("MintGreen", 0.24313725531101227,
                                                                0.7333333492279053,
                                                                0.3843137323856354, 25);

    public static const Aqua:BitwigColor = new BitwigColor("Aqua", 0.26274511218070984,
                                                           0.8235294222831726,
                                                           0.7254902124404907, 32);

    public static const Cyan:BitwigColor = new BitwigColor("Cyan", 0.2666666805744171,
                                                           0.7843137383460999,
                                                           1, 41);

    public static const White:BitwigColor = new BitwigColor("White", 1, 1, 1, 120);

    public static var _values:Vector.<BitwigColor>;

    public static function get values():Vector.<BitwigColor>
    {
        if (_values != null)
            return _values;

        _values = new <BitwigColor>[];
        _values.push(DarkGrey);
        _values.push(Gray);
        _values.push(LightGray);
        _values.push(Silver);
        _values.push(DarkBrown);
        _values.push(Brown);
        _values.push(DarkBlue);
        _values.push(Lavendar);
        _values.push(Purple);
        _values.push(Pink);
        _values.push(Red);
        _values.push(Orange);
        _values.push(LightOrange);
        _values.push(Green);
        _values.push(DarkGreen);
        _values.push(Teal);
        _values.push(ElectricBlue);
        _values.push(LightPurple);
        _values.push(LightPink);
        _values.push(Skin);
        _values.push(Peach);
        _values.push(BurntOrange);
        _values.push(OliveGreen);
        _values.push(MintGreen);
        _values.push(Aqua);
        _values.push(Cyan);
        _values.push(White);

        return _values;
    }

    private var _name:String;
    private var _r:Number;
    private var _g:Number;
    private var _b:Number;
    private var _id:int;

    public function get name():String
    {
        return _name;
    }

    public function get value():uint
    {
        return ColorUtils.rgbToHex(255 * _r, 255 * _g, 255 * _b);
    }

    public function get id():int
    {
        return _id;
    }

    public function BitwigColor(name:String, r:Number, g:Number, b:Number, id:int)
    {
        _name = name;
        _r = r;
        _g = g;
        _b = b;
        _id = id;
    }

    public static function fromId(id:int):BitwigColor
    {
        for each (var color:BitwigColor in values)
        {
            if (color.id == id)
                return color;
        }
        return null;
    }
}
}
