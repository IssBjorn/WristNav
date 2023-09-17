import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.Application;
import Toybox.Lang;
import Toybox.System;

class MapPickerView extends WatchUi.View {
var text = ["UKRAINE","TURKEY","SLOVAKIA","SLOVENIA","SWEDEN","SERBIA","ROMANIA","PORTUGAL","POLAND","NORWAY","NETHERLANDS","MALTA","NORTH MACEDONIA","MONTENEGRO","MOLDOVA","LATVIA","LUXEMBOURG","LITHUANIA","ITALY","ICELAND","IRELAND","HUNGARY","CROATIA","GREECE","GEORGIA","UNITED KINGDOM","FRANCE","FINLAND","SPAIN","ESTONIA","DENMARK","GERMANY","CZECH REPUBLIC","SWITZERLAND","BELARUS","BULGARIA","BELGIUM","BOSNIA'AND'HERZEGOVINA","AUSTRIA","ARMENIA","ALBANIA"];
   
    function initialize() {
        View.initialize();
        Pebble = WatchUi.loadResource(Rez.Fonts.pebble);
    }

     function onLayout(dc) {
     if (timer != null) {timer = null;}
      
        timer = new Timer.Timer();
  timer.start(method(:timerCallback), 10000, true);
        }

   

function timerCallback() as Void {
  WatchUi.requestUpdate();

}
    
    
 
 
    // Update the view
    function onUpdate(dc) {
    dc.setColor(Graphics.COLOR_WHITE,  Graphics.COLOR_WHITE);
  dc.clear();
  dc.setColor(Graphics.COLOR_TRANSPARENT, Graphics.COLOR_WHITE);
   var y = 58;
   dc.clearClip();
   dc.setColor(Graphics.COLOR_BLUE, Graphics.COLOR_TRANSPARENT);
  dc.fillRectangle(0, y - 20, gw, 40);
   dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_TRANSPARENT);
   
   
   
   if (NameIndex.indexOf(load) != -1){
   var tick = WatchUi.loadResource(Rez.Drawables[:tick]);
   dc.drawBitmap((gw/2) + 60, y - 26, tick);
   }
   if (load >= 2) {
   if (NameIndex.indexOf(load-1) != -1){
   var tick = WatchUi.loadResource(Rez.Drawables[:tick]);
   dc.drawBitmap((gw/2) + 60, y + 15, tick);
   }
   if (NameIndex.indexOf(load-2) != -1){
   var tick = WatchUi.loadResource(Rez.Drawables[:tick]);
   dc.drawBitmap((gw/2) + 60, y + 55, tick);
   }}
   else if (load == 1) {
   if (NameIndex.indexOf(load - 1) != -1){
   var tick = WatchUi.loadResource(Rez.Drawables[:tick]);
   dc.drawBitmap((gw/2) + 60, y + 15, tick);
   }
   if (NameIndex.indexOf(text.size()-1) != -1){
   var tick = WatchUi.loadResource(Rez.Drawables[:tick]);
   dc.drawBitmap((gw/2) + 60, y + 55, tick);
   }}
   else {
   if (NameIndex.indexOf(text.size()-1) != -1){
   var tick = WatchUi.loadResource(Rez.Drawables[:tick]);
   dc.drawBitmap((gw/2) + 60, y + 15, tick);
   }
   if (NameIndex.indexOf(text.size()-2) != -1){
   var tick = WatchUi.loadResource(Rez.Drawables[:tick]);
   dc.drawBitmap((gw/2) + 60, y + 55, tick);
   }}
   
   
   dc.drawText(110, y, Pebble, text[load] , 1|4);
   if (load >= 6) {
   dc.drawText(110,y + 40,  Pebble, text[load - 1] , 1|4);
   dc.drawText(110,y + 80,  Pebble, text[load - 2] , 1|4); 
   dc.drawText(110,y + 120, Pebble, text[load - 3] , 1|4);
   dc.drawText(110,y + 160, Pebble, text[load - 4] , 1|4);
   dc.drawText(110,y + 200, Pebble, text[load - 5] , 1|4);
   dc.drawText(110,y + 240, Pebble, text[load - 6] , 1|4);
   }
   if (load == 5) {
   dc.drawText(110, y + 40,  Pebble, text[load - 1] , 1|4);
   dc.drawText(110, y + 80,  Pebble, text[load - 2] , 1|4); 
   dc.drawText(110, y + 120, Pebble, text[load - 3] , 1|4);
   dc.drawText(110, y + 160, Pebble, text[load - 4] , 1|4);
   dc.drawText(110, y + 200, Pebble, text[load - 5] , 1|4);
   dc.drawText(110, y + 240, Pebble, text[text.size() - 1] , 1|4);}
   if (load == 4) {
   dc.drawText(110, y + 40,  Pebble, text[load - 1] , 1|4);
   dc.drawText(110, y + 80,  Pebble, text[load - 2] , 1|4);
   dc.drawText(110, y + 120, Pebble, text[load - 3] , 1|4);
   dc.drawText(110, y + 160, Pebble, text[load - 4] , 1|4);
   dc.drawText(110, y + 200, Pebble, text[text.size() - 1] , 1|4);
   dc.drawText(110, y + 240, Pebble, text[text.size() - 2] , 1|4);}
             
  
   if (load == 3) {
   dc.drawText(110, y + 40,  Pebble, text[load - 1] , 1|4);
   dc.drawText(110, y + 80,  Pebble, text[load - 2] , 1|4); 
   dc.drawText(110, y + 120, Pebble, text[load - 3] , 1|4);
   dc.drawText(110, y + 160, Pebble, text[text.size() - 1] , 1|4);
   dc.drawText(110, y + 200, Pebble, text[text.size() - 2] , 1|4);
   dc.drawText(110, y + 240, Pebble, text[text.size() - 3] , 1|4);
   }              
   if (load == 2) {
   dc.drawText(110, y + 40,  Pebble, text[load - 1] , 1|4);
   dc.drawText(110, y + 80,  Pebble, text[load - 2] , 1|4); 
   dc.drawText(110, y + 120, Pebble, text[text.size() - 1] , 1|4);
   dc.drawText(110, y + 160, Pebble, text[text.size() - 2] , 1|4);
   dc.drawText(110, y + 200, Pebble, text[text.size() - 3] , 1|4);
   dc.drawText(110, y + 240, Pebble, text[text.size() - 4] , 1|4);
   }
   else if (load == 1){
   dc.drawText(110, y + 40,  Pebble, text[load - 1] , 1|4);
   dc.drawText(110, y + 80,  Pebble, text[text.size() - 1] , 1|4);
   dc.drawText(110, y + 120, Pebble, text[text.size() - 2] , 1|4);
   dc.drawText(110, y + 160, Pebble, text[text.size() - 3] , 1|4);
   dc.drawText(110, y + 200, Pebble, text[text.size() - 4] , 1|4);
   dc.drawText(110, y + 240, Pebble, text[text.size() - 5] , 1|4);}
   else if (load == 0){
   dc.drawText(110, y + 40,  Pebble, text[text.size() - 1] , 1|4);
   dc.drawText(110, y + 80,  Pebble, text[text.size() - 2] , 1|4);
   dc.drawText(110, y + 120, Pebble, text[text.size() - 3] , 1|4);
   dc.drawText(110, y + 160, Pebble, text[text.size() - 4] , 1|4);
   dc.drawText(110, y + 200, Pebble, text[text.size() - 5] , 1|4);
   dc.drawText(110, y + 240, Pebble, text[text.size() - 6] , 1|4);}

     }
}