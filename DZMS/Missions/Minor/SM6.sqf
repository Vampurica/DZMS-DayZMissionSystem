//Weapon Truck Crash by lazyink (Full credit for code to TheSzerdi & TAW_Tonic)
private ["_coords","_wait","_MainMarker75"];

[] execVM "\z\addons\dayz_server\Missions\SMGoMinor.sqf";
WaitUntil {MissionGoMinor == 1};

_coords = [getMarkerPos "center",0,5500,10,0,2000,0] call BIS_fnc_findSafePos;

[nil,nil,rTitleText,"A bandit weapons truck has crashed! Check your map for the location!", "PLAIN",10] call RE;

MCoords = _coords;
publicVariable "MCoords";
[] execVM "debug\addmarkers75.sqf";

_uralcrash = createVehicle ["UralWreck",_coords,[], 0, "CAN_COLLIDE"];
_uralcrash setVariable ["ObjectID",""];

_crate = createVehicle ["USLaunchersBox",[(_coords select 0) + 3, _coords select 1,0],[], 0, "CAN_COLLIDE"];
[_crate] execVM "\z\addons\dayz_server\missions\misc\fillBoxes.sqf";
_crate setVariable ["ObjectID",""];
_crate setVariable ["permaLoot",true];

_crate2 = createVehicle ["USLaunchersBox",[(_coords select 0) - 3, _coords select 1,0],[], 0, "CAN_COLLIDE"];
[_crate2] execVM "\z\addons\dayz_server\missions\misc\fillBoxesS.sqf";
_crate2 setVariable ["ObjectID",""];
_crate2 setVariable ["permaLoot",true];

_crate3 = createVehicle ["RULaunchersBox",[(_coords select 0) - 6, _coords select 1,0],[], 0, "CAN_COLLIDE"];
[_crate3] execVM "\z\addons\dayz_server\missions\misc\fillBoxesH.sqf";
_crate setVariable ["ObjectID",""];
_crate setVariable ["permaLoot",true];

[_coords,40,4,3,0] execVM "\z\addons\dayz_server\Missions\add_unit_server.sqf";//AI Guards
sleep 1;
[_coords,40,4,3,0] execVM "\z\addons\dayz_server\Missions\add_unit_server.sqf";//AI Guards
sleep 1;
[_coords,40,4,3,0] execVM "\z\addons\dayz_server\Missions\add_unit_server.sqf";//AI Guards
sleep 1;
[_coords,40,4,3,0] execVM "\z\addons\dayz_server\Missions\add_unit_server.sqf";//AI Guards
sleep 1;



waitUntil{{isPlayer _x && _x distance _uralcrash < 5  } count playableunits > 0}; 


[nil,nil,rTitleText,"The crash site has been secured by survivors!", "PLAIN",6] call RE;


[] execVM "debug\remmarkers75.sqf";
MissionGoMinor = 0;
MCoords = 0;
publicVariable "MCoords";

SM1 = 5;
[0] execVM "\z\addons\dayz_server\missions\Minor\SMfinder.sqf";
