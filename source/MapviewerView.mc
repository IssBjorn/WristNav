import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.Position;
import Toybox.Sensor;
import Toybox.Timer;
import Toybox.Application;
import Toybox.Math;
import Toybox.Attention;
import Toybox.Lang;
import Toybox.System;
var posnInfo = null;
var zoom = 200;
var timer;
var hasit = null;
var hasit2 = null;
var NumPick = 0;
var RoutePick = 0;
var Map = null;
var MapArr = null;
var gw = null;
var gh = null;
var load = 0;
var updatePos = 1;
var Lon = null;
var Lat = null;
var headingOld = null;
var Pebble = null;
 var circle = 0;
var destLat = null;
var destLon = null;
var route = [];
var generateDest = null;
var generatestart = null;
var startLat = null;
var startLon = null;
var oSB = null;
var oSBdc = null;
var lineArray = [];
var currentPoint = [startLon,startLat];
var bearing = null;
 var minDistanceToDest = 2147483647;
var minDistanceToStart = 2147483647;
var minDistance = 2147483647;
var closestPoint = null;
var CurrPoint = null; 
var newpoint = 0;
var numPoints = null;
var currentLat = null;
var startNode = [];
var destNode =[];
var currentLon = null;
var prevLat = null;
var prevPoint = null;
var prevLon = null;
var routeToDraw = null;
var Indexes = [];
 var queue = [];
var visited = [];
//var start = Position.getInfo().position.toDegrees();
 var generateRoute = null;
var startup = null;
var add = 0;
 var p = null;
 var points = [];
 var spacing = 10;
class MapviewerView extends WatchUi.View {
var graph = [];
var lastpush = 0;
var add2 = null;
var nlat = null;
var nlon = null;
var r2 = null;
var ifra = 1;
var posOldX = null;
var posOldY = null;
 var Aselect = 1;
var router = [];
var closestToStartY = null;
var closestToStartX = null;
 var uxl = null;
 var uyl = null;
 var uxr = null;
 var uyb = null;
 var circle = 0;
var closestToDestX = null;
var closestToDestY = null;
var c2DIndex = null;
var c2SIndex = null;
var currentArr = [];
var newPath = [];
  var rtoDraw = [:Tranvil1,:Tranvil2];
    var rtoDrawBW = [:Anvil1,:Anvil2];
  var toDraw = [:magnify,:pan,:home,:poi,:menu,:route,:bin];
    var toDrawBW = [:magnify1,:pan1,:home1,:poi1,:menu1,:route1,:bin1];
//regex for splitting lines (.{1,6000})\[(?=\S*$)
var iteration = 0;
var midpo = 0;
var midpoint = null;
    var minDist = tolerance;
    var minIndex = -1;
function initialize() {
        View.initialize();
        
      
    }
    
