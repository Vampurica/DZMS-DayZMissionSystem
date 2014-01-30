/*
	DayZ Mission System Functions
	by Vampire
*/

DZMSAIKilled = compile preprocessFileLineNumbers "\z\addons\dayz_server\DZMS\Scripts\DZMSAIKilled.sqf";
DZMSAddMajMarker = compile preprocessFileLineNumbers "\z\addons\dayz_server\DZMS\Scripts\DZMSAddMajMarker.sqf";
DZMSBoxSetup = compile preprocessFileLineNumbers "\z\addons\dayz_server\DZMS\Scripts\DZMSBox.sqf";
DZMSAISpawn = compile preprocessFileLineNumbers "\z\addons\dayz_server\DZMS\Scripts\DZMSAISpawn.sqf";
DZMSSaveVeh = compile preprocessFileLineNumbers "\z\addons\dayz_server\DZMS\Scripts\DZMSSaveToHive.sqf";

//Attempts to find a mission location
//If findSafePos fails it searches again until a position is found
//This fixes the issue with missions spawning in Novy Sobor on Chernarus
DZMSFindPos = {
	private["_findRun","_pos"];
	_findRun = true;
	while {_findRun} do {
		_pos = [getMarkerPos "center",0,5500,100,0,20,0] call BIS_fnc_findSafePos;
		if (!(_pos == (getMarkerPos "center"))) then {
			_findRun = false;
		};
		sleep 2;
	};
	
	_pos
};

//Clears the cargo and sets fuel, direction, and orientation
//Direction stops the awkwardness of every vehicle bearing 0
DZMSSetupVehicle = {
	private ["_object","_objectID"];
	_object = _this;

	_objectID = str( round( random 999999 ) );
	_object setVariable ["ObjectID", _objectID, true];
	_object setVariable ["ObjectUID", _objectID, true];
	
	if (DZMSEpoch) then {
		PVDZE_serverObjectMonitor set [count PVDZE_serverObjectMonitor, _object];
	} else {
		dayz_serverObjectMonitor set [count dayz_serverObjectMonitor, _object];
	};
	
	waitUntil {(!isNull _object)};
	
	clearWeaponCargoGlobal _object;
	clearMagazineCargoGlobal _object;
	
	_ranFuel = random 1;
	if (_ranFuel < .1) then {_ranFuel = .1;};
	_object setFuel _ranFuel;
	_object setvelocity [0,0,1];
	_object setDir (round(random 360));
	
	//If saving vehicles to the database is disabled, lets warn players it will disappear
	if (!(DZMSSaveVehicles)) then {
		_object addEventHandler ["GetIn",{
			_nil = [nil,(_this select 2),"loc",rTITLETEXT,"Warning: This vehicle will disappear on server restart!","PLAIN DOWN",5] call RE;
		}];
	};

	true
};

//Prevents an object being cleaned up by the server anti-hack
DZMSProtectObj = {
	private ["_object","_objectID"];
	_object = _this;
	
	_objectID = str( round( random 999999 ) );
	_object setVariable ["ObjectID", _objectID, true];
	_object setVariable ["ObjectUID", _objectID, true];
	_object setvelocity [0,0,1];

	if (DZMSEpoch) then {
		PVDZE_serverObjectMonitor set [count PVDZE_serverObjectMonitor, _object];
	} else {
		dayz_serverObjectMonitor set [count dayz_serverObjectMonitor, _object];
	};

	true
};


//------------------------------------------------------------------//
diag_log format ["[DZMS]: Mission Functions Script Loaded!"];