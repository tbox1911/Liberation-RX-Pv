private _distfob = 100;
private _distarsenal = 10;
private _distspawn = 10;
private _distredeploy = 20;
private _distveh = 15;
private _distvehclose = 5;
private _icon_dog = (getText (configFile >> "CfgVehicleIcons" >> "iconAnimal"));
private _icon_grp = "\a3\Ui_F_Curator\Data\Displays\RscDisplayCurator\modeGroups_ca.paa";
private _icon_tuto = "\a3\ui_f\data\map\markers\handdrawn\unknown_ca.paa";

private _id_actions = [
	-1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
	-1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
	-1, -1, -1, -1, -1, -1, -1, -1, -1, -1
];

is_DogOnDuty = {
	private _ret = false;
	private _my_dog = player getVariable ["my_dog", nil];

	if (!isNil {_my_dog getVariable ["do_find", nil]} || stopped _my_dog) then { _ret = true };
	_ret;
};

waitUntil { sleep 1; !isNil "build_confirmed" };
waitUntil { sleep 1; !isNil "one_synchro_done" };
waitUntil { sleep 1; one_synchro_done };
waitUntil { sleep 1; !isNil "GRLIB_player_spawned" };
waituntil { sleep 1; GRLIB_player_spawned; (player getVariable ["GRLIB_score_set", 0] == 1)};
waitUntil { sleep 1; !isNil "GRLIB_mobile_respawn" };
waituntil { sleep 1; !isNil "GRLIB_marker_init" };
if (!(player diarySubjectExists str(parseText GRLIB_r3))) exitWith {};

