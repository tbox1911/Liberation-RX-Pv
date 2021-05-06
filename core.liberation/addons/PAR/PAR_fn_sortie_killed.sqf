params ["_wnded", "_medic"];

if (isDedicated) exitWith {};
if (!(local _wnded)) exitWith {};

[_wnded] remoteExec ["removeAllActions", 0];
_wnded setDamage 1;

_msg = format ["%1 was Killed by %2", name _wnded, name _medic];
[_medic, _msg] call PAR_fn_globalchat;
[_medic, 5] remoteExec ["addScore", 2];