params ["_vehicle"];
private _distveh = 15;
private _ret = false;
private _nearfuel = nearestObjects [(getPosATL _vehicle), [canister_fuel_typename, fuelbarrel_typename], _distveh];
if (count _nearfuel > 0) then {_ret = true};

_ret;