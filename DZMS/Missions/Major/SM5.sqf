/*
	Medical Ural Attack by lazyink (Full credit for original code to TheSzerdi & TAW_Tonic)
	Updated to New Format by Vampire
*/

private ["_missName","_coords","_crash","_vehicle","_vehicle1","_crate","_crate2"];

//Name of the Mission
_missName = "Medical Ural Crash";

//DZMSFindPos loops BIS_fnc_findSafePos until it gets a valid result
_coords = call DZMSFindPos;

[nil,nil,rTitleText,"Bandits have destroyed a Ural carrying medical supplies and are securing the cargo! Check your map for the location!", "PLAIN",10] call RE;

//DZMSAddMajMarker is a simple script that adds a marker to the location
[_coords,_missname] ExecVM DZMSAddMajMarker;

//We create the scenery
_crash = createVehicle ["UralWreck",_coords,[], 0, "CAN_COLLIDE"];
[_crash] call DZMSProtectObj;

//We create the vehicles like normal
_vehicle = createVehicle ["UAZ_Unarmed_UN_EP1",[(_coords select 0) + 20, (_coords select 1) - 5,0],[], 0, "CAN_COLLIDE"];
_vehicle1 = createVehicle ["HMMWV_DZ",[(_coords select 0) + 30, (_coords select 1) - 5,0],[], 0, "CAN_COLLIDE"];

//DZMSSetupVehicle prevents the vehicle from disappearing and sets fuel and such
[_vehicle] call DZMSSetupVehicle;
[_vehicle1] call DZMSSetupVehicle;

_crate = createVehicle ["USVehicleBox",[(_coords select 0) - 6, _coords select 1,0],[], 0, "CAN_COLLIDE"];

//DZMSBoxFill fills the box, DZMSProtectObj prevents it from disappearing
[_crate,"medical"] ExecVM DZMSBoxSetup;
[_crate] call DZMSProtectObj;

_crate2 = createVehicle ["USLaunchersBox",[(_coords select 0) - 10, _coords select 1,0],[], 0, "CAN_COLLIDE"];

[_crate2,"weapons"] ExecVM DZMSBoxSetup;
[_crate2] call DZMSProtectObj;

[_coords,6,1] ExecVM DZMSAISpawn;
sleep 5;
[_coords,6,1] ExecVM DZMSAISpawn;
sleep 5;
[_coords,4,1] ExecVM DZMSAISpawn;
sleep 5;

waitUntil{{isPlayer _x && _x distance _coords <= 30  } count playableunits > 0}; 

//Call DZMSSaveVeh to attempt to save the vehicles to the database
//If saving is off, the script will exit.
[_vehicle] ExecVM DZMSSaveVeh;
[_vehicle1] ExecVM DZMSSaveVeh;

[nil,nil,rTitleText,"The medical supplies have been secured by survivors!", "PLAIN",6] call RE;
diag_log format["[DZMS]: Major SM5 Medical Supplies Mission has Ended."];
deleteMarker "DZMSMajMarker";
deleteMarker "DZMSMajDot";

//Let the timer know the mission is over
DZMSMajDone = true;