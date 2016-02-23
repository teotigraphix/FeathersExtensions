package com.teotigraphix.frameworks.project
{
public interface IProjectConfigurator
{
    function setupNewProject(project:Project):void;
    
    function configureExistingProject(project:Project):void;
}
}