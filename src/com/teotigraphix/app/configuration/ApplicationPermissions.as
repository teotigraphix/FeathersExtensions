package com.teotigraphix.app.configuration
{
import com.teotigraphix.model.AbstractModel;

public class ApplicationPermissions extends AbstractModel implements IApplicationPermissions
{
    private var _permissions:Object;

    public function get permissions():Object
    {
        return _permissions;
    }

    public function set permissions(value:Object):void
    {
        _permissions = value;
    }
    
    
    public function ApplicationPermissions()
    {
        super();
    }
    
    public function hasPermission(permission:int):Boolean
    {
        return _permissions[permission];
    }
}
}