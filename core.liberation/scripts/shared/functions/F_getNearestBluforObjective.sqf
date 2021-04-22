params [ "_startpos" ];
private [ "_currentnearest", "_refdistance", "_tpositions"];

_currentnearest = [];
_refdistance = 99999;
_tpositions = [];

if ( count GRLIB_fobs_west != 0 || count west_sectors != 0 ) then {

	{ _tpositions pushback _x; } foreach GRLIB_fobs_west;

	{
		if ( _startpos distance2D _x < _refdistance ) then {
			_refdistance = (_startpos distance2D _x);
			_currentnearest = [_x,_refdistance];
		};
	} foreach _tpositions;

	if ( _refdistance > 4000 ) then {
		{
			_tpositions pushback (markerpos _x);
		} foreach west_sectors;

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
