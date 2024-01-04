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
        // again, there is one entry in your pattern, so there will be one entry in the values array.
        // App.getApp().setProperty("D", values[0]);

        System.println("Got value from number picker");
        
        var userWeight = values[0] as Float;
        
        System.println("Was: " + userWeight);

        getApp().addNewWeight(userWeight);

        WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);

        return true;
    }
}