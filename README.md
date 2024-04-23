# WristNav
Offline map with routing for Garmin Devices that don't come with maps or routing, not all devices are supported yet and is not 100% complete but is in workable condition for currently supported devices.

Features:

Offline Map of highways and major roads covering all of Europe and nearby parts of Asia including Georgia, Turkey, etc. Does not include Russia as coordinate data was too big for it.

 * Set a home location.
 * Set waypoints.
 * Show/Hide waypoints on the map.
 * Select waypoint.
 * Route algorithm that takes selected Waypoint/routes to home.
 * Basic Pan functionality (moving the map without your location changing).
 * Delete selected waypoint.
 * Show/Hide Route.
 * Map Selector (You can select and deselect countries from a list and have the ability to select multiple countries, currently deselection has 
   only been tested with one country selected so I wouldn't load more than one country just yet, also its better memory wise and increases the speed of routing to limit country selection.
 * Horizontal Compass.
 * Ui and icons inspired by Pebble Watch design.
 
 
All icons are custom made and are the only part of the app you must provide credit for if you wish to use them from the open source.
Map requires gps signal to load but no internet is required for any of the functionality. Other continents and countries (large coord data heavy ones such as china or russia cannot be included with others 
due to storage constraints) will come when I am satisfied with the functionality of the European one. 


 # Notice/warning: Due to the goal of it being a completely offline (no internet connection, only gps) app aswell as the storage/memory constraints of some devices there is no functionality for ensuring the provided road network is up to date/completely  accurate or for providing road rules/safety information such as speed limitations, signage, etc and/or indicators/information for whether a route, waypoint or portion of the map is on private, public or hazardous land. It is up to you, the user to be mindful of the limitations of this app and the laws and hazards of the land/country you are on/in when navigating to ensure the safety of you, those around you and anyone you are travelling with, I take no responsibility for a user or users of this or any modified or reproduce version of this software who fail to heed/read this notice/warning.
