waitUntil {sleep 1;GRLIB_player_spawned};

while { true } do {
  waitUntil {sleep 1; alive player && lifeState player != 'INCAPACITATED' && side player != GRLIB_side_friendly};
  sleep 10;
  // Renegade
  if (alive player && lifeState player != 'INCAPACITATED' && side player != GRLIB_side_friendly) then {
    //diag_log format ["DBG: Player %1 wrong side - (%2)", name player, side player];
    player setcaptive true;
    player addrating 2000;
    [player] joinSilent my_group;
    my_group selectLeader player;
    player setcaptive false;
  };
};
