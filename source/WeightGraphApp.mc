import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;
using Toybox.Time;
using Toybox.Time.Gregorian;

class WeightGraphApp extends Application.AppBase 
{
    private var _view as Null or WeightGraphView;

    public var WeightRecords as Array<Float> = [ 0.0 ] as Array<Float>;
    public var DateRecords as Array<String> = [ "" ] as Array<String>;

    function initialize() 
    {
        AppBase.initialize();
    }

    // onStart() is called on application start up
    function onStart(state as Dictionary?) as Void 
    {
               
    }

    // onStop() is called when your application is exiting
    function onStop(state as Dictionary?) as Void 
    {
        // var testWeights = [213, 212.4, 212.6, 215.8, 214.2];
        // var testDates = [ "2023-11-27", "2023-11-28", "2023-11-29", "2023-11-30", "2023-12-01" ];

        System.println("Saving weight array and date array");

        // Clear arrays:
        // WeightRecords = [];
        // DateRecords = [];

        //addNewWeight(210.4f);

        Storage.setValue("weight_records", WeightRecords);
        Storage.setValue("date_records", DateRecords);
    }

    // Return the initial view of your application here
    function getInitialView() as Array<Views or InputDelegates>? 
    {
        WeightRecords = Application.Storage.getValue("weight_records") as Array<Float>;
        DateRecords = Application.Storage.getValue("date_records") as Array<String>;

        System.println("Loaded saved data:");
        debugPrintWeightsAndDates();

        System.println("");

        // addNewWeight(210.8);

        _view = new WeightGraphView();

        System.println("When initializing WeightGraphDelegate():");
        System.println(WeightRecords);
        System.println(DateRecords);

        return [_view, new WeightGraphDelegate(WeightRecords, DateRecords) ] as Array<Views or InputDelegates>;
    }

    function getView() as Null or View
    {
        return _view;        
    }

    function addNewWeight(weightValue as Float) as Void
    {
        if (WeightRecords != null)
        {
            WeightRecords.add(weightValue);
        }
        
        if (DateRecords != null)
        {
            DateRecords.add(getNowDateTimestampString());
        }        

        System.println("Added new weight and date:");
        debugPrintWeightsAndDates();

        Storage.setValue("weight_records", WeightRecords);
        Storage.setValue("date_records", DateRecords);
    }

    function getNowDateTimestampString() as String
    {
        var today = Gregorian.info(Time.now(), Time.FORMAT_SHORT);

        var dateString = Lang.format(
            "$1$-$2$-$3$ $4$:$5$:$6$",
            [
                today.year,
                today.month,
                today.day,
                today.hour,
                today.min,
                today.sec
            ]
        );

        //System.println(dateString); // e.g. "16:28:32 2017-12-31"

        return dateString; 
    }

    function debugPrintWeightsAndDates() as Void
    {
        System.println("Weight records:");
        System.println(WeightRecords);

        System.println("");

        System.println("Date records:");
        System.println(DateRecords);

        System.println("");
    }
}

function getApp() as WeightGraphApp 
{
    return Application.getApp() as WeightGraphApp;
}

function getView() as Null or View
{
    return Application.getApp().getView();
}


