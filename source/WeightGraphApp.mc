import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;
using Toybox.Time;
using Toybox.Time.Gregorian;

class WeightGraphApp extends Application.AppBase 
{
    private var _view as Null or View;

    public var _weightRecords as Null or Array<Float>;
    public var _dateRecords as Null or Array<String>;

    function initialize() 
    {
        AppBase.initialize();
    }

    // onStart() is called on application start up
    function onStart(state as Dictionary?) as Void 
    {
        _weightRecords = Application.Storage.getValue("weight_records") as Array<Float>;
        _dateRecords = Application.Storage.getValue("date_records") as Array<String>;

        System.println("Loaded saved data:");
        debugPrintWeightsAndDates();

        System.println("");

        //addNewWeight(214.2);

        System.println("");
        
        // System.println("_weightRecords.size:");
        // System.println(_weightRecords.size());
        
        updateMainViewWithLastWeight();
    }

    // onStop() is called when your application is exiting
    function onStop(state as Dictionary?) as Void 
    {
        // var testWeights = [213, 212.4, 212.6, 215.8, 214.2];
        // var testDates = [ "2023-11-27", "2023-11-28", "2023-11-29", "2023-11-30", "2023-12-01" ];

        System.println("Saving weight array and date array");

        // Clear arrays:
        // _weightRecords = [];
        // _dateRecords = [];

        //addNewWeight(210.4f);

        Storage.setValue("weight_records", _weightRecords);
        Storage.setValue("date_records", _dateRecords);
    }

    // Return the initial view of your application here
    function getInitialView() as Array<Views or InputDelegates>? 
    {
        _view = new WeightGraphView();

        return [_view, new WeightGraphDelegate() ] as Array<Views or InputDelegates>;
    }

    function getView() as Null or View
    {
        return _view;        
    }

    function addNewWeight(weightValue as Float) as Void
    {
        if (_weightRecords != null)
        {
            _weightRecords.add(weightValue);
        }
        
        if (_dateRecords != null)
        {
            _dateRecords.add(getNowDateTimestampString());
        }        

        System.println("Added new weight and date:");
        debugPrintWeightsAndDates();
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
        System.println(_weightRecords);

        System.println("");

        System.println("Date records:");
        System.println(_dateRecords);

        System.println("");
    }

    function updateMainViewWithLastWeight() as Void
    {
        if (_weightRecords != null)
        {
            if (_weightRecords.size() > 0)
            {       
                var weightRecordsSize = 0;

                if (_weightRecords != null)
                {   
                    weightRecordsSize = _weightRecords.size() as Number;
                }

                if (_weightRecords != null)
                {
                    System.println("_weightRecords.size:");
                    System.println(weightRecordsSize);
                
                }
                
                        
                // var lastWeight = _weightRecords[_weightRecords.size() - 1] as Array<Float>;
                // var lastDate = "5"; //_dateRecords.slice(_dateRecords.size() - 1, _dateRecords.size());

                // System.println("Updating main view:");
                // System.println(lastWeight + " | " + lastDate);
            
                // _view.updateLastWeight(lastWeight, lastDate);
            }                
        }
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


