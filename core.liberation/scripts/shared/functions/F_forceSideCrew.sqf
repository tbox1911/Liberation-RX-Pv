params [ "_veh", "_side" ];

createVehicleCrew _veh;
sleep 0.1;
_grp = createGroup [_side, true];
{
	_x addMPEventHandler ["MPKilled", {_this spawn kill_manager}];
	[_x] joinSilent _grp;
} foreach (crew _veh);

_grp setCombatMode "GREEN";
_grp setBehaviour "SAFE";