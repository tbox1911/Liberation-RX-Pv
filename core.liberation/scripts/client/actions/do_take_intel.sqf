params ["_intel_obj"];
if (isNull _intel_obj) exitWith {};
[ _intel_obj, GRLIB_side_friendly, player ] remoteExec ["intel_remote_call", 2];