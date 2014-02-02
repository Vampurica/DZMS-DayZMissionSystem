/*
	DZMSInit.sqf by Vampire
	This is the file that every other file branches off from.
	It checks that it is safe to run, sets relations, and starts mission timers.
*/
private["_modVariant"];

waitUntil{initialized};

//Error Check
if (!isServer) exitWith { diag_log format ["[DZMS]: <ERROR> DZMS is Installed Incorrectly! DZMS is not Running!"]; };
if (!isnil("DZMSActive")) exitWith { diag_log format ["[DZMS]: <ERROR> DZMS is Installed Twice or Installed Incorrectly!"]; };

// Global for other scripts to check if DZMS is installed.
DZMSInstalled = true;

diag_log format ["[DZMS]: Starting DayZ Mission System."];

//Let's see if we need to set relationships
//Checking for DayZAI, SargeAI, and WickedAI (Three AI Systems that already set relations)
//I would rather the user set their relations in the respective mod instead of overwrite them here.
if ( (isnil("DZAI_isActive")) && (isnil("SAR_version")) && (isnil("WAIconfigloaded")) ) then
{
	//They weren't found, so let's set relationships
	diag_log format ["[DZMS]: Relations not found! Using DZMS Relations."];
	
	//Create the groups if they aren't created already
	createCenter east;
	//Make AI Hostile to Survivors
	WEST setFriend [EAST,0];
	EAST setFriend [WEST,0];
	//Make AI Hostile to Zeds
	EAST setFriend [CIVILIAN,0];
	CIVILIAN setFriend [EAST,0];
} else {
	//Let's inform the user which relations we are using
	DZMSRelations = 0; //Set our counter variable
	if (!isnil("DZAI_isActive")) then {
		diag_log format ["[DZMS]: DZAI Found! Using DZAI's Relations!"];
		DZMSRelations = DZMSRelations + 1;
	};
	if (!isnil("SAR_version")) then {
		diag_log format ["[DZMS]: SargeAI Found! Using SargeAI's Relations!"];
		DZMSRelations = DZMSRelations + 1;
	};
	if (!isnil("WAIconfigloaded")) then {
		diag_log format ["[DZMS]: WickedAI Found! Using WickedAI's Relations!"];
		DZMSRelations = DZMSRelations + 1;
	};
	//If we have multiple relations running, lets warn the user
	if (DZMSRelations > 1) then {
		diag_log format ["[DZMS]: Multiple Relations Detected! Unwanted AI Behaviour May Occur!"];
		diag_log format ["[DZMS]: If Issues Arise, Decide on a Single AI System! (DayZAI, SargeAI, or WickedAI)"];
	};
	DZMSRelations = nil; //Destroy the Global Var
};

//Let's Load the Mission Configuration
call compile preprocessFileLineNumbers "\z\addons\dayz_server\DZMS\DZMSConfig.sqf";
waitUntil {DZMSConfigured};
DZMSConfigured = nil;

//These are Extended configuration files the user can adjust if wanted
call compile preprocessFileLineNumbers "\z\addons\dayz_server\DZMS\ExtConfig\DZMSWeaponCrateList.sqf";
call compile preprocessFileLineNumbers "\z\addons\dayz_server\DZMS\ExtConfig\DZMSAIConfig.sqf";

if (DZMSVersion != "1.0") then {
	diag_log format ["[DZMS]: Outdated Configuration Detected! Please Update DZMS!"];
	diag_log format ["[DZMS]: Old Versions are not supported by the Mod Author!"];
};

diag_log format ["[DZMS]: Mission and Extended Configuration Loaded!"];

//Lets get the map name for mission location purposes
DZMSWorldName = toLower format ["%1", worldName];
diag_log format["[DZMS]: %1 Detected. Map Specific Settings Adjusted!", DZMSWorldName];

//Lets check if we are running Epoch, in case the user chooses to have mission vehicles save
_modVariant = toLower(getText (configFile >> "CfgMods" >> "DayZ" >> "dir"));
if (_modVariant == "@dayz_epoch") then {DZMSEpoch = true;} else {DZMSEpoch = false;};

if (DZMSEpoch) then {
	diag_log format ["[DZMS]: DayZ Epoch Detected! Some Scripts Adjusted!"];
};

//Lets load our functions
call compile preprocessFileLineNumbers "\z\addons\dayz_server\DZMS\DZMSFunctions.sqf";

//Let's get the clocks running!
call compile preprocessFileLineNumbers "\z\addons\dayz_server\DZMS\Scripts\DZMSMajTimer.sqf";
call compile preprocessFileLineNumbers "\z\addons\dayz_server\DZMS\Scripts\DZMSMinTimer.sqf";

//Let's get the Marker Re-setter running for JIPs to stay updated
call compile preprocessFileLineNumbers "\z\addons\dayz_server\DZMS\Scripts\DZMSMarkerLoop.sqf";