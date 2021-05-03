one_synchro_done = false;
synchro_done = false;
waitUntil {sleep 1; !isNil "sync_vars_west" };

while { true } do {

	waitUntil {
		sleep 0.5;
		count sync_vars_west > 0;
	};
	resources_infantry = sync_vars_west select 0;
	resources_fuel = sync_vars_west select 1;
	infantry_cap = sync_vars_west select 2;
	fuel_cap = sync_vars_west select 3;
	unitcap = sync_vars_west select 4;
	combat_readiness = sync_vars_west select 5;
	resources_intel = sync_vars_west select 6;
	sync_vars_west = [];
	one_synchro_done = true;
	synchro_done = true;
};
