params [ "_startpos" ];
private [ "_currentnearest", "_refdistance", "_tpositions"];

_currentnearest = [];
_refdistance = 99999;
_tpositions = [];

if ( count GRLIB_fobs_west != 0 || count west_sectors != 0 || count GRLIB_fobs_east != 0 || count east_sectors != 0) then {

	{ _tpositions pushback _x; } foreach GRLIB_fobs_west + GRLIB_fobs_east;

	{
		if ( _startpos distance2D _x < _refdistance ) then {
			_refdistance = (_startpos distance2D _x);
			_currentnearest = [_x,_refdistance];
		};
	} foreach _tpositions;

	if ( _refdistance > 4000 ) then {
		{
			_tpositions pushback (markerpos _x);
		} foreach west_sectors + east_sectors;

		{
			if ( _startpos distance2D _x < _refdistance ) then {
				_refdistance = (_startpos distance2D _x);
				_currentnearest = [_x,_refdistance];
			};
		} foreach _tpositions;
	};
} else {
	_currentnearest = _startpos;
};

_currentnearest