      function onLayout(dc) {
      Pebble = WatchUi.loadResource(Rez.Fonts.pebble);
     if (timer != null) {timer = null;}
      gw = dc.getWidth();
      gh = dc.getHeight();
      
      MapviewerView.GenerateBitmap();
        timer = new Timer.Timer();
  timer.start(method(:timerCallback), 10000, true);
        }

   

function timerCallback() as Void {
  WatchUi.requestUpdate();

}

function GenerateBitmap(){
if (Toybox.Graphics has :createBufferedBitmap) {
oSB = Graphics.createBufferedBitmap.get(
{:width=>gw - 20,
:height=>gh - 20,
:palette=>[
Graphics.COLOR_TRANSPARENT,
Graphics.COLOR_WHITE,
Graphics.COLOR_BLACK,
Graphics.COLOR_YELLOW]
} );

}
else {
if (WatchUi has :getSubscreen){
oSB = new Graphics.BufferedBitmap({:width=>gw-20,
:height=>gh - 20,
:palette=>[
Graphics.COLOR_WHITE,
Graphics.COLOR_BLACK
]
});}
else {
oSB = new Graphics.BufferedBitmap({:width=>gw-20,
:height=>gh - 20,
:palette=>[
Graphics.COLOR_TRANSPARENT,
Graphics.COLOR_WHITE,
Graphics.COLOR_BLACK,
Graphics.COLOR_YELLOW,
Graphics.COLOR_RED
]
});
}}
oSBdc = oSB.getDc();

}

function drawMap(dc){
var py = null;
var px = null;
var pyOld = null;
var pxOld = null; 




if (MapArr != null) {

   for (var i=0; i<MapArr.size();i++){
   var arr = MapArr[i];

      for (var j=0; j<arr.size();j+=2){
       
     
      var long = arr[j];
      var lat = arr[j+1];
      var pixelsLon = (long - startLon) * zoom + (gw/2);
      var pixelsLat = (startLat - lat) * zoom + (gh/2);
      
      py = pixelsLat.toNumber();
      px = pixelsLon.toNumber();
      
      //var pyRot = ((px - gw/2) * Math.sin(heading2) + (py - gh/2) * Math.cos(heading2)) + gh/2;
       //var pxRot = ((px - gw/2) * Math.cos(heading2) - (py - gh/2) * Math.sin(heading2)) + gw/2;

  
       if (j == 0){
       pxOld = null;
       pyOld = null;
       }
       
       if (pxOld != null){
  if (j != 0) {
     if (NumPick >= col) {
  
       oSBdc.setPenWidth(3);
       if (WatchUi has :getSubscreen){
        oSBdc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);
       }
       else {
             oSBdc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);
       }
    }
       else {
      
       oSBdc.setPenWidth(4);
       if (WatchUi has :getSubscreen){
       oSBdc.setPenWidth(6);
        oSBdc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);
       }
       else{

       oSBdc.setColor(Graphics.COLOR_YELLOW, Graphics.COLOR_YELLOW);}
       
       }
   }
       
       
       
      
     
      
               oSBdc.drawLine(pxOld, pyOld, px,py);
       if (WatchUi has :getSubscreen && NumPick < col){
        oSBdc.setPenWidth(3);
               oSBdc.drawLine(pxOld, pyOld, px,py);}
}
   
   pxOld = px;
   pyOld = py;
   
   }


   
  if (i == (MapArr.size() - 1)){
  if (NumPick != (Map.size() - 1)){
  NumPick = NumPick + 1;
  WatchUi.requestUpdate();}
  else if (NumPick == (Map.size() - 1) && i == (MapArr.size() - 1)){
  if (route != null && route.size() > 0 && RoutePick == Map.size() && routeToDraw != null){
  
for (var j=0; j<route.size();j+=2){
if (j==0) {
  pxOld = null;
  pyOld = null;
  oSBdc.setColor(Graphics.COLOR_TRANSPARENT,Graphics.COLOR_TRANSPARENT);
  }
      var long = route[j];
      var lat = route[j+1];
      var pixelsLon = (long - startLon) * zoom + (gw/2);
      var pixelsLat = (startLat - lat) * zoom + (gh/2);
      
       py = pixelsLat.toNumber();
       px = pixelsLon.toNumber();
       if (pxOld != null){ 
       oSBdc.setPenWidth(3);

    oSBdc.setColor(Graphics.COLOR_RED, Graphics.COLOR_RED);
               oSBdc.drawLine(pxOld, pyOld, px,py);
}

   pxOld = px;
   pyOld = py;
   
   }
   
   }
   
  var Waypoints = Application.Storage.getValue("waypoint");
if (Waypoints != null && drawWP != null){
for (var f=0; f<Waypoints.size();f+=2){
      var Wlong = Waypoints[f];
      var Wlat = Waypoints[f+1];
 var WpixelsLon = (Wlong - startLon) * zoom + (gw/2);
      var WpixelsLat = (startLat - Wlat) * zoom + (gh/2);
      var wpy = WpixelsLat.toNumber();
       var wpx = WpixelsLon.toNumber();
      oSBdc.setPenWidth(9);
       oSBdc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);
      // System.println(wpx + ", " + wpy);
      oSBdc.drawPoint(wpx, wpy);
      oSBdc.setPenWidth(5);
       oSBdc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_WHITE);
             oSBdc.drawPoint(wpx, wpy);}

}
  
  pxOld = null;
  pyOld = null;
  NumPick = NumPick + 1;
 

  WatchUi.requestUpdate();
 
}}  }}



}


