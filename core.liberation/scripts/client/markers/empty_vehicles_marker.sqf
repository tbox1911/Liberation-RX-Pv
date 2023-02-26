private [ "_marker", "_nextvehicle", "_nextmarker" ];
private _veh_list = [];
private _vehmarkers = [];
private _vehmarkers_bak = [];
private _only_ammobox = false;

private _no_marker_classnames = [
	"Kart_01_Base_F",
	Respawn_truck_typename,
	huron_typename,
	playerbox_typename,
	GRLIB_player_gravebox
];
{ _no_marker_classnames pushback (_x select 0) } foreach buildings;

waitUntil {sleep 1; !isNil "GRLIB_init_server"};

while { true } do {
	_veh_list = [vehicles, {
		alive _x &&	locked _x != 2 &&
		(_x distance2D lhd_west) > GRLIB_sector_size &&
		(_x distance2D lhd_east) > GRLIB_sector_size &&
		(_x distance2D ([_x] call F_getNearestFobEnemy) > GRLIB_sector_size) &&
		!([typeOf _x, _no_marker_classnames] call F_itemIsInClass) &&
		!(_x getVariable ['R3F_LOG_disabled', true]) &&
		(isNull (_x getVariable ["R3F_LOG_est_transporte_par", objNull])) &&
		(_x getVariable ["GRLIB_vehicle_owner", ""] != "server") &&
		!(side _x == GRLIB_side_civilian && count (crew _x) > 0)
	}] call BIS_fnc_conditionalSelect;

	_vehmarkers_bak = [];
	{
		_nextvehicle = _x;
		_nextmarker = format ["markedveh%1" ,_nextvehicle];

		if (_vehmarkers find _nextmarker < 0) then {
			_marker = createMarkerLocal [format ["markedveh%1", _nextvehicle], markers_reset];
			_marker setMarkerColorLocal "ColorKhaki";
			_marker setMarkerTypeLocal "mil_dot";
			_marker setMarkerSizeLocal [ 0.75, 0.75 ];
			_marker setMarkerPosLocal (getPosATL _nextvehicle);
			_marker setMarkerTextLocal ([(typeOf _nextvehicle)] call F_getLRXName);
			_marker setMarkerAlphaLocal 0;
			_vehmarkers_bak pushback _marker;

			if (typeOf _nextvehicle in [ammobox_b_typename,ammobox_o_typename,ammobox_i_typename]) then {
				_marker setMarkerColorLocal "ColorGUER";
			};
			if (typeOf _nextvehicle in [waterbarrel_typename,fuelbarrel_typename,foodbarrel_typename]) then {
				_marker setMarkerColorLocal "ColorGrey";
				_marker setMarkerTypeLocal "mil_triangle";
			};
		} else {
			//add check move sector
			_nextmarker setMarkerAlphaLocal 0;
			_nextmarker setMarkerPosLocal (getPosATL _nextvehicle);
			_vehmarkers_bak pushback _nextmarker;
		};

		_sector = [_nextvehicle] call F_getSectorSide;
		_side = [_nextvehicle getVariable ["GRLIB_vehicle_owner", ""]] call F_getPlayerSide;
		if (_sector != GRLIB_side_enemy && _side == str sideUnknown) then {
			_side = str (side group _nextvehicle);
		};

		diag_log format ["DBG %1 %2 %3", typeOf _nextvehicle, _sector, _side];

		if (_side == str sideUnknown) then {
			_nextmarker setMarkerColorLocal "ColorKhaki";
			_nextmarker setMarkerAlphaLocal 1;
		};

		// Owned sectors
		if (_sector == GRLIB_side_friendly) then {
			if (_side == str GRLIB_side_west) then {
				_nextmarker setMarkerColorLocal GRLIB_color_west;
				_nextmarker setMarkerAlphaLocal 1;
			};
			if (_side == str GRLIB_side_east) then {
				_nextmarker setMarkerColorLocal GRLIB_color_east;
				_nextmarker setMarkerAlphaLocal 1;
			};
			if (_side == str GRLIB_side_enemy) then {
				_nextmarker setMarkerColorLocal GRLIB_color_enemy;
				_nextmarker setMarkerAlphaLocal 1;
			};
		};
		
		// Enemies sectors
		if (_sector == GRLIB_side_enemy) then {
			if (_side == str GRLIB_side_friendly) then {
				_nextmarker setMarkerColorLocal GRLIB_color_friendly;
				_nextmarker setMarkerAlphaLocal 1;
			};
		};

		// Civilian sectors
		if (_sector == GRLIB_side_civilian) then {
			if (_side == str GRLIB_side_friendly) then {
				_nextmarker setMarkerColorLocal GRLIB_color_friendly;
				_nextmarker setMarkerAlphaLocal 1;
			};
		};

	} foreach _veh_list;
	
	{ deleteMarkerLocal _x} foreach (_vehmarkers - _vehmarkers_bak);
	_vehmarkers = _vehmarkers_bak;

	sleep 5;
};

// ------------------------------------


// private [ "_marker" ];
// private _veh_list = [];
// private _vehmarkers = [];
// private _markedveh = [];

