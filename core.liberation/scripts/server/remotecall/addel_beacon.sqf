if (!isServer && hasInterface) exitWith {};
params ["_beacon", "_action", "_side"];

if (isNil "_beacon") exitWith {};

private _beacon_source = GRLIB_mobile_respawn_east;
if (_side == GRLIB_side_west) then {
	_beacon_source = GRLIB_mobile_respawn_west;
};

private _tmp_global_locked_beacon = [];
{
	if (!isNil "_x") then {
		if (!isNull _x && alive _x ) then {
			_tmp_global_locked_beacon pushBack _x;
		};
	};
} foreach _beacon_source;

if (_side == GRLIB_side_west) then {
	switch (_action) do {
		case "add" : {GRLIB_mobile_respawn_west = _tmp_global_locked_beacon + [_beacon]};
		case "del" : {GRLIB_mobile_respawn_west = _tmp_global_locked_beacon - [_beacon]; deleteVehicle _beacon };
		default {GRLIB_mobile_respawn_west = _tmp_global_locked_beacon};
	};
	publicVariable "GRLIB_mobile_respawn_west";
};

if (_side == GRLIB_side_east) then {
	switch (_action) do {
		case "add" : {GRLIB_mobile_respawn_east = _tmp_global_locked_beacon + [_beacon]};
		case "del" : {GRLIB_mobile_respawn_east = _tmp_global_locked_beacon - [_beacon]; deleteVehicle _beacon };
		default {GRLIB_mobile_respawn_east = _tmp_global_locked_beacon};
	};
	publicVariable "GRLIB_mobile_respawn_east";
};

if (_side == sideUnknown) then {
	switch (_action) do {
		//case "add" : {GRLIB_mobile_respawn_east = _tmp_global_locked_beacon + [_beacon]};
		case "del" : {
			GRLIB_mobile_respawn_west = _tmp_global_locked_beacon - [_beacon];
			GRLIB_mobile_respawn_east = _tmp_global_locked_beacon - [_beacon];
			deleteVehicle _beacon;
		};
	};
	publicVariable "GRLIB_mobile_respawn_west";	
	publicVariable "GRLIB_mobile_respawn_east";
};