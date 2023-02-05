params [ "_sector", "_radius", "_number" ];
private [ "_activation_radius_infantry", "_activation_radius_vehicles", "_spread", "_infantry_trigger", "_ultra_strong", "_vehicle_trigger", "_ied_type", "_ied_obj", "_roadobj", "_goes_boom"];

if (_number == 0) exitWith {};
if (_number >= 1) then {
	[ _sector, _radius, _number - 1 ] spawn ied_manager;
};

_activation_radius_infantry = 6.66;
_activation_radius_vehicles = 12;

_spread = 7;
_infantry_trigger = 2 + (floor (random 3));
_ultra_strong = false;
if ( floor(random 100) < 30 ) then {
	_ultra_strong = true;
};
_vehicle_trigger = 1;
_ied_type = selectRandom [ "IEDLandBig_F","IEDLandSmall_F","IEDUrbanBig_F","IEDUrbanSmall_F" ];
_ied_obj = objNull;
_roadobj = [ [  getmarkerpos (_sector), floor(random _radius), random(360)  ] call BIS_fnc_relPos, _radius, [] ] call BIS_fnc_nearestRoad;
_goes_boom = false;

if ( !(isnull _roadobj) ) then {

	_roadpos = getposATL _roadobj;
	_ied_obj = createMine [ _ied_type, [ _roadpos, _spread, random(360) ] call BIS_fnc_relPos, [], 0];
	_ied_obj setdir (random 360);

	_timeout = time + (30 * 60);
	while {time < _timeout && mineActive _ied_obj && !_goes_boom } do {
		_nearinfantry = [ (getposATL _ied_obj) nearEntities [ "Man", _activation_radius_infantry ] , { side _x in [ GRLIB_side_west, GRLIB_side_east ] } ] call BIS_fnc_conditionalSelect;
		_nearvehicles = [ (getposATL _ied_obj) nearEntities [ [ "Car", "Tank", "Air" ], _activation_radius_vehicles ] , { side _x in [ GRLIB_side_west, GRLIB_side_east ] } ] call BIS_fnc_conditionalSelect;
		if ( count _nearinfantry >= _infantry_trigger || count _nearvehicles >= _vehicle_trigger ) then {
			if ( _ultra_strong ) then {
				"Bomb_04_F" createVehicle (getposATL _ied_obj);
				deleteVehicle _ied_obj;
			} else {
				_ied_obj setDamage 1;
			};
			stats_ieds_detonated = stats_ieds_detonated + 1; publicVariable "stats_ieds_detonated";
			_goes_boom = true;
		};
		sleep 1;
	};
};