// private _no_marker_classnames = [ Respawn_truck_typename, huron_typename, playerbox_typename,  GRLIB_player_gravebox];
// { _no_marker_classnames pushback (_x select 0) } foreach buildings;

// waitUntil {sleep 1; !isNil "GRLIB_init_server"};

// while { true } do {
// 	_veh_list = [vehicles, {
// 		alive _x && locked _x != 2 &&
// 		_x distance lhd_west > GRLIB_sector_size &&
// 		_x distance lhd_east > GRLIB_sector_size &&
// 		(_x distance2D ([_x] call F_getNearestFobEnemy) > GRLIB_sector_size) &&
// 		!(typeOf _x in _no_marker_classnames) &&
// 		!(_x getVariable ['R3F_LOG_disabled', true]) &&
// 		(isNull (_x getVariable ["R3F_LOG_est_transporte_par", objNull])) &&
// 		(_x getVariable ["GRLIB_vehicle_owner", ""] != "server") &&
// 		(
// 			(side _x == GRLIB_side_friendly) ||
// 			(side _x == GRLIB_side_civilian && count (crew _x) == 0)
// 		)
// 	}] call BIS_fnc_conditionalSelect;

// 	private _markedveh = [];
// 	{ _markedveh pushback _x } foreach _veh_list;

// 	if ( count _markedveh != count _vehmarkers ) then {
// 		{ deleteMarkerLocal _x; } foreach _vehmarkers;
// 		_vehmarkers = [];

// 		{
// 			_marker = createMarkerLocal [ format [ "markedveh%1" ,_x], markers_reset ];
// 			_vehmarkers pushback _marker;
// 		} foreach _markedveh;
// 	};

// 	{
// 		_marker = _vehmarkers select (_markedveh find _x);

// 		// Owned sector
// 		if (([_x] call F_getSectorSide) == GRLIB_side_friendly) then {
// 			_marker setMarkerPosLocal getpos _x;
// 			_text = [(typeOf _x)] call F_getLRXName;
// 			_marker setMarkerTextLocal _text;
// 			_marker setMarkerTypeLocal "mil_dot";
// 			_marker setMarkerColorLocal "ColorKhaki";
// 			_marker setMarkerSizeLocal [ 0.75, 0.75 ];

// 			_side = [_x getVariable ["GRLIB_vehicle_owner", ""]] call F_getPlayerSide;
// 			if (_side == str GRLIB_side_west) then {
// 				_marker setMarkerColorLocal GRLIB_color_west;
// 			};

// 			if (_side == str GRLIB_side_east) then {
// 				_marker setMarkerColorLocal GRLIB_color_east;
// 			};

// 			if (_side == str GRLIB_side_enemy) then {
// 				_marker setMarkerColorLocal GRLIB_color_enemy;
// 			};

// 		};
		
// 		// Civilian sector
// 		if (([_x] call F_getSectorSide) == GRLIB_side_civilian) then {
// 			_side = [_x getVariable ["GRLIB_vehicle_owner", ""]] call F_getPlayerSide;
// 			if (_side == str GRLIB_side_friendly) then {
// 				_marker setMarkerPosLocal getpos _x;
// 				_text = [(typeOf _x)] call F_getLRXName;
// 				_marker setMarkerTextLocal _text;
// 				_marker setMarkerTypeLocal "mil_dot";
// 				_marker setMarkerColorLocal GRLIB_color_friendly;
// 				_marker setMarkerSizeLocal [ 0.75, 0.75 ];
// 			};

// 			if (_side == str sideUnknown && side _x != GRLIB_side_enemy) then {
// 				_marker setMarkerPosLocal getpos _x;
// 				_text = [(typeOf _x)] call F_getLRXName;
// 				_marker setMarkerTextLocal _text;
// 				_marker setMarkerTypeLocal "mil_dot";
// 				_marker setMarkerColorLocal "ColorKhaki";
// 				_marker setMarkerSizeLocal [ 0.75, 0.75 ];
// 			};
// 		};

// 		// Side Items
// 		if (typeOf _x in [waterbarrel_typename,fuelbarrel_typename,foodbarrel_typename]) then {
// 			_marker setMarkerPosLocal getpos _x;
// 			_text = [(typeOf _x)] call F_getLRXName;
// 			_marker setMarkerTextLocal _text;
// 			_marker setMarkerTypeLocal "mil_triangle";
// 			_marker setMarkerColorLocal "ColorGrey";
// 			_marker setMarkerSizeLocal [ 0.75, 0.75 ];
// 		};

// 		// Ammobox
// 		if (typeOf _x in [ammobox_b_typename,ammobox_o_typename,ammobox_i_typename]) then {
// 			_marker setMarkerPosLocal getpos _x;
// 			_text = [(typeOf _x)] call F_getLRXName;
// 			_marker setMarkerTextLocal _text;
// 			_marker setMarkerTypeLocal "mil_box";
// 			_marker setMarkerColorLocal "ColorGUER";
// 			_marker setMarkerSizeLocal [ 0.75, 0.75 ];
// 		};

// 	} foreach _markedveh;

// 	sleep 5;
// };
