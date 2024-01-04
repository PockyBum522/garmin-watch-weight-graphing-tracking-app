import Toybox.Lang;
import Toybox.WatchUi;

class WeightGraphDelegate extends WatchUi.BehaviorDelegate 
{
    private var _weightRecords as Null or Array<Float>;
    private var _dateRecords as Null or Array<String>;

    function initialize(weightRecords as Null or Array<Float>, dateRecords as Null or Array<String>) 
    {
        BehaviorDelegate.initialize();

        if (weightRecords != null)
        {
            _weightRecords = weightRecords;
        }
        
        if (dateRecords != null)
        {
            _dateRecords = dateRecords;
        }        
        
        System.println("Step 2: In initialize() in WeightGraphDelegate:");
        System.println(_weightRecords);
        System.println(_dateRecords);
    }

    function onMenu() as Boolean 
    {
        System.println("Menu loading!");

        WatchUi.pushView(new Rez.Menus.MainMenu(), new WeightGraphMenuDelegate(_weightRecords, _dateRecords), WatchUi.SLIDE_UP);

        return true;
    }
    
    function onSelect() as Boolean 
    {
        System.println("Menu loading!");

        WatchUi.pushView(new Rez.Menus.MainMenu(), new WeightGraphMenuDelegate(_weightRecords, _dateRecords), WatchUi.SLIDE_UP);

        return true;
    }
}