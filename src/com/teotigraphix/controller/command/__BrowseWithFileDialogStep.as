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
import com.teotigraphix.ui.IUIController;
import com.teotigraphix.ui.component.file.FileListData;
import com.teotigraphix.ui.component.file.FileListEvent;
import com.teotigraphix.ui.dialog.FileDialog;

import flash.filesystem.File;

import starling.events.Event;

/**
 * 
 * @author Teoti
 */
public class __BrowseWithFileDialogStep extends StepCommand
{
    //--------------------------------------------------------------------------
    // Inject
    //--------------------------------------------------------------------------

    [Inject]
    public var ui:IUIController;
    
    //--------------------------------------------------------------------------
    // Private :: Variables
    //--------------------------------------------------------------------------
    
    private var _dialog:FileDialog;
    
    private var _isYesEnabled:Boolean;
    private var _iNoEnabled:Boolean;
    
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
    
    public function setTitle(value:String):void
    {
        _dialog.title = value;
    }
    
    //----------------------------------
    // isOkEnabled
    //----------------------------------
    
    public function get isYesEnabled():Boolean
    {
        return _isYesEnabled;
    }

    public function set isYesEnabled(value:Boolean):void
    {
        _isYesEnabled = value;
        _dialog.yesButton.isEnabled = _isYesEnabled;
    }
    
    //----------------------------------
    // isNoEnabled
    //----------------------------------
    
    public function get isNoEnabled():Boolean
    {
        return _iNoEnabled;
    }
    
    public function set isNoEnabled(value:Boolean):void
    {
        _iNoEnabled = value;
        _dialog.noButton.isEnabled = _iNoEnabled;
    }
    
    //----------------------------------
    // selectedFile
    //----------------------------------
    
    /**
     * Returns the FileList.selectedFile, may be null if selectedIndex == -1.
     */
    public function get selectedFile():File
    {
        return _dialog.fileList.selectedFile;
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
        return _dialog.fileList.rootDirectory;
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

        _dialog = ui.browseForFile(data, view_yesHandler, view_noHandler);

        _dialog.addEventListener(FileListEvent.ROOT_DIRECTORY_CHANGE, view_rootDirectoryChangeHandler);
        _dialog.addEventListener(FileDialog.EVENT_FILE_CHANGE, view_fileOrDirectoryChangeHandler);
        
        // bubbling events
        _dialog.addEventListener(FileListEvent.FILE_DOUBLE_TAP, view_fileDoubleTapHandler);
        
        setupDialog(_dialog);

        return super.execute();
    }

    protected function createData():FileListData
    {
        return null;
    }
    
    protected function setupDialog(screen:FileDialog):void
    {
    }
    
    /**
     * @param file The selected file.
     * @param directory The selected directory.
     */
    protected function stateChanged(file:File, directory:File):void
    {
    }
    
    //--------------------------------------------------------------------------
    // Handlers
    //--------------------------------------------------------------------------
    
    protected function view_fileDoubleTapHandler(event:Event, file:File):void
    {
    }

    protected function view_yesHandler(event:Event, file:File):void
    {
        _dialog.hide();
        _dialog = null;
        finished();
    }

    protected function view_noHandler(event:Event, file:File):void
    {
        _dialog.hide();
        _dialog = null;
        cancel();
    }

    protected function view_rootDirectoryChangeHandler(event:Event, directory:File):void
    {
        stateChanged(selectedFile, selectedDirectory);
    }

    protected function view_fileOrDirectoryChangeHandler(event:Event, file:File):void
    {
        stateChanged(selectedFile, selectedDirectory);
    }
}
}
