package com.teotigraphix.frameworks.osc
{

import flash.errors.EOFError;
import flash.utils.ByteArray;

/**
 * An OSCMessage
 * @author Immanuel Bauer
 * @author Michael Schmalle
 */
public class OSCMessage extends OSCPacket
{

    private var _addressPattern:String;
    private var _pattern:String;
    private var _action:String;
    private var _argumentArray:Array;
    private var _openArray:Array;
    private var _innerArray:Array;
    private var _typesArray:Array;

    /**
     * @return The address pattern of the OSCMessage
     */
    public function get address():String
    {
        return _addressPattern;
    }

    /**
     * Sets the address of the Message
     */
    public function set address(address:String):void
    {
        _addressPattern = address;
    }

    /**
     * @return The arguments/content of the OSCMessage
     */
    public function get arguments():Array
    {
        return _argumentArray;
    }

    /**
     * Creates a OSCMessage from the given ByteArray containing a binarycoded OSCMessage
     *
     * @param    bytes A ByteArray containing an OSCMessage
     */
    public function OSCMessage(bytes:ByteArray = null)
    {
        super(bytes);

        if (bytes != null)
        {
            //read the OSCMessage head
            _addressPattern = readString();

            //read the parsing pattern for the following OSCMessage bytes
            _pattern = readString();

            _typesArray = [];
            _argumentArray = [];

            //read the remaining bytes according to the parsing pattern
            _openArray = _argumentArray;
            var l:int = _pattern.length;
            try
            {
                for (var c:int = 0; c < l; c++)
                {
                    switch (_pattern.charAt(c))
                    {
                        case "s":
                            _openArray.push(readString());
                            _typesArray.push("s");
                            break;
                        case "f":
                            _openArray.push(_bytes.readFloat());
                            _typesArray.push("f");
                            break;
                        case "i":
                            _openArray.push(_bytes.readInt());
                            _typesArray.push("i");
                            break;
                        case "b":
                            _openArray.push(readBlob());
                            _typesArray.push("b");
                            break;
                        case "h":
                            _openArray.push(read64BInt());
                            _typesArray.push("h");
                            break;
                        case "t":
                            _openArray.push(readTimeTag());
                            _typesArray.push("t");
                            break;
                        case "d":
                            _openArray.push(_bytes.readDouble());
                            _typesArray.push("d");
                            break;
                        case "S":
                            _openArray.push(readString());
                            _typesArray.push("S");
                            break;
                        case "c":
                            _openArray.push(_bytes.readMultiByte(4, "US-ASCII"));
                            _typesArray.push("c");
                            break;
                        case "r":
                            _openArray.push(_bytes.readUnsignedInt());
                            _typesArray.push("r");
                            break;
                        case "T":
                            _openArray.push(true);
                            _typesArray.push("T");
                            break;
                        case "F":
                            _openArray.push(false);
                            _typesArray.push("F");
                            break;
                        case "N":
                            _openArray.push(null);
                            _typesArray.push("N");
                            break;
                        case "I":
                            _openArray.push(Infinity);
                            _typesArray.push("I");
                            break;
                        case "[":
                            _innerArray = [];
                            _openArray = _innerArray;
                            _typesArray.push("[");
                            break;
                        case "]":
                            _argumentArray.push(_innerArray.concat());
                            _openArray = _argumentArray;
                            _typesArray.push("]");
                            break;
                        default:
                            break;
                    }
                }
            }
            catch (e:EOFError)
            {
                trace("corrupt");
                _argumentArray = [];
                _argumentArray.push("Corrupted OSCMessage");
                _openArray = null;
            }
        }
        else
        {
            _pattern = ",";
            _argumentArray = [];
            _openArray = _argumentArray;
        }
    }

    public override function getBytes():ByteArray
    {
        var out:ByteArray = new ByteArray();
        writeString(address, out);
        writeString(_pattern, out);
        out.writeBytes(_bytes, 0, _bytes.length);
        out.position = 0;
        return out;
    }

    /**
     * Generates a String representation of this OSCMessage for debugging purposes
     *
     * @return A traceable String.
     */
    public override function getPacketInfo():String
    {
        var out:String = "";
        out += "\nMessagehead: " + _addressPattern + " | " + _pattern + " | ->  (" + _argumentArray.length + ") \n" + argumentsToString();
        return out;
    }

    /* Returns the bytes of this <code>OSCMessage</code>
     *
     * @return A <code>ByteArray</code> containing the bytes of this <code>OSCMessage</code>
     */

    /**
     * Adds a single argument value to the OSCMessage
     * For special oscTypes like booleans or infinity there is no value needed
     * If you want to add an OSCArray to the <code>OSCMessage</code> use <code>addArgmuents()</code>
     *
     * @param    oscType The OSCType of the argument.
     * @param    value The value of the argument.
     */
    public function addArgument(oscType:String, value:Object = null):void
    {
        if (oscType.length == 1)
        {
            if ((oscType == "s" || oscType == "S") && value is String)
            {
                _pattern += oscType;
                _openArray.push(value);
                writeString(value as String);
            }
            else if (oscType == "f" && value is Number)
            {
                _pattern += oscType;
                _openArray.push(value);
                _bytes.writeFloat(value as Number);
            }
            else if (oscType == "i" && value is int)
            {
                _pattern += oscType;
                _openArray.push(value);
                _bytes.writeInt(value as int);
            }
            else if (oscType == "b" && value is ByteArray)
            {
                _pattern += oscType;
                _openArray.push(value);
                writeBlob(value as ByteArray);
            }
            else if (oscType == "h" && value is ByteArray)
            {
                _pattern += oscType;
                _openArray.push(value);
            }
            else if (oscType == "t" && value is OSCTimeTag)
            {
                _pattern += oscType;
                _openArray.push(value);
                writeTimeTag(value as OSCTimeTag);
            }
            else if (oscType == "d" && value is Number)
            {
                _pattern += oscType;
                _openArray.push(value);
                _bytes.writeDouble(value as Number);
            }
            else if (oscType == "c" && value is String && (value as String).length == 1)
            {
                _pattern += oscType;
                _openArray.push(value);
                _bytes.writeMultiByte(value as String, "US-ASCII");
            }
            else if (oscType == "r" && value is uint)
            {
                _pattern += oscType;
                _openArray.push(value);
                _bytes.writeUnsignedInt(value as uint);
            }
            else if (oscType == "T")
            {
                _pattern += oscType;
                _openArray.push(true);
            }
            else if (oscType == "F")
            {
                _pattern += oscType;
                _openArray.push(false);
            }
            else if (oscType == "N")
            {
                _pattern += oscType;
                _openArray.push(null);
            }
            else if (oscType == "I")
            {
                _pattern += oscType;
                _openArray.push(Infinity);
            }
            else
            {
                throw new Error("Invalid or unknown OSCType or invalid value for given OSCType: " + oscType);
            }
        }
        else
        {
            throw new Error("The oscType has to be one character.");
        }
    }

    /**
     * Add multiple argument values to the OSCMessage at once.
     *
     * @param    oscTypes The OSCTypes of the arguments
     * @param    values The values of the arguments
     */
    public function addArguments(oscTypes:String, values:Array):void
    {
        var l:int = oscTypes.length;
        var oscType:String = "";
        var vc:int = 0;

        for (var c:int = 0; c < l; c++)
        {
            oscType = oscTypes.charAt(c);
            if (oscType.charCodeAt(0) < 97)
            { //isn't a small letter
                if (oscType == "[")
                {
                    _innerArray = new Array();
                    _openArray = _innerArray;
                }
                else if (oscType == "]")
                {
                    _argumentArray.push(_innerArray.concat());
                    _openArray = _argumentArray;
                }
                else if (oscType == "S")
                {
                    addArgument(oscType, values[vc]);
                    vc++;
                }
                else
                {
                    addArgument(oscType);
                }
            }
            else
            {
                addArgument(oscType, values[vc]);
                vc++;
            }
        }
    }

    /**
     * Generates a String representation of this OSCMessage's content for debugging purposes
     *
     * @return A traceable String.
     */
    public function argumentsToString():String
    {
        var out:String = "arguments: ";
        if (_argumentArray.length > 0)
        {
            try
            {
                out += _argumentArray[0].toString();
            }
            catch (e:Error)
            {
                trace("");
            }

            for (var c:int = 1; c < _argumentArray.length; c++)
            {
                out += " | " + _argumentArray[c].toString();
            }
        }
        return out;
    }

    /**
     *
     * @return string representation of an OSCMessage.
     *
     */
    public function toString():String
    {
        var toString:String = new String();
        toString = toString + ("<name:");
        toString = toString + ("", address);
        toString = toString + (",");

        //types
        toString = toString + (" [types: ");
        for (var i:Number = 0; i < _typesArray.length; i++)
        {
            toString = toString + ("", _typesArray[i]);
            if (i < _typesArray.length - 1)
            {
                toString = toString + (", ");
            }
        }
        toString = toString + ("],");

        //arguments
        toString = toString + (" [arguments: ");
        for (i = 0; i < _openArray.length; i++)
        {
            toString = toString + ("", _openArray[i]);
            if (i < _openArray.length - 1)
            {
                toString = toString + (", ");
            }
        }
        toString = toString + ("]");

        toString = toString + (">");

        return toString;
    }

    /**
     * Checks if the given ByteArray is an OSCMessage
     *
     * @param    bytes The ByteArray to be checked.
     * @return true if the ByteArray contains an OSCMessage
     */
    public static function isMessage(bytes:ByteArray):Boolean
    {
        if (bytes != null)
        {
            //bytes.position = 0;
            var header:String = bytes.readUTFBytes(1);
            bytes.position -= 1;
            if (header == "/")
            {
                return true;
            }
            else
            {
                return false;
            }
        }
        else
        {
            return false;
        }
    }

    /**
     * This is comfort function for creating an OSCMessage with less code.
     *
     * @param    address The OSCAddress of the <code>OSCMessage</code>.
     * @param    valueOSCTypes A <code>String</code> of OSCTypes describing the types of the <code>Objects</code>
     *     within the <code>values</code> <code>Array</code>. There has to be a type for every value in the
     *     <code>values</code> <code>Array</code>.
     * @param    values An <code>Array</code> containing the values that should be part of the
     *     <code>OSCMessage</code>.
     * @return    An <code>OSCMessage</code> containing the given values.
     */
    public static function createOSCMessage(address:String, valueOSCTypes:String, values:Array):OSCMessage
    {
        var msg:OSCMessage = new OSCMessage();
        msg._addressPattern = address;
        msg.addArguments(valueOSCTypes, values);
        return msg;
    }
}

}