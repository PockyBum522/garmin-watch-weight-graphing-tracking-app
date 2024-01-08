import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

using Toybox.Math;
using Toybox.System; 

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
        var parentApp = getApp();

        if (item == :view_history) 
        {
            System.println("History menu loading!");

            _historyMenu = initializeHistoryMenuItemsWithWeightRecords();

            WatchUi.pushView(_historyMenu, new WeightHistoryMenuDelegate(_weightRecords, _dateRecords), WatchUi.SLIDE_UP);
        } 
        else if (item == :add_weight) 
        {
            System.println("Add weight menu option selected");

            var mainView = parentApp.getView();

            if (mainView != null)
            {
                System.println("About to launch add weight number picker");

                WatchUi.pushView(new NumberPicker(), new NumberPickerDelegate(), WatchUi.SLIDE_UP);
            }            
        }
        else if (item == :open_settings) 
        {
            System.println("Settings menu option selected");
        } 
        else if (item == :delete_all) 
        {
            System.println("Delete all weight records menu option selected");

            parentApp.deleteAllWeightRecords();
        } 
    }

    function initializeHistoryMenuItemsWithWeightRecords() as WatchUi.Menu2
    {
        var menu = new WatchUi.Menu2({:title=>"History"});
        var delegate;

        var weightRecordsCount = 0;

        // If _weightRecords is null, then display a placeholder entry telling the user there's no records
        if (_weightRecords == null)
        {
            menu.addItem(new MenuItem("No", "records", "itemIdNone", {}));
        }

        // And the rest of this method handles normal formatting and displaying of records
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
                var fetchedWeight = 0.0;

                if (_weightRecords[i] != null)
                {
                    fetchedWeight = _weightRecords[i] as Float;
                }               

                currentWeightRecord = fetchedWeight;
            }

            if (_dateRecords != null)
            {
                var fetchedDate = "ERROR";

                if (_dateRecords[i] != null)
                {
                    fetchedDate = _dateRecords[i] as String;
                }

                if (_dateRecords[i] == "")
                {
                    fetchedDate = "ERROR";
                }
                
                currentDateRecord = fetchedDate;
            }
            
            var currentWeightString = (currentWeightRecord as Float).format("%.1f") as String;
            
            menu.addItem(new MenuItem(currentWeightString, currentDateRecord, "itemId" + i.toString(), {}));
        }

        delegate = new WeightHistoryMenuItemDelegate();

        WatchUi.pushView(menu, delegate, WatchUi.SLIDE_IMMEDIATE);

        return menu;
    }
}