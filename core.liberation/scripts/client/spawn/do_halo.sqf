private [ "_backpack", "_backpackcontents" ];

if ( isNil "GRLIB_last_halo_jump" ) then { GRLIB_last_halo_jump = -6000; };

if ( GRLIB_halo_param > 1 && ( GRLIB_last_halo_jump + ( GRLIB_halo_param * 60 ) ) >= time ) exitWith {
	hint format [ localize "STR_HALO_DENIED_COOLDOWN", ceil ( ( ( GRLIB_last_halo_jump + ( GRLIB_halo_param * 60 ) ) - time ) / 60 ) ];
};

createDialog "liberation_halo";
dojump = 0;
halo_position = getpos player;

_backpackcontents = [];

[ "halo_map_event", "onMapSingleClick", { halo_position = _pos } ] call BIS_fnc_addStackedEventHandler;

"spawn_marker" setMarkerTextLocal (localize "STR_HALO_PARAM");

waitUntil { dialog };
while { dialog && alive player && dojump == 0 } do {
	"spawn_marker" setMarkerPosLocal halo_position;
	sleep 0.1;
};

if ( dialog ) then {
	closeDialog 0;
	sleep 0.1;
};

"spawn_marker" setMarkerPosLocal markers_reset;
"spawn_marker" setMarkerTextLocal "";

[ "halo_map_event", "onMapSingleClick" ] call BIS_fnc_removeStackedEventHandler;

private _nearset_sector = [ GRLIB_sector_size * 2, halo_position] call F_getNearestSector;
private _denied_sectors = west_sectors;
private _denied_fobs = GRLIB_fobs_west;
private _denied_lhd = lhd_west;
if (GRLIB_side_friendly == GRLIB_side_west) then {
	_denied_sectors = east_sectors;
	_denied_fobs = GRLIB_fobs_east;
	_denied_lhd = lhd_east;
};

private _nearset_fob = [0,0,0];
if ( count _denied_fobs > 0 ) then {
	_nearset_fob = ( [ _denied_fobs , [] , { halo_position distance2D _x } , 'ASCEND' ] call BIS_fnc_sortBy ) select 0;
};

if ( _nearset_sector in _denied_sectors || 
     halo_position distance2D _nearset_fob < GRLIB_sector_size * 2 ||
	 halo_position distance2D _denied_lhd < GRLIB_sector_size * 2 
	) then {
	dojump = 0;
	hintSilent "You cannot Halo jump on this position!";
};

if ( dojump > 0 ) then {
	GRLIB_last_halo_jump = time;

	halojumping = true;
	cutRsc ["fasttravel", "PLAIN", 1];
	playSound "parasound";
	[player, "hide"] remoteExec ["dog_action_remote_call", 2];
	sleep 2;
	halo_position = [ halo_position, floor(random 250), floor(random 360) ] call BIS_fnc_relPos;
	halo_position = [ halo_position select 0, halo_position select 1, GRLIB_halo_altitude + floor(random 200) ];
	_player_pos = getPos player;
	_UnitList = units group player;
	_my_squad = player getVariable ["my_squad", nil];
	if (!isNil "_my_squad") then {
		{ _UnitList pushBack _x } forEach units _my_squad;
	};
	{
		if ( round (_x distance2D _player_pos) <= 30 && lifestate _x != 'INCAPACITATED' && vehicle _x == _x ) then {
			[_x,  halo_position] spawn paraDrop;
			sleep (1 + floor(random 3));
		};
	} forEach _UnitList;
};
