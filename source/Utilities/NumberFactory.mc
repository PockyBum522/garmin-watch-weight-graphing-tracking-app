import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;

using Toybox.Graphics;
using Toybox.Time;
using Toybox.Time.Gregorian;

class NumberFactory extends WatchUi.PickerFactory 
{
    hidden var startNum as Float;
    hidden var stopNum as Float;
    hidden var incVal as Float;
    hidden var mFormatString as String = "";

    function getIndex(value as Float) as Number
    {
        var index = (value / incVal) - startNum;
        
        return index as Number;
    }

    function initialize(start as Float, stop as Float, increment as Float, options as Object) 
    {
        PickerFactory.initialize();

        startNum = start;
        stopNum = stop;
        incVal = increment;
    }

    function getDrawable(index, selected) as WatchUi.Drawable or Null
    {

        return new WatchUi.Text( { :text=>(getValue(index) as Number).format("%0.1f"), :color=>Graphics.COLOR_WHITE, :font=> Graphics.FONT_SMALL, :locX =>WatchUi.LAYOUT_HALIGN_CENTER, :locY=>WatchUi.LAYOUT_VALIGN_CENTER } ) as WatchUi.Drawable;
    }

    function getValue(index) 
    {
        return startNum + (index * incVal);
    }

    function getSize() as Lang.Number
    {
        return ((stopNum - startNum) / incVal + 1) as Number;
    }
}