if (!isServer && hasInterface) exitWith {};
params [ "_thispos", "_side" ];

[_thispos, _side] call destroy_fob;
[_thispos, 2] remoteExec ["remote_call_fob", 0];
