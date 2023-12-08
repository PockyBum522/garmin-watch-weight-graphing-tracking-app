import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

class WeightGraphMenuDelegate extends WatchUi.MenuInputDelegate 
{
    private var _weightRecords as Null or Array<Float>;
    private var _dateRecords as Null or Array<String>;

    private var _historyMenu as Null or WatchUi.Menu2;

    function initialize(weightRecords as Null or Array<Float>, dateRecords as Null or Array<String>) 
    {
        MenuInputDelegate.initialize();

        if (weightRecords != null)
        {
            _weightRecords = weightRecords;
        }
        
        if (dateRecords != null)
        {
            _dateRecords = dateRecords;
        }        
    }

    function onMenuItem(item as Symbol) as Void 
    {
        if (item == :add_weight) 
        {
            System.println("Add weight menu option selected");
        } 
        else if (item == :view_history) 
        {
            System.println("History menu loading!");

            _historyMenu = initializeHistoryMenuItemsWithWeightRecords();

            WatchUi.pushView(_historyMenu, new WeightHistoryMenuDelegate(_weightRecords, _dateRecords), WatchUi.SLIDE_UP);
        }
        else if (item == :settings) 
        {
            System.println("Add Weight menu option selected");
        } 
    }

    function initializeHistoryMenuItemsWithWeightRecords() as WatchUi.Menu2
    {
        var menu = new WatchUi.Menu2({:title=>"History"});
        var delegate;

        var weightRecordsCount = 0;

        if (_weightRecords != null)
        {
            weightRecordsCount = _weightRecords.size();
        }

        for (var i = weightRecordsCount - 1; i >= 0; i--)
        {
            var currentWeightRecord = 0.0;
            var currentDateRecord = "";

            if (_weightRecords != null)
            {
                currentWeightRecord = _weightRecords[i] as Float;
            }

            if (_dateRecords != null)
            {
                currentDateRecord = _dateRecords[i] as String;
            }
            
            var currentWeightString = (currentWeightRecord as Float).format("%.1f") as String;

            menu.addItem(
                new MenuItem(

                    // Set the 'Label' parameter
                    currentWeightString,

                    // Set the `subLabel` parameter
                    currentDateRecord,

                    // Set the `identifier` parameter
                    "itemId" + i.toString(),
                    // Set the options, in this case `null`
                    {}
                )
            );
        }

        // Create a new Menu2InputDelegate
        delegate = new WeightHistoryMenuItemDelegate(); // a WatchUi.Menu2InputDelegate

        // Push the Menu2 View set up in the initializer
        WatchUi.pushView(menu, delegate, WatchUi.SLIDE_IMMEDIATE);

        return menu;
    }
}