/**
 * Created by Teoti on 4/9/2015.
 */
package com.teotigraphix.model
{

import flash.filesystem.File;

import org.as3commons.async.command.IAsyncCommand;

public interface IMidiModel
{
    function loadAsync(file:File):IAsyncCommand;
}
}
