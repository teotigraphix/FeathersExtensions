package com.teotigraphix.frameworks.osc
{

import flash.utils.ByteArray;

/**
 * This class contains the functions to create, process and identify OSCBundles.
 *
 * @author Immanuel Bauer
 * @author Michael Schmalle
 */
public class OSCBundle extends OSCPacket
{

    private const SECONDS_1900_1970:uint = 2208988800;
    private var _content:Array;
    private var _time:OSCTimeTag;

    /**
     * Returns all subpackets of this OSCBundle
     *
     * @return An Array containing OSCPackets
     */
    public function get subPackets():Array
    {
        return _content;
    }

    /**
     * Returns the number of subpackets in this OSCBundle
     *
     * @return The number of subpackets
     */
    public function get subPacketCount():uint
    {
        return _content.length;
    }

    /**
     * @return The OSCTimetag of this OSCBundle
     */
    public function get timetag():OSCTimeTag
    {
        return _time;
    }

    /**
     * Set the OSCBundles OSCTimetag
     */
    public function set timetag(ott:OSCTimeTag):void
    {
        _time = ott;
    }

    /**
     * Creates a OSCBundle from the given ByteArray containing binary coded OSCBundle
     *
     * @param    bytes ByteArray containing OSC data
     */
    public function OSCBundle(bytes:ByteArray = null)
    {
        super(bytes);

        if (bytes != null)
        {

            //skip the OSC Bundle head
            _bytes.readUTFBytes(8);

            //get OSC timetag
            _time = this.readTimeTag();

            _content = new Array();

            //parse the contentBytes to get the OSC Bundles subbundles or messages
            getSubPackets();

        }
        else
        {
            _bytes = new ByteArray();
            _content = [];
            _time = new OSCTimeTag(SECONDS_1900_1970 + new Date().time, 0);
        }
    }

    /**
     * Returns the bytes of this <code>OSCBundle</code> and its contained <code>OSCPackets</code>
     *
     * @return A <code>ByteArray</code> containing the bytes of this <code>OSCBundle</code>
     */
    public override function getBytes():ByteArray
    {
        var out:ByteArray = new ByteArray();

        writeString('#bundle', out);
        writeTimeTag(_time, out);
        out.writeBytes(_bytes, 0, _bytes.length);

        out.position = 0;
        return out;
    }

    /**
     * Generates a String representation of this OSCBundle and its subpackets for debugging purposes
     *
     * @return traceable String
     */
    public override function getPacketInfo():String
    {
        var out:String = "";
        out += "\nSeconds: " + timetag.seconds.toString();
        out += "\nPicoseconds: " + timetag.picoseconds.toString();
        out += "\nSubPackets: " + subPacketCount.toString();
        for each(var item:OSCPacket in _content)
        {
            out += item.getPacketInfo();
        }
        return out;
    }

    /**
     * Returns the subpacket of this OSCPacket with the specified index
     *
     * @param    pos The index of the subpacket
     * @return An OSCPacket if the given index is valid, else null
     */
    public function getContent(pos:uint):OSCPacket
    {
        if (pos < _content.length)
        {
            return _content[pos];
        }
        else
        {
            return null;
        }
    }

    /**
     * Adds an <code>OSCPacket</code> in its current state to the <code>OSCBundle</code>
     *
     * @param    packet The <code>OSCPacket</code> to be added.
     */
    public function addPacket(packet:OSCPacket):void
    {
        _content.push(packet);
        var packetBytes:ByteArray = packet.getBytes();
        _bytes.writeInt(packetBytes.length);
        _bytes.writeBytes(packetBytes, 0, packetBytes.length);
    }

    /**
     * Parses the contentBytes for additional OSCBundles or OSCMessages within this OSCBundle
     */
    private function getSubPackets():void
    {
        while (_bytes.bytesAvailable > 0)
        {
            //read / skip length info
            _bytes.readInt();
            if (isBundle(_bytes))
            {
                this._content.push(new OSCBundle(_bytes));
            }
            else
            {
                this._content.push(new OSCMessage(_bytes));
            }
        }
    }

    /**
     * Checks if the given ByteArray is an OSCBundle
     *
     * @param    bytes The ByteArray to be checked.
     * @return true if the ByteArray contains an OSCBundle
     */
    public static function isBundle(bytes:ByteArray):Boolean
    {
        if (bytes != null)
        {
            if (bytes.bytesAvailable >= 8)
            {
                //bytes.position = 0;
                var header:String = bytes.readUTFBytes(8);
                bytes.position -= 8;
                if (header == "#bundle")
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
        else
        {
            return false;
        }
    }

    /**
     * This is comfort function for creating an OSCBundle with less code.
     *
     * @param    content An <code>Array</code> containing <code>OSCPackets</code> that should be wrapped by the
     *     <code>OSCBundle</code>.
     * @param    timetag The <code>OSCTimtetag</code> of the <code>OSCBundle</code>. If not supplied the time of
     *     instantiation is used.
     * @return    An <code>OSCBundle</code> containing the given <code>OSCPackets</code>.
     */
    public static function createOSCBundle(content:Array, timetag:OSCTimeTag = null):OSCBundle
    {
        var bundle:OSCBundle = new OSCBundle();
        if (timetag) bundle._time = timetag;
        for each(var packet:OSCPacket in content)
        {
            bundle.addPacket(packet);
        }
        return bundle;
    }

}

}