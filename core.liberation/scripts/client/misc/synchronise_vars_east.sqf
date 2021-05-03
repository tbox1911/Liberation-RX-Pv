one_synchro_done = false;
synchro_done = false;
waitUntil {sleep 1; !isNil "sync_vars_east" };

while { true } do {

	waitUntil {
		sleep 0.5;
		count sync_vars_east > 0;
	};
	resources_infantry = sync_vars_east select 0;
	resources_fuel = sync_vars_east select 1;
	infantry_cap = sync_vars_east select 2;
	fuel_cap = sync_vars_east select 3;
	unitcap = sync_vars_east select 4;
	combat_readiness = sync_vars_east select 5;
	resources_intel = sync_vars_east select 6;
	sync_vars_east = [];
	one_synchro_done = true;
	synchro_done = true;
};
