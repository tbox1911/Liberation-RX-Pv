params ["_obj"];

private _side = GRLIB_side_civilian;
private _nearset_sector = [ GRLIB_sector_size, getPos _obj ] call F_getNearestSector;

if ( _nearset_sector in (sectors_allSectors - west_sectors - east_sectors)) then {_side = GRLIB_side_enemy};
if ( _nearset_sector in west_sectors) then {_side = GRLIB_side_west};
if ( _nearset_sector in east_sectors) then {_side = GRLIB_side_east};

_side;