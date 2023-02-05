if (!isServer && hasInterface) exitWith {};
params [ "_new_fob", "_side" ];

if (_side == GRLIB_side_west) then {
	GRLIB_fobs_west pushback _new_fob;publicVariable "GRLIB_fobs_west";
};

if (_side == GRLIB_side_east) then {
	GRLIB_fobs_east pushback _new_fob;publicVariable "GRLIB_fobs_east";
};


[ _new_fob, 0, _side ] remoteExec ["remote_call_fob", 0];
sleep 1;
stats_fobs_built = stats_fobs_built + 1;