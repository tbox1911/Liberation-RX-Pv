params [ "_unit" ];
if (isNull _unit) exitWith {0};

_expensive_items = [
	"medikit",
	"toolkit",
	"srifle_dmr_02",
	"srifle_dmr_04",
    "srifle_dmr_05",
	"srifle_gm6",
	"srifle_lrr",
	"mmg_",
	"lmg_",
	"launch_o_vorona",
	"launch_b_titan",
	"launch_o_titan",
	"launch_i_titan",
	"titan_aa",
	"titan_at",
	"titan_ap",
	"vorona_he",
	"vorona_heat"
];

_free_items = [
	"rnd_",
	"firstaidkit",
	"smokeshell",
	"grenade",
	"charge_remote_mag",
	"Laserbatteries",
	"chemlight"
];

_fn_isfree = {
	params ["_item"];
	_ret = false;
	{
		if (tolower (_item) find _x >= 0) exitWith {_ret = true};
	} forEach _free_items;
	_ret;
};

_fn_isexpensive = {
	params ["_item"];
	_ret = false;
	{
		if (tolower (_item) find _x >= 0) exitWith {_ret = true};
	} forEach _expensive_items;
	_ret;
};

_val = 0;

if (_unit isKindOf "Man") then {
	if (count(handgunWeapon _unit) > 0 ) then {_val = _val + 6};
	if (count(primaryWeapon _unit) > 0 ) then {
		if ([primaryWeapon _unit] call _fn_isexpensive) then {_val = _val + 28} else {_val = _val + 15};
		// Weapon items (scope,pointer,..)
		_weap_items = ([weaponsItems _unit, {(_x select 0) == (primaryWeapon _unit)}] call BIS_fnc_conditionalSelect) select 0;
		_weap_items deleteAt 0;
		_weap_items deleteAt 3;
		_val = _val + (3 * count ([_weap_items, {count _x > 1}] call BIS_fnc_conditionalSelect));
	};
	if (count(secondaryWeapon _unit) > 0 ) then {
		if ([secondaryWeapon _unit] call _fn_isexpensive) then {_val = _val + 55} else {_val = _val + 32};
	};

	{
		_item = _x;
		_isfree = [_item] call _fn_isfree;

		if (!_isfree) then {
			_isexpensive = [_item] call _fn_isexpensive;
			if (_isexpensive) then {_val = _val + 14} else {_val = _val + 5};
		};
	} forEach (backpackItems _unit + vestItems _unit + uniformItems _unit) + (secondaryWeaponMagazine _unit) select 0;

	{
		if (_x != "") then {_val = _val + 5};
	} forEach [headgear _unit, hmd _unit, binocular _unit, vest _unit, uniform _unit, backpack _unit];

	// Player items (map,compass,..)
	_val = _val + (2 * count(assignedItems _unit));
};

if (_unit iskindof "LandVehicle") then {
	_weap_cargo = weaponCargo _unit;
	if (count _weap_cargo > 0) then {
		{
			_item = _x;
			_isfree = [_item] call _fn_isfree;

			if (!_isfree) then {
				_isexpensive = [_item] call _fn_isexpensive;

				if (_item isKindOf ["Pistol", configFile >> "CfgWeapons"]) then {
					_val = _val + 6;
				};
				if (_item isKindOf ["Rifle", configFile >> "CfgWeapons"]) then {
					if (_isexpensive) then {_val = _val + 28} else {_val = _val + 15};
				};
				if (_item isKindOf ["Launcher", configFile >> "CfgWeapons"]) then {
					if (_isexpensive) then {_val = _val + 55} else {_val = _val + 32};
				};
			};
		} forEach _weap_cargo;
	};

	_item_cargo = itemCargo _unit;
	if (count _item_cargo > 0) then {
		{
			_item = _x;
			_isfree = [_item] call _fn_isfree;

			if (!_isfree) then {
				_isexpensive = [_item] call _fn_isexpensive;
				if (_isexpensive) then {_val = _val + 14} else {_val = _val + 3};
			};
		} forEach _item_cargo;
	};
};
_val;