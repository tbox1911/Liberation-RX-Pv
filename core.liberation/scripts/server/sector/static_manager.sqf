params [ "_sector", "_number" ];
if (_sector in active_sectors) exitWith {};
if (_number == 0) exitWith {};
if (_number >= 1) then {
	[ _sector, _number - 1 ] spawn static_manager;
};

private _duration = 15 * 60;

// Create
private _grp = createGroup [GRLIB_side_enemy, true];
private _spawn_pos = [ getMarkerPos _sector, floor(random 50), random 360 ] call BIS_fnc_relPos;
private _vehicle = [ _spawn_pos, selectRandom opfor_statics ] call F_libSpawnVehicle;

_vehicle setVariable ["GRLIB_counter_TTL", round(time + 900)];
opfor_spotter createUnit [ getposATL _vehicle, _grp, 'this addMPEventHandler ["MPKilled", {_this spawn kill_manager}]', 0.5, "PRIVATE"];
opfor_spotter createUnit [ getposATL _vehicle, _grp, 'this addMPEventHandler ["MPKilled", {_this spawn kill_manager}]', 0.5, "PRIVATE"];
(crew _vehicle) joinSilent _grp;
_vehicle setVariable ["GRLIB_vehicle_gunner", units _grp];

diag_log format [ "Spawn Static Patrol on sector %1 at %2", _sector, time ];
if ( local _grp ) then {
    _headless_client = [] call F_lessLoadedHC;
    if ( !isNull _headless_client ) then {
        _grp setGroupOwner ( owner _headless_client );
    };
};

// AI (managed by manage_static.sqf)

// Wait
private _timeout = round (time + _duration);
while { count (units _grp) > 0 && time < _timeout } do {
    sleep 60;
};

// Cleanup
private _west_units = [markerpos _sector, GRLIB_sector_size, GRLIB_side_west] call F_getUnitsCount;
private _east_units = [markerpos _sector, GRLIB_sector_size, GRLIB_side_east] call F_getUnitsCount;
if ( _west_units == 0 && _east_units == 0 ) then {
    { deleteVehicle _x } foreach (units _grp);
    deleteGroup _grp;
    deleteVehicle _vehicle;
};
