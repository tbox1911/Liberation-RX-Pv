params [ [ "_source_position", (getpos player) ] ];
private [ "_retvalue" ];

_retvalue = [0,0,0];
if ( count GRLIB_fobs_west > 0 ) then {
	_retvalue = ( [ GRLIB_fobs_west , [] , { _source_position distance2D _x } , 'ASCEND' ] call BIS_fnc_sortBy ) select 0;
};

_retvalue
