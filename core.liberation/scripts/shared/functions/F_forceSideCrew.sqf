params [ "_veh" ];

private _nearestfob = [getPos _veh] call F_getNearestFob;
private _fobside = [_nearestfob] call F_getFobSide;
if (_fobside != GRLIB_side_civilian) then {
	private _grp = createGroup [_fobside, true];

	_crew_classname = crewman_classname_east;
	if (_fobside == GRLIB_side_west) then {
		_crew_classname = crewman_classname_west;
	};

	while { count units _grp < 3 } do {
		_crew_classname createUnit [ getPos _veh, _grp, 'this addMPEventHandler ["MPKilled", {_this spawn kill_manager}]; this addEventHandler ["HandleDamage", {_this call damage_manager_EH}]'];
		//sleep 0.1;
	};
	((units _grp) select 0) moveInDriver _veh;
	((units _grp) select 1) moveInGunner _veh;
	((units _grp) select 2) moveInCommander _veh;
	sleep 0.1;
	{ if ( vehicle _x == _x ) then { deleteVehicle _x }; } foreach (units _grp);
	//sleep 1;
	//(crew _veh) joinSilent _grp;
	(group ((crew _veh) select 0)) setCombatMode "GREEN";
	(group ((crew _veh) select 0)) setBehaviour "SAFE";
};