// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: missionProcessor.sqf
//	@file Author: AgentRev

if (!isServer) exitwith {};

#define MISSION_LOCATION_COOLDOWN (10*60)
#define MISSION_TIMER_EXTENSION (20*60)

private ["_controllerSuffix", "_missionTimeout", "_availableLocations", "_missionLocation", "_leader", "_marker", "_failed", "_complete", "_startTime", "_oldAiCount", "_leaderTemp", "_newAiCount", "_adjustTime", "_lastPos", "_floorHeight"];

// Variables that can be defined in the mission script :
private ["_missionType", "_locationsArray", "_aiGroup", "_missionPos", "_missionPicture", "_missionHintText", "_successHintMessage", "_failedHintMessage"];

_controllerSuffix = param [0, "", [""]];
_aiGroup = grpNull;

if (!isNil "_setupVars") then { call _setupVars };

["lib_secondary_a3w_mission", [_missionType]] remoteExec ["bis_fnc_shownotification", 0];
diag_log format ["%1 Mission%2 started: %3", MISSION_PROC_TYPE_NAME, _controllerSuffix, _missionType];

_missionTimeout = MISSION_PROC_TIMEOUT;

if (!isNil "_locationsArray") then {
	while {true} do
	{
		_availableLocations = [_locationsArray, { !(_x select 1) && diag_tickTime - (_x param [2, -1e11]) >= MISSION_LOCATION_COOLDOWN}] call BIS_fnc_conditionalSelect;

		if (count _availableLocations > 0) exitWith {};
		sleep 60;
	};

	_missionLocation = (selectRandom _availableLocations) select 0;
	[_locationsArray, _missionLocation, true] call setLocationState;
	[_locationsArray, _missionLocation, markerPos _missionLocation] call cleanLocationObjects; // doesn't matter if _missionLocation is not a marker, the function will know
};

if (!isNil "_setupObjects") then { call _setupObjects };

_leader = leader _aiGroup;
_marker = [_missionType, _missionPos] call createMissionMarker;
_aiGroup setVariable ["A3W_missionMarkerName", _marker, true];

if (isNil "_missionPicture") then { _missionPicture = "" };

[
	format ["%1 Objective", MISSION_PROC_TYPE_NAME],
	_missionType,
	_missionPicture,
	_missionHintText,
	MISSION_PROC_COLOR_DEFINE
] call missionHint;

diag_log format ["%1 Mission%2 waiting to be finished: %3", MISSION_PROC_TYPE_NAME, _controllerSuffix, _missionType];

_failed = false;
_complete = false;
_startTime = diag_tickTime;
_oldAiCount = 0;

if (isNil "_ignoreAiDeaths") then { _ignoreAiDeaths = false };

waitUntil {
	sleep 1;

	_leaderTemp = leader _aiGroup;

	// Force immediate leader change if current one is dead
	if (!alive _leaderTemp) then {
		{
			if (alive _x) exitWith {
				_aiGroup selectLeader _x;
				_leaderTemp = _x;
			};
		} forEach units _aiGroup;
	};

	_newAiCount = count units _aiGroup;

	if (_newAiCount < _oldAiCount) then {
		// some units were killed, mission expiry will be reset to 20 mins if it's currently lower than that
		_adjustTime = if (_missionTimeout < MISSION_TIMER_EXTENSION) then { MISSION_TIMER_EXTENSION - _missionTimeout } else { 0 };
		_startTime = _startTime max (diag_tickTime - ((MISSION_TIMER_EXTENSION - _adjustTime) max 0));
	};

	_oldAiCount = _newAiCount;

	if (!isNull _leaderTemp) then { _leader = _leaderTemp }; // Update current leader

	if (!isNil "_waitUntilMarkerPos") then { _marker setMarkerPos (call _waitUntilMarkerPos) };
	if (!isNil "_waitUntilExec") then { call _waitUntilExec };

	_west_units = [_missionPos, GRLIB_sector_size, GRLIB_side_west] call F_getUnitsCount;
	_east_units = [_missionPos, GRLIB_sector_size, GRLIB_side_east] call F_getUnitsCount;
	_expired = (diag_tickTime - _startTime >= _missionTimeout && _west_units == 0 && _east_units == 0);
	_failed = ((!isNil "_waitUntilCondition" && {call _waitUntilCondition}) || _expired || count allPlayers == 0);
	
	if (!isNil "_waitUntilSuccessCondition" && {call _waitUntilSuccessCondition}) then {
		_failed = false;
		_complete = true;
	};

	(GRLIB_endgame == 1 || _failed || _complete || (!_ignoreAiDeaths && {alive _x} count units _aiGroup == 0))
};

if (_failed) then {
	// Mission failed

	{ moveOut _x; deleteVehicle _x } forEach units _aiGroup;

	if (!isNil "_failedExec") then { call _failedExec };

	if (!isNil "_vehicle" && {typeName _vehicle == "OBJECT"}) then
	{
		deleteVehicle _vehicle;
	};

	if (!isNil "_vehicles" && {typeName _vehicles == "ARRAY"}) then
	{
		{
			if (!isNil "_x" && {typeName _x == "OBJECT"}) then
			{
				deleteVehicle _x;
			};
		} forEach _vehicles;
	};

	[
		"Objective Failed",
		_missionType,
		_missionPicture,
		if (!isNil "_failedHintMessage") then { _failedHintMessage } else { "Better luck next time!" },
		failMissionColor
	] call missionHint;

	["lib_secondary_a3w_mission_fail", [_missionType]] remoteExec ["bis_fnc_shownotification", 0];
	diag_log format ["%1 Mission%2 failed: %3", MISSION_PROC_TYPE_NAME, _controllerSuffix, _missionType];
}
else {
	// Mission completed

	if (isNull _leader) then {
		_lastPos = markerPos _marker;
	} else {
		_lastPos = ASLToAGL getPosASL _leader;
		_floorHeight = (getPos _leader) select 2;
		_lastPos set [2, (_lastPos select 2) - _floorHeight];
	};

	if (!isNil "_successExec") then { call _successExec };

	if (!isNil "_vehicle" && {typeName _vehicle == "OBJECT"}) then
	{
		_vehicle setVariable ["R3F_LOG_disabled", false, true];
		_vehicle setVariable ["A3W_missionVehicle", true, true];
	};

	if (!isNil "_vehicles" && {typeName _vehicles == "ARRAY"}) then
	{
		{
			if (!isNil "_x" && {typeName _x == "OBJECT"}) then
			{
				_x setVariable ["R3F_LOG_disabled", false, true];
				_x setVariable ["A3W_missionVehicle", true, true];
			};
		} forEach _vehicles;
	};

	[
		"Objective Complete",
		_missionType,
		_missionPicture,
		_successHintMessage,
		successMissionColor
	] call missionHint;

	["lib_secondary_a3w_mission_success", [_missionType]] remoteExec ["bis_fnc_shownotification", 0];
	diag_log format ["%1 Mission%2 complete: %3", MISSION_PROC_TYPE_NAME, _controllerSuffix, _missionType];
};

deleteGroup _aiGroup;
deleteMarker _marker;

if (!isNil "_locationsArray") then
{
	[_locationsArray, _missionLocation, false] call setLocationState;
};
