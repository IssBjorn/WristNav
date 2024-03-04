import Toybox.Communications;
import Toybox.Application;
import Toybox.Graphics;
import Toybox.Lang;
import Toybox.WatchUi;
var setting = 1;
var projLocy = 0;
var toggle = 0;
var col = null;
var id = 0;
var id1 = 0;
var NameIndex = [];
var drawWP = null;
var Highways = null;
 var Major = null;
 var selectedWaypoint = null;
class CountryAddDelegate extends WatchUi.BehaviorDelegate {

      var NameIndex = [];
    function initialize() {
        BehaviorDelegate.initialize();
    }
    
    public function onKey(event) as Boolean {
        var key = event.getKey();
        if (key == WatchUi.KEY_ENTER || key == WatchUi.KEY_START) {
            return onSelect();
        } else if (key == WatchUi.KEY_ESC || key == WatchUi.KEY_LAP) {
            return onBack();
        } else if (key == WatchUi.KEY_UP || key == WatchUi.KEY_MODE) {
            return controlPrev();
        } else if (key == WatchUi.KEY_DOWN || key == WatchUi.KEY_CLOCK) {
            return controlNext();
        }
        return false;
    }

    // handle long press activity (used to scroll up or down through the list of letters)
   

    function onHold(clickEvent) as Boolean {
    add = 0;
    var m = Position.getInfo().position;
	m = m.toDegrees();
	startLat = m[0];
	startLon = m[1];
     NumPick = 0;
     projLocy = 0;

     zoom = 10;
     selectedWaypoint = null;
       MapviewerView.GenerateBitmap();
       
    }
    
   // function onKeyPressed(){
    //add = 0;
   // var m = Position.getInfo().position;
	//m = m.toDegrees();
	//startLat = m[0];
	//startLon = m[1];
   // NumPick = 0;
   // zoom = 10;
   // selectedWaypoint = null;
   // MapviewerView.GenerateBitmap();}
    
    function onSwipe(swipeEvent) as Boolean
    {    
    var swi = swipeEvent.getDirection();
         if (swi == WatchUi.SWIPE_DOWN){
         return controlNext();}
         if (swi == WatchUi.SWIPE_UP){
              return controlPrev();
         }
           WatchUi.requestUpdate();
       
      return true;  
      }
    
    
   
    
    function controlPrev() as Boolean {
     //System.println(setting);
    if (toggle != 1){
    if (setting > 0) {
    setting = setting - 1;
    }
    else if (setting == 0) 
     {setting = 6;}
     }
     
   if (toggle == 1) {
      if (setting == 0){
        NumPick = 0;
      var m = Position.getInfo().position;
	m = m.toDegrees();
	startLat = m[0];
	startLon = m[1];
       MapviewerView.GenerateBitmap();
       
           if (zoom != 10) {

                zoom = zoom - 10;}     
     
                if (zoom == 10) {
                zoom = 250;}
       
       }
       
        else if (setting == 1) {
    
           projLocy = projLocy - 1000;
           if (projLocy <= 0) {
             projLocy = 500000;
          }
   
        }
        else if (setting == 4) {
        var wp = Application.Storage.getValue("waypoint");
        if (wp != null && wp.size() >= 2){
	    return pushWaypointSelect();}
	    }
	else if (setting == 2 && Map != null && NumPick == Map.size()) {
	oSB = null;
    oSBdc = null;
	generateRoute = 1;
	RoutePick = 0;
	route = [];
	var m = Position.getInfo().position;
	m = m.toDegrees();
	startLat = m[0];
	startLon = m[1];
    routeToDraw = 1;
	var destination = Application.Storage.getValue("home");
	destLat = destination[0];
	destLon = destination[1];


	
	
	
	}
	
	else if (setting == 3) {
	oSB = null;
    oSBdc = null;
	var m = Position.getInfo().position;
	m = m.toDegrees();
	RoutePick = 0;
	startLat = m[0];
	startLon = m[1];
	generateDest = 2;
   minDistanceToStart = 2147483647;
	
	}
	
	else if (setting == 5  && Map != null && NumPick == Map.size()) {
	if (selectedWaypoint != null) {
	oSB = null;
    oSBdc = null;
 
	generateRoute = 1;
	RoutePick = 0;
	route = [];
	var m = Position.getInfo().position;
	m = m.toDegrees();
	startLat = m[0];
	startLon = m[1];


	
    routeToDraw = 1;
	var destination = Application.Storage.getValue("waypoint");
	destLat = destination[id1+1];
	destLon = destination[id1];

	}}
	
	else if (setting == 6) {
	if (selectedWaypoint != null && Map != null && NumPick == Map.size()) {
	var toDelete = Application.Storage.getValue("waypoint");
	if (toDelete != null) {
	Application.Storage.deleteValue("waypoint");
	toDelete.remove(toDelete[id1]);
	toDelete.remove(toDelete[id1]);
    Application.Storage.setValue("waypoint",toDelete);
	startLon = toDelete[id1];
    startLat = toDelete[id1+1];
    NumPick = 0;
    MapviewerView.GenerateBitmap();
	}
	}
	}
	
	
	
	}
        WatchUi.requestUpdate();
        return true;
    }
    
