unitcap = 0;

while { true } do {
	_local_unitcap = 0;
	{
		//|| (isPlayer _x)
		if ( (side group _x == GRLIB_side_west || side group _x == GRLIB_side_east) && (alive _x) && (_x distance lhd_west) > GRLIB_sector_size && (_x distance lhd_east) > GRLIB_sector_size ) then {
			_local_unitcap = _local_unitcap + 1;
		};
	} foreach allUnits;
	unitcap = _local_unitcap;
	sleep 2;
};