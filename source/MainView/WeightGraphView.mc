import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.Lang;

class WeightGraphView extends WatchUi.View 
{
    private var _lastWeightLabel as Null or Text;    

    function initialize() 
    {
        View.initialize();
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void 
    {
        setLayout(Rez.Layouts.MainLayout(dc));

        _lastWeightLabel = findDrawableById("last_weight_recorded") as Text;

        updateLastWeightLabel();
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void
    {
        _lastWeightLabel = findDrawableById("last_weight_recorded") as Text;

        updateLastWeightLabel();
    }

    // Update the view
    function onUpdate(dc as Dc) as Void
    {
        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void 
    {

    }

    function updateLastWeightLabel() as Void
    {
        _lastWeightLabel = findDrawableById("last_weight_recorded") as Text;

        var weightRecords = [ ] as Array<Float>;
        var weightRecordsCount = 0;
        var lastWeight = 0.0f;
        var lastDate = "";

        var parentApp = getApp();

        System.println("about to test WeightGraphApp");

        weightRecords = parentApp.WeightRecords;

        if (weightRecords != null)
        {
            weightRecordsCount = weightRecords.size();
            System.println("weightRecordsCount: " + weightRecordsCount);
        }
        
        var lastWeightString = "None";

        if (weightRecordsCount > 0)
        {
            lastWeight = weightRecords[weightRecordsCount - 1];
                
            lastWeightString = (lastWeight as Float).format("%.1f") as String;
        }

        if (_lastWeightLabel != null)
        {
            _lastWeightLabel.setText("Last: " + lastWeightString + "\n" + lastDate);
            
            System.println("Updated view with new lastWeight:");            
            System.println(_lastWeightLabel);
            
            WatchUi.requestUpdate();
        }            
    }
}
