private [ "_marker" ];
private _veh_list = [];
private _vehmarkers = [];
private _markedveh = [];

private _no_marker_classnames = [ Respawn_truck_typename, huron_typename, playerbox_typename ];
{ _no_marker_classnames pushback (_x select 0) } foreach buildings;

waitUntil {sleep 1; !isNil "GRLIB_init_server"};

while { true } do {
	_veh_list = [vehicles, {
		alive _x && locked _x != 2 &&
		_x distance lhd_west > GRLIB_sector_size &&
		_x distance lhd_east > GRLIB_sector_size &&
		(_x distance2D ([_x] call F_getNearestFobEnemy) > GRLIB_sector_size) &&
		!(typeOf _x in _no_marker_classnames) &&
		!(_x getVariable ['R3F_LOG_disabled', true]) &&
		(isNull (_x getVariable ["R3F_LOG_est_transporte_par", objNull])) &&
		(_x getVariable ["GRLIB_vehicle_owner", ""] != "server") &&
		(
			(side _x == GRLIB_side_friendly) ||
			(side _x == GRLIB_side_civilian && count (crew _x) == 0)
		)
	}] call BIS_fnc_conditionalSelect;

	private _markedveh = [];
	{ _markedveh pushback _x } foreach _veh_list;

	if ( count _markedveh != count _vehmarkers ) then {
		{ deleteMarkerLocal _x; } foreach _vehmarkers;
		_vehmarkers = [];

		{
			_marker = createMarkerLocal [ format [ "markedveh%1" ,_x], markers_reset ];
			_vehmarkers pushback _marker;
		} foreach _markedveh;
	};

	{
		_marker = _vehmarkers select (_markedveh find _x);

		// Owned sector
		if (([_x] call F_getSectorSide) == GRLIB_side_friendly) then {
			_marker setMarkerPosLocal getpos _x;
			_text = [(typeOf _x)] call F_getLRXName;
			_marker setMarkerTextLocal _text;
			_marker setMarkerTypeLocal "mil_dot";
			_marker setMarkerColorLocal "ColorKhaki";
			_marker setMarkerSizeLocal [ 0.75, 0.75 ];

			_side = [_x getVariable ["GRLIB_vehicle_owner", ""]] call F_getPlayerSide;
			if (_side == str GRLIB_side_west) then {
				_marker setMarkerColorLocal GRLIB_color_west;
			};

			if (_side == str GRLIB_side_east) then {
				_marker setMarkerColorLocal GRLIB_color_east;
			};

			if (_side == str GRLIB_side_enemy) then {
				_marker setMarkerColorLocal GRLIB_color_enemy;
			};

		};
		
		// Civilian sector
		if (([_x] call F_getSectorSide) == GRLIB_side_civilian) then {
			_side = [_x getVariable ["GRLIB_vehicle_owner", ""]] call F_getPlayerSide;
			if (_side == str GRLIB_side_friendly) then {
				_marker setMarkerPosLocal getpos _x;
				_text = [(typeOf _x)] call F_getLRXName;
				_marker setMarkerTextLocal _text;
				_marker setMarkerTypeLocal "mil_dot";
				_marker setMarkerColorLocal GRLIB_color_friendly;
				_marker setMarkerSizeLocal [ 0.75, 0.75 ];
			};

			if (_side == str sideUnknown && side _x != GRLIB_side_enemy) then {
				_marker setMarkerPosLocal getpos _x;
				_text = [(typeOf _x)] call F_getLRXName;
				_marker setMarkerTextLocal _text;
				_marker setMarkerTypeLocal "mil_dot";
				_marker setMarkerColorLocal "ColorKhaki";
				_marker setMarkerSizeLocal [ 0.75, 0.75 ];
			};
		};

		// Side Items
		if (typeOf _x in [waterbarrel_typename,fuelbarrel_typename,foodbarrel_typename]) then {
			_marker setMarkerPosLocal getpos _x;
			_text = [(typeOf _x)] call F_getLRXName;
			_marker setMarkerTextLocal _text;
			_marker setMarkerTypeLocal "mil_triangle";
			_marker setMarkerColorLocal "ColorGrey";
			_marker setMarkerSizeLocal [ 0.75, 0.75 ];
		};

		// Ammobox
		if (typeOf _x in [ammobox_b_typename,ammobox_o_typename,ammobox_i_typename]) then {
			_marker setMarkerPosLocal getpos _x;
			_text = [(typeOf _x)] call F_getLRXName;
			_marker setMarkerTextLocal _text;
			_marker setMarkerTypeLocal "mil_box";
			_marker setMarkerColorLocal "ColorGUER";
			_marker setMarkerSizeLocal [ 0.75, 0.75 ];
		};

	} foreach _markedveh;

	sleep 5;
};
