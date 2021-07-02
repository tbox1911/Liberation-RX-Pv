waitUntil {sleep 1; !isNil "west_sectors" };
waitUntil {sleep 1; !isNil "east_sectors" };
waitUntil {sleep 1; !isNil "combat_readiness" };
waitUntil {sleep 1; !isNil "sectors_bigtown" };
waitUntil {sleep 1; !isNil "active_sectors" };

while { true } do {
	if ( count (west_sectors + east_sectors) >= ((count sectors_allSectors) * 0.9)) then {
		if ( combat_readiness > 50 ) then {
			combat_readiness = combat_readiness - 0.15;
		};		
	} else {
		if ( (combat_readiness < (count (west_sectors + east_sectors) * 2) && combat_readiness < 35 ) || 
		     (combat_readiness < (count (west_sectors + east_sectors) * 1.25) && combat_readiness < 60 )) then {
			combat_readiness = combat_readiness + 0.25;
			stats_readiness_earned = stats_readiness_earned + 0.25;
		};
	};

	if ( combat_readiness > 100.0 && GRLIB_difficulty_modifier < 2 ) then { combat_readiness = 100.0 };

	sleep (45 + floor( 45));
};