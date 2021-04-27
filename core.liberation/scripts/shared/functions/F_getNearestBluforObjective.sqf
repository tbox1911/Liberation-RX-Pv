params [ "_startpos" ];
private [ "_currentnearest", "_refdistance", "_tpositions"];

_currentnearest = [];
_refdistance = 99999;
_tpositions = [];

if ( count GRLIB_fobs_west != 0 || count west_sectors != 0 || count GRLIB_fobs_east != 0 || count east_sectors != 0) then {
	private _west_units = count(allPlayers select {side _x == GRLIB_side_west});
	private _east_units = count(allPlayers select {side _x == GRLIB_side_east});

	private _fob_lists = GRLIB_fobs_west + GRLIB_fobs_east;
	if (_west_units > _east_units) then {
		_fob_lists = GRLIB_fobs_west;
	};
	if (_east_units > _west_units) then {
		_fob_lists = GRLIB_fobs_east;
	};
	{ _tpositions pushback _x; } foreach _fob_lists;

	{
		if ( _startpos distance2D _x < _refdistance ) then {
			_refdistance = (_startpos distance2D _x);
			_currentnearest = [_x,_refdistance];
		};
	} foreach _tpositions;

	if ( _refdistance > 4000 ) then {
		private _sectors_list = west_sectors + east_sectors;
		if (_west_units > _east_units) then {
			_sectors_list = west_sectors;
		};
		if (_east_units > _west_units) then {
			_sectors_list = east_sectors;
		};
		{
			_tpositions pushback (markerpos _x);
		} foreach _sectors_list;

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
