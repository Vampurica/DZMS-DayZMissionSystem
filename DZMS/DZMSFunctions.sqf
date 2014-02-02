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
	private["_findRun","_pos","_centerPos","_mapHardCenter"];
	
	//Lets try to use map specific "Novy Sobor Fixes".
	//If the map is unrecognised this function will still work.
	if (DZMSWorldName in ["chernarus","utes","zargabad","fallujah","takistan","tavi","lingor","namalsk","mbg_celle2","oring","panthera2","isladuala","smd_sahrani_a2","trinity"]) then
	{
		_mapHardCenter = true;
		
		//We have a supported map so lets set the center
		//New map support can easily be added to these
		if (DZMSWorldName == "chernarus") then {
			_centerPos = [7100, 7750, 0];
		};
		if (DZMSWorldName == "utes") then {
			_centerPos = [3500, 3500, 0];
		};
		if (DZMSWorldName == "zargabad") then {
			_centerPos = [4096, 4096, 0];
		};
		if (DZMSWorldName == "fallujah") then {
			_centerPos = [3500, 3500, 0];
		};
		if (DZMSWorldName == "takistan") then {
			_centerPos = [8000, 1900, 0];
		};
		if (DZMSWorldName == "tavi") then {
			_centerPos = [13300, 2660, 0];
		};
		if (DZMSWorldName == "lingor") then {
			_centerPos = [4400, 4400, 0];
		};
		if (DZMSWorldName == "namalsk") then {
			_centerPos = [4352, 7348, 0];
		};
		if (DZMSWorldName == "mbg_celle2") then {
			_centerPos = [8765.27, 2075.58, 0];
		};
		if (DZMSWorldName == "oring") then {
			_centerPos = [1577, 3429, 0];
		};
		if (DZMSWorldName == "panthera2") then {
			_centerPos = [4400, 4400, 0];
		};
		if (DZMSWorldName == "isladuala") then {
			_centerPos = [4400, 4400, 0];
		};
		if (DZMSWorldName == "smd_sahrani_a2") then {
			_centerPos = [13200, 8850, 0];
		};
		if (DZMSWorldName == "trinity") then {
			_centerPos = [6400, 6400, 0];
		};
		
	}
	else
	{
		//We don't have a supported map. Let's use the norm.
		_pos = [getMarkerPos "center",0,5500,100,0,20,0] call BIS_fnc_findSafePos;
		
	};
	
	//If we have a hardcoded center, then we need to loop for a location
	//Else we can ignore this block of code and just return the position
	if (_mapHardCenter) then {
	
		//We need to loop findSafePos until it doesn't return the map center
		_findRun = true;
		while {_findRun} do
		{
			_pos = [_centerPos,0,5500,100,0,20,0] call BIS_fnc_findSafePos;
			if (_pos != _centerPos) then {
				_findRun = false;
			};
			sleep 2;
		};
		
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