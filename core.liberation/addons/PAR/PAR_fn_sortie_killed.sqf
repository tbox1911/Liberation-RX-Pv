params ["_wnded"];

if (isDedicated) exitWith {};
if (!(local _wnded)) exitWith {};

[_wnded] remoteExec ["removeAllActions", 0];
_wnded setDamage 1;
