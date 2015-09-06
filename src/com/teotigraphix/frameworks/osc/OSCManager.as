package com.teotigraphix.frameworks.osc
{

/**
 * The main class for receiving and sending OSC data.
 *
 * @author Michael Schmalle
 */
public class OSCManager implements IOSCConnectorListener
{

    /**
     * If <code>true</code> pattern matching is enabled for OSC addresse lookups. The default is <code>false</code>.
     */
    public var usePatternMatching:Boolean = false;

    private var _connectorIn:IOSCConnector;
    private var _connectorOut:IOSCConnector;
    private var _currentPacket:OSCPacket;
    private var _listeners:Array;
    private var _oscMethods:Array;
    private var _oscAddressSpace:OSCAddressSpace = new OSCAddressSpace();
    private var _running:Boolean;

    public function get running():Boolean
    {
        return _running;
    }

    public function get connectorIn():IOSCConnector
    {
        return this._connectorIn;
    }

    /**
     * The IOSConnector which is used for receiving OSC data.
     */
    public function set connectorIn(conn:IOSCConnector):void
    {
        if (_connectorIn != null)
        {
            _connectorIn.removeListener(this);
        }

        _connectorIn = conn;

        if (conn != null)
        {
            _connectorIn.addListener(this);
        }
    }

    public function get connectorOut():IOSCConnector
    {
        return _connectorOut;
    }

    /**
     * The IOSConnector which is used for sending OSC data.
     */
    public function set connectorOut(conn:IOSCConnector):void
    {
        _connectorOut = conn;
    }

    /**
     * The OSCPacket which was last received.
     */
    public function get currentPacket():OSCPacket
    {
        return _currentPacket;
    }

    /**
     * Creates a new instance of the OSCManager.
     * @param    connectorIn The IOSConnector which should be used for receiving OSC data.
     * @param    connectorOut The IOSCConnector which should be used to send OSC data
     * @param    autoStart If true the OSCManager will immediately begin to process incoming OSCPackets. Default is
     *     true.
     */
    public function OSCManager(connectorIn:IOSCConnector = null,
                               connectorOut:IOSCConnector = null,
                               autoStart:Boolean = true)
    {

        this._listeners = [];
        this._oscMethods = [];

        _connectorIn = connectorIn;

        if (_connectorIn != null)
            _connectorIn.addListener(this);

        _connectorOut = connectorOut;

        _running = autoStart;

    }

    /**
     * If called the OSCManager will start to process incoming OSCPackets.
     */
    public function start():void
    {
        _running = true;
    }

    /**
     * If called the OSCManager will stop to process incoming OSCPackets.
     */
    public function stop():void
    {
        _running = false;
    }

    /**
     * Sends the given OSCPacket via the outgoing IOSCConnector.
     * @param    oscPacket
     */
    public function sendOSCPacket(oscPacket:OSCPacket):void
    {
        if (_connectorOut)
        {
            _connectorOut.sendOSCPacket(oscPacket);
        }
    }

    /**
     * @inheritDoc
     */
    public function acceptOSCPacket(oscPacket:OSCPacket):void
    {
        if (_running)
        {
            _currentPacket = oscPacket;
            distributeOSCPacket(_currentPacket);
            oscPacket = null;
        }
    }

    public function theLength():int
    {
        var count:int = 0;
        for each (var object:Object in _oscMethods)
        {
            count++;
        }
        return count;
    }

    /**
     * Registers an OSC Method handler
     * @param    address The address of the OSC Method
     * @param    listener The listener for handling calls to the OSC Method
     */
    public function addMethod(address:String, listener:IOSCListener):void
    {
        _oscMethods[address] = listener;
        _oscAddressSpace.addMethod(address, listener);
    }

    /**
     * Unregisters the OSC Method under the given address
     * @param    address The address of the OSC Method to be unregistered.
     */
    public function removeMethod(address:String):void
    {
        _oscMethods[address] = null;
        _oscAddressSpace.removeMethod(address);
    }

    /**
     * Registers a general OSCMethod listener which will be called for every
     * recevied OSCMessage.
     * @param    listener The IOSCListener implementation to handle the OSC Messages.
     */
    public function addOSCListener(listener:IOSCListener):void
    {
        if (_listeners.indexOf(listener) > -1)
            return;
        _listeners.push(listener);
    }

    /**
     * Removes the given OSC Method listener
     * @param    listener The listener to be removed.
     */
    public function removeOSCListener(listener:IOSCListener):void
    {
        _listeners.splice(_listeners.indexOf(listener), 1);
    }

    /**
     * Distributes the OSCPacket to all lissteners by checking if the OSCPacket is an
     * OSCBundle or an OSCMessage and recursively calling itself until the contained
     * OSCMessages are distibuted.
     * @param    packet The OSCPacket which has to be distributed
     */
    private function distributeOSCPacket(packet:OSCPacket):void
    {
        if (packet is OSCMessage)
        {
            distributeOSCMessage(packet as OSCMessage);
        }
        else if (packet is OSCBundle)
        {
            var cont:Array = (packet as OSCBundle).subPackets;
            for each(var p:OSCPacket in cont)
            {
                distributeOSCPacket(p);
            }
        }
    }

    /**
     * Distributes the given OSCMessage to the addressd IOSCListeners.
     * @param    msg The OSCMessage to distribute.
     */
    private function distributeOSCMessage(msg:OSCMessage):void
    {
        for each(var l:IOSCListener in _listeners)
        {
            l.acceptOSCMessage(msg);
        }

        if (theLength() > 0)
        { // this.oscMethods.length

            var oscMethod:IOSCListener;
            var oscMethods:Array;

            if (usePatternMatching)
            {
                oscMethods = _oscAddressSpace.getMethods(msg.address);
                for each(l in oscMethods)
                {
                    l.acceptOSCMessage(msg);
                }
            }
            else
            {
                oscMethod = oscMethods[msg.address];
                if (oscMethod != null)
                    oscMethod.acceptOSCMessage(msg);
            }
        }
    }
}
}