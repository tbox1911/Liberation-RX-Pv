if ( !isServer ) exitWith {};

params [ "_intel_object", "_side" ];

if ( isNil "_intel_object" ) exitWith {};

_intel_yield = 8;
deleteVehicle _intel_object;
if (_side == GRLIB_side_west) then {
    resources_intel_west = resources_intel_west + (floor (_intel_yield + (random _intel_yield)));
} else {
    resources_intel_east = resources_intel_east + (floor (_intel_yield + (random _intel_yield)));
};

[ 1 ] remoteExec ["remote_call_intel", 0];