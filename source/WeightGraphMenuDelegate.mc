import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

class WeightGraphMenuDelegate extends WatchUi.MenuInputDelegate 
{
    function initialize() 
    {
        MenuInputDelegate.initialize();
    }

    function onMenuItem(item as Symbol) as Void 
    {
        if (item == :add_weight) 
        {
            System.println("Add weight menu option selected");
        } 
        else if (item == :view_history) 
        {
            System.println("View history menu option selected");
        } 
        else if (item == :delete_weight) 
        {
            System.println("Delete weight menu option selected");
        } 
        else if (item == :settings) 
        {
            System.println("Add Weight menu option selected");
        } 
    }
}