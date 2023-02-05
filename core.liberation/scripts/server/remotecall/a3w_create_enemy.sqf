if (!isServer && hasInterface) exitWith {};
params ["_pos", "_type"];

if (isNil "_pos") exitWith {};
if !(isNil "GRLIB_A3W_Mission_SD_Spawn") exitWith {};

private _nbUnits = [] call getNbUnits;
private _aiGroup = createGroup [GRLIB_side_enemy, true];
[_aiGroup, _pos, _nbUnits, _type] call createCustomGroup;
GRLIB_A3W_Mission_SD_Spawn = true;