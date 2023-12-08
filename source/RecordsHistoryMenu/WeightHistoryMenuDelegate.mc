import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

class WeightHistoryMenuDelegate extends WatchUi.MenuInputDelegate 
{
    function initialize(weightRecords as Null or Array<Float>, dateRecords as Null or Array<String>) 
    {
        MenuInputDelegate.initialize();
    }

    function onMenuItem(item as Symbol) as Void 
    {
        
    }
}