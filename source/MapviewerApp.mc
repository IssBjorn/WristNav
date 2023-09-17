import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.Position;

             


class MapviewerApp extends Application.AppBase {
var metres;
    function initialize() {
        AppBase.initialize();
    }

    // onStart() is called on application start up
    //! @param state Startup arguments
    public function onStart(state as Dictionary?)
    {   
        Position.enableLocationEvents(Position.LOCATION_CONTINUOUS, method(:onPosition));
  
    }

    //! onStop() is called when your application is exiting
    public function onStop(state as Dictionary?)
    {
    Position.enableLocationEvents(Position.LOCATION_DISABLE, method(:onPosition));

    }
    
   public function onPosition(info as Info) as Void {
        MapviewerView.setPosition(info);    
    }

    // Return the initial view of your application here
    //! @return Array Pair [View, InputDelegate]
    public function getInitialView() {
        return [ new MapviewerView(), new CountryAddDelegate() ];
    }
     


function getApp() as MapviewerApp {
    return Application.getApp() as MapviewerApp;
}



}