if (!isServer && hasInterface) exitWith {};
params [ "_new_fob", "_side" ];
private _delete_items = [
	FOB_box_typename_west, FOB_truck_typename_west, "Land_Cargo_HQ_V1_ruins_F",
	FOB_box_typename_east, FOB_truck_typename_east, "Land_Cargo_HQ_V3_ruins_F"
];

if (_side == GRLIB_side_west) then {
	GRLIB_fobs_west pushback _new_fob;publicVariable "GRLIB_fobs_west";
};

if (_side == GRLIB_side_east) then {
	GRLIB_fobs_east pushback _new_fob;publicVariable "GRLIB_fobs_east";
};


{deleteVehicle _x} foreach ([_new_fob nearObjects GRLIB_fob_range ,{( typeof _x in _delete_items )}] call BIS_fnc_conditionalSelect);

trigger_server_save = true;
sleep 3;
[ _new_fob, 0, _side ] remoteExec ["remote_call_fob", 0];
stats_fobs_built = stats_fobs_built + 1;