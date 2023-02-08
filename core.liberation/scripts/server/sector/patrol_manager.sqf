params [ "_sector", "_patrol_type", "_side" ];
if (_sector in active_sectors) exitWith {};
private _grp = grpNull;
private _vehicle = objNull;
private _duration = 15 * 60;

// Create Infantry
if (_patrol_type == 1) then {
    _grp = [markerpos _sector, ([] call F_getAdaptiveSquadComp), _side, "infantry"] call F_libSpawnUnits;
    [_grp, markerpos _sector, 150] spawn add_defense_waypoints;
    diag_log format [ "Spawn Infantry Patrol on sector %1 at %2", _sector, time ];
};

// Create Armored
if (_patrol_type == 2) then {
    _vehicle = [ markerpos _sector, [_side] call F_getAdaptiveVehicle ] call F_libSpawnVehicle;
    _grp = group ((crew _vehicle) select 0);
    [_grp, markerpos _sector, 250] spawn add_defense_waypoints;
    diag_log format [ "Spawn Armored Patrol on sector %1 at %2", _sector, time ];
};

if ( local _grp ) then {
    _headless_client = [] call F_lessLoadedHC;
    if ( !isNull _headless_client ) then {
        _grp setGroupOwner ( owner _headless_client );
    };
};

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
