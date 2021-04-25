params ["_fobpos", "_side"];

private _buildingsdestroy = [ (_fobpos nearobjects 150) , { getObjectType _x >= 8 && side _x != _side } ] call BIS_fnc_conditionalSelect;

{
	[_x] spawn {
		params ["_unit"];
		sleep floor(random 2);
		_unit setdamage 1;
		sleep floor(random 60);
		deletevehicle _unit;
	};
	sleep 0.1;
} foreach _buildingsdestroy;