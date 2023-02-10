params [ "_sector", "_status", "_side", ["_sector_timer", 0] ];

if (isDedicated || (!hasInterface && !isServer)) exitWith {};

sector_timer = _sector_timer;
if ( _status == 0 ) then {
	if (GRLIB_side_friendly == _side) then {
		private _lst_player = "Thanks to: - ";
		{
			if (_x distance2D (markerpos _sector) < GRLIB_sector_size && side group _x == _side) then {
				_lst_player = _lst_player + name _x + " - ";
			};
		} forEach allPlayers;
		[ "lib_sector_captured_info", [ _lst_player ], 3 ] call BIS_fnc_showNotification;
		[ "lib_sector_captured", [ markerText _sector ], 7 ] call BIS_fnc_showNotification;
	};
	"opfor_capture_marker" setMarkerPosLocal markers_reset;
};

if ( _status == 1 ) then {
	if (GRLIB_side_friendly == _side) then {
		[ "lib_sector_attacked", [ markerText _sector ] ] call BIS_fnc_showNotification;
	};
	"opfor_capture_marker" setMarkerPosLocal ( markerpos _sector );
};

if ( _status == 2 ) then {
	if (GRLIB_side_friendly == _side) then {
		[ "lib_sector_lost", [ markerText _sector ] ] call BIS_fnc_showNotification;
	};
	"opfor_capture_marker" setMarkerPosLocal markers_reset;
};

if ( _status == 3 ) then {
	[ "lib_sector_safe", [ markerText _sector ] ] call BIS_fnc_showNotification;
	"opfor_capture_marker" setMarkerPosLocal markers_reset;
};

{ _x setMarkerColorLocal GRLIB_color_enemy; } foreach (sectors_allSectors - west_sectors - east_sectors);
{ _x setMarkerColorLocal GRLIB_color_friendly; } foreach ([] call get_mySectors);