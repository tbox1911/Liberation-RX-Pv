if (!isServer) exitWith {};

params [ "_new_fob", "_create_fob_building", "_side" ];
private [ "_fob_building", "_fob_pos", "_fob_box_list", "_ruin_list" ];

if (_side == west) then {
	GRLIB_fobs_west pushback _new_fob;
	publicVariable "GRLIB_fobs_west";
} else {
	GRLIB_fobs_east pushback _new_fob;
	publicVariable "GRLIB_fobs_east";
};

if ( _create_fob_building ) then {
	_fob_pos = [ (_new_fob select 0) + 15, (_new_fob select 1) + 2, 0 ];
	_fob_building = FOB_typename createVehicle _fob_pos;
	_fob_building setpos _fob_pos;
	_fob_building setVectorUp [0,0,1];
	sleep 1;
};

{deleteVehicle _x} foreach ([_new_fob nearObjects GRLIB_fob_range ,{( typeof _x in [FOB_box_typename, FOB_truck_typename, "Land_Cargo_HQ_V1_ruins_F"] )}] call BIS_fnc_conditionalSelect);

trigger_server_save = true;
sleep 3;
[ [ _new_fob, 0 ] , "remote_call_fob" ] call BIS_fnc_MP;
stats_fobs_built = stats_fobs_built + 1;