function drawGUI(dc){
var heading2 = Sensor.getInfo().heading;

  if (heading2==null||heading2==0){
  heading2 = Activity.getActivityInfo().currentHeading;}
  if (heading2 != null){
  if ( heading2 < 0 ){
  heading2 = 2*Math.PI+heading2;}
  dc.setColor(Graphics.COLOR_BLUE, Graphics.COLOR_TRANSPARENT);
  dc.fillRectangle(0, 0, gw, 40);
  dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_TRANSPARENT);
  dc.fillRectangle(0, 20, gw, 4);}
  
  
  var headdeg = heading2*180.0/Math.PI;
  var cx = headdeg/180.0*gw;
  //dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
  //dc.fillRectangle((gw/2-cx)-6,gh-gh+21, 13, 16);
  //dc.fillRectangle((0-cx)-6,gh-gh+21, 13, 16);
  //dc.fillRectangle((gw-cx)-6,gh-gh+21, 13, 16);
  //dc.fillRectangle((gw*2+gw/2-cx)-6,gh-gh+21, 13, 16);
  //dc.fillRectangle((gw*2-cx)-6,gh-gh+21, 13, 16);
  //dc.fillRectangle((gw+gw/2-cx)-6,gh-gh+21, 13, 16);
  //dc.fillRectangle((gw*3-cx)-6,gh-gh+21, 13, 16);
  dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLUE);
  dc.drawText(gw/2-cx,gh-gh+20,Pebble, "N", 1|4);
  dc.drawText(0-cx,gh-gh+20,Pebble, "W", 1|4);
  dc.drawText(gw-cx,gh-gh+20,Pebble, "E", 1|4);
  dc.drawText(gw*2+gw/2-cx,gh-gh+20,Pebble, "N", 1|4);
  dc.drawText(gw*2-cx,gh-gh+20,Pebble, "W", 1|4);
  dc.drawText(gw+gw/2-cx,gh-gh+20,Pebble, "S", 1|4);
  dc.drawText(gw*3-cx,gh-gh+20,Pebble, "N", 1|4);
if (WatchUi has :getSubscreen) {
 if (toggle == 0){
circle = 0;     }
 if (toggle == 1){
 circle = 1; }
}
else {
 if (toggle == 0){
   dc.clearClip();
  dc.setColor(Graphics.COLOR_BLUE, Graphics.COLOR_TRANSPARENT);
  dc.fillRectangle(0, gh-40, gw, 40);}

 if (toggle == 1){
  dc.clearClip();
  dc.setColor(Graphics.COLOR_RED, Graphics.COLOR_TRANSPARENT);
  dc.fillRectangle(0, gh-40, gw, 40);
  var ghNew = gh-170;
 dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_WHITE);
  dc.drawText(gw/2,ghNew,Pebble, "SWIPE/PRESS UP:", 1|4);
   dc.drawText(gw/2,ghNew + 60,Pebble, "SWIPE/PRESS DOWN:", 1|4);
  
  if (setting == 0){
  
    dc.drawText(gw/2,ghNew + 30,Pebble, "ZOOM OUT", 1|4);
   dc.drawText(gw/2,ghNew + 90,Pebble, "ZOOM IN", 1|4);

  }
  
  if (setting == 1){
  
    dc.drawText(gw/2,ghNew + 30,Pebble, "PAN RIGHT", 1|4);
   dc.drawText(gw/2,ghNew + 90,Pebble, "PAN UP", 1|4);

  }
  
  if (setting == 2){
  
    dc.drawText(gw/2,ghNew + 30,Pebble, "ROUTE TO HOME", 1|4);
   dc.drawText(gw/2,ghNew + 90,Pebble, "SET HOME", 1|4);

  }
  
  if (setting == 3){
  
    dc.drawText(gw/2,ghNew + 30,Pebble, "SET WAYPOINT", 1|4);
   if (drawWP == null) {
	dc.drawText(gw/2,ghNew + 90,Pebble, "SHOW WAYPOINTS", 1|4);}
	else if (drawWP != null) {
	dc.drawText(gw/2,ghNew + 90,Pebble, "HIDE WAYPOINTS", 1|4);}
      
  }
  
  if (setting == 4){
  
    dc.drawText(gw/2,ghNew + 30,Pebble, "PICK WAYPOINT", 1|4);
   dc.drawText(gw/2,ghNew + 90,Pebble, "PICK MAP", 1|4);

  }
  
  if (setting == 5){
  
    dc.drawText(gw/2,ghNew + 30,Pebble, "ROUTE TO WAYPOINT", 1|4);
   if (routeToDraw == null) {
	dc.drawText(gw/2,ghNew + 90,Pebble, "SHOW ROUTE", 1|4);}
	else if (routeToDraw != null) {
	dc.drawText(gw/2,ghNew + 90,Pebble, "HIDE ROUTE", 1|4);}

  }
   if (setting == 6){
  
    dc.drawText(gw/2,ghNew + 30,Pebble, "DELETE WAYPOINT", 1|4);
   dc.drawText(gw/2,ghNew + 90,Pebble, "DELETE ROUTE", 1|4);

  }
  
  
  }
  }

  
