params ["_intel_obj"];
if (isNull _intel_obj) exitWith {};
[ _intel_obj ] remoteExec ["intel_remote_call", 2];