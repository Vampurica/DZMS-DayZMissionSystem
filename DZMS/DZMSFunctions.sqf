/*
	DayZ Mission System Functions
	by Vampire
*/

DZMSMajTimer = "\z\addons\dayz_server\DZMS\Scripts\DZMSMajTimer.sqf";
DZMSMinTimer = "\z\addons\dayz_server\DZMS\Scripts\DZMSMinTimer.sqf";
DZMSMarkerLoop = "\z\addons\dayz_server\DZMS\Scripts\DZMSMarkerLoop.sqf";

DZMSAddMajMarker = "\z\addons\dayz_server\DZMS\Scripts\DZMSAddMajMarker.sqf";
DZMSAddMinMarker = "\z\addons\dayz_server\DZMS\Scripts\DZMSAddMinMarker.sqf";

DZMSAISpawn = "\z\addons\dayz_server\DZMS\Scripts\DZMSAISpawn.sqf";
DZMSAIKilled = "\z\addons\dayz_server\DZMS\Scripts\DZMSAIKilled.sqf";

DZMSBoxSetup = "\z\addons\dayz_server\DZMS\Scripts\DZMSBox.sqf";
DZMSSaveVeh = "\z\addons\dayz_server\DZMS\Scripts\DZMSSaveToHive.sqf";

DZMSOpenRamp = "\z\addons\dayz_server\DZMS\Scripts\DZMSOpenRamp.sqf";

//Attempts to find a mission location
//If findSafePos fails it searches again until a position is found
//This fixes the issue with missions spawning in Novy Sobor on Chernarus
DZMSFindPos = {
    private["_mapHardCenter","_isTavi","_centerPos","_pos","_hardX","_hardY","_findRun","_posX","_posY","_feel1","_feel2","_feel3","_feel4","_noWater","_tavTest","_tavHeight","_disMaj","_disMin","_okDis"];
  
    //Lets try to use map specific "Novy Sobor Fixes".
    //If the map is unrecognised this function will still work.
	//Better code thanks to Halv
	_mapHardCenter = true;
	_isTavi = false;
	switch (DZMSWorldName) do {
		case "chernarus":{_centerPos = [7100, 7750, 0]};
		case "utes":{_centerPos = [3500, 3500, 0]};
		case "zargabad":{_centerPos = [4096, 4096, 0]};
		case "fallujah":{_centerPos = [3500, 3500, 0]};
		case "takistan":{_centerPos = [8000, 1900, 0]};
		case "tavi":{_centerPos = [13300, 2660, 0];_isTavi = true;};
		case "lingor":{_centerPos = [4400, 4400, 0]};
		case "namalsk":{_centerPos = [4352, 7348, 0]};
		case "napf":{_centerPos = [10240, 10240, 0]};
		case "mbg_celle2":{_centerPos = [8765.27, 2075.58, 0]};
		case "oring":{_centerPos = [1577, 3429, 0]};
		case "panthera2":{_centerPos = [4400, 4400, 0]};
		case "isladuala":{_centerPos = [4400, 4400, 0]};
		case "smd_sahrani_a2":{_centerPos = [13200, 8850, 0]};
		case "sauerland":{_centerPos = [13591.66, 12495.667, 0]};
		case "trinity":{_centerPos = [6400, 6400, 0]};
		//We don't have a supported map. Let's use the norm.
		default{_pos = [getMarkerPos "center",0,5500,60,0,20,0] call BIS_fnc_findSafePos;_mapHardCenter = false;};
	};

    //If we have a hardcoded center, then we need to loop for a location
    //Else we can ignore this block of code and just return the position
    if (_mapHardCenter AND (!(DZMSStaticPlc))) then {
   
        _hardX = _centerPos select 0;
        _hardY = _centerPos select 1;
   
        //We need to loop findSafePos until it doesn't return the map center
        _findRun = true;
        while {_findRun} do
        {
            _pos = [_centerPos,0,5500,60,0,20,0] call BIS_fnc_findSafePos;
           
            //Apparently you can't compare two arrays and must compare values
            _posX = _pos select 0;
            _posY = _pos select 1;
           
            //Water Feelers. Checks for nearby water within 50meters.
            _feel1 = [_posX, _posY+50, 0];
            _feel2 = [_posX+50, _posY, 0];
            _feel3 = [_posX, _posY-50, 0];
            _feel4 = [_posX-50, _posY, 0];
           
            //Water Check
            _noWater = (!surfaceIsWater _pos && !surfaceIsWater _feel1 && !surfaceIsWater _feel2 && !surfaceIsWater _feel3 && !surfaceIsWater _feel4);
			
			//Lets test the height on Taviana
			if (_isTavi) then {
				_tavTest = createVehicle ["Can_Small",[_posX,_posY,0],[], 0, "CAN_COLLIDE"];
				_tavHeight = (getPosASL _tavTest) select 2;
				deleteVehicle _tavTest;
			};
			
			//Lets check for minimum mission separation distance
			_disMaj = (_pos distance DZMSMajCoords);
			_disMin = (_pos distance DZMSMinCoords);
			_okDis = ((_disMaj > 1000) AND (_disMin > 1000));
			
			//Lets combine all our checks to possibly end the loop
            if ((_posX != _hardX) AND (_posY != _hardY) AND _noWater AND _okDis) then {
				if (!(_isTavi)) then {
					_findRun = false;
				};
				if (_isTavi AND (_tavHeight <= 185)) then {
					_findRun = false;
				};
            };
			// If the missions never spawn after running, use this to debug the loop. noWater=true / Dis > 1000 / TaviHeight <= 185
			//diag_log format ["[DZMS]: DEBUG: Pos:[%1,%2] / noWater?:%3 / okDistance?:%4 / TaviHeight:%5", _posX, _posY, _noWater, _okDis, _tavHeight];
            sleep 2;
        };
       
    };
	
	if (DZMSStaticPlc) then {
		_pos = DZMSStatLocs call BIS_fnc_selectRandom;
	};
   
    _fin = [(_pos select 0), (_pos select 1), 0];
    _fin
};

