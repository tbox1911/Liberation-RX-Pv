private [ "_markers", "_markers_mobilespawns", "_marker", "_idx", "_respawn_trucks", "_markers_mobilespawns" ];

_markers = [];
_markers_mobilespawns = [];

uiSleep 3;

while { true } do {
	private _myfobs = ([] call get_myFobs);
	if ( count _markers != count _myfobs ) then {
		{ deleteMarkerLocal _x } foreach _markers;
		_markers = [];
		for [ {_idx=0},{_idx < count _myfobs},{_idx=_idx+1}] do {
			_marker = createMarkerLocal [format ["fobmarker%1",_idx], markers_reset];
			_marker setMarkerTypeLocal "b_hq";
			_marker setMarkerSizeLocal [ 1.7, 1.7 ];
			_marker setMarkerPosLocal (_myfobs select _idx);
			_marker setMarkerTextLocal format ["FOB %1",military_alphabet select _idx];
			_marker setMarkerColorLocal "ColorYellow";
			_markers pushback _marker;
		};
	};

	_respawn_trucks = call F_getMobileRespawns;
	if ( count _markers_mobilespawns != count _respawn_trucks ) then {
		{ deleteMarkerLocal _x; } foreach _markers_mobilespawns;
		_markers_mobilespawns = [];
		for [ {_idx=0} , {_idx < (count _respawn_trucks)} , {_idx=_idx+1} ] do {
			_marker = createMarkerLocal [format ["mobilespawn%1",_idx], markers_reset];
			_marker setMarkerTypeLocal "mil_end";
			_marker setMarkerColorLocal "ColorYellow";
			_markers_mobilespawns pushback _marker;
		};
	};

	if ( count _respawn_trucks == count _markers_mobilespawns ) then {
		for [ {_idx=0},{_idx < (count _markers_mobilespawns)},{_idx=_idx+1} ] do {
			(_markers_mobilespawns select _idx) setMarkerPosLocal getpos (_respawn_trucks select _idx);
			(_markers_mobilespawns select _idx) setMarkerTextLocal format ["%1 %2",localize "STR_RESPAWN_TRUCK",mapGridPosition (_respawn_trucks select _idx)];
		};
	};

	sleep 5;
};
