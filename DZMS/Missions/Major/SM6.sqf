/*
	Medical Crate by lazyink (Full credit for original code to TheSzerdi & TAW_Tonic)
	Updated to new format by Vampire
*/

private ["_coords","_vehicle","_vehicle1","_crate","_crate2"];

//DZMSFindPos loops BIS_fnc_findSafePos until it gets a valid result
_coords = call DZMSFindPos;

[nil,nil,rTitleText,"A medical supply crate has been secured by bandits! Check your map for the location!", "PLAIN",10] call RE;

//DZMSAddMajMarker is a simple script that adds a marker to the location
[_coords] call DZMSAddMajMarker;

//We create the vehicles like normal
_vehicle = createVehicle ["HMMWV_DZ",[(_coords select 0) + 10, (_coords select 1) - 10,0],[], 0, "CAN_COLLIDE"];
_vehicle1 = createVehicle ["UAZ_Unarmed_UN_EP1",[(_coords select 0) + 20, (_coords select 1) - 5,0],[], 0, "CAN_COLLIDE"];

//DZMSSetupVehicle prevents the vehicle from disappearing and sets fuel and such
[_vehicle] call DZMSSetupVehicle;
[_vehicle1] call DZMSSetupVehicle;

_crate = createVehicle ["USVehicleBox",[(_coords select 0) - 1, _coords select 1,0],[], 0, "CAN_COLLIDE"];

//DZMSBoxFill fills the box, DZMSProtectObj prevents it from disappearing
[_crate,"medical"] call DZMSBoxSetup;
[_crate] call DZMSProtectObj;

_crate2 = createVehicle ["USLaunchersBox",[(_coords select 0) - 3, _coords select 1,0],[], 0, "CAN_COLLIDE"];
[_crate2,"weapons"] call DZMSBoxSetup;
[_crate2] call DZMSProtectObj;

[_coords,6,1] call DZMSAISpawn;
sleep 5;
[_coords,6,1] call DZMSAISpawn;
sleep 5;
[_coords,4,1] call DZMSAISpawn;

waitUntil{{isPlayer _x && _x distance _coords <= 30  } count playableunits > 0}; 

//Call DZMSSaveVeh to attempt to save the vehicles to the database
//If saving is off, the script will exit.
[_vehicle] call DZMSSaveVeh;
[_vehicle1] call DZMSSaveVeh;

[nil,nil,rTitleText,"The medical crate is under survivor control!", "PLAIN",6] call RE;
diag_log format["[DZMS]: Major SM5 Medical Crate Mission has Ended."];
deleteMarker "DZMSMajMarker";

//Let the timer know the mission is over
DZMSMajDone = true;