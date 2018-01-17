/*
	Usage: [_crate,"type"] execVM "dir\DZMSBox.sqf";
		_crate is the crate to fill
		"type" is the type of crate
		"type" can be weapons or medical
*/
_crate = _this select 0;
_type = _this select 1;

// Clear the current cargo
clearWeaponCargoGlobal _crate;
clearMagazineCargoGlobal _crate;

// Define lists. Some lists are defined in DZMSWeaponCrateList.sqf in the ExtConfig.
_bpackList = ["DZ_Patrol_Pack_EP1","DZ_Assault_Pack_EP1","DZ_Czech_Vest_Pouch","DZ_ALICE_Pack_EP1","DZ_TK_Assault_Pack_EP1","DZ_British_ACU","DZ_CivilBackpack_EP1","DZ_Backpack_EP1"];
_gshellList = ["HandGrenade_west","FlareGreen_M203","FlareWhite_M203"];
_medical = ["ItemBandage","ItemMorphine","ItemEpinephrine","ItemPainkiller","ItemWaterbottle","FoodMRE","ItemAntibiotic","ItemBloodbag"];
_money = ["ItemSilverBar","ItemSilverBar10oz","ItemGoldBar","ItemGoldBar10oz"];

_ammoRU = [
	"30Rnd_545x39_AK","30Rnd_545x39_AK","30Rnd_545x39_AKSD","75Rnd_545x39_RPK",
	"30Rnd_762x39_AK47","75Rnd_762x39_RPK",
	"10Rnd_762x54_SVD","100Rnd_762x54_PK",
	"30Rnd_762x39_SA58","50Rnd_762x54_UK59",
	"1Rnd_HE_GP25","FlareGreen_GP25","1Rnd_Smoke_GP25",
	"HandGrenade_East","SmokeShell","SmokeShellRed","SmokeShellGreen","PipeBomb"
];

_ammoUS = [
	"30Rnd_556x45_Stanag","30Rnd_556x45_Stanag","30Rnd_556x45_StanagSD","200Rnd_556x45_M249",
	"20Rnd_762x51_DMR","100Rnd_762x51_M240",
	"30Rnd_556x45_G36","30Rnd_556x45_G36SD",
	"20Rnd_762x51_FNFAL","5Rnd_86x70_L115A1",
	"1Rnd_HE_M203","FlareGreen_M203","1Rnd_Smoke_M203",
	"HandGrenade_West"
];

//////////////////////////////////////////////////////////////////
// Medical Crates
if (_type == "medical") then {
	// load medical
	_scount = count _medical;
	for "_x" from 0 to 40 do {
		_sSelect = floor(random _sCount);
		_item = _medical select _sSelect;
		_crate addMagazineCargoGlobal [_item,(round(random 2))];
	};
};

//////////////////////////////////////////////////////////////////
// Ammo Boxes
if (_type == "ammoRU") then {
	_scount = count _ammoRU;
	for "_x" from 0 to 25 do {
		_sSelect = floor(random _sCount);
		_item = _ammoRU select _sSelect;
		_crate addMagazineCargoGlobal [_item,(round(random 2))];
	};
};
if (_type == "ammoUS") then {
	_scount = count _ammoUS;
	for "_x" from 0 to 25 do {
		_sSelect = floor(random _sCount);
		_item = _ammoUS select _sSelect;
		_crate addMagazineCargoGlobal [_item,(round(random 2))];
	};
};

///////////////////////////////////////////////////////////////////
// Weapon Crates
if (_type == "weapons") then {
	// load grenades
	_scount = count _gshellList;
	for "_x" from 0 to 2 do {
		_sSelect = floor(random _sCount);
		_item = _gshellList select _sSelect;
		_crate addMagazineCargoGlobal [_item,(round(random 2))];
	};
   
	// load packs
	_scount = count _bpackList;
	for "_x" from 0 to 3 do {
		_sSelect = floor(random _sCount);
		_item = _bpackList select _sSelect;
		_crate addBackpackCargoGlobal [_item,1];
	};
	 
	// load pistols
	_scount = count DZMSpistolList;
	for "_x" from 0 to 2 do {
		_sSelect = floor(random _sCount);
		_item = DZMSpistolList select _sSelect;
		_crate addWeaponCargoGlobal [_item,1];
		_ammo = [] + getArray (configFile >> "cfgWeapons" >> _item >> "magazines");
		if (count _ammo > 0) then {
			_crate addMagazineCargoGlobal [(_ammo select 0),(round(random 8))];
		};
	};

	//load sniper
	_scount = count DZMSsniperList;
	for "_x" from 0 to 1 do {
		_sSelect = floor(random _sCount);
		_item = DZMSsniperList select _sSelect;
		_crate addWeaponCargoGlobal [_item,1];
		_ammo = [] + getArray (configFile >> "cfgWeapons" >> _item >> "magazines");
		if (count _ammo > 0) then {
			_crate addMagazineCargoGlobal [(_ammo select 0),(round(random 8))];
		};
	};

	//load mg
	_scount = count DZMSmgList;
	for "_x" from 0 to 1 do {
		_sSelect = floor(random _sCount);
		_item = DZMSmgList select _sSelect;
		_crate addWeaponCargoGlobal [_item,1];
		_ammo = [] + getArray (configFile >> "cfgWeapons" >> _item >> "magazines");
		if (count _ammo > 0) then {
			_crate addMagazineCargoGlobal [(_ammo select 0),(round(random 8))];
		};
	};

	//load primary
	_scount = count DZMSprimaryList;
	for "_x" from 0 to 2 do {
		_sSelect = floor(random _sCount);
		_item = DZMSprimaryList select _sSelect;
		_crate addWeaponCargoGlobal [_item,1];
		_ammo = [] + getArray (configFile >> "cfgWeapons" >> _item >> "magazines");
		if (count _ammo > 0) then {
			_crate addMagazineCargoGlobal [(_ammo select 0),(round(random 8))];
		};
	};
};

///////////////////////////////////////////////////////////////////
// Epoch Supply Crates
if (_type == "supply") then {
	// load tools
	_scount = count DZMSConTools;
	for "_x" from 0 to 2 do {
		_sSelect = floor(random _sCount);
		_item = DZMSConTools select _sSelect;
		_crate addWeaponCargoGlobal [_item, 1];
	};
	
	// load construction
	_scount = count DZMSConSupply;
	for "_x" from 0 to 30 do {
		_sSelect = floor(random _sCount);
		_item = DZMSConSupply select _sSelect;
		_crate addMagazineCargoGlobal [_item,1];
	};
};

///////////////////////////////////////////////////////////////////
// Epoch Money Crates
if (_type == "money") then {
	// load money
	_scount = count _money;
	for "_x" from 0 to 3 do {
		_sSelect = floor(random _sCount);
		_item = _money select _sSelect;
		_crate addMagazineCargoGlobal [_item,1];
	};
};