    function controlNext() as Boolean {
    //System.println(setting);
    if (toggle != 1) {
      if (setting < 6) {
    setting = setting + 1;
    }
    else if (setting == 6) 
    {setting = 0;}
    }
      if (toggle == 1){
       if (setting == 0){
        NumPick = 0;
      var m = Position.getInfo().position;
	m = m.toDegrees();
	startLat = m[0];
	startLon = m[1];
       MapviewerView.GenerateBitmap();
           if (zoom != 250) {

                zoom = zoom + 10;}     
     
                if (zoom == 250) {
                zoom = 10;}}
    else if (setting == 1) {
    
           projLocy = projLocy + 1000;
           if (projLocy == 500000) {
             projLocy = 0;
             
          }
        }
     else if (setting == 4) {
        
	    return pushMapSelect();
	    }
	    
	else if (setting == 2) {
	if (posnInfo != null  && NumPick == Map.size() && Map != null){
	
	oSB = null;
    oSBdc = null;
	RoutePick = 0;
	var m = Position.getInfo().position;
	m = m.toDegrees();
	startLat = m[0];
	startLon = m[1];
	generateDest = 1;
   minDistanceToStart = 2147483647;

	}
	}
	
	else if (setting == 3) {
	if (drawWP == null) {
	drawWP = 1;
	 }
	else if (drawWP != null) {
	drawWP = null;
	
      }
	NumPick = 0;
      var m = Position.getInfo().position;
	m = m.toDegrees();
	startLat = m[0];
	startLon = m[1];
       MapviewerView.GenerateBitmap();
	}
	
	
	else if (setting == 5) {
	if (route != null && routeToDraw != null && route.size() >= 2) {
	routeToDraw = null;
	Application.Storage.setValue("route",route);
	MapviewerView.GenerateBitmap();
	NumPick = 0;
    var m = Position.getInfo().position;
	m = m.toDegrees();
	startLat = m[0];
	startLon = m[1];}
	
	else if (routeToDraw == null && Map != null && Map.size() > 0) {
	routeToDraw = 1; 
	RoutePick = Map.size();
	NumPick = 0;
	if (route == null || route.size() < 2){
	route = Application.Storage.getValue("route");}
	MapviewerView.GenerateBitmap();
    var m = Position.getInfo().position;
	m = m.toDegrees();
	startLat = m[0];
	startLon = m[1];
		}
	}
	
	
	
	
	else if (setting == 6) {
	if (route != null){
	route = [];
	}
     NumPick = 0;
      var m = Position.getInfo().position;
	m = m.toDegrees();
	startLat = m[0];
	startLon = m[1];
       MapviewerView.GenerateBitmap();
	}
	  

    }
        WatchUi.requestUpdate();
        return true;
   
	}


