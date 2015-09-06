package com.teotigraphix.frameworks.osc.connectors
{

import com.teotigraphix.frameworks.osc.IOSCConnector;
import com.teotigraphix.frameworks.osc.IOSCConnectorListener;
import com.teotigraphix.frameworks.osc.OSCBundle;
import com.teotigraphix.frameworks.osc.OSCEvent;
import com.teotigraphix.frameworks.osc.OSCMessage;
import com.teotigraphix.frameworks.osc.OSCPacket;
import com.teotigraphix.frameworks.osc.connectors.udp.OSCDatagramSocket;

import flash.utils.ByteArray;

/**
 * An implementation of the <code>IOSCConnector</code> using UDP.
 * This connector only works in Adobe AIR since v2 due to it using the <code>DatagramSocket</code>
 *
 * This connector can be used to send an receive OSC bundles and messages.
 * Though you have to create separate instances of the connector.
 *
 * @author Johannes Luderschmidt
 * @author Immanuel Bauer
 * @author Michael Schmalle
 */
public class UDPConnector implements IOSCConnector
{
    private var _connection:OSCDatagramSocket;
    private var _listeners:Array;

    public function get bound():Boolean
    {
        return _connection.bound;
    }

    /**
     * @param host ip of the tracker resp. tuio message producer.
     * @param port of the tracker resp. tuio message producer.
     * @param bind If true the <code>UDPConnector</code> will try to bind the given IP:port and to receive packets.
     *     If false the <code>UDPConnector</code> connects to the given IP:port and will wait for calls of
     *     <code>UDPConnector.sendOSCPacket()</code>
     *
     */
    public function UDPConnector(host:String = "127.0.0.1", port:int = 3333, bind:Boolean = true)
    {
        _listeners = [];

        _connection = new OSCDatagramSocket(host, port, bind);
        _connection.addEventListener(OSCEvent.OSC_DATA, receiveOscData);
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
     * @inheritDoc
     */
    public function sendOSCPacket(oscPacket:OSCPacket):void
    {
        if (_connection.bound)
            _connection.send(oscPacket.getBytes());
        else
            throw new Error("Can't send if not connected.");
    }

    /**
     * @inheritDoc
     */
    public function close():void
    {
        if (_connection.bound)
            _connection.close();
    }

    private function copyPacket(packet:ByteArray):ByteArray
    {
        var copyPacket:ByteArray = new ByteArray();
        copyPacket.writeBytes(packet);
        copyPacket.position = 0;
        return copyPacket;
    }

    /**
     * parses an incoming OSC message.
     *
     * @private
     *
     */
    public function receiveOscData(e:OSCEvent):void
    {
        var packet:ByteArray = new ByteArray();
        packet.writeBytes(e.data);
        packet.position = 0;

        if (packet != null)
        {
            if (_listeners.length > 0)
            {
                //call receive listeners and push the received messages
                for each(var l:IOSCConnectorListener in _listeners)
                {
                    //packet has to be copied in order to allow for more than one listener
                    //that actually reads from the ByteArray (after one listener has read,
                    //packet will be empty)
                    var copiedPacket:ByteArray = copyPacket(packet);
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
                        //this.debug("\nreceived: invalid osc packet.");
                    }
                    packet = copiedPacket;
                }
            }
        }

        packet = null;
    }
}
}