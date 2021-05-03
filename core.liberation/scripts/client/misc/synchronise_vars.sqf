if (GRLIB_side_friendly == GRLIB_side_west) then {
    [] execVM "scripts\client\misc\synchronise_vars_west.sqf";
} else {
    [] execVM "scripts\client\misc\synchronise_vars_east.sqf";
};
