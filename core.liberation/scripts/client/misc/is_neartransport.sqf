params ["_vehicle"];
private _ret = false;

private _neartruck = [nearestObjects [player, transport_vehicles, 20], {
	(_x distance my_lhd) >= GRLIB_sector_size &&
	([player, _x] call is_owner || [_x] call is_public) &&
	!(_x getVariable ['R3F_LOG_disabled', false])
}] call BIS_fnc_conditionalSelect;

if (count(_neartruck) > 0) then { _ret = true };
_ret;