if (setting != null) {

if (WatchUi has :getSubscreen){
var draw = WatchUi.loadResource(Rez.Drawables[toDrawBW[setting]]);
dc.drawBitmap(gw-60, (gh-gh)+6, draw);
}
else {
var draw = WatchUi.loadResource(Rez.Drawables[toDraw[setting]]);
dc.drawBitmap((gw/2) - 25, gh-40, draw);}
}
if (WatchUi has :getSubscreen){
if (circle == 1) {
 dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_TRANSPARENT);
dc.setPenWidth(10);
dc.drawCircle(((gw/6)*5) + (gw/10) - (gw/19)*1.9, gh/5.6, gw/6);
}
else
{
 dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
dc.setPenWidth(10);
dc.drawCircle(((gw/6)*5) + (gw/10) - (gw/19)*1.9, gh/5.6, gw/6);
}
}}


function onUpdate(dc) {
 var p = Position.getInfo().position;
 View.onUpdate(dc); 




if (Aselect == 1){
Aselect = 0;}
else if (Aselect == 0){
Aselect = 1;}

 if (Map != null && NumPick != Map.size()){
   dc.setClip(0, 0, gw, 40);   
   dc.setClip(0, 200, gw, 40); 
}
    dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_WHITE);
  dc.clear();
  dc.setColor(Graphics.COLOR_TRANSPARENT, Graphics.COLOR_WHITE);
   
   dc.clearClip();
  
if (p != null && posnInfo != null) {
p = p.toDegrees();
    
	
	if (updatePos == 1 && generateRoute == null){
	Lon = p[1].toFloat();
	Lat = p[0].toFloat();
	updatePos = 0;
	}

//if (uxl != null){
//if (uxl >= 120 || uyl >= 120 || uxr <= 120 || uyb <= 120){
//System.println(uxl + ", " + uyl + ", " + uxr + ", " + uyb);
//MapviewerView.GenerateBitmap();
//}

//}

if (generateDest != null && generateRoute == null && Map != null && posnInfo != null) {
MapArr = WatchUi.loadResource(Rez.JsonData[Map[RoutePick]]);
toggle = 0;
if (WatchUi has :getSubscreen){
var Adraw = WatchUi.loadResource(Rez.Drawables[rtoDrawBW[Aselect]]);
dc.drawBitmap((gw/2) - 40, gh/2 - 50, Adraw);
}
else {
var Adraw = WatchUi.loadResource(Rez.Drawables[rtoDraw[Aselect]]);
dc.drawBitmap((gw/2) - 40, gh/2 - 50, Adraw);}
MapviewerView.GenerateDest();
}

 if (Map != null && NumPick != Map.size() && posnInfo != null) {
if (generateRoute == null && generateDest == null) {

MapArr = WatchUi.loadResource(Rez.JsonData[Map[NumPick]]);
  if (oSBdc == null){
   GenerateBitmap();
  }
   drawMap(dc);}}
   
if (generateRoute != null && Map != null && RoutePick != Map.size() && posnInfo != null) {

if (destLat != null && startLat != null){


MapArr = WatchUi.loadResource(Rez.JsonData[Map[RoutePick]]);
toggle = 0;
//if (WatchUi has :getSubscreen){
//var Adraw = WatchUi.loadResource(Rez.Drawables[rtoDrawBW[Aselect]]);
//dc.drawBitmap((gw/2) - 40, gh/2 - 50, Adraw);
//}
//else {
//var Adraw = WatchUi.loadResource(Rez.Drawables[rtoDraw[Aselect]]);
//dc.drawBitmap((gw/2) - 40, gh/2 - 50, Adraw);}
   
GenerateRoute();
   }
  



}
        }
        

