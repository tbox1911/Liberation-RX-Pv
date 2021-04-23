if ( GRLIB_fob_type == 1 ) exitWith {};
waitUntil {sleep 1; !isNil "GRLIB_fobs_east" };
waitUntil {sleep 1; !isNil "save_is_loaded" };

private _huron = objNull;

while { true } do {

	private _huronlist = [entities huron_typename_east, {
		(_x getVariable ["GRLIB_vehicle_ishuron", false])
	}] call BIS_fnc_conditionalSelect;

	if ( count _huronlist == 0) then {
		_huron = huron_typename_east createVehicle ( getPosATL huronspawn_east );
		_huron allowdamage false;
		_huron addMPEventHandler ["MPKilled", {_this spawn kill_manager}];
		_huron setVariable ["GRLIB_vehicle_owner", "public", true];
		_huron setVariable ["GRLIB_vehicle_ishuron", true, true];
		_huron setPosATL (getPosATL huronspawn_east);
		_huron setDir (getDir huronspawn_east);
		sleep 0.5;
		_huron AnimateDoor ["Door_rear_source", 1, true];
		clearWeaponCargoGlobal _huron;
		clearMagazineCargoGlobal _huron;
		clearItemCargoGlobal _huron;
		clearBackpackCargoGlobal _huron;
		_huron enableSimulationGlobal true;
		sleep 3;
		_huron setDamage 0;
		_huron allowdamage true;

		if ( alive _huron ) then {
			waitUntil {
				sleep 1;
				!alive _huron;
			};
			stats_spartan_respawns = stats_spartan_respawns + 1;
			sleep 15;
		};

		if (_huron distance lhd_east < GRLIB_sector_size) then {
			deletevehicle _huron;
		};
	};
	sleep 10;
};