params [ "_veh"];

createVehicleCrew _veh;
sleep 0.1;

{
	_x addMPEventHandler ["MPKilled", { _this spawn kill_manager }];
 	_x addEventHandler ["HandleDamage", { _this call damage_manager_enemy }];
	_x setSkill 0.65;
	_x allowFleeing 0;
} foreach (crew _veh);

_grp = createGroup [GRLIB_side_enemy, true];
(crew _veh) joinSilent _grp;

_grp setCombatMode "GREEN";
_grp setBehaviour "SAFE";