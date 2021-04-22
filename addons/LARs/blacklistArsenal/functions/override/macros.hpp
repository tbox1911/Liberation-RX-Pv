#define DEBUG( msg ) if ( getMissionConfigValue[ "LARs_overrideVA_debug", 0 ] > 0 ) then {  diag_log msg };
	
//item, weapon, magazine, backpack
#define CONDITION( GEAR ) switch ( toUpper (( GEAR call BIS_fnc_itemType ) select 0 ) ) do { \
	case ( "EQUIPMENT" ) : { \
		switch ( toUpper (( GEAR call BIS_fnc_itemType ) select 1 ) ) do { \
			case ( "BACKPACK" ) : { \
				_msg = format[ "LOAD: %1 allowed %2", GEAR, (( toLower GEAR ) in ( _whitelist select 3 )) || { "%all" in ( _whiteList select 3 ) } ]; \
				DEBUG( _msg ); \
				(( toLower GEAR ) in ( _whitelist select 3 )) || { "%all" in ( _whiteList select 3 ) } \
			}; \
			default { \
				_msg = format[ "LOAD: %1 allowed %2", GEAR, (( toLower GEAR ) in ( _whitelist select 0 )) || { "%all" in ( _whiteList select 0 ) } ]; \
				DEBUG( _msg ); \
				(( toLower GEAR ) in ( _whitelist select 0 )) || { "%all" in ( _whiteList select 0 ) } \
			}; \
		}; \
	}; \
	case ( "ITEM" ) : { \
		_msg = format[ "LOAD: %1 allowed %2", GEAR, (( toLower GEAR ) in ( _whitelist select 0 )) || { "%all" in ( _whiteList select 0 ) } ]; \
		DEBUG( _msg ); \
		(( toLower GEAR ) in ( _whitelist select 0 )) || { "%all" in ( _whiteList select 0 ) } \
	}; \
	case ( "WEAPON" ) : { \
		_msg = format[ "LOAD: %1 allowed %2", GEAR, (( toLower GEAR ) in ( _whitelist select 1 )) || { "%all" in ( _whiteList select 1 ) } ]; \
		DEBUG( _msg ); \
		(( toLower GEAR ) in ( _whitelist select 1 )) || { "%all" in ( _whiteList select 1 ) } \
	}; \
	case ( "MINE" ); \
	case ( "MAGAZINE" ) : { \
		_msg = format[ "LOAD: %1 allowed %2", GEAR, (( toLower GEAR ) in ( _whitelist select 2 )) || { "%all" in ( _whiteList select 2 ) } ]; \
		DEBUG( _msg ); \
		(( toLower GEAR ) in ( _whitelist select 2 )) || { "%all" in ( _whiteList select 2 ) } \
	}; \
	default { \
		false \
	}; \
}