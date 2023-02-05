//--- LRX Savegame
if (!isServer) exitWith {};
if (!isNil "GRLIB_server_stopped") exitWith {};
diag_log format [ "--- LRX Save start at %1", time ];

// BUILDINGS
private _classnames_to_save = [FOB_outpost, FOB_sign];
{
	_classnames_to_save pushback (_x select 0);
} foreach buildings + buildings_west + buildings_east;
// BLU
private _classnames_to_save_blu = [FOB_typename_west, huron_typename_west];
{
	_classnames_to_save_blu pushback (_x select 0);
} foreach (static_vehicles_west + air_vehicles_west + heavy_vehicles_west + light_vehicles_west + support_vehicles_west );
// RED
private _classnames_to_save_red = [FOB_typename_east, huron_typename_east];
{
	_classnames_to_save_red pushback (_x select 0);
} foreach (static_vehicles_east + air_vehicles_east + heavy_vehicles_east + light_vehicles_east + support_vehicles_east );

_classnames_to_save = _classnames_to_save + _classnames_to_save_blu + _classnames_to_save_red + all_hostile_classnames;
_classnames_to_save = _classnames_to_save arrayIntersect _classnames_to_save;

private _vehicles_light = GRLIB_vehicle_blacklist + list_static_weapons + uavs + [mobile_respawn];
{ _vehicles_light pushback (_x select 0) } foreach support_vehicles;
_vehicles_light = _vehicles_light arrayIntersect _vehicles_light;

