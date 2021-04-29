params ["_uid"];

private _side = sideUnknown;
{
    if ( (getPlayerUID _x) ==  _uid) then { _side = _x getVariable ["GREUH_pvp_side", sideUnknown]};
} forEach allPlayers;

if (_side == sideUnknown) then {
    {
        private _p1 = _x;
        if ( (_p1 select 0) ==  _uid) then {_side = (_p1 select 4)};
    } forEach GRLIB_player_scores;
};

_side;