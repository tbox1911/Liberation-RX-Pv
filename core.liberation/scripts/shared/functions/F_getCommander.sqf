private [ "_commanderobj" ];

_commanderobj = objNull;

{ if ( typeOf _x == commander_classname_west || typeOf _x == commander_classname_east ) exitWith { _commanderobj = _x }; } foreach allPlayers;

_commanderobj