if (Map != null && oSBdc != null && NumPick == Map.size() && oSB != null && p != null && startLon != null) {
   if (posOldY != null){
  if (selectedWaypoint != null){
   uxl = (Lon - p[1]) + projLocx; 
   uyl = (p[0] - Lat) + projLocy;
  
  }
 else {
  uxl = ((Lon - p[1]) * zoom + projLocx); 
  uyl = ((p[0] - Lat) * zoom + projLocy);
  }
  uxr = (uxl + (gh - 20));
  uyb = (uyl + (gw - 20));
  var ux = uxl.toNumber(), uy = uyl.toNumber();

   dc.drawBitmap(ux, uy, oSB);  }
 
    posOldY = p[0];
	posOldX = p[1];
   
}
 
    dc.clearClip();
    
  if (generateRoute == null){
  drawGUI(dc);
  }
}

function saveMapArraysToStorage(){
var limit = 12;
for (var i=0;i<Map.size()-1 || i == limit;i++){
MapArr = WatchUi.loadResource(Rez.JsonData[Map[i]]);
var MapKey = i.toString();
Application.Storage.setValue(MapKey, MapArr);
}
}

// Define the Earth's radius in kilometers
var EARTH_RADIUS = 6371;
// Convert latitude and longitude from degrees to radians
var spacing = 10; // in km

var tolerance = 0.01;

// Function to calculate distance between two coordinates (Haversine formula)
function haversine(lon1, lat1, lon2, lat2) {
var R = 6371; // km
var dLat = (lat2 - lat1) * Math.PI / 180;
var dLon = (lon2 - lon1) * Math.PI / 180;
var a = Math.sin(dLat / 2) * Math.sin(dLat / 2) +
Math.cos(lat1 * Math.PI / 180) * Math.cos(lat2 * Math.PI / 180) *
Math.sin(dLon / 2) * Math.sin(dLon / 2);
var c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
 return R * c; // distance in km
}

// Function to calculate the midpoint between two long-lat points


function GenerateDest() {

if (MapArr != null) {
//System.println("generateDest");

 //go through all arrays to find the closest point to start
  var array = MapArr[add];
  for (var j = 0; j < array.size() - 2; j+=2) {
 var CurrentX = array[j];
 var CurrentY = array[j+1];
 //System.println("coords: " + CurrentX + "," + CurrentY);
  var distance = haversine(startLon,startLat,CurrentX,CurrentY);
  if (distance < minDistanceToStart) {
  destLat = CurrentY;
  destLon = CurrentX;
  minDistanceToStart = distance;
  //System.println("sl: " + destLat + ", " + destLon + ", " + minDistanceToStart);
  }
  
  }
if (add != MapArr.size() - 1) {
//System.println("array" + array);
add = add + 1;
  WatchUi.requestUpdate();
}
  
 else if (add == (MapArr.size() - 1)){
     
  if (RoutePick != (Map.size() - 1)){
  add = 0;
  RoutePick = RoutePick + 1;
  //System.println("rpDest: " + RoutePick);
  //go through the current array to find the closest point to destination
  WatchUi.requestUpdate();}
  
  else if (RoutePick == (Map.size() - 1)){
  if (generateDest == 1){
  Application.Storage.deleteValue("home");
  //System.println("slagain: " + destLat + "," + destLon);
  Application.Storage.setValue("home",[destLat,destLon]);}
  if (generateDest == 2){
  if (posnInfo != null){
	var m = Position.getInfo().position;
	m = m.toDegrees();
	var waypoints = Application.Storage.getValue("waypoint");
	if (waypoints != null) {
	waypoints.add(destLon); 
	waypoints.add(destLat); 
	Application.Storage.setValue("waypoint", waypoints);}
	else if (waypoints == null) {
	waypoints = [];
	waypoints.add(destLon); 
	waypoints.add(destLat); 
	Application.Storage.setValue("waypoint", waypoints);
	}
	}
  }
  generateDest = null;
  destLat = null;
  destLon = null;
  var m = Position.getInfo().position;
  m = m.toDegrees();
  startLat = m[0];
  startLon = m[1];
  minDistanceToStart = 2147483647;
  add = 0;
  
 }
 
  WatchUi.requestUpdate();
  
}



}
  

}
  




