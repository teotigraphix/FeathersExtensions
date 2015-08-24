/**
 * Created by Teoti on 4/2/2015.
 */
package com.teotigraphix.service
{

import com.teotigraphix.service.async.IStepCommand;

public interface IApplicationService
{
    function startupCoreServices():IStepCommand;
}
}
