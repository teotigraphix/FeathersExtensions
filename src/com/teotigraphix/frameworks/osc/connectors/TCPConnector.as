package com.teotigraphix.frameworks.osc.connectors
{

import com.teotigraphix.frameworks.osc.IOSCConnector;
import com.teotigraphix.frameworks.osc.IOSCConnectorListener;
import com.teotigraphix.frameworks.osc.OSCBundle;
import com.teotigraphix.frameworks.osc.OSCEvent;
import com.teotigraphix.frameworks.osc.OSCMessage;
import com.teotigraphix.frameworks.osc.OSCPacket;
import com.teotigraphix.frameworks.osc.connectors.tcp.OSCSocket;

import flash.utils.ByteArray;

/**
 * An implementation of the <code>IOSCConnector</code> using TCP.
 */
public class TCPConnector implements IOSCConnector
{
    private var _host:String;
    private var _port:int;
    private var _connection:OSCSocket;
    private var _listeners:Array;

    /**
     * Creates a new instance of the TCPConnector
     * @param    host The IP of the tracker or bridge.
     * @param    port The port on which device sends data.
     */
    public function TCPConnector(host:String = "127.0.0.1", port:int = 3333)
    {
        _listeners = [];

        _host = host;
        _port = port;

        _connection = new OSCSocket();
        _connection.addEventListener(OSCEvent.OSC_DATA, receiveOscData);

        _connection.connect(host, port);
    }

    /**
     * @inheritDoc
     */
    public function addListener(listener:IOSCConnectorListener):void
    {
        if (_listeners.indexOf(listener) > -1)
            return;

        _listeners.push(listener);
    }

    /**
     * @inheritDoc
     */
    public function removeListener(listener:IOSCConnectorListener):void
    {
        _listeners.splice(_listeners.indexOf(listener), 1);
    }

    /**
     * <b>not implemented</b>
     * @inheritDoc
     */
    public function sendOSCPacket(oscPacket:OSCPacket):void
    {
        // Not Implemented
    }

    /**
     * @inheritDoc
     */
    public function close():void
    {
        if (_connection.connected) _connection.close();
    }

    private function debug(msg:String):void
    {
        trace(msg);
    }

    /**
     * @private
     */
    public function receiveOscData(e:OSCEvent):void
    {
        var packet:ByteArray = new ByteArray();
        packet.writeBytes(e.data, 4);
        packet.position = 0;
        if (packet != null)
        {
            if (_listeners.length > 0)
            {
                //call receive listeners and push the received messages
                for each(var l:IOSCConnectorListener in _listeners)
                {
                    if (OSCBundle.isBundle(packet))
                    {
                        l.acceptOSCPacket(new OSCBundle(packet));
                    }
                    else if (OSCMessage.isMessage(packet))
                    {
                        l.acceptOSCPacket(new OSCMessage(packet));
                    }
                    else
                    {
                        debug("\nreceived: invalid osc packet.");
                    }
                }
            }
        }
    }
}
}
	