//Clears the cargo and sets fuel, direction, and orientation
//Direction stops the awkwardness of every vehicle bearing 0
DZMSSetupVehicle = {
	private ["_object","_objectID","_ranFuel"];
	_object = _this select 0;

	_objectID = str(round(random 999999));
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
	_object = _this select 0;
	
	_objectID = str(round(random 999999));
	_object setVariable ["ObjectID", _objectID, true];
	_object setVariable ["ObjectUID", _objectID, true];
	
	if (_object isKindOf "ReammoBox") then {
		// PermaLoot on top of ObjID because that "arma logic"
		_object setVariable ["permaLoot",true];
	};

	if (DZMSEpoch) then {
		PVDZE_serverObjectMonitor set [count PVDZE_serverObjectMonitor, _object];
	} else {
		dayz_serverObjectMonitor set [count dayz_serverObjectMonitor, _object];
	};

	true
};

//Gets the weapon and magazine based on skill level
DZMSGetWeapon = {
	private ["_skill","_aiweapon","_weapon","_magazine","_fin"];
	
	_skill = _this select 0;
	
	//diag_log format ["[DZMS]: AI Skill Func:%1",_skill];
	
	switch (_skill) do {
		case 0: {_aiweapon = DZMSWeps1;};
		case 1: {_aiweapon = DZMSWeps2;};
		case 2: {_aiweapon = DZMSWeps3;};
	};
	_weapon = _aiweapon call BIS_fnc_selectRandom;
	_magazine = getArray (configFile >> "CfgWeapons" >> _weapon >> "magazines") select 0;
	
	_fin = [_weapon,_magazine];
	
	_fin
};


//------------------------------------------------------------------//
diag_log format ["[DZMS]: Mission Functions Script Loaded!"];