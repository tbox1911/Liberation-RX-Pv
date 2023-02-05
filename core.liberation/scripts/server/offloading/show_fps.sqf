private [ "_sourcestr", "_position", "_myfpsmarker", "_myfps", "_units_blu", "_units_opf", "_units_civ"];

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

	_units_blu = { alive _x && (_x distance2D lhd_west) >= 500 } count units GRLIB_side_west;
	_units_opf = { alive _x && (_x distance2D lhd_east) >= 500 } count units GRLIB_side_east;
	_units_civ = { alive _x && !(typeOf _x in [SHOP_Man, SELL_Man])} count units GRLIB_side_civilian;

	_myfpsmarker setMarkerColor "ColorGREEN";
	if ( _myfps < 30 ) then { _myfpsmarker setMarkerColor "ColorYELLOW"; };
	if ( _myfps < 20 ) then { _myfpsmarker setMarkerColor "ColorORANGE"; };
	if ( _myfps < 10 ) then { _myfpsmarker setMarkerColor "ColorRED"; };

	_myfpsmarker setMarkerText format [ "%1: %2 fps - Up: %9 - civ:%3 blu:%4 red:%5",
		_sourcestr, ( round ( _myfps * 100.0 ) ) / 100.0 ,
		_units_civ,_units_blu,_units_opf,
		[time/3600,"HH:MM:SS"] call BIS_fnc_timeToString];

	sleep 15;
};
