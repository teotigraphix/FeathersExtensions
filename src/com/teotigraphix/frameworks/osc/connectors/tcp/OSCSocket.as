package com.teotigraphix.frameworks.osc.connectors.tcp
{

import com.teotigraphix.frameworks.osc.OSCBundle;
import com.teotigraphix.frameworks.osc.OSCEvent;

import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.events.ProgressEvent;
import flash.events.SecurityErrorEvent;
import flash.net.Socket;
import flash.utils.ByteArray;

/**
 * A class for receiving OSCBundles from a TCP socket stream.
 */
public class OSCSocket extends Socket
{
    private var _debug:Boolean = true;
    private var _buffer:ByteArray = new ByteArray();
    private var _partialRecord:Boolean = false;
    private var _isBundle:Boolean = false;

    public function OSCSocket()
    {
        configureListeners();
    }

    private function configureListeners():void
    {
        addEventListener(Event.CLOSE, closeHandler);
        addEventListener(Event.CONNECT, connectHandler);
        addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
        addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
        addEventListener(ProgressEvent.SOCKET_DATA, socketDataHandler);
    }

    private function socketDataHandler(event:ProgressEvent):void
    {

        var data:ByteArray = new ByteArray();
        if (_partialRecord)
        {
            _buffer.readBytes(data, 0, _buffer.length);
            _partialRecord = false;
        }

        super.readBytes(data, data.length, super.bytesAvailable);

        var length:int;

        // While we have data to read
        while (data.position < data.length)
        {
            _isBundle = OSCBundle.isBundle(data);

            if (_isBundle)
            { //check if the bytes are already a OSCBundle
                if (data.bytesAvailable > 20)
                { //there should be size information
                    data.position += 16;
                    if (data.readUTFBytes(1) != "#")
                    {
                        data.position -= 1;
                        length = data.readInt() + 20;
                        data.position -= 20;
                    }
                    else
                    {
                        data.position -= 17;
                        length = 16;
                    }
                }
                else
                {
                    length = data.length + 1;
                }
            }
            else
            {
                length = data.readInt() + 4;
                data.position -= 4;
            }

            // If we have enough data to form a full packet.
            if (length <= (data.length - data.position))
            {
                var packet:ByteArray = new ByteArray();
                if (_isBundle)
                    packet.writeInt(length);

                data.readBytes(packet, packet.position, length);
                packet.position = 0;

                dispatchEvent(new OSCEvent(packet));
            }
            else
            {
                // Read the partial packet
                _buffer = new ByteArray();
                data.readBytes(_buffer, 0, data.length - data.position);
                _partialRecord = true;
            }

        }

    }

    private function closeHandler(event:Event):void
    {
        if (_debug)trace("Connection Closed");
    }

    private function connectHandler(event:Event):void
    {
        if (_debug)trace("Connected");
    }

    private function ioErrorHandler(event:IOErrorEvent):void
    {
        if (_debug)trace("ioErrorHandler: " + event);
    }

    private function securityErrorHandler(event:SecurityErrorEvent):void
    {
        if (_debug)trace("securityErrorHandler: " + event);
    }
}
}