function GenerateRoute() {

if (MapArr != null) {
if (RoutePick != Map.size()){

 //go through all arrays to find the closest point to start
 for (var i=0; i < MapArr.size(); i++) {
  var array = MapArr[i];
  for (var j = 0; j < array.size(); j+=2) {
 var CurrentX = array[j];
 var CurrentY = array[j+1];
  var distance = haversine(startLon,startLat,CurrentX,CurrentY);
   hasit = route.indexOf(CurrentX);
   hasit2 = route.indexOf(CurrentY);
  if (distance < minDistanceToStart && CurrentX != startLon && CurrentY != startLat && hasit == -1) {
  currentArr = array;
  minDistanceToStart = distance;
  c2SIndex = j;
  }
  
  }

  

  }
  if (RoutePick != (Map.size() - 1)){
  RoutePick = RoutePick + 1;
  
  //go through the current array to find the closest point to destination
  WatchUi.requestUpdate();}
  
  
  else if (RoutePick == (Map.size() - 1)){
  for (var k=0; k<currentArr.size(); k+=2) {

 var CurrentX = currentArr[k];
 var CurrentY = currentArr[k+1];
  var distance = haversine(destLon,destLat,CurrentX,CurrentY);
   hasit = route.indexOf(CurrentX);
   hasit2 = route.indexOf(CurrentY);
  if (distance < minDistanceToDest && hasit == -1) {
  closestToDestX = CurrentX;
  closestToDestY = CurrentY;
  minDistanceToDest = distance;
  c2DIndex = k;
 
  }
  }
   //reverse array if start index is greater than destination index
   router = [];
  if (c2SIndex > c2DIndex) {

   for (var l = c2SIndex; l > c2DIndex; l-=2){
    
    router.addAll([currentArr[l],currentArr[l+1]]);
  }
  //System.println(router);
  //System.println(c2DIndex + "," + c2SIndex + "reverse");
  }
  // Add the points to the route array.
   else if (c2SIndex < c2DIndex){
  for (var l = c2SIndex; l < c2DIndex; l+=2) {
 

   router.addAll([currentArr[l],currentArr[l+1]]);
  }
 //System.println(c2DIndex + "," + c2SIndex + "Don't reverse");
 
 }
  
  else if (c2SIndex == c2DIndex){
  router.addAll([currentArr[c2SIndex],currentArr[c2SIndex + 1]]);
  
  }
  hasit = route.indexOf(router);
  if (router.size() > 0 && hasit == -1){
  route.addAll(router);}
  router = null;
 if (closestToDestX == destLon && closestToDestY == destLat || route[0] == destLat && route[1] == destLon){
 RoutePick = Map.size();
  System.println("route finished");
  route.add(destLon);
  route.add(destLat);
  generateRoute = null;
  NumPick = 0;
  var m = Position.getInfo().position;
  m = m.toDegrees();
  startLat = m[0];
  startLon = m[1];
  
  MapviewerView.GenerateBitmap();
 }
 else {
  RoutePick = 0;
  
  startLat = closestToDestY;
  startLon = closestToDestX;
  minDistanceToDest = 2147483647;
  minDistanceToStart = 2147483647;

  WatchUi.requestUpdate();
  
}
}


} 

  WatchUi.requestUpdate();


}
  
}



  function toRadians(degrees) {
 if (degrees != null) {
return degrees * (Math.PI / 180);
}}

 

    function setPosition(info) {
        posnInfo = info;  
        WatchUi.requestUpdate();
        
    }
    function onHide(){
        timer.stop();
    
    }
    
    

}