params [ "_fob" ];

private _fobside = GRLIB_side_west;
if (_fob in GRLIB_fobs_east) then { _fobside = GRLIB_side_east; };

_fobside;