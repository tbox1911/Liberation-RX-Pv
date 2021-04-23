_box = _this select 3;
if (isNull _box) exitWith {};

private [ "_minfobdist", "_minsectordist", "_distfob", "_clearedtobuildfob", "_distsector", "_clearedtobuildsector", "_idx" ];

//only one at time
if ((_box getVariable ["box_in_use", false])) exitWith {};
_box setVariable ["box_in_use", true, true];

if ( count GRLIB_my_fobs >= GRLIB_maximum_fobs ) exitWith {
	hint format [ localize "STR_HINT_FOBS_EXCEEDED", GRLIB_maximum_fobs ];
};

_minfobdist = 1000;
_minsectordist = GRLIB_capture_size + GRLIB_fob_range;
_distfob = 1;
_clearedtobuildfob = true;
_distsector = 1;
_clearedtobuildsector = true;

_idx = 0;
while { (_idx < (count GRLIB_my_fobs)) && _clearedtobuildfob } do {
	if ( player distance (GRLIB_my_fobs select _idx) < _minfobdist ) then {
		_clearedtobuildfob = false;
		_distfob = player distance (GRLIB_my_fobs select _idx);
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
		buildtype = 99;
		dobuild = 1;
	};
};
_box setVariable ["box_in_use", false, true];