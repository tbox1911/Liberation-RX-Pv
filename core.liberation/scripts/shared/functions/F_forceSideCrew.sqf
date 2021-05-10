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


//add air crew/pilot check
// if (_classname in uavs) then {
// 	createVehicleCrew _veh;
// 	sleep 0.1;
// } else {
// 	private _crew_classname = opfor_crew;
// 	switch (_side) do {
// 		case GRLIB_side_west: {_crew_classname = crewman_classname_west};
// 		case GRLIB_side_east: {_crew_classname = crewman_classname_east};
// 	};

// 	private _grp = createGroup [_side, true];
// 	while { count units _grp < 3 } do {
// 		_crew_classname createUnit [ zeropos, _grp, 'this addMPEventHandler ["MPKilled", {_this spawn kill_manager}]; this addEventHandler ["HandleDamage", {_this call damage_manager_EH}]'];
// 		sleep 0.1;
// 	};
// 	((units _grp) select 0) moveInDriver _veh;
// 	((units _grp) select 1) moveInGunner _veh;
// 	((units _grp) select 2) moveInCommander _veh;
// 	sleep 0.1;
// 	{ if ( vehicle _x == _x ) then { deleteVehicle _x }; } foreach (units _grp);
// };
// (group ((crew _veh) select 0)) setCombatMode "GREEN";
// (group ((crew _veh) select 0)) setBehaviour "SAFE";

//(crew _veh) joinSilent _grp;