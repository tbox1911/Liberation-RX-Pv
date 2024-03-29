if (GRLIB_side_friendly == GRLIB_side_west) then {
	my_lhd = lhd_west;
	GRLIB_Arsenal = LARsBox_west;
	GRLIB_color_friendly = GRLIB_color_west;
	huron_typename = huron_typename_west;
	FOB_typename = FOB_typename_west;
	FOB_box_typename = FOB_box_typename_west;
	FOB_truck_typename = FOB_truck_typename_west;
	Respawn_truck_typename = Respawn_truck_typename_west;
	ammo_truck_typename = ammo_truck_typename_west;
	fuel_truck_typename = fuel_truck_typename_west;
	repair_truck_typename = repair_truck_typename_west;
	repair_sling_typename = repair_sling_typename_west;
	fuel_sling_typename = fuel_sling_typename_west;
	ammo_sling_typename = ammo_sling_typename_west;
	medic_sling_typename = medic_sling_typename_west;
	commander_classname = commander_classname_west;
	crewman_classname = crewman_classname_west;
	pilot_classname = pilot_classname_west;
	infantry_units = [ infantry_units_west ] call F_filterMods;
	light_vehicles = [ light_vehicles_west ] call F_filterMods;
	heavy_vehicles = [ heavy_vehicles_west ] call F_filterMods;
	air_vehicles = [ air_vehicles_west ] call F_filterMods;
	support_vehicles = [ support_vehicles_west ] call F_filterMods;
	static_vehicles = [ static_vehicles_west ] call F_filterMods;
	buildings = [ buildings_west ] call F_filterMods;
	squads = squads_west;
	chimera_sign = chimera_sign_west;
	air_attack = air_attack_west;
	deleteMarkerLocal "base_chimera_east";
	deleteMarkerLocal "huronmarker_east";
} else {
	my_lhd = lhd_east;
	GRLIB_Arsenal = LARsBox_east;
	GRLIB_color_friendly = GRLIB_color_east;
	huron_typename = huron_typename_east;
	FOB_typename = FOB_typename_east;
	FOB_box_typename = FOB_box_typename_east;
	FOB_truck_typename = FOB_truck_typename_east;
	Respawn_truck_typename = Respawn_truck_typename_east;
	ammo_truck_typename = ammo_truck_typename_east;
	fuel_truck_typename = fuel_truck_typename_east;
	repair_truck_typename = repair_truck_typename_east;
	repair_sling_typename = repair_sling_typename_east;
	fuel_sling_typename = fuel_sling_typename_east;
	ammo_sling_typename = ammo_sling_typename_east;
	medic_sling_typename = medic_sling_typename_east;
	commander_classname = commander_classname_east;
	crewman_classname = crewman_classname_east;
	pilot_classname = pilot_classname_east;
	infantry_units = [ infantry_units_east ] call F_filterMods;
	light_vehicles = [ light_vehicles_east ] call F_filterMods;
	heavy_vehicles = [ heavy_vehicles_east ] call F_filterMods;
	air_vehicles = [ air_vehicles_east ] call F_filterMods;
	support_vehicles = [ support_vehicles_east ] call F_filterMods;
	static_vehicles = [ static_vehicles_east ] call F_filterMods;
	buildings = [ buildings_east ] call F_filterMods;
	squads = squads_east;
	chimera_sign = chimera_sign_east;
	air_attack = air_attack_east;
	deleteMarkerLocal "base_chimera_west";
	deleteMarkerLocal "huronmarker_west";
	deleteMarkerLocal "marker_332";
	deleteMarkerLocal "marker_334";
};
build_lists = [[],infantry_units,light_vehicles,heavy_vehicles,air_vehicles,static_vehicles,buildings,support_vehicles,squads];