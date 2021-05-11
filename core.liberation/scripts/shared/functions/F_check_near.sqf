params ["_vehicle", "_list", "_dist", "_includeFOB"];

private _ret = false;
private _classlist = [];
private _object = [];
private _near = 0;
private _vehpos = getPosATL _vehicle;

if (isNil "_list") exitWith {_ret};
if (isNil "_dist") then {_dist = 15};
if (isNil "_includeFOB") then {_includeFOB = true};

switch ( _list ) do {
	case "SRV" : { _classlist = GRLIB_Marker_SRV};
	case "ATM" : { _classlist = GRLIB_Marker_ATM};
	case "FUEL" : { _classlist = GRLIB_Marker_FUEL};
	case "REPAIR" : { _classlist = GRLIB_Marker_REPAIR};
	case "RESPAWN" : { _object = ([] call get_myBeacons) + (_vehpos nearEntities [[Respawn_truck_typename, huron_typename], _distspawn])};
	case "MEDIC" : { _object = ai_healing_sources};
	case "ARSENAL" : { _object = Arsenal_typename};
	case "REAMMO" : { _object = vehicle_rearm_sources};
	case "REAMMO_AI" : { _object = ai_resupply_sources};
};

if (count(_classlist) == 0 ) then {
	// From Objects
	_near = (_vehpos nearEntities [_object, _dist]);
} else {
	// From GRLIB_Marker
	_near = _classlist select {( _vehpos distance2D _x) <= _dist};
};
if (count _near > 0) then {_ret = true};

// Include FOB
if (_includeFOB) then {
	_nearfob = [] call F_getNearestFob;
	_fobdistance = round (_vehpos distance2D _nearfob);
	if (_fobdistance <= (_dist * 2) ) then {_ret = true};
};

_ret;