 public function onBack() as Boolean {
        WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
        return true;
    }
    //This saves a tap on the screen to storage
 public function onSelect() as Boolean {
 if (toggle == 1) {
 toggle = 0;
 }
 else if (toggle != 1) {
 toggle = 1;
 }
     WatchUi.requestUpdate();}
        

    //This code allows for the same function as the ontap fucntion above but for button watches
    


//! Create the Images custom menu
public function pushMapSelect() as Void {
       
       WatchUi.pushView(new MapPickerView(), new Menu2TestMenu2Delegate(), WatchUi.SLIDE_UP);
     
     Map = null;
    
}

public function pushWaypointSelect() as Void {
       var Waypoint = Application.Storage.getValue("waypoint");
       if (Waypoint != null) { 
       if (selectedWaypoint == null){
       id1 = 0;
        selectedWaypoint = 1;
       }
      
       else if (id1 < Waypoint.size() - 2 && Waypoint.size() > 2) {
       id1 = id1+2;
        selectedWaypoint = 1;
       System.println("plus2");
       }
       else if (id1 == Waypoint.size() - 2) {
       selectedWaypoint = null;
       System.println("zero");
       }
       
      
      
     startLon = Waypoint[id1];
       startLat = Waypoint[id1+1];
      
     }
 
       WatchUi.requestUpdate();
       }

}
class Menu2TestMenu2Delegate extends WatchUi.BehaviorDelegate {

    //! Constructor
    public function initialize() {
        BehaviorDelegate.initialize();
    }
    
     public function onKey(event) as Boolean {
        var key = event.getKey();
        if (key == WatchUi.KEY_ENTER || key == WatchUi.KEY_START) {
            return onSelect();
        } else if (key == WatchUi.KEY_ESC || key == WatchUi.KEY_LAP) {
            return onBack();
        } else if (key == WatchUi.KEY_UP || key == WatchUi.KEY_MODE) {
            return controlPre();
        } else if (key == WatchUi.KEY_DOWN || key == WatchUi.KEY_CLOCK) {
            return controlNex();
        }
        return false;
    }

public function onSelect() as Boolean {
    if (Major == null) {
    Major = [];
    Highways = [];}
    var list =  [[:UA_M,:UA_M1,:UA_M2,:UA_M3],[:UA_H,:UA_H1],[:TR_M,:TR_M1,:TR_M2,:TR_M3],[:TR_H,:TR_H1,:TR_H2],[:SK_M],[:SK_H],[:SI_M],[:SI_H],[:SE_M,:SE_M1,:SE_M2],[:SE_H,:SE_H],[:RS_M,:RS_M1],[:RS_H],[:RO_M,:RO_M1],[:RO_H,:RO_H1],[:PT_M,:PT_M1],[:PT_H],[:PL_M,:PL_M1,:PL_M2,:PL_M3,:PL_M4],[:PL_H,:PL_H1],[:NO_M,:NO_M1],[:NO_H,:NO_H1],[:NL_M],[:NL_H],[:MT_M],[:MT_H],[:MK_M],[:MK_H],[:ME_M],[:ME_H],[:MD_M],[:MD_H],[:LV_M],[:LV_H],[:LU_M],[:LU_H],[:LT_M],[:LT_H],[:IT_M,:IT_M1,:IT_M2,:IT_M3,:IT_M4,:SM_M],[:IT_H,:IT_H1,:IT_H2],[:IS_M,:IS_M1],[:IS_H],[:IE_M,:IE_M1],[:IE_H],[:HU_M,:HU_M1],[:HU_H],[:HR_M],[:HR_H],[:GR_M,:GR_M1,:CY_M],[:GR_H],[:GE_M,:AZ_H],[:GE_H],[:GB_M,:GB_M1,:GB_M2,:GB_M3,:GB_M4,:GB_M5,:IM_M],[:GB_H,:GB_H1,:GB_H2],[:FR_M,:FR_M1,:FR_M2,:FR_M3,:FR_M4,:FR_M5,:FR_M6,:MC_M],[:FR_H,:FR_H1,:FR_H2,:FR_H3],[:FI_M,:FI_M1,:FI_M2],[:FI_H,:FI_H1],[:ES_M,:ES_M1,:ES_M2,:ES_M3],[:ES_H,:ES_H1,:ES_H2],[:EE_M],[:EE_H],[:DK_M,:DK_M1],[:DK_H],[:DE_M,:DE_M1,:DE_M2,:DE_M3,:DE_M4,:DE_M5,:DE_M6,:DE_M7,:DE_M8],[:DE_H,:DE_H1,:DE_H2],[:CZ_M,:CZ_M1],[:CZ_H],[:CH_M,:LI_M],[:CH_H],[:BY_M,:BY_M1],[:BY_H],[:BG_M,:BG_M1],[:BG_H],[:BE_M],[:BE_H],[:BA_M],[:BA_H],[:AT_M],[:AT_H],[:AM_M],[:AM_H],[:AL_M],[:AL_H]];       
       
     if (NameIndex.indexOf(load) == -1){
       
          Highways.add(list[id+1]);
     Major.add(list[id]);
     NameIndex.add(load);
     }
     else if (NameIndex.indexOf(load) != -1){
     
     var thing = list[id];
     
     while (thing.size() > 0) {
     //System.println(thing.size()); 
     thing.remove(thing[0]);
     }
     while (Major.size() > 0){
     Major.remove(Major[0]);}
      thing = list[id+1];
     while (thing.size() > 0) {
    // System.println(thing.size()); 
     thing.remove(thing[0]);
     }
     while (Highways.size() > 0){
     Highways.remove(Highways[0]);}
     NameIndex.remove(load);
     }
     WatchUi.requestUpdate();
 
       
    }
    
