sync_vars_west = []; publicVariable "sync_vars_west";

waitUntil{ !isNil "save_is_loaded" };
waitUntil{ !isNil "resources_infantry_west" };
waitUntil{ !isNil "resources_fuel_west" };
waitUntil{ !isNil "infantry_cap_west" };
waitUntil{ !isNil "fuel_cap_west" };
waitUntil{ !isNil "combat_readiness" };
waitUntil{ !isNil "unitcap_west" };
waitUntil{ !isNil "resources_intel_west" };


_infantry_cap_old = -999;
_fuel_cap_old = -999;
_resources_infantry_old = -999;
_resources_fuel_old = -999;
_resources_intel_old = -999;
_unitcap_old = -1;
_combat_readiness_old = -1;

while { true } do {

	waitUntil { sleep 0.25;
		_resources_infantry_old != resources_infantry_west
		|| _resources_fuel_old != resources_fuel_west
		|| _infantry_cap_old != infantry_cap_west
		|| _fuel_cap_old != fuel_cap_west
		|| _unitcap_old != unitcap_west
		|| _combat_readiness_old != combat_readiness
		|| _resources_intel_old != resources_intel_west
	};
	sleep 0.25;
	sync_vars_west = [resources_infantry_west, resources_fuel_west, infantry_cap_west, fuel_cap_west, unitcap_west, combat_readiness, resources_intel_west];
	publicVariable "sync_vars_west";

	_infantry_cap_old = infantry_cap_west;
	_fuel_cap_old = fuel_cap_west;
	_resources_infantry_old = resources_infantry_west;
	_resources_fuel_old = resources_fuel_west;
	_unitcap_old = unitcap_west;
	_combat_readiness_old = combat_readiness;
	_resources_intel_old = resources_intel_west;
};