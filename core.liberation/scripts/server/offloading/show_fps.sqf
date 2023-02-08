private [ "_sourcestr", "_position", "_myfpsmarker", "_myfps", "_localunits", "_localvehicles" ];

if ( isServer ) then {
	_sourcestr = "Server";
	_position = 0;
} else {
	if (!isNil "HC1") then {
		if (!isNull HC1) then {
			if (local HC1) then {
				_sourcestr = "HC1";
				_position = 1;
			};
		};
	};

	if (!isNil "HC2") then {
		if (!isNull HC2) then {
			if (local HC2) then {
				_sourcestr = "HC2";
				_position = 2;
			};
		};
	};

	if (!isNil "HC3") then {
		if (!isNull HC3) then {
			if (local HC3) then {
				_sourcestr = "HC3";
				_position = 3;
			};
		};
	};
};

_myfpsmarker = createMarker [ format ["fpsmarker%1", _sourcestr ], [ 200, 200 + (200 * _position) ] ];
_myfpsmarker setMarkerType "mil_start";
_myfpsmarker setMarkerSize [ 0.7, 0.7 ];

while { true } do {

	_myfps = diag_fps;

	_localunits_civ = 0;
	_localvehicles_civ = 0;
	_localunits_enemy = 0;
	_localvehicles_enemy = 0;

	{
		switch (side _x) do {
			case GRLIB_side_civilian: {_localunits_civ = _localunits_civ +1};
			case GRLIB_side_enemy: {_localunits_enemy = _localunits_enemy +1};
		};
	} forEach ([allUnits, {(local _x) && (alive _x) && (_x distance2D lhd_west) >= GRLIB_sector_size && (_x distance2D lhd_east) >= GRLIB_sector_size}] call BIS_fnc_conditionalSelect);

	{
		switch (side _x) do {
			case GRLIB_side_civilian: {_localvehicles_civ = _localvehicles_civ +1};
			case GRLIB_side_enemy: {_localvehicles_enemy = _localvehicles_enemy +1};
		};
	} forEach ([vehicles, {(local _x) && (alive _x) && (_x distance2D lhd_west) >= GRLIB_sector_size && (_x distance2D lhd_east) >= GRLIB_sector_size && (!isNull (currentPilot _x))}] call BIS_fnc_conditionalSelect);

	_myfpsmarker setMarkerColor "ColorGREEN";
	if ( _myfps < 30 ) then { _myfpsmarker setMarkerColor "ColorYELLOW"; };
	if ( _myfps < 20 ) then { _myfpsmarker setMarkerColor "ColorORANGE"; };
	if ( _myfps < 10 ) then { _myfpsmarker setMarkerColor "ColorRED"; };

	_myfpsmarker setMarkerText format [ "%1: %2 fps - Unt: civ:%3 ind:%4 - Veh:civ:%5 ind:%6",
		_sourcestr, ( round ( _myfps * 100.0 ) ) / 100.0 ,
		_localunits_civ,_localunits_enemy,
		_localvehicles_civ,_localvehicles_enemy];

	sleep 15;
};
