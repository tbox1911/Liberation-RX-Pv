params ["_first_objective", "_side"];

if (isNil "_side") then {_side = GRLIB_side_enemy};
private _planeType = opfor_air;
if (_side == GRLIB_side_friendly) then {_planeType = blufor_air};

private _planes_number = 1;
if ( combat_readiness >= 50 ) then { _planes_number = 2 };
if ( combat_readiness >= 75 ) then { _planes_number = 3 };
if ( combat_readiness >= 85 ) then { _planes_number = 4 };

_air_spawnpoint = ( [ sectors_airspawn , [ _first_objective ] , { (markerpos _x) distance _input0 }, "ASCEND"] call BIS_fnc_sortBy ) select 0;
_air_grp = createGroup [_side, true];

for "_i" from 1 to _planes_number do {
	private _newvehicle = createVehicle [ (selectRandom _planeType), (markerPos _air_spawnpoint), [], 50, "FLY"];
	_newvehicle setPos (getPosATL _newvehicle vectorAdd [0, 0, 400]);
	createVehicleCrew _newvehicle;
	sleep 1;
	_newvehicle flyInHeight 400;

	private _pilot_group = group ((crew _newvehicle) select 0);
	_newvehicle addMPEventHandler ["MPKilled", {_this spawn kill_manager}];
	{ _x addMPEventHandler ["MPKilled", {_this spawn kill_manager}]; } foreach (crew _newvehicle);
	(crew _newvehicle) joinSilent _air_grp;
	diag_log format [ "Spawning Air vehicle %1 at %2", typeOf _newvehicle, time ];
	sleep 5;
};

while {(count (waypoints _air_grp)) != 0} do {deleteWaypoint ((waypoints _air_grp) select 0);};
{_x doFollow leader _air_grp} foreach units _air_grp;
sleep 0.2;

_waypoint = _air_grp addWaypoint [ _first_objective, 500];
_waypoint setWaypointType "MOVE";
_waypoint setWaypointSpeed "FULL";
_waypoint setWaypointBehaviour "AWARE";
_waypoint setWaypointCombatMode "RED";
_waypoint = _air_grp addWaypoint [ _first_objective, 500];
_waypoint setWaypointType "MOVE";
_waypoint setWaypointSpeed "FULL";
_waypoint setWaypointBehaviour "AWARE";
_waypoint setWaypointCombatMode "RED";
_waypoint = _air_grp addWaypoint [ _first_objective, 500];
_waypoint setWaypointType "MOVE";
_waypoint setWaypointSpeed "FULL";
_waypoint setWaypointBehaviour "AWARE";
_waypoint setWaypointCombatMode "RED";
_waypoint = _air_grp addWaypoint [ _first_objective, 500];
_waypoint setWaypointType "SAD";
_waypoint = _air_grp addWaypoint [ _first_objective, 1000];
_waypoint setWaypointType "SAD";
_waypoint = _air_grp addWaypoint [ _first_objective, 2000];
_waypoint setWaypointType "SAD";
_waypoint = _air_grp addWaypoint [ _first_objective, 3000];
_waypoint setWaypointType "SAD";
_waypoint = _air_grp addWaypoint [ _first_objective, 4000];
_waypoint setWaypointType "SAD";
_waypoint = _air_grp addWaypoint [ _first_objective, 5000];
_waypoint setWaypointType "SAD";
_waypoint = _air_grp addWaypoint [ _first_objective, 500];
_waypoint setWaypointType "CYCLE";

_air_grp setCurrentWaypoint [ _air_grp, 2];
sleep 60;

while {
	sleep 5;
	{( alive _x )} count (units _air_grp) > 0
 } do {

	{
		private _unit = _x;
		if ( alive _unit && vehicle _unit == _unit ) then {
			private _sectors = (sectors_allSectors - west_sectors);
			if (_side == GRLIB_side_friendly) then {_sectors = west_sectors};
			private _nearest_sector = [_sectors, _unit] call BIS_fnc_nearestPosition;

			if (!isNil "_nearest_sector") then {
				private _flee_grp = createGroup [_side, true];
				[_unit] joinSilent _flee_grp;

				while {(count (waypoints _flee_grp)) != 0} do {deleteWaypoint ((waypoints _flee_grp) select 0);};
				{_x doFollow leader _flee_grp} foreach units _flee_grp;

				_waypoint = _flee_grp addWaypoint [markerPos _nearest_sector, 0];
				_waypoint setWaypointType "MOVE";
				_waypoint setWaypointSpeed "FULL";
				_waypoint setWaypointBehaviour "AWARE";
				_waypoint setWaypointCombatMode "GREEN";
				_waypoint setWaypointCompletionRadius 50;

				_waypoint = _flee_grp addWaypoint [markerPos _nearest_sector, 0];
				_waypoint setWaypointType "MOVE";
				_waypoint setWaypointCompletionRadius 50;
				_waypoint setWaypointStatements ["true", "deleteVehicle this"];
				sleep 10;
			};
		};
	} foreach units _air_grp;

};
