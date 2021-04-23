private [ "_sector_count", "_vehicle_unlock_markers", "_marker", "_nextbase", "_nextvehicle", "_cfg", "_nextmarker" ];

waitUntil {sleep 1; !isNil "sectors_allSectors" };
waitUntil {sleep 1; !isNil "save_is_loaded" };
waitUntil {sleep 1; !isNil "west_sectors" };
waitUntil {sleep 1; !isNil "east_sectors" };

_getMarkerType = {
	params ["_marker"];
	private _type = "n_art";
	if (_marker in sectors_bigtown) then { _type = "n_service"};
	if (_marker in sectors_tower) then { _type = "loc_Transmitter"};
	if (_marker in sectors_factory) then { _type = "loc_Fuelstation"};
	if (_marker in sectors_military) then { _type = "o_support"};
	_type;
};

_vehicle_unlock_markers = [];
_cfg = configFile >> "cfgVehicles";

{
	_nextvehicle = _x select 0;
	_nextbase = _x select 1;
	_marker = createMarkerLocal [format ["vehicleunlockmarker%1",_nextbase], [ markerpos _nextbase select 0, (markerpos _nextbase select 1) + 125]];
	_marker setMarkerTextLocal ( getText (_cfg >> _nextvehicle >> "displayName") );
	_marker setMarkerColorLocal GRLIB_color_enemy;
	_marker setMarkerTypeLocal "mil_pickup";
	_vehicle_unlock_markers pushback [ _marker, _nextbase ];
} foreach GRLIB_vehicle_to_military_base_links;

_sector_count_west = -1;
_sector_count_east = -1;

uiSleep 1;

while { true } do {
	waitUntil {sleep 1;(count west_sectors != _sector_count_west || count east_sectors != _sector_count_east) };

	if (GRLIB_hide_opfor) then {
		{
			_x setMarkerColorLocal GRLIB_color_enemy;
			_x setMarkerTypeLocal "Empty";
		} foreach (sectors_allSectors - west_sectors - east_sectors);
		{
			_x setMarkerColorLocal GRLIB_color_west;
			_x setMarkerTypeLocal ([_x] call _getMarkerType);
		 } foreach west_sectors;
		{
			_x setMarkerColorLocal GRLIB_color_east;
			_x setMarkerTypeLocal ([_x] call _getMarkerType);
		 } foreach east_sectors;
	} else {
		{ _x setMarkerColorLocal GRLIB_color_enemy; } foreach (sectors_allSectors - west_sectors - east_sectors);
		{ _x setMarkerColorLocal GRLIB_color_west; } foreach west_sectors;
		{ _x setMarkerColorLocal GRLIB_color_east; } foreach east_sectors;
	};

	{
		_nextmarker = _x;
		(_nextmarker select 0) setMarkerColorLocal GRLIB_color_enemy;
		{
			if ( _x == (_nextmarker select 1) ) exitWith { (_nextmarker select 0) setMarkerColorLocal GRLIB_color_west; };
		} foreach west_sectors;
		{
			if ( _x == (_nextmarker select 1) ) exitWith { (_nextmarker select 0) setMarkerColorLocal GRLIB_color_east; };
		} foreach east_sectors;

	} foreach _vehicle_unlock_markers;

	_sector_count_west = count west_sectors;
	_sector_count_east = count east_sectors;

};