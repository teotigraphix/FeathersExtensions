package com.teotigraphix.frameworks.osc
{

import flash.utils.ByteArray;

/**
 * This is a basic class for OSCBundles and OSCMessages that basically wraps a ByteArray
 * and offers some additional functions for reading the binary data for extending classes.
 *
 * @author Immanuel Bauer
 * @author Michael Schmalle
 */
public class OSCPacket
{

    internal var _bytes:ByteArray;

    public function OSCPacket(bytes:ByteArray = null)
    {
        if (bytes != null)
            _bytes = bytes;
        else
            _bytes = new ByteArray();
    }

    public function getPacketInfo():String
    {
        return "packet";
    }

    public function getBytes():ByteArray
    {
        return _bytes;
    }

    protected function skipNullString():void
    {
        var character:String = "";
        while (_bytes.bytesAvailable > 0)
        {
            character = _bytes.readUTFBytes(1);
            if (character != "")
            {
                _bytes.position -= 1;
                break;
            }
        }
    }

    protected function readString():String
    {
        var out:String = "";
        var character:String = "";
        while (_bytes.bytesAvailable > 0)
        {
            character = _bytes.readUTFBytes(4);
            out += character;
            if (character.length < 4) break;
        }
        return out;
    }

    protected function readTimeTag():OSCTimeTag
    {
        var seconds:uint = _bytes.readUnsignedInt();
        var picoseconds:uint = _bytes.readUnsignedInt();

        return new OSCTimeTag(seconds, picoseconds);
    }

    protected function readBlob():ByteArray
    {
        var length:int = _bytes.readInt();
        var blob:ByteArray = new ByteArray();
        _bytes.readBytes(blob, 0, length);

        var bits:int = (length + 1) * 8;
        while ((bits % 32) != 0)
        {
            _bytes.position += 1;
            bits += 8;
        }

        return blob;
    }

    protected function read64BInt():ByteArray
    {
        var bigInt:ByteArray = new ByteArray();

        _bytes.readBytes(bigInt, 0, 8);

        return bigInt;
    }

    protected function writeString(str:String, byteArray:ByteArray = null):void
    {
        var nulls:int = 4 - (str.length % 4);
        if (!byteArray) byteArray = _bytes;
        byteArray.writeUTFBytes(str);
        //add zero padding so the length of the string is a multiple of 4
        for (var c:int = 0; c < nulls; c++)
        {
            byteArray.writeByte(0);
        }
    }

    protected function writeTimeTag(ott:OSCTimeTag, byteArray:ByteArray = null):void
    {
        if (!byteArray) byteArray = _bytes;
        byteArray.writeUnsignedInt(ott.seconds);
        byteArray.writeUnsignedInt(ott.picoseconds);
    }

    protected function writeBlob(blob:ByteArray):void
    {
        var length:int = blob.length;
        blob.position = 0;
        blob.readBytes(_bytes, _bytes.position, length);

        var nulls:int = length % 4;
        for (var c:int = 0; c < nulls; c++)
        {
            _bytes.writeByte(0);
        }
    }

    protected function write64BInt(bigInt:ByteArray):void
    {
        bigInt.position = 0;
        bigInt.readBytes(_bytes, _bytes.position, 8);
    }
}
}