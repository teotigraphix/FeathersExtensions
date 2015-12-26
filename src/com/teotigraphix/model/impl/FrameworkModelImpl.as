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
package com.teotigraphix.model.impl
{

import com.teotigraphix.app.config.ApplicationDescriptor;
import com.teotigraphix.controller.IActionManager;
import com.teotigraphix.controller.ICommandLauncher;
import com.teotigraphix.frameworks.project.IProjectPreferences;
import com.teotigraphix.frameworks.project.Project;
import com.teotigraphix.model.AbstractModel;
import com.teotigraphix.model.IApplicationSettings;
import com.teotigraphix.model.IDeviceModel;
import com.teotigraphix.model.IFrameworkModel;
import com.teotigraphix.model.IProjectModel;
import com.teotigraphix.service.IProjectService;
import com.teotigraphix.service.async.IStepCommand;
import com.teotigraphix.service.async.IStepSequence;
import com.teotigraphix.ui.IUIFactory;
import com.teotigraphix.ui.screen.IScreenLauncher;
import com.teotigraphix.ui.screen.IScreenProvider;

import flash.filesystem.File;
import flash.utils.Dictionary;

public class FrameworkModelImpl extends AbstractModel implements IFrameworkModel
{
    [Inject]
    public var _descriptor:ApplicationDescriptor;

    [Inject]
    public var _applicationSettings:IApplicationSettings; // override

    [Inject]
    public var _screenProvider:IScreenProvider;

    [Inject]
    public var _projectService:IProjectService;

    [Inject]
    public var _projectModel:IProjectModel;

    [Inject]
    public var _deviceModel:IDeviceModel;

    [Inject]
    public var _commands:ICommandLauncher; // override

    [Inject]
    public var _screens:IScreenLauncher; // override

    [Inject]
    public var _actions:IActionManager;

    [Inject]
    public var _ui:IUIFactory;

    private var _data:Dictionary = new Dictionary();

    public var _preferences:IProjectPreferences;

    //--------------------------------------------------------------------------
    // Properties
    //--------------------------------------------------------------------------

    //----------------------------------
    // descriptor
    //----------------------------------

    /**
     * @inheritDoc
     */
    public function get descriptor():ApplicationDescriptor
    {
        return _descriptor;
    }

    //----------------------------------
    // actions
    //----------------------------------

    /**
     * @inheritDoc
     */
    public function get actions():IActionManager
    {
        return _actions;
    }

    //----------------------------------
    // screenData
    //----------------------------------

    /**
     * @inheritDoc
     */
    public function get screenData():*
    {
        return _screenProvider.data;
    }

    //----------------------------------
    // IProjectModel
    //----------------------------------

    /**
     * @inheritDoc
     */
    public function get project():Project
    {
        return _projectModel.project;
    }

    /**
     * @inheritDoc
     */
    public function set project(value:Project):void
    {
        _projectModel.project = value;
    }

    /**
     * @inheritDoc
     */
    public function get projectDirectory():File
    {
        return _projectModel.projectDirectory;
    }

    /**
     * @inheritDoc
     */
    public function get projectFile():File
    {
        return _projectModel.projectFile;
    }

    //----------------------------------
    // IDeviceModel
    //----------------------------------

    /**
     * @inheritDoc
     */
    public function get isLandscape():Boolean
    {
        return _deviceModel.isLandscape;
    }

    /**
     * @inheritDoc
     */
    public function get isTablet():Boolean
    {
        return _deviceModel.isTablet;
    }

    /**
     * @inheritDoc
     */
    public function get isPhone():Boolean
    {
        return _deviceModel.isPhone;
    }

    /**
     * @inheritDoc
     */
    public function get orientation():String
    {
        return _deviceModel.orientation;
    }

    /**
     * @inheritDoc
     */
    public function get supportedOrientations():Vector.<String>
    {
        return _deviceModel.supportedOrientations;
    }

    public function FrameworkModelImpl()
    {
    }

    //--------------------------------------------------------------------------
    // App :: Methods
    //--------------------------------------------------------------------------

    //----------------------------------
    // IProjectService
    //----------------------------------

    /**
     * @inheritDoc
     */
    public function saveQuick():void
    {
    }

    /**
     * @inheritDoc
     */
    public function getApplicationSettings():IApplicationSettings
    {
        return _applicationSettings;
    }
    /**
     * @inheritDoc
     */
    public function getUI():IUIFactory
    {
        return _ui;
    }

    public function saveProjectAsync():IStepSequence
    {
        return _projectService.saveAsync();
    }

    public function createProjectAsync(name:String, path:String):IStepCommand
    {
        return _projectService.createProjectAsync(name, path);
    }

    public function loadProjectAsync(file:File):IStepCommand
    {
        return _projectService.loadProjectAsync(file);
    }

    /**
     * @inheritDoc
     */
    public function getProperty(name:String):*
    {
        return _data[name];
    }

    /**
     * @inheritDoc
     */
    public function clearProperty(name:String):*
    {
        var result:* = _data[name];
        _data[name] = null;
        delete _data[name];
        return result;
    }

    /**
     * @inheritDoc
     */
    public function setProperty(name:String, value:*):void
    {
        if (_data[name] == value)
            return;

        _data[name] = value;
        dispatchWith(name, false, value);
    }
}
}
