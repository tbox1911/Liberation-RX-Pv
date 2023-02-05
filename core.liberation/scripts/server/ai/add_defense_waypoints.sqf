params ["_grp", "_flagpos", ["_radius", 100]];
private ["_basepos", "_waypoint"];
if (isNil "_grp") exitWith {};

private _patrol_in_water = false;
if (surfaceIsWater _flagpos) then { _patrol_in_water = true; _radius = 60 };

private _patrolcorners = [
	[ (_flagpos select 0) - _radius, (_flagpos select 1) - _radius, 0 ],
	[ (_flagpos select 0) + _radius, (_flagpos select 1) - _radius, 0 ],
	[ (_flagpos select 0) + _radius, (_flagpos select 1) + _radius, 0 ],
	[ (_flagpos select 0) - _radius, (_flagpos select 1) + _radius, 0 ]
];

while {(count (waypoints _grp)) != 0} do {deleteWaypoint ((waypoints _grp) select 0)};
sleep 1;
{
	if (_patrol_in_water) then {
		_waypoint = _grp addWaypoint [_x, 0];
	} else {
		if (surfaceIsWater _x) then {
			_waypoint = _grp addWaypoint [_flagpos, _radius];
		} else {
			_waypoint = _grp addWaypoint [_x, 0];
		};
	};
	_waypoint setWaypointType "MOVE";
	_waypoint setWaypointBehaviour "AWARE";
	_waypoint setWaypointCombatMode "GREEN";
	_waypoint setWaypointSpeed "LIMITED";
	_waypoint setWaypointBehaviour "SAFE";
	_waypoint setWaypointCompletionRadius 10;
} foreach _patrolcorners;

_waypoint = _grp addWaypoint [(_patrolcorners select 0), 0];
_waypoint setWaypointType "CYCLE";
{_x doFollow (leader _grp)} foreach units _grp;

waitUntil {
	sleep 10;
	( { alive _x } count (units _grp) == 0 ) || !(isNull ((leader _grp) findNearestEnemy (leader _grp)))
};

if ( { alive _x } count (units _grp) > 0 ) then {
	while {(count (waypoints _grp)) != 0} do { deleteWaypoint ((waypoints _grp) select 0) };
	{_x doFollow leader _grp} foreach units _grp;

	_basepos = getPosATL (leader _grp);
	_waypoint = _grp addWaypoint [_basepos, _radius];
	_waypoint setWaypointType "SAD";
	_waypoint setWaypointBehaviour "COMBAT";
	_waypoint setWaypointCombatMode "GREEN";
	_waypoint setWaypointSpeed "LIMITED";
	_waypoint = _grp addWaypoint [_basepos, _radius];
	_waypoint setWaypointType "SAD";
	_waypoint = _grp addWaypoint [_basepos, _radius];
	_waypoint setWaypointType "SAD";
	_waypoint = _grp addWaypoint [_basepos, _radius];
	_waypoint setWaypointType "SAD";
	_waypoint = _grp addWaypoint [_basepos, _radius];
	_waypoint setWaypointType "CYCLE";
};