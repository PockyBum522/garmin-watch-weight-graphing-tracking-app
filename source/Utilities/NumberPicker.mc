import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;
import Toybox.Graphics;

class NumberPicker extends WatchUi.Picker 
{
    function initialize( ) 
    {
        var title = new WatchUi.Text(
        {
            :text => "Weight",
            :locX => WatchUi.LAYOUT_HALIGN_CENTER,
            :locY => WatchUi.LAYOUT_VALIGN_BOTTOM,
            :color => Graphics.COLOR_WHITE
        });

        System.println("PICKER INIT: Making number factory");

        var factory = new NumberFactory(0.0, 700.0, 0.2, {:format=>"%0.1f"});

        var pattern = [ factory ];

        var storedValue = 150.0;

        var weightRecordsFromParent = getApp().WeightRecords;

        if (weightRecordsFromParent != null)
        {
            var weightRecordsSize = weightRecordsFromParent.size();

            if (weightRecordsSize > 0)
            {
                storedValue = weightRecordsFromParent[weightRecordsSize - 1] as Float;
            }
        }

        var defaults = [ factory.getIndex(storedValue) ];

        Picker.initialize(
        {
            :title=>title, :pattern=>pattern, :defaults=>defaults
        });
    }

    function onUpdate(dc) 
    {
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);
        dc.clear( );
        Picker.onUpdate(dc);
    }    
}


class NumberPickerDelegate extends WatchUi.PickerDelegate 
{
    private var _weightRecords as Null or Array<Float>;
    private var _dateRecords as Null or Array<String>;

    function initialize( ) 
    {
        PickerDelegate.initialize();
    }

    function onCancel( ) 
    {
        WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);

        return true;
    }

    function onAccept(values) 
    {
        System.println("Got value from number picker");
        
        var userWeight = values[0] as Float;
        
        System.println("Was: " + userWeight);

        getApp().addNewWeight(userWeight);

        WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);

        _weightRecords = getApp().WeightRecords;
        _dateRecords = getApp().DateRecords;

        var historyMenu = initializeHistoryMenuItemsWithWeightRecords();

        WatchUi.pushView(historyMenu, new WeightHistoryMenuDelegate(_weightRecords, _dateRecords), WatchUi.SLIDE_UP);

        return true;
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