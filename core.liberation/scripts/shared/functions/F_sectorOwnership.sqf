params [ "_thatpos", [ "_localsize", GRLIB_capture_size ] ];
private [ "_cap_thresold_count", "_cap_thresold_ratio", "_cap_min_ratio", "_sectorside", "_countblufor_ownership", "_countopfor_ownership", "_blufor_ratio", "_tower" ];

_cap_thresold_count = 3;
_cap_thresold_ratio = 0.85;
_cap_min_ratio = 0.51;

_sectorside = GRLIB_side_enemy;
_countblufor_ownership = [_thatpos, _localsize, GRLIB_side_west ] call F_getUnitsCount;
_countopfor_ownership = [_thatpos, _localsize, GRLIB_side_east ] call F_getUnitsCount;

_blufor_ratio = 0;
_opfor_ratio = 0;

if ( _countblufor_ownership + _countopfor_ownership != 0 ) then {
	_blufor_ratio = _countblufor_ownership / ( _countblufor_ownership + _countopfor_ownership);
	_opfor_ratio = _countopfor_ownership / ( _countblufor_ownership + _countopfor_ownership);
};

if ( _countblufor_ownership == 0 && _countopfor_ownership <= _cap_thresold_count ) then { _sectorside = GRLIB_side_civilian; };

if ( _countblufor_ownership > 0 && ( ( _countopfor_ownership <= _cap_thresold_count && _blufor_ratio > _cap_min_ratio ) || _blufor_ratio > _cap_thresold_ratio) ) then { _sectorside = GRLIB_side_west; };

if ( _countopfor_ownership > 0 && ( ( _countblufor_ownership <= _cap_thresold_count && _opfor_ratio > _cap_min_ratio ) || _opfor_ratio > _cap_thresold_ratio) ) then { _sectorside = GRLIB_side_east; };

if ( _countblufor_ownership == 0 && _countopfor_ownership > _cap_thresold_count ) then { _sectorside = GRLIB_side_enemy; };

//radio is down
if ( [_thatpos, GRLIB_side_enemy, GRLIB_capture_size] call F_getNearestTower != "" ) then {
	_tower = [];
	_tower = (_thatpos nearobjects ["Land_Communication_F", GRLIB_capture_size]) select 0;
	if (!isNil "_tower") then {
		if (alive _tower) then {
			_sectorside = GRLIB_side_enemy;
		};
	};
};

_sectorside
