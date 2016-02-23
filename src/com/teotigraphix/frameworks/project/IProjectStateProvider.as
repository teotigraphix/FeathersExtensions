package com.teotigraphix.frameworks.project
{
public interface IProjectStateProvider
{
    function get provided():IProjectState;
    
    function set provided(value:IProjectState):void;
}
}