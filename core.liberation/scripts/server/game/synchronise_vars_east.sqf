sync_vars_east = []; publicVariable "sync_vars_east";

waitUntil{ !isNil "save_is_loaded" };
waitUntil{ !isNil "resources_infantry_east" };
waitUntil{ !isNil "resources_fuel_east" };
waitUntil{ !isNil "infantry_cap_east" };
waitUntil{ !isNil "fuel_cap_east" };
waitUntil{ !isNil "combat_readiness" };
waitUntil{ !isNil "unitcap_east" };
waitUntil{ !isNil "resources_intel_east" };


_infantry_cap_old = -999;
_fuel_cap_old = -999;
_resources_infantry_old = -999;
_resources_fuel_old = -999;
_resources_intel_old = -999;
_unitcap_old = -1;
_combat_readiness_old = -1;

while { true } do {

	waitUntil { sleep 0.25;
		_resources_infantry_old != resources_infantry_east
		|| _resources_fuel_old != resources_fuel_east
		|| _infantry_cap_old != infantry_cap_east
		|| _fuel_cap_old != fuel_cap_east
		|| _unitcap_old != unitcap_east
		|| _combat_readiness_old != combat_readiness
		|| _resources_intel_old != resources_intel_east
	};
	sleep 0.25;
	sync_vars_east = [resources_infantry_east, resources_fuel_east, infantry_cap_east, fuel_cap_east, unitcap_east, combat_readiness, resources_intel_east];
	publicVariable "sync_vars_east";

	_infantry_cap_old = infantry_cap_east;
	_fuel_cap_old = fuel_cap_east;
	_resources_infantry_old = resources_infantry_east;
	_resources_fuel_old = resources_fuel_east;
	_unitcap_old = unitcap_east;
	_combat_readiness_old = combat_readiness;
	_resources_intel_old = resources_intel_east;
};