unitcap_west = 0;
unitcap_east = 0;

while { true } do {

	_local_unitcap_west = 0;
	_local_unitcap_east = 0;

	{
		// WEST
		if ( (side group _x == GRLIB_side_west) && (alive _x) && (_x distance lhd_west) > GRLIB_sector_size ) then {
			_local_unitcap_west = _local_unitcap_west + 1;
		};

		// EAST
		if ( (side group _x == GRLIB_side_east) && (alive _x) && (_x distance lhd_east) > GRLIB_sector_size ) then {
			_local_unitcap_east = _local_unitcap_east + 1;
		};
	} foreach allUnits;
	
	unitcap_west = _local_unitcap_west;
	unitcap_east = _local_unitcap_east;
	sleep 2;
};