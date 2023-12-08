import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.Lang;

class WeightGraphView extends WatchUi.View 
{
    private var _lastWeight as Null or Text;

    function initialize() 
    {
        View.initialize();
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void 
    {
        setLayout(Rez.Layouts.MainLayout(dc));

        _lastWeight = findDrawableById("last_weight_recorded") as Text;

        //updateLastWeight((220.2).toFloat());
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void 
    {

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

    function updateLastWeight(lastWeight as Float, lastDate as String) as Void
    {
            var value = lastWeight.format("%.1f");

            if (_lastWeight != null)
            {
                _lastWeight.setText("Last: " + value + "\n" + lastDate);
            }            

            WatchUi.requestUpdate();
    }
}
