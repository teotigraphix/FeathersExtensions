package com.teotigraphix.frameworks.osc
{

/**
 * An internaly used class which implements a tree structure
 * for managing OSCContainers and speeding up OSCAddress lookups.
 *
 * @author Michael Schmalle
 */
public class OSCAddressSpace
{

    private var _root:OSCContainer;

    public function OSCAddressSpace()
    {
        _root = new OSCContainer("");
    }

    /**
     * Adds a OSC Method to the lookup tree.
     * @param    address The OSC Address of the OSC Method.
     * @param    method The IOSCListener handling calls to the OSC Method.
     */
    public function addMethod(address:String, method:IOSCListener):void
    {
        var parts:Array = address.split("/");
        var part:String;
        var currentNode:OSCContainer = _root;
        var nextNode:OSCContainer;
        while (parts.length > 0)
        {
            part = parts.pop();
            nextNode = currentNode.getChild(part);
            if (nextNode == null)
            {
                nextNode = new OSCContainer(part);
                currentNode.addChild(nextNode);
            }
            currentNode = nextNode;
        }
        currentNode.method = method;
    }

    /**
     * Removes the OSC Method stored under the given Address from the tree.
     * @param    address The OSC Address of th eOSC Method to be removed.
     */
    public function removeMethod(address:String):void
    {
        var parts:Array = address.split("/");
        var part:String;
        var currentNode:OSCContainer = _root;
        var nextNode:OSCContainer;
        while (parts.length > 0)
        {
            part = parts.pop();
            nextNode = currentNode.getChild(part);
            if (nextNode == null)
            {
                break;
            }
            currentNode = nextNode;
        }
        currentNode.parent.removeChild(currentNode);
    }

    /**
     * Retreives all OSC Methods stored in the tree matching the given OSC Address pattern.
     * @param    pattern The OSC Address pattern to match against.
     * @return An Array containing all matching OSCContainers.
     */
    public function getMethods(pattern:String):Array
    {
        return _root.getMatchingChildren(pattern.substr(1, pattern.length));
    }
}
}