private [ "_dialog" ];

if ( isNil "cinematic_camera_started" ) then { cinematic_camera_started = false };
if (isMultiplayer) then {
	waituntil {(time > 2) && (getClientStateNumber >= 10) && (getClientState == "BRIEFING READ")};
} else {
	GRLIB_introduction = true;
};

[] spawn cinematic_camera;
uiSleep 1;

if (serverName == "DevSrv") then {
	GRLIB_introduction = false;
};
GRLIB_introduction = false;

if ( GRLIB_introduction ) then {
	uisleep 2;
	cutRsc ["intro1","PLAIN",1,true];
	uisleep 2.5;
	cutRsc ["intro11","PLAIN",1,true];
	uisleep 2.5;
	cutRsc ["intro12","PLAIN",1,true];
	uisleep 2.5;
	cutRsc ["intro2","PLAIN",1,true];
	uisleep 8.5;
};

while {	(player getVariable ["GRLIB_score_set", 0] == 0) } do {
	_msg= "... Loading Player Data ...";
    [_msg, 0, 0, 5, 0, 0, 90] spawn BIS_fnc_dynamicText;
	uIsleep 2;
	_msg= "... Please Wait ...";
    [_msg, 0, 0, 5, 0, 0, 90] spawn BIS_fnc_dynamicText;
	uIsleep 2;
};

if (! ((getPlayerUID player) in GRLIB_whitelisted_steamids)) then {
	if ((player getvariable ["GREUH_pvp_side", sideUnknown]) != GRLIB_side_friendly) exitWith {
		titleText ["Wrong side selected...","BLACK FADED", 1000];
		sleep 5;
		endMission "LOSER";
	};
};

showcaminfo = true;
dostartgame = 0;
howtoplay = 0;

_dialog = createDialog "liberation_menu";
_noesckey = (findDisplay 5651) displayAddEventHandler ["KeyDown", "if ((_this select 1) == 1) then { true }"];
waitUntil { dialog };
disableUserInput false;
disableUserInput true;
disableUserInput false;

waitUntil { dostartgame == 1 || howtoplay == 1 };
disableUserInput true;
(findDisplay 5651) displayRemoveEventHandler ["KeyDown", _noesckey];
closeDialog 0;

if ( howtoplay == 1 ) then {
	[] call compileFinal preprocessFileLineNUmbers "scripts\client\ui\tutorial_manager.sqf";
	dostartgame = 1;
};
