package com.teotigraphix.app.event
{
public class ApplicationEventData
{
    /**
     * Only dialogs should use this as screens will check. 
     */
    public var isBackHandled:Boolean;
    
    public function ApplicationEventData()
    {
    }
    
    public static function create():ApplicationEventData
    {
        return new ApplicationEventData();
    }
}
}