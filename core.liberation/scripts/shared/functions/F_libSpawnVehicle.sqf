params [
	"_sectorpos",
	"_classname",
	[ "_precise_position", false ],
	[ "_random_rotate", false ],
	[ "_civilian", false]
];

diag_log format [ "Spawn vehicle %1 at %2", _classname , time ];

private _vehicle = objNull;
private _spawnpos = [];
private _vehcrew = [];
private _airveh_alt = 350;
private _radius = GRLIB_capture_size;
private _max_try = 10;

if ( _precise_position ) then {
	_spawnpos = _sectorpos;
} else {
	while { count _spawnpos == 0 && _max_try > 0 } do {
		_spawnpos = [4, _sectorpos, _radius, 30, true] call R3F_LOG_FNCT_3D_tirer_position_degagee_sol;
		_radius = _radius + 20;
		_max_try = _max_try -1;
		sleep 0.5;
	};
};

if ( count _spawnpos == 0 ) then {
	_spawnpos = _sectorpos findEmptyPosition [0, _radius, _classname];
};

if ( count _spawnpos == 0 ) exitWith { diag_log format ["--- LRX Error: No place to build vehicle %1 at position %2", _classname, _sectorpos]; objNull };

if ( _classname isKindOf "Air" ) then {
	if ( _civilian ) then { _airveh_alt = 200 };
	_spawnpos set [2, _airveh_alt];
	_vehicle = createVehicle [_classname, _spawnpos, [], 0, "FLY"];
} else {
	_spawnpos set [2, 0.5];
	if (surfaceIsWater _spawnpos && !(_classname isKindOf "Ship")) then {
		if ( _civilian ) then {
			_classname = selectRandom boats_names_civ;
		} else {
			_classname = selectRandom opfor_boats;
		};
	};
	_vehicle = createVehicle [_classname, _spawnpos, [], 0, "NONE"];
};
waitUntil {!isNull _vehicle};
_vehicle allowDamage false;

if ( _vehicle isKindOf "Air" ) then {
	_vehicle engineOn true;
	_vehicle flyInHeight _airveh_alt;
};

if ( _random_rotate ) then {
	_vehicle setdir (random 360);
};

if ( _vehicle isKindOf "LandVehicle" ) then {
	sleep 1;
	if ((vectorUp _vehicle) select 2 < 0.70 || (getPosATL _vehicle) select 2 < 0) then {
		_vehicle setpos [(getPosATL _vehicle) select 0, (getPosATL _vehicle) select 1, 0.5];
		_vehicle setVectorUp surfaceNormal position _vehicle;
	};
};

if ( !_civilian ) then {
	if ( _classname in militia_vehicles ) then {
		[ _vehicle ] call F_libSpawnMilitiaCrew;
	} else {
		[ _vehicle ] call F_forceOpforCrew;
	};

	_vehcrew = crew _vehicle;
	{ _x allowDamage false } forEach _vehcrew;

	// A3 textures
	if ( _classname in ["I_E_Truck_02_MRL_F"] ) then {
		[_vehicle, ["Opfor",1], true ] call BIS_fnc_initVehicle;
	};

	// CUP remove tank panel
	if (GRLIB_CUPV_enabled && _classname isKindOf "Tank") then {
		[_vehicle, false, ["hide_front_ti_panels",1,"hide_cip_panel_rear",1,"hide_cip_panel_bustle",1]] call BIS_fnc_initVehicle;
	};

	// LRX textures
	if (count opfor_texture_overide > 0) then {
		_texture_name = selectRandom opfor_texture_overide;
		_texture = [ RPT_colorList, { _x select 0 == _texture_name } ] call BIS_fnc_conditionalSelect select 0 select 1;
		[_vehicle, _texture, _texture_name] call RPT_fnc_TextureVehicle;
	};

	[_vehicle, _vehcrew] spawn {
		params ["_veh", "_crew"];
		sleep 5;
		_veh setDamage 0;
		_veh allowDamage true;
		{ _x setDamage 0; _x allowDamage true } forEach _crew;
	};
};

_vehicle addMPEventHandler ['MPKilled', {_this spawn kill_manager}];
_vehicle allowCrewInImmobile [true, false];
_vehicle setUnloadInCombat [true, false];

clearWeaponCargoGlobal _vehicle;
clearMagazineCargoGlobal _vehicle;
clearItemCargoGlobal _vehicle;
clearBackpackCargoGlobal _vehicle;

if ( _civilian ) then { _vehicle allowDamage true };

diag_log format [ "Done Spawning vehicle %1 at %2", _classname , time ];

_vehicle;
