if (!isServer && hasInterface) exitWith {};

params [ "_thispos" ];

[_thispos] call destroy_fob;
trigger_server_save = true;

[] call recalculate_caps;
stats_fobs_lost = stats_fobs_lost + 1;