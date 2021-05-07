params [ "_veh", "_side" ];

//add air crew/pilot check
createVehicleCrew _veh;
sleep 0.1;
if (count(crew _veh) == 0) then {
	private _crew_classname = opfor_crew;
	switch (_side) do {
		case GRLIB_side_west: {_crew_classname = crewman_classname_west};
		case GRLIB_side_east: {_crew_classname = crewman_classname_east};
	};

	private _grp = createGroup [_side, true];
	while { count units _grp < 3 } do {
		_crew_classname createUnit [ zeropos, _grp, 'this addMPEventHandler ["MPKilled", {_this spawn kill_manager}]; this addEventHandler ["HandleDamage", {_this call damage_manager_EH}]'];
		sleep 0.1;
	};
	((units _grp) select 0) moveInDriver _veh;
	((units _grp) select 1) moveInGunner _veh;
	((units _grp) select 2) moveInCommander _veh;
	sleep 0.1;
	{ if ( vehicle _x == _x ) then { deleteVehicle _x }; } foreach (units _grp);
};
//sleep 1;
(group ((crew _veh) select 0)) setCombatMode "GREEN";
(group ((crew _veh) select 0)) setBehaviour "SAFE";

//(crew _veh) joinSilent _grp;