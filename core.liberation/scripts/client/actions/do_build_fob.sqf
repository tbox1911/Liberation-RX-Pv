_box = _this select 3;
if (isNull _box) exitWith {};

private [ "_minfobdist", "_minsectordist", "_distfob", "_clearedtobuildfob", "_distsector", "_clearedtobuildsector", "_idx" ];

//only one at time
if ((_box getVariable ["box_in_use", false])) exitWith {};

private _myfobs = ([] call get_myFobs);
if ( count _myfobs >= GRLIB_maximum_fobs ) exitWith {
	hint format [ localize "STR_HINT_FOBS_EXCEEDED", GRLIB_maximum_fobs ];
};

_box setVariable ["box_in_use", true, true];
_minfobdist = 1000;
_minsectordist = GRLIB_capture_size + GRLIB_fob_range;
_distfob = 1;
_clearedtobuildfob = true;
_distsector = 1;
_clearedtobuildsector = true;

_idx = 0;
while { (_idx < (count _myfobs)) && _clearedtobuildfob } do {
	if ( player distance (_myfobs select _idx) < _minfobdist ) then {
		_clearedtobuildfob = false;
		_distfob = player distance (_myfobs select _idx);
	};
	_idx = _idx + 1;
};

_idx = 0;
if(_clearedtobuildfob) then {
	while { (_idx < (count sectors_allSectors)) && _clearedtobuildsector } do {
		if ( player distance (getmarkerpos (sectors_allSectors select _idx)) < _minsectordist ) then {
			_clearedtobuildsector = false;
			_distsector = player distance (getmarkerpos (sectors_allSectors select _idx));
		};
		_idx = _idx + 1;
	};
};

if (!_clearedtobuildfob) then {
	hint format [localize "STR_FOB_BUILDING_IMPOSSIBLE",floor _minfobdist,floor _distfob];
} else {
	if ( !_clearedtobuildsector ) then {
		hint format [localize "STR_FOB_BUILDING_IMPOSSIBLE_SECTOR",floor _minsectordist,floor _distsector];
	} else {
		if (typeOf _box == FOB_box_outpost) then {
			buildtype = 98;
			dobuild = 1;
		} else {
			buildtype = 99;
			dobuild = 1;
		};
	};
};
_box setVariable ["box_in_use", false, true];