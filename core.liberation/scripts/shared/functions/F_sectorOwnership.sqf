params [ "_thatpos", [ "_localsize", GRLIB_capture_size ] ];
private ["_sectorside", "_countenemy_guer", "_countenemy_west", "_countenemy_east", "_tower" ];

_cap_thresold_count = 3;
_sectorside = GRLIB_side_civilian; 
_countenemy_guer = [_thatpos, _localsize, GRLIB_side_enemy ] call F_getUnitsCount;
_countenemy_west = [_thatpos, _localsize, GRLIB_side_west ] call F_getUnitsCount;
_countenemy_east = [_thatpos, _localsize, GRLIB_side_east ] call F_getUnitsCount;

if ( _countenemy_guer >= _cap_thresold_count && _countenemy_guer > _countenemy_west && _countenemy_guer > _countenemy_east ) then { _sectorside = GRLIB_side_enemy; };
if ( _countenemy_west > _countenemy_guer && _countenemy_west > _countenemy_east ) then { _sectorside = GRLIB_side_west; };
if ( _countenemy_east > _countenemy_guer && _countenemy_east > _countenemy_west ) then { _sectorside = GRLIB_side_east; };

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
