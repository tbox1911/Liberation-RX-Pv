createDialog "liberation_admin";
waitUntil { dialog };
disableSerialization;
do_unban = 0;
do_score = 0;
do_spawn = 0;
do_ammo = 0;
do_change = 0;

private _getBannedUID = {
	params ["_ban_combo"];
	lbClear _ban_combo;
	{
		private _r1 = BTC_logic getVariable [_x, 0];
		if (typeName _r1 == "SCALAR") then {
			if (_r1 > 0) then { _ban_combo lbAdd format["%1", _x] };
		};
	} foreach allVariables BTC_logic;
};

private _color_west = getArray (configFile >> "CfgMarkerColors" >> GRLIB_color_west >> "color") call BIS_fnc_colorConfigToRGBA;
private _color_east = getArray (configFile >> "CfgMarkerColors" >> GRLIB_color_east >> "color") call BIS_fnc_colorConfigToRGBA;
private _display = findDisplay 5204;

// GodMode ?
if (!isDamageAllowed player) then {
	(_display displayCtrl 1607) ctrlSetChecked true;
} else {
	(_display displayCtrl 1607) ctrlSetChecked false;
};

// Teleport on map
player onMapSingleClick "if (_alt) then {player setPosATL _pos}";

// Clear listbox
_ban_combo = _display displayCtrl 1611;
lbClear _ban_combo;
_score_combo = _display displayCtrl 1612;
lbClear _score_combo;
_build_combo = _display displayCtrl 1614;
lbClear _build_combo;

(_display displayCtrl 1603) ctrlSetText getMissionPath "res\ui_confirm.paa";
(_display displayCtrl 1603) ctrlSetToolTip "Add 200 XP Score";
(_display displayCtrl 1615) ctrlSetText getMissionPath "res\ui_arsenal.paa";
(_display displayCtrl 1615) ctrlSetToolTip "Add 300 Ammo";
(_display displayCtrl 1616) ctrlSetText getMissionPath "res\ui_rotation.paa";
(_display displayCtrl 1616) ctrlSetToolTip "Change Player Side";

// Build Banned
[_ban_combo] call _getBannedUID;

// Build Players list
_i = 0;
{
	_score_combo lbAdd format["%1", name _x];
	_uid = getPlayerUID _x;
	_score_combo lbSetData [_i, _uid];
	_side = [_uid] call F_getPlayerSide;
	_color = _color_west;
	if (_side == GRLIB_side_east) then {_color = _color_east};
	_score_combo lbSetColor [_i, _color];
	_i = _i + 1;
} foreach AllPlayers;

{
	_score_combo lbAdd format["%1", _x select 3];
	_uid = _x  select 0;
	_score_combo lbSetData [_i, _uid];
	_side = _x select 4;
	_color = _color_west;
	if (_side == GRLIB_side_east) then {_color = _color_east};
	_score_combo lbSetColor [_i, _color];
	_i = _i + 1;
} foreach GRLIB_player_scores;

// Build Vehicles list
_i = 0;
{
	_build_combo lbAdd format["%1", getText(configFile >> "cfgVehicles" >> ( _x select 0 ) >> "DisplayName")];
	_build_combo lbSetData [_i, ( _x select 0 )];
	_i = _i + 1;
} forEach light_vehicles_west + heavy_vehicles_west + air_vehicles_west + static_vehicles_west + support_vehicles_west +
		  light_vehicles_east + heavy_vehicles_east + air_vehicles_east + static_vehicles_east + support_vehicles_east + opfor_recyclable;

_ban_combo lbSetCurSel 0;
_score_combo lbSetCurSel 0;
_build_combo lbSetCurSel 0;

while { alive player && dialog } do {
	if (do_unban == 1) then {
		do_unban = 0;
		_dst_id = _ban_combo lbText (lbCurSel _ban_combo);
		if (_dst_id != "") then {
			BTC_logic setVariable [_dst_id, 0, true];
			hint format ["Unban player UID: %1", _dst_id];
			lbClear _ban_combo;
			[_ban_combo] call _getBannedUID;
		};
	};

	if (do_score == 1) then {
		do_score = 0;
		_name = _score_combo lbText (lbCurSel _score_combo);
		_uid = _score_combo lbData (lbCurSel _score_combo);
		[_uid, 200] remoteExec ["F_addPlayerScore", 2];
		_msg = format ["Add 200 XP to player: %1.", _name];
		hint _msg;
		systemchat _msg;
		sleep 1;
	};

	if (do_spawn == 1) then {
		do_spawn = 0;
		_veh_text = _build_combo lbText (lbCurSel _build_combo);
		_veh_class = _build_combo lbData (lbCurSel _build_combo);
		_msg = format ["Build Vehicle: %1", _veh_text];
		hint _msg;
		systemchat _msg;
		buildtype = 9;
		build_unit = [_veh_class,[],1,[],[]];
		dobuild = 1;
		closeDialog 0;
	};

	if (do_ammo == 1) then {
		do_ammo = 0;
		_name = _score_combo lbText (lbCurSel _score_combo);
		_uid = _score_combo lbData (lbCurSel _score_combo);
		[_uid, 300] remoteExec ["F_addPlayerAmmo", 2];
		_msg = format ["Add 300 Ammo to player: %1.", _name];
		hint _msg;
		systemchat _msg;
		sleep 1;
	};

	if (do_change == 1) then {
		do_change = 0;
		_name = _score_combo lbText (lbCurSel _score_combo);
		_uid = _score_combo lbData (lbCurSel _score_combo);
		_side = [_uid] call F_getPlayerSide;
		if (_side == GRLIB_side_east) then {_side = GRLIB_side_west} else {_side = GRLIB_side_east};
		[_uid, _side] remoteExec ["F_setPlayerSide", 2];
		_msg = format ["Side changed for player: %1.\nPlayer must reconnect to take effect.", _name];
		hint _msg;
		systemchat _msg;
		sleep 1;
	};

	sleep 0.5;
};
closeDialog 0;
hintSilent "";