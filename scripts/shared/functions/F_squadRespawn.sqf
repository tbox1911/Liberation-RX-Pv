private [ "_member_to_respawn" ];

_member_to_respawn = objNull;

{
	if ( isnull _member_to_respawn && !isPlayer _x && alive _x && (_x distance lhd_west) > GRLIB_sector_size && (_x distance lhd_east) > GRLIB_sector_size && !(surfaceIsWater (getpos _x)) )then {
		_member_to_respawn = _x;
	}
} foreach (units (group player));

_member_to_respawn