if ( GRLIB_endgame == 1 ) then {
    if (GRLIB_param_wipe_keepscore == 1) then {
        GRLIB_permissions = profileNamespace getVariable GRLIB_save_key select 12;
        private _keep_players = [];
        {
            if (_x select 1 > GRLIB_perm_tank) then {
                _x set [1, GRLIB_perm_tank];  	// score
            };
            _x set [2, GREUH_start_ammo];  		// ammo
            _x set [3, GREUH_start_fuel];  		// fuel
            _keep_players pushback _x;
        } foreach (profileNamespace getVariable GRLIB_save_key select 15);
        GRLIB_player_scores = _keep_players;

        private _savegame = [
            [],
            [],
            [],
            time_of_day,
            0,
            [],
            GRLIB_mod_west,
            GRLIB_mod_east,
            0,
            [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
            [33, 33, 33],
            [],
            GRLIB_permissions,
            [],
            0,
            GRLIB_player_scores
        ];
        profileNamespace setVariable [ GRLIB_save_key, _savegame ];
    } else {
        profileNamespace setVariable [ GRLIB_save_key, nil ];
    };
    saveProfileNamespace;
} else {
    buildings_to_save = [];
    private _all_buildings = [];
    {
        _fobpos = _x;
        _nextbuildings = [ _fobpos nearobjects (GRLIB_fob_range * 2), {
            ( getObjectType _x >= 8 ) &&
            !(isSimpleObject _x) &&
            ((typeof _x) in _classnames_to_save ) &&
            ( alive _x) &&
            ( speed vehicle _x < 5 ) &&
            ( isNull attachedTo _x ) &&
            (((getPosATL _x) select 2) < 10 ) &&
            (_x getVariable ["GRLIB_vehicle_owner", ""] != "server")
        }] call BIS_fnc_conditionalSelect;
        _all_buildings = _all_buildings + _nextbuildings;
    } foreach GRLIB_fobs_west + GRLIB_fobs_east;

    // Filter low score Player
    private _player_scores = [];
    private _keep_score_id = ["Default"];
    {
        _id = _x select 0;
        _score = _x select 1;
        if (_score >= GRLIB_min_score_player) then {
            _keep_score_id pushback _id;
            _player_scores pushback _x;
        };
    } forEach GRLIB_player_scores;

    // Save objects
    {
        private _savedpos = getPosWorld _x;
        private _nextclass = typeof _x;
        private _nextdir = getdir _x;
        private _hascrew = false;
        private _owner = "";
        private _color = "";
        private _color_name = "";
        private _lst_a3 = [];
        private	_lst_r3f = [];
        private	_lst_grl = [];
        private _compo = [];

        if ( _nextclass in _classnames_to_save_blu + _classnames_to_save_red + all_hostile_classnames ) then {
            if (side _x != GRLIB_side_enemy) then {
                _owner = _x getVariable ["GRLIB_vehicle_owner", ""];
                _hascrew = _x getVariable ["GRLIB_vehicle_manned", false];
                if (_owner == "") then {
                    buildings_to_save pushback [ _nextclass, _savedpos, _nextdir, _hascrew ];
                };
                if (_owner == "public") then {
                    buildings_to_save pushback [ _nextclass, _savedpos, _nextdir, _hascrew, _owner ];
                };

                if (_owner in _keep_score_id) then {
                    if (_nextclass in _vehicles_light) then {
                        if ( _nextclass == playerbox_typename ) then {
                            buildings_to_save pushback [ _nextclass, _savedpos, _nextdir, _hascrew, _owner, [_x] call F_getCargo ];
                        } else {
                            buildings_to_save pushback [ _nextclass, _savedpos, _nextdir, _hascrew, _owner ];
                        };
                    } else {
                        _color = _x getVariable ["GRLIB_vehicle_color", ""];
                        _color_name = _x getVariable ["GRLIB_vehicle_color_name", ""];
                        _compo = _x getVariable ["GRLIB_vehicle_composant", []];
                        _lst_a3 = [_x] call F_getCargo;
                        {_lst_r3f pushback (typeOf _x)} forEach (_x getVariable ["R3F_LOG_objets_charges", []]);
                        {_lst_grl pushback (typeOf _x)} forEach (_x getVariable ["GRLIB_ammo_truck_load", []]);
                        buildings_to_save pushback [ _nextclass, _savedpos, _nextdir, _hascrew, _owner, _color, _color_name, _lst_a3, _lst_r3f, _lst_grl, _compo];
                    };
                };
            };
        } else {
            buildings_to_save pushback [ _nextclass, _savedpos, _nextdir ];
        };
    } foreach _all_buildings;

    // Save scores
    private _permissions = [];
    {
        _id = _x select 0;
        if (_id in _keep_score_id) then {_permissions pushback _x};
    } forEach GRLIB_permissions;

    time_of_day = date select 3;
    stats_saves_performed = stats_saves_performed + 1;

    _stats = [];
    _stats pushback stats_opfor_soldiers_killed;
    _stats pushback stats_opfor_killed_by_players;
    _stats pushback stats_blufor_soldiers_killed;
    _stats pushback stats_player_deaths;
    _stats pushback stats_opfor_vehicles_killed;
    _stats pushback stats_opfor_vehicles_killed_by_players;
    _stats pushback stats_blufor_vehicles_killed;
    _stats pushback stats_blufor_soldiers_recruited;
    _stats pushback stats_blufor_vehicles_built;
    _stats pushback stats_civilians_killed;
    _stats pushback stats_civilians_killed_by_players;
    _stats pushback stats_sectors_liberated;
    _stats pushback stats_playtime;
    _stats pushback stats_spartan_respawns;
    _stats pushback stats_secondary_objectives;
    _stats pushback stats_hostile_battlegroups;
    _stats pushback stats_ieds_detonated;
    _stats pushback stats_saves_performed;
    _stats pushback stats_saves_loaded;
    _stats pushback stats_reinforcements_called;
    _stats pushback stats_prisonners_captured;
    _stats pushback stats_blufor_teamkills;
    _stats pushback stats_vehicles_recycled;
    _stats pushback stats_ammo_spent;
    _stats pushback stats_sectors_lost;
    _stats pushback stats_fobs_built;
    _stats pushback stats_fobs_lost;
    _stats pushback stats_readiness_earned;

    greuh_liberation_savegame = [
        west_sectors,
        east_sectors,
        GRLIB_fobs_west,
        GRLIB_fobs_east,
        time_of_day,
        round combat_readiness,
        GRLIB_garage,
        buildings_to_save,
        0,		//free for extened use
        _stats,
        [ round infantry_weight max 33, round armor_weight max 33, round air_weight max 33 ],
        GRLIB_vehicle_to_military_base_links,
        _permissions,
        resources_intel_west,
        resources_intel_east,
        _player_scores,
        GRLIB_mod_west,GRLIB_mod_east,
        GRLIB_player_context
    ];

    profileNamespace setVariable [ GRLIB_save_key, greuh_liberation_savegame ];
    saveProfileNamespace;
    diag_log format [ "--- LRX Save %1 in Profile at %2", GRLIB_save_key, time ];
};

diag_log format [ "--- LRX Save finish at %1", time ];
