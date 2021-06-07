if ( isDedicated ) exitWith {};
params [ "_fob", "_status", "_side" ];

if (GRLIB_side_friendly != _side)  exitWith {};
if ( isNil "sector_timer" ) then { sector_timer = 0 };

private _fobname = [ _fob ] call F_getFobName;

if ( _status == 0 ) then {
	[ "lib_fob_built", [ _fobname ] ] call BIS_fnc_showNotification;
};

if ( _status == 1 ) then {
	[ "lib_fob_attacked", [ _fobname ] ] call BIS_fnc_showNotification;
	"opfor_capture_marker" setMarkerPosLocal _fob;
	sector_timer = (GRLIB_vulnerability_timer + (5 * 60));
};

if ( _status == 2 ) then {
	[ "lib_fob_lost", [ _fobname ] ] call BIS_fnc_showNotification;
	"opfor_capture_marker" setMarkerPosLocal markers_reset;
	sector_timer = 0;
};

if ( _status == 3 ) then {
	[ "lib_fob_safe", [ _fobname ] ] call BIS_fnc_showNotification;
	"opfor_capture_marker" setMarkerPosLocal markers_reset;
	sector_timer = 0;
};

if ( _status == 4 ) then {
	if (player distance2D _fob > GRLIB_sector_size) then {
		[ "lib_fob_attacked", [ _fobname ] ] call BIS_fnc_showNotification;
	};
};

if ( _status == 5 ) then {
	[ "lib_sector_attacked", [ _fobname ] ] call BIS_fnc_showNotification;
	"opfor_capture_marker" setMarkerPosLocal _fob;
	sector_timer = GRLIB_vulnerability_timer;
};

if ( _status == 6 ) then {
	[ "lib_fob_destroyed", [ _fobname ] ] call BIS_fnc_showNotification;
	"opfor_capture_marker" setMarkerPosLocal markers_reset;
	sector_timer = 0;
};
