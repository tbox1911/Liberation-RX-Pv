params ["_uid"];

private _side = str sideUnknown;
private _p1 = _uid call BIS_fnc_getUnitByUID;
if (!isNull _p1) then {_side = _p1 getVariable ["GREUH_pvp_side", str sideUnknown]};

if (_side == str sideUnknown) then {
    {
        if ( (_x select 0) == _uid) exitWith {_side = (_x select 5)};
    } forEach GRLIB_player_scores;
};

_side;