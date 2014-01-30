//Adds a marker for Major Missions. Only runs once.
//DZMSMarkerLoop.sqf keeps this marker updated.
private["_nil"];
DZMSMinCoords = _this select 0;

_nil = createMarker ["DZMSMinMarker", DZMSMinCoords];
"DZMSMinMarker" setMarkerColor "ColorRed";
"DZMSMinMarker" setMarkerShape "ELLIPSE";
"DZMSMinMarker" setMarkerBrush "Grid";
"DZMSMinMarker" setMarkerSize [150,150];