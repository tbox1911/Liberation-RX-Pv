waitUntil {sleep 1; !isNil "save_is_loaded" };

please_recalculate = true;

while { true } do {
		waitUntil {sleep 1; please_recalculate };
		please_recalculate = false;

		[] call recalculate_caps;

		// WEST
		_new_manpower_used = 0;
		_new_fuel_used = 0;

		{
			if ( ( side group _x == GRLIB_side_west ) && ( !isPlayer _x ) ) then {
				if ( ( _x distance lhd_west ) > GRLIB_sector_size && ( alive _x ) ) then {
					_unit = _x;
					{
						if ( ( _x select 0 ) == typeof _unit ) then {
							_new_manpower_used = _new_manpower_used + (_x select 1);
							_new_fuel_used = _new_fuel_used + (_x select 3);
						};
					} foreach infantry_units_west;
				};
			};
		} foreach allUnits;

		{
			if (
				(([_x getVariable ["GRLIB_vehicle_owner", ""]] call F_getPlayerSide) == GRLIB_side_west) &&
				(_x distance lhd_west > GRLIB_sector_size) &&
				!(_x getVariable ['R3F_LOG_disabled', false]) &&
				isNull (_x getVariable ["R3F_LOG_est_transporte_par", objNull]) &&
				(alive _x)
				) then {
		  		_unit = _x;
				{
					if ( (_x select 0) == typeof _unit ) then {
						_new_manpower_used = _new_manpower_used + (_x select 1);
						_new_fuel_used = _new_fuel_used + (_x select 3);
					};
				} foreach ( light_vehicles_west + heavy_vehicles_west + air_vehicles_west + static_vehicles_west + support_vehicles_west + opfor_recyclable );
			};
		} foreach vehicles + GRLIB_mobile_respawn_west;

		resources_infantry_west = _new_manpower_used;
		resources_fuel_west = _new_fuel_used;


		// EAST
		_new_manpower_used = 0;
		_new_fuel_used = 0;

		{
			if ( ( side group _x == GRLIB_side_east ) && ( !isPlayer _x ) ) then {
				if ( ( _x distance lhd_east ) > GRLIB_sector_size && ( alive _x ) ) then {
					_unit = _x;
					{
						if ( ( _x select 0 ) == typeof _unit ) then {
							_new_manpower_used = _new_manpower_used + (_x select 1);
							_new_fuel_used = _new_fuel_used + (_x select 3);
						};
					} foreach infantry_units_east;
				};
			};
		} foreach allUnits;

		{
			if (
				(([_x getVariable ["GRLIB_vehicle_owner", ""]] call F_getPlayerSide) == GRLIB_side_east) &&
				(_x distance lhd_east > GRLIB_sector_size) &&
				!(_x getVariable ['R3F_LOG_disabled', false]) &&
				isNull (_x getVariable ["R3F_LOG_est_transporte_par", objNull]) &&
				(alive _x)
				) then {
		  		_unit = _x;
				{
					if ( (_x select 0) == typeof _unit ) then {
						_new_manpower_used = _new_manpower_used + (_x select 1);
						_new_fuel_used = _new_fuel_used + (_x select 3);
					};
				} foreach ( light_vehicles_east + heavy_vehicles_east + air_vehicles_east + static_vehicles_east + support_vehicles_east + opfor_recyclable );
			};
		} foreach vehicles + GRLIB_mobile_respawn_east;

		resources_infantry_east = _new_manpower_used;
		resources_fuel_east = _new_fuel_used;		
};