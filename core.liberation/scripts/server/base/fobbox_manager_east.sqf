waitUntil {sleep 1; !isNil "GRLIB_fobs_west" };
waitUntil {sleep 1; !isNil "save_is_loaded" };

private [ "_fobbox", "_foblist" ];

_fob_type = FOB_box_typename_west;
if ( GRLIB_fob_type == 1 ) then {
	_fob_type = FOB_truck_typename_west;
};

while { true } do {

	_foblist = [entities _fob_type, {[_x] call is_public}] call BIS_fnc_conditionalSelect;

	if ( count _foblist == 0 && count GRLIB_fobs_west == 0 ) then {
		_fobbox = _fob_type createVehicle (getPosATL base_boxspawn_west);
		_fobbox allowdamage false;
		_fobbox setPosATL (getPosATL base_boxspawn_west);
		_fobbox setdir (getdir base_boxspawn_west);
		_fobbox setMass 3000;
		clearWeaponCargoGlobal _fobbox;
		clearMagazineCargoGlobal _fobbox;
		clearItemCargoGlobal _fobbox;
		clearBackpackCargoGlobal _fobbox;
		_fobbox enableSimulationGlobal true;
		_fobbox setVariable ["GRLIB_vehicle_owner", "public", true];
		sleep 3;
		_fobbox setDamage 0;
		_fobbox allowdamage true;

		waitUntil {
			sleep 1;
			!(alive _fobbox) || count GRLIB_fobs_west > 0
		};
		sleep 30;
		deleteVehicle _fobbox;
	};
	sleep 10;
};