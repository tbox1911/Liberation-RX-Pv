params [ [ "_source_position", (getpos player) ] ];

private _retvalue = [0,0,0];
private _enemyFOB = GRLIB_fobs_west;

if (GRLIB_side_friendly == west) then {
	_enemyFOB = GRLIB_fobs_east;
};

if ( count _enemyFOB > 0 ) then {
	_retvalue = ( [ _enemyFOB , [] , { _source_position distance2D _x } , 'ASCEND' ] call BIS_fnc_sortBy ) select 0;
};

_retvalue
