params ["_unit"];
// Cleanup
{_unit removeAllEventHandlers _x} count [
	"GetInMan",
	"GetOutMan",
	"SeatSwitchedMan",
	"InventoryOpened",
	"InventoryClosed",
	"FiredMan",
	"WeaponAssembled",
	"Take"
];

// For all

// Cannot DisAssemble
_unit enableWeaponDisassembly false;

// Check Veh perms
_unit addEventHandler ["GetInMan", {_this spawn vehicle_permissions}];
_unit addEventHandler ["SeatSwitchedMan", {_this spawn vehicle_permissions}];

_unit addEventHandler ["GetOutMan", {
	params ["_unit", "_role", "_vehicle"];
	if (_vehicle == getConnectedUAV player) then {
		objNull remoteControl _unit;
		player switchCamera cameraView;
	};
}];

_unit addEventHandler ["InventoryClosed", {
	params ["_unit"];
	[_unit] call F_filterLoadout;
	if (_unit == player) then {
		hintSilent format ["Inventory value:\n%1 AMMO.", ([_unit] call F_loadoutPrice)];
	};
}];

_unit addEventHandler ["InventoryOpened", {
	params ["_unit", "_container"];
	_ret = false;
	playsound "ZoomIn";
	if ((typeOf _container in support_box_noArsenal) || (!alive _container)) exitWith { _ret };
	if (!([_unit, _container] call is_owner) || locked _container > 1) then {
		closeDialog 106;
		_ret = true;
	};
	_ret;
}];

_unit addEventHandler ["WeaponAssembled", {
	params ["_unit", "_staticWeapon"];
	if ((typeOf _staticWeapon) in uavs) then { [_staticWeapon] spawn F_forceBluforCrew };
}];

_unit addEventHandler ["Take", {
	params ["_unit", "_container", "_item"];
	if !([_item] call is_allowed_item) then {
		_unit removeWeapon _item;
		_unit removeItem _item;
		_unit unlinkItem _item;
	};
}];

// No mines in the base zone + pay artillery fire
_unit addEventHandler ["FiredMan",	{
	params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_vehicle"];

	if (count GRLIB_all_fobs >= 0) then {
		if (([_unit, "FOB", GRLIB_fob_range] call F_check_near || [_unit, "LHD", 500] call F_check_near) && _weapon == "Put") then { deleteVehicle _projectile };
	};
}];

// Player
if (_unit == player) then {

	// ACE specific
	if (GRLIB_ACE_enabled) then {		
		["ace_arsenal_displayClosed", {
			[player] call F_filterLoadout;
			[player] spawn F_payLoadout;
		}] call CBA_fnc_addEventHandler;
	};

	// Unblock units
	missionNamespace setVariable [
	"BIS_fnc_addCommMenuItem_menu", [
		["Do it !", true],
		["Unblock unit.", [2], "", -5, [["expression", "[groupSelectedUnits player] spawn PAR_unblock_AI"]], "1", "1"]
	]];

	// UI actions
	inGameUISetEventHandler ["Action", "
		private _ret = false;
		if (_this select 3 == 'DisAssemble') then { _ret = true };
		if (_this select 3 == 'Rearm' && !([_this select 1, _this select 0] call is_owner || [_this select 0] call is_public)) then { _ret = true };
		if ((['GetIn', _this select 3, true] call F_startsWith) && !isNull R3F_LOG_joueur_deplace_objet) then { _ret = true };
		if (_ret) then { hintSilent 'You are not allowed to do this' };
		_ret;
	"];

	// Get in Vehicle
	_unit removeAllEventHandlers "GetInMan";
	_unit addEventHandler ["GetInMan", {
		params ["_unit", "_role", "_vehicle"];
		1 fadeSound ( round desired_vehvolume / 100.0 );
		NRE_EarplugsActive = 1;
		[player, "hide"] remoteExec ["dog_action_remote_call", 2];
		if (GRLIB_thermic == 0 || (GRLIB_thermic == 1 && !(daytime > GRLIB_nights_start || daytime < GRLIB_nights_stop))) then {
			_vehicle disableTIEquipment true;
		} else {
			_vehicle disableTIEquipment false;
		};
		_this spawn vehicle_permissions
	}];

	// Get out Vehicle
	_unit removeAllEventHandlers "GetOutMan";
	_unit addEventHandler ["GetOutMan", {
		params ["_unit", "_role", "_vehicle"];
		1 fadeSound 1;
		NRE_EarplugsActive = 0;
		if ( (getPos _unit) select 2 > 20 && !(_unit getVariable ["AR_Is_Rappelling",false]) ) then {
			[_vehicle, _unit] spawn PAR_fn_eject;
		};
		[_unit] spawn {
			params ["_unit"];
			waitUntil {sleep 1; isTouchingGround (vehicle _unit)};
			if (primaryWeapon _unit != "") then { _unit selectWeapon primaryWeapon _unit };
			[_unit, "show"] remoteExec ["dog_action_remote_call", 2];
		};
	}];

};
