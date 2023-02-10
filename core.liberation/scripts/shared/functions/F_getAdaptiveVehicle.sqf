params [["_side", GRLIB_side_enemy]];
private _vehicle_pool = [];

if (_side == GRLIB_side_enemy) then {
	_vehicle_pool = opfor_vehicles;
	if ( combat_readiness < 35 ) then {
		_vehicle_pool = opfor_vehicles_low_intensity;
	};
};

if (_side == GRLIB_side_west) then {
	{_vehicle_pool pushBack (_x select 0)} foreach heavy_vehicles_west;
};

if (_side == GRLIB_side_east) then {
	{_vehicle_pool pushBack (_x select 0)} foreach heavy_vehicles_east;
};

(selectRandom (_vehicle_pool select {!(_x isKindOf "Truck_F")}));
