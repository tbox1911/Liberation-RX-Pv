params [ "_postosearch", "_side", "_limit" ];

private _sector_to_return = '';
private _sectors_to_search = [];
if ( _side == GRLIB_side_enemy ) then {
	_sectors_to_search = (sectors_tower - west_sectors - east_sectors);
};
if ( _side == GRLIB_side_west ) then {
	_sectors_to_search = [ west_sectors , { _x in sectors_tower } ] call BIS_fnc_conditionalSelect;
};
if ( _side == GRLIB_side_east ) then {
	_sectors_to_search = [ east_sectors , { _x in sectors_tower } ] call BIS_fnc_conditionalSelect;
};
_sectors_to_search = [ _sectors_to_search , { (markerPos _x) distance _postosearch < _limit } ] call BIS_fnc_conditionalSelect;

private _sectors_to_search_sorted = [ _sectors_to_search , [_postosearch] , { (markerPos _x) distance _input0 } , 'ASCEND' ] call BIS_fnc_sortBy;
if ( count _sectors_to_search_sorted > 0 ) then { _sector_to_return = _sectors_to_search_sorted select 0; } else { _sector_to_return = '' };

_sector_to_return;
