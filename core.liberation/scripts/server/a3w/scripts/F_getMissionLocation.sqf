params ["_list"];

(selectRandom ((west_sectors + east_sectors) select {_x in _list && !(_x in A3W_sectors_in_use)}));