base_infantry_cap = 50 * GRLIB_resources_multiplier;
base_fuel_cap = 20 * GRLIB_resources_multiplier;

infantry_cap_west = base_infantry_cap;
fuel_cap_west = base_fuel_cap;

{
	if ( _x in sectors_capture ) then {
		infantry_cap_west = infantry_cap_west + (10 * GRLIB_resources_multiplier);
	};
	if ( _x in sectors_factory ) then {
		fuel_cap_west = fuel_cap_west + (20 * GRLIB_resources_multiplier);
	};
} foreach west_sectors;

infantry_cap_east = base_infantry_cap;
fuel_cap_east = base_fuel_cap;
{
	if ( _x in sectors_capture ) then {
		infantry_cap_east = infantry_cap_east + (10 * GRLIB_resources_multiplier);
	};
	if ( _x in sectors_factory ) then {
		fuel_cap_east = fuel_cap_east + (20 * GRLIB_resources_multiplier);
	};
} foreach east_sectors;