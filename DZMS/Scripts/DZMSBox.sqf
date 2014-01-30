/*
	Usage: [_crate,"type"] execVM "dir\DZMSBox.sqf";
		_crate is the crate to fill
		"type" is the type of crate
		"type" can be weapons or medical
*/
_crate = _this select 0;
_type = _this select 1;

//Clear the current cargo
clearWeaponCargoGlobal _crate;
clearMagazineCargoGlobal _crate;

//define lists
_bpackList = ["CZ_VestPouch_EP1","DZ_ALICE_Pack_EP1","DZ_Assault_Pack_EP1","DZ_Backpack_EP1","DZ_British_ACU","DZ_CivilBackpack_EP1","DZ_Czech_Vest_Puch","DZ_Patrol_Pack_EP1","DZ_TK_Assault_Pack_EP1"];
_gshellList = ["HandGrenade_west","FlareGreen_M203","FlareWhite_M203"];
_medical = ["ItemBandage","ItemMorphine","ItemEpinephrine","ItemPainkiller","ItemWaterbottle","FoodCanBakedBeans","ItemAntibiotic","ItemBloodbag"];

if (_type == "medical") then {
// load medical
_scount = count _medical;
    for "_x" from 0 to 6 do {
        _sSelect = floor(random _sCount);
        _item = _medical select _sSelect;
        _crate addMagazineCargoGlobal [_item,(round(random 10))];
    };
if (true) exitWith {};
};

if (!(_type == "weapons")) exitWith {};
// load grenades
_scount = count _gshellList;
    for "_x" from 0 to 2 do {
        _sSelect = floor(random _sCount);
        _item = _gshellList select _sSelect;
        _crate addMagazineCargoGlobal [_item,(round(random 2))];
    };
   
// load packs
_scount = count _bpackList;
    for "_x" from 0 to 1 do {
        _sSelect = floor(random _sCount);
        _item = _bpackList select _sSelect;
        _crate addBackpackCargoGlobal [_item,2];
    };
 
// load pistols
_scount = count DZMSpistolList;
    for "_x" from 0 to 2 do {
        _sSelect = floor(random _sCount);
        _item = DZMSpistolList select _sSelect;
        _crate addWeaponCargoGlobal [_item,1];
        _ammo = [] + getArray (configFile >> "cfgWeapons" >> _item >> "magazines");
            if (count _ammo > 0) then {
            _crate addMagazineCargoGlobal [(_ammo select 0),8];
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
            _crate addMagazineCargoGlobal [(_ammo select 0),8];
            };
    };

//load mg
_scount = count DZMSmgList;
    for "_x" from 0 to 2 do {
        _sSelect = floor(random _sCount);
        _item = DZMSmgList select _sSelect;
        _crate addWeaponCargoGlobal [_item,1];
        _ammo = [] + getArray (configFile >> "cfgWeapons" >> _item >> "magazines");
            if (count _ammo > 0) then {
            _crate addMagazineCargoGlobal [(_ammo select 0),8];
            };
    };

//load primary
_scount = count DZMSprimaryList;
    for "_x" from 0 to 3 do {
        _sSelect = floor(random _sCount);
        _item = DZMSprimaryList select _sSelect;
        _crate addWeaponCargoGlobal [_item,1];
        _ammo = [] + getArray (configFile >> "cfgWeapons" >> _item >> "magazines");
        if (count _ammo > 0) then {
            _crate addMagazineCargoGlobal [(_ammo select 0),8];
        };
    };