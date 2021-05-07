params ["_uid"];

private _side = sideUnknown;
private _p1 = _uid call BIS_fnc_getUnitByUID;
if (!isNull _p1) then {_side = _p1 getVariable ["GREUH_pvp_side", sideUnknown]};

if (_side == sideUnknown) then {
    {
        _p1 = _x;
        if ( (_p1 select 0) == _uid) then {_side = (_p1 select 4)};
    } forEach GRLIB_player_scores;
};

_side;