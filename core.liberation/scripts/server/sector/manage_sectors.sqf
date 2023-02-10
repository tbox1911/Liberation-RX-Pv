waitUntil {sleep 1; !isNil "sectors_allSectors" };
private [ "_nextsector", "_opforcount", "_attacker", "_west_units", "_east_units" ];
active_sectors = [];
publicVariable "active_sectors";

while { GRLIB_endgame == 0 } do {

	{
		_nextsector = _x;
		_opforcount =  [] call F_opforCap;

		if ( _opforcount < GRLIB_sector_cap ) then {
			_west_units = [getmarkerpos _nextsector, GRLIB_sector_size, GRLIB_side_west] call F_getUnitsCount;
			_east_units = [getmarkerpos _nextsector, GRLIB_sector_size, GRLIB_side_east] call F_getUnitsCount;

			if ( (_west_units > 0 || _east_units > 0) && !(_nextsector in active_sectors) ) then {
				_attacker = GRLIB_side_west;
				if (_east_units > _west_units) then { _attacker = GRLIB_side_east };

				_hc = [] call F_lessLoadedHC;
				if ( isNull _hc ) then {
					[_nextsector, _attacker] spawn manage_one_sector;
				} else {
					diag_log format [ "Sector: %1 spawned on %2", _nextsector, _hc ];
					[_nextsector, _attacker] remoteExec ["manage_one_sector", _hc];
				};
				if ( _nextsector in sectors_military ) then {
					[_nextsector] call manage_ammoboxes;
				};
			};
		};
		sleep 0.25;
	} foreach ( sectors_allSectors - west_sectors - east_sectors );

	//diag_log format [ "Full sector scan at %1, active sectors: %2", time, active_sectors ];
	sleep 3;
};