import Toybox.Lang;
import Toybox.WatchUi;

class WeightGraphDelegate extends WatchUi.BehaviorDelegate 
{
    function initialize() 
    {
        BehaviorDelegate.initialize();
    }

    function onMenu() as Boolean 
    {
        System.println("Menu loading!");

        WatchUi.pushView(new Rez.Menus.MainMenu(), new WeightGraphMenuDelegate(), WatchUi.SLIDE_UP);

        return true;
    }
}