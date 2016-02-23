package com.teotigraphix.app.command
{
import com.teotigraphix.controller.command.core.AbstractCommand;

public class UncaughtErrorCommand extends AbstractCommand
{

    override public function execute():void
    {
        sequence(new Result(event.data)).
            addStep(ShowAlertStep).
            execute();
    }
}
}
import com.teotigraphix.app.configuration.ApplicationDescriptor;
import com.teotigraphix.service.async.StepCommand;
import com.teotigraphix.ui.IUIController;

import flash.net.URLRequest;
import flash.net.navigateToURL;

import feathers.controls.Alert;
import feathers.system.DeviceCapabilities;

import starling.core.Starling;

final class Result
{
    public var message:String;
    
    public function Result(data:Object)
    {
        if (data is Error)
        {
            var error:Error = data as Error;
            var eMessage:String = error.message;
            var eTrace:String = error.getStackTrace();
            
            message = eMessage + " " + eTrace;
        }
        else if (data is String)
        {
            message = data as String;
        }
    }
}

class ShowAlertStep extends StepCommand
{
    [Inject]
    public var controller:IUIController;
    
    [Inject]
    public var descriptor:ApplicationDescriptor;
    
    private var alert:Alert;
    
    override public function execute():*
    {
        alert = controller.showAlert("Uncaught Error - Send bug report email?", 
            Result(data).message, null, yesHandler, noHandler);
        
        return super.execute();
    }
    
    private function noHandler():void
    {
        alert = null;
        complete();
    }
    
    private function yesHandler():void
    {
        alert = null;
        
        var dpi:String = DeviceCapabilities.dpi.toString();
        var width:String = Starling.current.nativeStage.stageWidth.toString();
        var height:String = Starling.current.nativeStage.stageHeight.toString();
        
        var title:String = descriptor.appID + " v" + descriptor.version.toString() + " bug report | " +
            "Device " + width + "x" + height + " " + dpi + "dpi";
        var body:String = "";
        
        body += "" + Result(data).message.split("#").join(" ");
        
        sendEmail("teotigraphixllc@gmail.com", title, body);
        complete();
    }
    
    private function sendEmail(emailTo:String, subject:String, body:String):void 
    {
        var urlString:String = "mailto:";
        urlString += emailTo;
        urlString += "?subject=";
        urlString += subject;
        urlString += "&body=";
        urlString += encodeURI(body); 
        navigateToURL(new URLRequest(urlString));
    }
    
}

