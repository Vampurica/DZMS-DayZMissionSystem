/*																		//
	DZMSAISpawn.sqf by Vampire
	Usage: [position,unitcount,skillLevel] execVM "dir\DZMSAISpawn.sqf";
*/																		//
private ["_position","_unitcount","_skill","_wpRadius","_xpos","_ypos","_unitGroup","_aiskin","_unit","_wp","_wppos"];
_position = _this select 0;
_unitcount = _this select 1;
_skill = _this select 2;

_wpRadius = 80;

_xpos = _position select 0;
_ypos = _position select 1;

//Create the unit group. We use east by default.
_unitGroup = createGroup east;

//Probably unnecessary, but prevents client AI stacking
if (!isServer) exitWith {};

for "_x" from 1 to _unitcount do {

	//Lets pick a skin from the array
	_aiskin = DZMSBanditSkins call BIS_fnc_selectRandom;
	
	//Lets spawn the unit
	_unit = _unitGroup createUnit [_aiskin, [(_position select 0),(_position select 1),(_position select 2)], [], 10, "PRIVATE"];
	
	//Make him join the correct team
	[_unit] joinSilent _unitGroup;
	
	//Add the behaviour
	_unit enableAI "TARGET";
	_unit enableAI "AUTOTARGET";
	_unit enableAI "MOVE";
	_unit enableAI "ANIM";
	_unit enableAI "FSM";
	_unit setCombatMode "RED";
	_unit setBehaviour "COMBAT";
	
	//Remove the items he spawns with by default
	removeAllWeapons _unit;
	removeAllItems _unit;
	
	/*															//
		Now we need to figure out their loadout, and assign it
	*/															//
	
	//Get the weapon array based on skill
	switch (_skill) do {
		case 0 : {_aiweapon = DZMSWeps0;};
		case 1 : {_aiweapon = DZMSWeps1;};
		case 2 : {_aiweapon = DZMSWeps2;};
		case 3 : {_aiweapon = DZMSWeps3;};
		case 4 : {_aiweapon = DZMSWeps4;};
	};
	_weaponandmag = _aiweapon call BIS_fnc_selectRandom;
	_weapon = _weaponandmag select 0;
	_magazine = _weaponandmag select 1;
	
	//Get the gear array
	_aigearArray = [DZMSGear0,DZMSGear1,DZMSGear2,DZMSGear3,DZMSGear4];
	_aigear = _aigearArray call BIS_fnc_selectRandom;
	_gearmagazines = _aigear select 0;
	_geartools = _aigear select 1;
	
	//Gear the AI backpack
	_aipack = DZMSPacklist call BIS_fnc_selectRandom;

	//Lets add it to the Unit
	_unit addweapon _weapon;
	for "_i" from 1 to 3 do {
		_unit addMagazine _magazine;
	};
	
	_unit addBackpack _aipack;
	
	{
		_unit addMagazine _x
	} forEach _gearmagazines;
	{
		_unit addweapon _x
	} forEach _geartools;
	
	//Lets set the skills
	switch (_skill) do {
		case 0 : {_aicskill = DZMSSkills1;};
		case 1 : {_aicskill = DZMSSkills2;};
		case 2 : {_aicskill = DZMSSkills3;};
	};
	{
	_unit setSkill [(_x select 0),(_x select 1)]
	} forEach _aicskill;
	
	//To make sure we get the right count, lets add one to the loop
	ai_ground_units = (ai_ground_units + 1);
	
	//Lets prepare the unit for cleanup
	_unit addEventHandler ["Killed",{[_this select 0, _this select 1] call DZMSAIKilled;}];
	_unit setVariable ["DZMSAI", true];
};

for "_x" from 1 to 4 do {
	_wppos = [_xpos+(_x*20), _ypos+(_x*20), _wpRadius];
	_wp = _unitGroup addWaypoint [_wppos, _wpRadius];
	_wp setWaypointType "MOVE";
};
_wp = _unitGroup addWaypoint [[_xpos,_ypos,0], _wpRadius];
_wp setWaypointType "CYCLE";

diag_log format ["[DZMS]: Spawned %1 AI at %2.",_unitcount,_position];