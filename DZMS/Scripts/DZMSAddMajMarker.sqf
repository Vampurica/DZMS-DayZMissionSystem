//Adds a marker for Major Missions. Only runs once.
//DZMSMarkerLoop.sqf keeps this marker updated.
private["_nul"];
DZMSMajCoords = _this select 0;

_nul = createMarker ["DZMSMajMarker", DZMSMajCoords];
"DZMSMajMarker" setMarkerColor "ColorRed";
"DZMSMajMarker" setMarkerShape "ELLIPSE";
"DZMSMajMarker" setMarkerBrush "Grid";
"DZMSMajMarker" setMarkerSize [175,175];