////////////////////////////////////////////////////////////////////////////////
// Copyright 2015 Michael Schmalle - Teoti Graphix, LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License
//
// Author: Michael Schmalle, Principal Architect
// mschmalle at teotigraphix dot com
////////////////////////////////////////////////////////////////////////////////
package com.teotigraphix.controller.command
{

import com.teotigraphix.service.async.StepCommand;
import com.teotigraphix.ui.component.file.FileListData;
import com.teotigraphix.ui.component.file.FileListEvent;
import com.teotigraphix.ui.screen.IScreenLauncher;
import com.teotigraphix.ui.screen.impl.FileExplorerScreen;

import flash.filesystem.File;

import starling.events.Event;

/**
 * 
 * @author Teoti
 */
public class __FindFileLocationStep extends StepCommand
{
    //--------------------------------------------------------------------------
    // Inject
    //--------------------------------------------------------------------------

    [Inject]
    public var screenLauncher:IScreenLauncher;

    //--------------------------------------------------------------------------
    // Private :: Variables
    //--------------------------------------------------------------------------
    
    private var _screen:FileExplorerScreen;

    private var _title:String;
    private var _okEnabled:Boolean;

    private var _currentFile:File;

    //--------------------------------------------------------------------------
    // API :: Properties
    //--------------------------------------------------------------------------
    
    //----------------------------------
    // currentFile
    //----------------------------------
    
    /**
     * The current File the subclass has set as the result file.
     */
    public function get currentFile():File
    {
        return _currentFile;
    }
    
    public function set currentFile(value:File):void
    {
        _currentFile = value;
        o.file = _currentFile;
    }
    
    //----------------------------------
    // title
    //----------------------------------
    
    public function get title():String
    {
        return _title;
    }

    public function set title(value:String):void
    {
        _title = value;
        _screen.title = _title;
    }
    
    //----------------------------------
    // okEnabled
    //----------------------------------
    
    public function get okEnabled():Boolean
    {
        return _okEnabled;
    }

    public function set okEnabled(value:Boolean):void
    {
        _okEnabled = value;
        _screen.okButton.isEnabled = _okEnabled;
    }
    
    //----------------------------------
    // cancelEnabled
    //----------------------------------
    
    public function set cancelEnabled(value:Boolean):void
    {
        _screen.cancelButton.isEnabled = _okEnabled;
    }
    
    //----------------------------------
    // selectedFile
    //----------------------------------
    
    /**
     * Returns the FileList.selectedFile, may be null if selectedIndex == -1.
     */
    public function get selectedFile():File
    {
        return _screen.fileList.selectedFile;
    }
    
    //----------------------------------
    // selectedDirectory
    //----------------------------------
    
    /**
     * Never null, returns the rootDirectory if the selectedFile is null or NOT a directory.
     */
    public function get selectedDirectory():File 
    {
        if (selectedFile != null && selectedFile.isDirectory)
            return selectedFile;
        return rootDirectory;
    }
    
    //----------------------------------
    // rootDirectory
    //----------------------------------
    
    public function get rootDirectory():File
    {
        return _screen.fileList.rootDirectory;
    }
    
    //----------------------------------
    // o
    //----------------------------------
    
    public function get o():LocationResult
    {
        return data as LocationResult;
    }

    //--------------------------------------------------------------------------
    // Overridden :: Methods
    //--------------------------------------------------------------------------
        
    override public function execute():*
    {
        if (o.fileOverwrite)
        {
            finished();
            return;
        }

        var data:FileListData = createData();

        _screen = screenLauncher.goToFileExplorer(data);

        _screen.addEventListener(FileListEvent.ROOT_DIRECTORY_CHANGE, view_rootDirectoryChangeHandler);
        _screen.addEventListener(FileExplorerScreen.EVENT_FILE_OR_DIRECTORY_CHANGE, view_fileOrDirectoryChangeHandler);
        
        _screen.addEventListener(FileExplorerScreen.EVENT_OK, view_okHandler);
        _screen.addEventListener(FileExplorerScreen.EVENT_CANCEL, view_cancelHandler);

        // bubbling events
        _screen.addEventListener(FileListEvent.FILE_DOUBLE_TAP, view_fileDoubleTapHandler);
        
        setupScreen(_screen);

        return super.execute();
    }

    protected function createData():FileListData
    {
        return null;
    }
    
    protected function setupScreen(screen:FileExplorerScreen):void
    {
    }
    
    /**
     * @param file The selected file.
     * @param directory The selected directory.
     */
    protected function stateChanged(file:File, directory:File):void
    {
    }
    
    // TODO remove after others implement
    protected function selectedFileChanged(file:File):void
    {
    }
    
    //--------------------------------------------------------------------------
    // API
    //--------------------------------------------------------------------------
    
    protected function back():void
    {
        screenLauncher.back();
    }
    
    protected function backTo(screenID:String):void
    {
        screenLauncher.backTo(screenID);
    }
    
    //--------------------------------------------------------------------------
    // Handlers
    //--------------------------------------------------------------------------
    
    protected function view_fileDoubleTapHandler(event:Event, file:File):void
    {
    }

    protected function view_okHandler(event:Event, file:File):void
    {
        o.file = file;
        back();
        finished();
    }

    protected function view_cancelHandler(event:Event, file:File):void
    {
        back();
        cancel();
    }

    protected function view_rootDirectoryChangeHandler(event:Event, directory:File):void
    {
        selectedFileChanged(selectedFile);
        stateChanged(selectedFile, selectedDirectory);
    }

    protected function view_fileOrDirectoryChangeHandler(event:Event, file:File):void
    {
        selectedFileChanged(selectedFile);
        stateChanged(selectedFile, selectedDirectory);
    }
}
}
