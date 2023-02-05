private [ "_nextgroup", "_marker" ];
private _hostile_markers = [];
private _hostile_groups = [];

if (GRLIB_fancy_info == 0) exitWith {};

waitUntil {sleep 1; !isNil "GRLIB_init_server"};
waitUntil {sleep 1;	!isNil "west_sectors" && !isNil "east_sectors"};

while { true } do {
	{ deleteMarkerLocal _x } foreach _hostile_markers;
	_hostile_markers = [];
	_hostile_groups = [];

	{
		private [ "_nextgroup" ];
		_nextgroup = _x;
		if ( (side _nextgroup == GRLIB_side_enemy) && (({ !captive _x } count ( units _nextgroup ) ) > 0)) then {
			if ( [(getpos leader _nextgroup), GRLIB_side_friendly, GRLIB_radiotower_size] call F_getNearestTower != "" ) then {
				_hostile_groups pushback _nextgroup;
			};
		};
	} foreach allGroups;

	{
		_marker = createMarkerLocal [format ["hostilegroup%1",_x], markers_reset];
		_marker setMarkerColorLocal GRLIB_color_enemy_bright;
		_marker setMarkerTypeLocal "mil_warning";
		_marker setMarkerSizeLocal [ 0.65, 0.65 ];
		_marker setMarkerPosLocal ( [ getpos (leader _x), floor(random 50), floor(random 360) ] call BIS_fnc_relPos );
		_hostile_markers pushback _marker;
	} foreach _hostile_groups;

	sleep (60 + floor(random 60));
};