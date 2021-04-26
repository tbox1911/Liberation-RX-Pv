params [ [ "_source_position", (getpos player) ] ];

private _retvalue = [0,0,0];
private _allFob = GRLIB_fobs_west + GRLIB_fobs_east;
if ( count _allFob > 0 ) then {
	_retvalue = ( [ _allFob , [] , { _source_position distance2D _x } , 'ASCEND' ] call BIS_fnc_sortBy ) select 0;
};

_retvalue;
