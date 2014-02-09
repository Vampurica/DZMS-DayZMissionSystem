/*
	Bandit Hunting Party by lazyink (Full credit to TheSzerdi & TAW_Tonic for the code)
	Updated to new format by Vampire
*/
private ["_missName","_coords","_vehicle"];

//Name of the Mission
_missName = "Bandit Hunting Party";

//DZMSFindPos loops BIS_fnc_findSafePos until it gets a valid result
_coords = call DZMSFindPos;

[nil,nil,rTitleText,"A bandit hunting party has been spotted! Check your map for the location!", "PLAIN",10] call RE;

//DZMSAddMinMarker is a simple script that adds a marker to the location
[_coords,_missName] ExecVM DZMSAddMinMarker;

//Create the vehicle as normal
_vehicle = createVehicle ["UAZ_Unarmed_UN_EP1",[(_coords select 0) + 10, (_coords select 1) - 5,0],[], 0, "CAN_COLLIDE"];

//DZMSSetupVehicle prevents the vehicle from disappearing and sets fuel and such
[_vehicle] call DZMSSetupVehicle;

[_coords,2,1] ExecVM DZMSAISpawn;
sleep 5;
[_coords,2,1] ExecVM DZMSAISpawn;
sleep 5;
[_coords,2,1] ExecVM DZMSAISpawn;
sleep 5;
[_coords,2,1] ExecVM DZMSAISpawn;
sleep 1;

waitUntil{ {isPlayer _x && _x distance _coords <= 30 } count playableunits > 0 };

//Call DZMSSaveVeh to attempt to save the vehicles to the database
//If saving is off, the script will exit.
[_vehicle] ExecVM DZMSSaveVeh;

//Let everyone know the mission is over
[nil,nil,rTitleText,"The hunting party has been wiped out!", "PLAIN",6] call RE;
diag_log format["[DZMS]: Minor SM1 Hunting Party Mission has Ended."];
deleteMarker "DZMSMinMarker";
deleteMarker "DZMSMinDot";

//Let the timer know the mission is over
DZMSMinDone = true;