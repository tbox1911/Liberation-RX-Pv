params [ "_thatpos", [ "_localsize", GRLIB_capture_size ] ];
private ["_sectorside", "_countenemy_ownership", "_countblufor_ownership", "_countopfor_ownership", "_tower" ];

_sectorside = GRLIB_side_civilian;
_countenemy_ownership = [_thatpos, _localsize, GRLIB_side_enemy ] call F_getUnitsCount;
_countblufor_ownership = [_thatpos, _localsize, GRLIB_side_west ] call F_getUnitsCount;
_countopfor_ownership = [_thatpos, _localsize, GRLIB_side_east ] call F_getUnitsCount;

if ( _countenemy_ownership > _countblufor_ownership && _countenemy_ownership > _countopfor_ownership ) then { _sectorside = GRLIB_side_enemy; };
if ( _countblufor_ownership > _countenemy_ownership && _countblufor_ownership > _countenemy_ownership ) then { _sectorside = GRLIB_side_west; };
if ( _countopfor_ownership > _countenemy_ownership && _countopfor_ownership > _countenemy_ownership ) then { _sectorside = GRLIB_side_east; };

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
