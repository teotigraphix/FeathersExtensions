package com.teotigraphix.frameworks.osc.connectors.udp
{

import com.teotigraphix.frameworks.osc.OSCEvent;

import flash.events.DatagramSocketDataEvent;
import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.events.SecurityErrorEvent;
import flash.net.DatagramSocket;
import flash.utils.ByteArray;

/**
 * A simple class for receiving and sending OSCPackets via UDP.
 */
public class OSCDatagramSocket extends DatagramSocket
{
    private var _debug:Boolean = true;
    private var _buffer:ByteArray = new ByteArray();
    private var _partialRecord:Boolean = false;

    public function OSCDatagramSocket(host:String = "127.0.0.1", port:int = 3333, bindSocket:Boolean = true)
    {
        configureListeners();

        // UDP never dispatches events when bound
        if (bindSocket)
            bind(port, host);
        else
            connect(host, port);

        receive();
    }

    private function configureListeners():void
    {
        addEventListener(Event.CLOSE, closeHandler);
        addEventListener(Event.CONNECT, connectHandler);
        addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
        addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
        addEventListener(DatagramSocketDataEvent.DATA, dataReceived);
    }

    private function dataReceived(event:DatagramSocketDataEvent):void
    {
        dispatchEvent(new OSCEvent(event.data));
    }

    private function closeHandler(event:Event):void
    {
        if (_debug)
            trace("Connection Closed");
    }

    private function connectHandler(event:Event):void
    {
        if (_debug)
            trace("Connected");
    }

    private function ioErrorHandler(event:IOErrorEvent):void
    {
        if (_debug)
            trace("ioErrorHandler: " + event);
    }

    private function securityErrorHandler(event:SecurityErrorEvent):void
    {
        if (_debug)
            trace("securityErrorHandler: " + event);
    }

}
}