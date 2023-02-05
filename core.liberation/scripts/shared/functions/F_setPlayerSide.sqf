params ["_uid", "_side"];

private _p1 = _uid call BIS_fnc_getUnitByUID;
if (!isNull _p1) then {
    _p1 setVariable ["GREUH_pvp_side", _side, true];
};
{
    if ( (_x select 0) == _uid) exitWith {_x set [5, _side]};
} forEach GRLIB_player_scores;
