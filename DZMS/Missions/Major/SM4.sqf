/*
	Bandit Supply Heli Crash by lazyink (Full credit for original code to TheSzerdi & TAW_Tonic)
	New Mission Format by Vampire
*/

private ["_missName","_coords","_ranChopper","_chopper","_crate","_crate2","_crate3"];

//Name of the Mission
_missName = "Bandit Heli Crash";

//DZMSFindPos loops BIS_fnc_findSafePos until it gets a valid result
_coords = call DZMSFindPos;

[nil,nil,rTitleText,"A bandit supply helicopter has crash landed! Check your map for the location!", "PLAIN",10] call RE;

//DZMSAddMajMarker is a simple script that adds a marker to the location
[_coords,_missname] ExecVM DZMSAddMajMarker;

//We create the vehicles like normal
_ranChopper = ["UH1H_DZ","Mi17_DZ"] call BIS_fnc_selectRandom;
_chopper = createVehicle [_ranChopper,_coords,[], 0, "NONE"];

//DZMSSetupVehicle prevents the vehicle from disappearing and sets fuel and such
[_chopper] call DZMSSetupVehicle;

_crate = createVehicle ["USLaunchersBox",[(_coords select 0) - 6, _coords select 1,0],[], 0, "CAN_COLLIDE"];

//DZMSBoxFill fills the box, DZMSProtectObj prevents it from disappearing
[_crate,"weapons"] ExecVM DZMSBoxSetup;
[_crate] call DZMSProtectObj;

_crate2 = createVehicle ["USLaunchersBox",[(_coords select 0) + 6, _coords select 1,0],[], 90, "CAN_COLLIDE"];
[_crate2,"weapons"] ExecVM DZMSBoxSetup;
[_crate2] call DZMSProtectObj;

_crate3 = createVehicle ["RULaunchersBox",[(_coords select 0) - 14, (_coords select 1) -10,0],[], 0, "CAN_COLLIDE"];
[_crate3,"weapons"] ExecVM DZMSBoxSetup;
[_crate3] call DZMSProtectObj;

//DZMSAISpawn spawns AI to the mission.
//Usage: [_coords, count, skillLevel]
[_coords,6,1] ExecVM DZMSAISpawn;
sleep 5;
[_coords,4,1] ExecVM DZMSAISpawn;
sleep 5;
[_coords,4,1] ExecVM DZMSAISpawn;
sleep 5;
[_coords,4,1] ExecVM DZMSAISpawn;
sleep 5;

//Wait until the player is within 30meters
waitUntil{{isPlayer _x && _x distance _coords <= 30  } count playableunits > 0}; 

//Call DZMSSaveVeh to attempt to save the vehicles to the database
//If saving is off, the script will exit.
[_chopper] ExecVM DZMSSaveVeh;

//Let everyone know the mission is over
[nil,nil,rTitleText,"The helicopter has been taken by survivors!", "PLAIN",6] call RE;
diag_log format["[DZMS]: Major SM4 Helicopter Landing Mission has Ended."];
deleteMarker "DZMSMajMarker";
deleteMarker "DZMSMajDot";

//Let the timer know the mission is over
DZMSMajDone = true;