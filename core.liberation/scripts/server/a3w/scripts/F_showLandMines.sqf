if (!isServer) exitWith {};
params ["_pos"];

{
	if ( (getPosATL _x) distance2D _pos < GRLIB_sector_size) then { GRLIB_side_west revealMine _x;GRLIB_side_east revealMine _x };
} foreach allMines;
