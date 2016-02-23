package com.teotigraphix.ui.state
{
import com.teotigraphix.frameworks.project.AbstractProjectPreferencesChild;
import com.teotigraphix.frameworks.project.IProjectPreferences;
import com.teotigraphix.ui.event.ScreenLauncherEventType;

public class ProjectPreferencesTemplateUI extends AbstractProjectPreferencesChild
{
    private var _selectedContentIndex:int;
    
    //----------------------------------
    // selectedContentIndex
    //----------------------------------
    
    public function get selectedContentIndex():int
    {
        return _selectedContentIndex;
    }
    
    public function set selectedContentIndex(value:int):void
    {
        if (_selectedContentIndex == value)
            return;
        _selectedContentIndex = value;
        onPropertyChange(ScreenLauncherEventType.SELECTED_CONTENT_INDEX_CHANGED, _selectedContentIndex);
    }

    public function ProjectPreferencesTemplateUI(owner:IProjectPreferences = null)
    {
        super(owner);
    }
}
}