package com.teotigraphix.ui.template.main._mediators.data
{
public class ContentScreenItem
{
    public var id:String;
    public var label:String;
    public var defaultIcon:Object;
    public var defaultSelectedIcon:Object;
    
    public function ContentScreenItem(id:String, label:String, defaultIcon:Object = null, defaultSelectedIcon:Object = null)
    {
        this.defaultSelectedIcon = defaultSelectedIcon;
        this.defaultIcon = defaultIcon;
        this.label = label;
        this.id = id;
    }
}
}