while { true } do {
	if ([] call is_menuok) then {
		_fobdistance = round (player distance2D ([] call F_getNearestFob));
		_near_arsenal = [player, "ARSENAL", _distarsenal, true] call F_check_near;
		_near_spawn = ([player, "RESPAWN", _distvehclose, true] call F_check_near) || (count(player nearEntities [[Respawn_truck_typename, huron_typename], _distspawn])>0) ;
		_near_fobbox = player nearEntities [[FOB_box_typename, FOB_truck_typename], _distspawn];
		_near_fuel = [player, "FUEL", _distvehclose, false] call F_check_near;
		_near_repair = [player, "REPAIR", _distvehclose, false] call F_check_near;
		_near_atm = [player, "ATM", _distvehclose, true] call F_check_near;
		_my_dog = player getVariable ["my_dog", objNull];
		_my_squad = player getVariable ["my_squad", objNull];

		// Tuto
		_idact_tutorial = _id_actions select 0;
		if ((player distance my_lhd) <= GRLIB_sector_size ) then {
			if ( _idact_tutorial == -1 ) then {
				_idact = player addAction ["<t color='#80FF80'>" + localize "STR_TUTO_ACTION" + "</t> <img size='1' image='" + _icon_tuto + "'/>","[] execVM 'scripts\client\ui\tutorial_manager.sqf'","",-740,false,true,"",""];
				_id_actions set [0, _idact];
			};
		} else {
			if ( _idact_tutorial != -1 ) then {
				player removeAction _idact_tutorial;
				_id_actions set [0, -1];
			};
		};

		// Dog - Actions
		_idact_dog_action1 = _id_actions select 1;
		if (!isNull _my_dog ) then {
			if ( _idact_dog_action1 == -1 ) then {
				_idact = player addAction ["<t color='#80FF80'>" + "-- DOG FIND"+ "</t> <img size='1' image='" + _icon_dog + "'/>","scripts\client\actions\do_dog.sqf","find",-640,false,true,"","!call is_DogOnDuty"];
				_id_actions set [1, _idact];
				_idact = player addAction ["<t color='#80FF80'>" + "-- DOG RECALL"+ "</t> <img size='1' image='" + _icon_dog + "'/>","scripts\client\actions\do_dog.sqf","recall",-640,false,true,"","call is_DogOnDuty"];
				_id_actions set [2, _idact];
				_idact = player addAction ["<t color='#80FF80'>" + "-- DOG STOP" + "</t> <img size='1' image='" + _icon_dog + "'/>","scripts\client\actions\do_dog.sqf","stop",-641,false,true,"","!call is_DogOnDuty"];
				_id_actions set [3, _idact];
				_idact = player addAction ["<t color='#FF8080'>" + "-- DOG DISMISS" + "</t> <img size='1' image='" + _icon_dog + "'/>","scripts\client\actions\do_dog.sqf","del",-641,false,true,"",""];
				_id_actions set [4, _idact];
			};
		} else {
			if ( _idact_dog_action1 != -1 ) then {
				player removeAction _idact_dog_action1;
				_id_actions set [1, -1];
				_idact_dog_action2 = _id_actions select 2;
				player removeAction _idact_dog_action2;
				_id_actions set [2, -1];
				_idact_dog_action3 = _id_actions select 3;
				player removeAction _idact_dog_action3;
				_id_actions set [3, -1];
				_idact_dog_action4 = _id_actions select 4;
				player removeAction _idact_dog_action4;
				_id_actions set [4, -1];
			};
		};

		// Squad - Actions
		_idact_squad_action1 = _id_actions select 5;
		if (!isNull _my_squad ) then {
			if ( _idact_squad_action1 == -1 ) then {
				_idact = player addAction ["<t color='#80FF80'>" + "-- SQUAD MOVE"+ "</t> <img size='1' image='" + _icon_grp + "'/>","scripts\client\actions\do_squad.sqf","move",-635,false,true,"",""];
				_id_actions set [5, _idact];
				_idact = player addAction ["<t color='#80FF80'>" + "-- SQUAD FOLLOW"+ "</t> <img size='1' image='" + _icon_grp + "'/>","scripts\client\actions\do_squad.sqf","follow",-635,false,true,"",""];
				_id_actions set [6, _idact];
				_idact = player addAction ["<t color='#80FF80'>" + "-- SQUAD STOP"+ "</t> <img size='1' image='" + _icon_grp + "'/>","scripts\client\actions\do_squad.sqf","stop",-635,false,true,"",""];
				_id_actions set [7, _idact];
				_idact = player addAction ["<t color='#80FF80'>" + "-- SQUAD DISMISS"+ "</t> <img size='1' image='" + _icon_grp + "'/>","scripts\client\actions\do_squad.sqf","del",-635,false,true,"",""];
				_id_actions set [8, _idact];
			};
		} else {
			if ( _idact_squad_action1 != -1 ) then {
				player removeAction _idact_squad_action1;
				_id_actions set [5, -1];
				_idact_squad_action2 = _id_actions select 6;
				player removeAction _idact_squad_action2;
				_id_actions set [6, -1];
				_idact_squad_action3 = _id_actions select 7;
				player removeAction _idact_squad_action3;
				_id_actions set [7, -1];
				_idact_squad_action4 = _id_actions select 8;
				player removeAction _idact_squad_action4;
				_id_actions set [8, -1];
			};
		};

		// Halo Jump
		_idact_halo = _id_actions select 9;
		if ((_fobdistance < _distredeploy || _near_spawn || (player distance my_lhd) <= 200) && GRLIB_halo_param > 0) then {
			if ( _idact_halo == -1 ) then {
				_idact = player addAction ["<t color='#80FF80'>" + localize "STR_HALO_ACTION" + "</t> <img size='1' image='res\ui_redeploy.paa'/>","scripts\client\spawn\do_halo.sqf","",-749,false,true,"","build_confirmed == 0"];
				_id_actions set [9, _idact];
			};
		} else {
			if ( _idact_halo != -1 ) then {
				player removeAction _idact_halo;
				_id_actions set [9, -1];
			};
		};

		// Send Ammo
		_idact_send = _id_actions select 10;
		if  ([] call is_menuok && score player > 20 && ( (player distance my_lhd) <= 200 || _near_atm ) && count AllPlayers > 1 ) then {
			if ( _idact_send == -1 ) then {
				_idact = player addAction ["<t color='#80FF00'>-- SEND AMMO</t> <img size='1' image='res\ui_arsenal.paa'/>","scripts\client\misc\send_ammo.sqf","",-981,true,true,"","build_confirmed == 0"];
				_id_actions set [10, _idact];
			};
		} else {
			if ( _idact_send != -1 ) then {
				player removeAction _idact_send;
				_id_actions set [10, -1];
			};
		};

		// Fuel
		_idact_buyfuel = _id_actions select 11;
		if ((player distance my_lhd) >= GRLIB_sector_size && (_near_fuel || _near_repair) ) then {
			if ( _idact_buyfuel == -1 ) then {
				_idact = player addAction ["<t color='#00F080'>-- BUY FUEL</t> <img size='1' image='R3F_LOG\icons\r3f_fuel.paa'/>", "scripts\client\actions\do_buyfuel.sqf","",-900,true,true,"",""];
				_id_actions set [11, _idact];
			};
		} else {
			if ( _idact_buyfuel != -1 ) then {
				player removeAction _idact_buyfuel;
				_id_actions set [11, -1];
			};
		};

		// Heal Self
		_idact_heal = _id_actions select 12;
		if ((_fobdistance < _distarsenal || (player distance my_lhd) <= 200) && (damage player) >= 0.023) then {
			if ( _idact_heal == -1 ) then {
				_idact = player addAction ["<img size='1' image='\a3\ui_f\data\IGUI\Cfg\Actions\heal_ca'/>", { (_this select 1) playMove "AinvPknlMstpSlayWnonDnon_medic"; (_this select 1) setDamage 0;},"",999,true,true,"", ""];
				_id_actions set [12, _idact];
			};
		} else {
			if ( _idact_heal != -1 ) then {
				player removeAction _idact_heal;
				_id_actions set [12, -1];
			};
		};

		// Take Leadrship
		_idact_lead = _id_actions select 13;
		if (!(isPlayer (leader (group player))) && (local (group player)) ) then {
			if ( _idact_lead == -1 ) then {
				_idact = player addAction ["<t color='#80FF80'>-- TAKE LEADRSHIP</t> <img size='1' image='" + _icon_grp + "'/>", {(group player) selectLeader player}, [],0,true,true,"", "build_confirmed == 0"];
				_id_actions set [13, _idact];
			};
		} else {
			if ( _idact_lead != -1 ) then {
				player removeAction _idact_lead;
				_id_actions set [13, -1];
			};
		};

		// Air Drop
		_idact_drop = _id_actions select 14;
		if ((player distance ([] call F_getNearestFob)) >= (2 * GRLIB_fob_range) && (player distance my_lhd >= GRLIB_sector_size) ) then {
			if ( _idact_drop == -1 ) then {
				_idact = player addAction ["<t color='#00F0F0'>-- AIR SUPPORT</t> <img size='1' image='R3F_LOG\icons\r3f_drop.paa'/>","scripts\client\misc\drop_support.sqf","",-980,false,true];
				_id_actions set [14, _idact];
			};
		} else {
			if ( _idact_drop != -1 ) then {
				player removeAction _idact_drop;
				_id_actions set [14, -1];
			};
		};

		// Redeploy
		_idact_redeploy = _id_actions select 15;
		if ((_fobdistance < _distredeploy || _near_spawn || (player distance my_lhd) <= 200) ) then {
			if ( _idact_redeploy == -1 ) then {
				_idact = player addAction ["<t color='#80FF80'>" + localize "STR_DEPLOY_ACTION" + "</t> <img size='1' image='res\ui_redeploy.paa'/>","scripts\client\spawn\redeploy_manager.sqf","",-750,false,true,"","build_confirmed == 0"];
				_id_actions set [15, _idact];
			};
		} else {
			if ( _idact_redeploy != -1 ) then {
				player removeAction _idact_redeploy;
				_id_actions set [15, -1];
			};
		};

		// Arsenal
		_idact_arsenal = _id_actions select 16;
		if (GRLIB_enable_arsenal && (_near_arsenal || (player distance my_lhd) <= 200) ) then {
			if (_idact_arsenal == -1) then {
				_idact = player addAction ["<t color='#FFFF00'>" + localize "STR_ARSENAL_ACTION" + "</t> <img size='1' image='res\ui_arsenal.paa'/>","scripts\client\actions\open_arsenal.sqf","",-500,true,true,"","build_confirmed == 0"];
				_id_actions set [16, _idact];
			};
		} else {
			if ( _idact_arsenal != -1 ) then {
				player removeAction _idact_arsenal;
				_id_actions set [16, -1];
			};
		};

		// Virtual Garage
		_idact_garage = _id_actions select 17;
		if (_fobdistance > 15 && _fobdistance < _distfob && (player distance my_lhd) >= GRLIB_sector_size && score player >= GRLIB_perm_inf ) then {
			if ( _idact_garage == -1 ) then {
				_idact = player addAction ["<t color='#0080FF'>-- VIRTUAL GARAGE" + "</t> <img size='1' image='res\ui_veh.paa'/>","addons\VIRT\virtual_garage.sqf","",-984,false,true,"",""];
				_id_actions set [17, _idact];
			};
		} else {
			if ( _idact_garage != -1 ) then {
				player removeAction _idact_garage;
				_id_actions set [17, -1];
			};
		};

		// Build Menu
		_idact_build = _id_actions select 18;
		if (_fobdistance < _distfob && (player distance my_lhd) >= GRLIB_sector_size && ( ([player, 3] call fetch_permission) || (player == ([] call F_getCommander) || [] call is_admin)) ) then {
			if ( _idact_build == -1 ) then {
				_idact = player addAction ["<t color='#FFFF00'>" + localize "STR_BUILD_ACTION" + "</t> <img size='1' image='res\ui_build.paa'/>","scripts\client\build\open_build_menu.sqf","",-985,false,true,"","build_confirmed == 0"];
				_id_actions set [18, _idact];
			};
		} else {
			if ( _idact_build != -1 ) then {
				player removeAction _idact_build;
				_id_actions set [18, -1];
			};
		};

		// Squad Management
		_idact_squad = _id_actions select 19;
		if ((leader group player == player) && (count units group player > 1) && (_fobdistance < _distfob || (player distance my_lhd) <= 200) ) then {
			if ( _idact_squad == -1 ) then {
				_idact = player addAction ["<t color='#80FF80'>" + localize "STR_SQUAD_MANAGEMENT_ACTION" + "</t> <img size='1' image='" + _icon_grp + "'/>","scripts\client\ui\squad_management.sqf","",-760,false,true,"","build_confirmed == 0"];
				_id_actions set [19, _idact];
			};
		} else {
			if ( _idact_squad != -1 ) then {
				player removeAction _idact_squad;
				_id_actions set [19, -1];
			};
		};

		// Commander Menu
		_idact_commander = _id_actions select 20;
		if (( player == ( [] call F_getCommander ) || [] call is_admin ) && GRLIB_permissions_param ) then {
			if ( _idact_commander == -1 ) then {
				_idact = player addAction ["<t color='#FF8000'>" + localize "STR_COMMANDER_ACTION" + "</t> <img size='1' image='" + _icon_grp + "'/>","scripts\client\commander\open_permissions.sqf","",-996,false,true,"","build_confirmed == 0"];
				_id_actions set [20, _idact];
			};
		} else {
			if ( _idact_commander != -1 ) then {
				player removeAction _idact_commander;
				_id_actions set [20, -1];
			};
		};

		// Secondary Objectives
		_idact_secondary = _id_actions select 21;
		if (count ([] call get_myFobs) > 0 && ( GRLIB_endgame == 0 ) && (_fobdistance < _distredeploy || (player distance my_lhd) <= 200) && (score player >= GRLIB_perm_air ||  player == ( [] call F_getCommander ) || [] call is_admin) ) then {
			if ( _idact_secondary == -1 ) then {
				_idact = player addAction ["<t color='#FFFF00'>" + localize "STR_SECONDARY_OBJECTIVES" + "</t>","scripts\client\ui\secondary_ui.sqf","",-995,false,true,"","build_confirmed == 0"];
				_id_actions set [21, _idact];
			};
		} else {
			if ( _idact_secondary != -1 ) then {
				player removeAction _idact_secondary;
				_id_actions set [21, -1];
			};
		};

		// Pack FOB
		_idact_packfob = _id_actions select 22;
		if ((_fobdistance < _distarsenal && (player distance my_lhd) >= GRLIB_sector_size) && ( (score player >= GRLIB_perm_max) || (player == ( [] call F_getCommander ) || [] call is_admin) )) then {
			if ( _idact_packfob == -1 ) then {
				_idact = player addAction ["<t color='#FF6F00'>" + localize "STR_FOB_REPACKAGE" + "</t> <img size='1' image='res\ui_deployfob.paa'/>","scripts\client\actions\do_repackage_fob.sqf",([] call F_getNearestFob),-981,false,true,"","build_confirmed == 0 && !(cursorObject getVariable ['fob_in_use', false])"];
				_id_actions set [22, _idact];
			};
		} else {
			if ( _idact_packfob != -1 ) then {
				player removeAction _idact_packfob;
				_id_actions set [22, -1];
			};
		};

		// Build FOB
		_idact_unpackfob = _id_actions select 23;
		if ((_fobdistance > GRLIB_sector_size && (player distance my_lhd) >= GRLIB_sector_size) && cursorObject in _near_fobbox ) then {
			if ( _idact_unpackfob == -1 ) then {
				_idact = player addAction ["<t color='#FF6F00'>" + localize "STR_FOB_ACTION" + "</t> <img size='1' image='res\ui_deployfob.paa'/>","scripts\client\actions\do_build_fob.sqf",cursorObject,-981,false,true,"","build_confirmed == 0 && !(cursorObject getVariable ['box_in_use', false])"];
				_id_actions set [23, _idact];
			};
		} else {
			if ( _idact_unpackfob != -1 ) then {
				player removeAction _idact_unpackfob;
				_id_actions set [23, -1];
			};
		};

		// Pack Beacon
		_idact_packtent = _id_actions select 24;
		if ((player distance my_lhd) >= GRLIB_sector_size && typeOf cursorObject == mobile_respawn ) then {
			if ( _idact_packtent == -1 ) then {
				_idact = player addAction ["<t color='#FFFF00'>-- PACK BEACON</t> <img size='1' image='res\ui_deployfob.paa'/>","scripts\client\actions\do_beacon_pack.sqf",cursorObject,-950,true,true,"","!(cursorObject getVariable ['tent_in_use', false])"];
				_id_actions set [24, _idact];
			};
		} else {
			if ( _idact_packtent != -1 ) then {
				player removeAction _idact_packtent;
				_id_actions set [24, -1];
			};
		};

		// UnPack Beacon
		_idact_unpacktent = _id_actions select 25;
		if ((player distance my_lhd) >= GRLIB_sector_size && backpack player == mobile_respawn_bag ) then {
			if ( _idact_unpacktent == -1 ) then {
				_idact = player addAction ["<t color='#FFFF00'>-- UNPACK BEACON</t> <img size='1' image='res\ui_deployfob.paa'/>","scripts\client\actions\do_beacon_unpack.sqf","",-950,true,true,"",""];
				_id_actions set [25, _idact];
			};
		} else {
			if ( _idact_unpacktent != -1 ) then {
				player removeAction _idact_unpacktent;
				_id_actions set [25, -1];
			};
		};

		// Options
		_idact_options = _id_actions select 26;
		if ( (_fobdistance < _distredeploy || (player distance my_lhd) <= 200) ) then {
			if ( _idact_options == -1 ) then {
				_idact = player addAction ["<t color='#FF8000'>-- Extended Options</t>","GREUH\scripts\GREUH_dialog.sqf","",-997,false,true];
				_id_actions set [26, _idact];
			};
		} else {
			if ( _idact_options != -1 ) then {
				player removeAction _idact_options;
				_id_actions set [26, -1];
			};
		};

		// Admin Menu
		_idact_admin = _id_actions select 27;
		if (([] call is_admin) && GRLIB_admin_menu ) then {
			if ( _idact_admin == -1 ) then {
				_idact = player addAction ["<t color='#0000F8'>-- ADMIN MENU</t>","scripts\client\commander\admin_menu.sqf","",999,false,true,"",""];
				_id_actions set [27, _idact];
			};
		} else {
			if ( _idact_admin != -1 ) then {
				player removeAction _idact_admin;
				_id_actions set [27, -1];
			};
		};
	} else {
		{
			if (_x != -1) then {
				player removeAction _x;
				_id_actions set [_forEachIndex, -1];
			};
		} forEach _id_actions;
	};

	sleep 2;
};