    function onSwipe(swipeEvent) as Boolean
    {    
    var swi = swipeEvent.getDirection();
         if (swi == WatchUi.SWIPE_DOWN){
         return controlNex();}
         if (swi == WatchUi.SWIPE_UP){
              return controlPre();
         }
           WatchUi.requestUpdate();
       
      return true;  
      }
    
    
   
    
    function controlPre() as Boolean {          
    
    
     if (gh != null){ 
     
    if (id > 0) {
    id = id - 2;
    load = load - 1;}
    else {
    id = 80;
    load = 40;}
    }
	
        WatchUi.requestUpdate();
        return true;
    }
    
    function controlNex() as Boolean {
    if (gh != null){
    
    if (id < 80) {
    id = id + 2;
    load = load + 1;}
    else {
    id = 0;
    load = 0;}
    }

    WatchUi.requestUpdate();
        return true;
    }
    

    

    //! Handle the back key being pressed
    public function onBack() as Void {
    var m = Position.getInfo().position;
	m = m.toDegrees();
	startLat = m[0];
	startLon = m[1];
    if (Major != null && Major.size() > 0){
    Map = [];
    
    for (var i=0;i<Highways.size();i++){
    var Higharray = Highways[i];
     for (var l=0; l<Higharray.size(); l++){
    Map.add(Higharray[l]);}}
     col = Map.size();
    for (var j=0;j<Major.size();j++){
    var Majorarray = Major[j];
     for (var k=0; k<Majorarray.size(); k++){
    Map.add(Majorarray[k]);}}
    }   
        NumPick = 0;
        MapviewerView.GenerateBitmap();
        WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
        WatchUi.pushView(new MapviewerView(), new CountryAddDelegate(), WatchUi.SLIDE_UP);
       
    }
}
