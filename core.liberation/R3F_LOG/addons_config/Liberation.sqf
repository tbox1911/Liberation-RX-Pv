//--------------- Air ---------------
R3F_LOG_CFG_can_tow = R3F_LOG_CFG_can_tow +
[
];

R3F_LOG_CFG_can_be_towed = R3F_LOG_CFG_can_be_towed +
[
	"Air"
];

R3F_LOG_CFG_can_lift = R3F_LOG_CFG_can_lift +
[
	huron_typename_west,
	huron_typename_east
];

R3F_LOG_CFG_can_be_lifted = R3F_LOG_CFG_can_be_lifted +
[
];

R3F_LOG_CFG_can_transport_cargo = R3F_LOG_CFG_can_transport_cargo +
[
	[huron_typename_west, 200],
	[huron_typename_east, 200]
];

R3F_LOG_CFG_can_be_transported_cargo = R3F_LOG_CFG_can_be_transported_cargo +
[
];

R3F_LOG_CFG_can_be_moved_by_player = R3F_LOG_CFG_can_be_moved_by_player +
[

];

//--------------- Ground ---------------

R3F_LOG_CFG_can_tow = R3F_LOG_CFG_can_tow +
[
];

R3F_LOG_CFG_can_be_towed = R3F_LOG_CFG_can_be_towed +
[
];

R3F_LOG_CFG_can_lift = R3F_LOG_CFG_can_lift +
[
];

R3F_LOG_CFG_can_be_lifted = R3F_LOG_CFG_can_be_lifted +
[
];

R3F_LOG_CFG_can_transport_cargo = R3F_LOG_CFG_can_transport_cargo +
[
];

R3F_LOG_CFG_can_be_transported_cargo = R3F_LOG_CFG_can_be_transported_cargo +
[
];

R3F_LOG_CFG_can_be_moved_by_player = R3F_LOG_CFG_can_be_moved_by_player +
[
];

//--------------- Ship ---------------

R3F_LOG_CFG_can_transport_cargo = R3F_LOG_CFG_can_transport_cargo +
[
];

R3F_LOG_CFG_can_be_transported_cargo = R3F_LOG_CFG_can_be_transported_cargo +
[
];

R3F_LOG_CFG_can_be_moved_by_player = R3F_LOG_CFG_can_be_moved_by_player +
[
];

R3F_LOG_CFG_can_be_lifted = R3F_LOG_CFG_can_be_lifted +
[
];

R3F_LOG_CFG_can_be_towed = R3F_LOG_CFG_can_be_towed +
[
];

//--------------- Building ---------------
R3F_LOG_CFG_can_transport_cargo = R3F_LOG_CFG_can_transport_cargo +
[
	[FOB_box_typename_west, 0],
	[FOB_box_typename_east, 0],
	[FOB_box_outpost, 0],
    [FOB_truck_typename_west, 0],
    [FOB_truck_typename_east, 0],
	[ammo_truck_typename_west, 0],
	[ammo_truck_typename_east, 0],
	[fuel_truck_typename_west, 0],
	[fuel_truck_typename_east, 0],
	[repair_truck_typename_west, 0],
	[repair_truck_typename_east, 0]
];

R3F_LOG_CFG_can_be_transported_cargo = R3F_LOG_CFG_can_be_transported_cargo +
[
	[mobile_respawn, 2],
	[Arsenal_typename, 5],
	[FOB_box_typename_west, 50],
	[FOB_box_typename_east, 50],
	[FOB_box_outpost, 25],
	[ammobox_b_typename, 15],
	[ammobox_o_typename, 15],
	[ammobox_i_typename, 15],
	[waterbarrel_typename, 10],
	[fuelbarrel_typename, 10],
	[foodbarrel_typename, 10],
	[medicalbox_typename, 2],
	[repair_sling_typename_west, 25],
	[fuel_sling_typename_west, 25],
	[ammo_sling_typename_west, 25],
	[medic_sling_typename_west, 25],
	[repair_sling_typename_east, 25],
	[fuel_sling_typename_east, 25],
	[ammo_sling_typename_east, 25],
	[medic_sling_typename_east, 25],
	[A3W_BoxWps, 7],
	[canisterFuel, 1],
	["Land_PierLadder_F", 2],
	["Land_CargoBox_V1_F", 20]
];

R3F_LOG_CFG_can_be_moved_by_player = R3F_LOG_CFG_can_be_moved_by_player +
[
	mobile_respawn,
	Arsenal_typename,
	FOB_box_typename_west,
	FOB_box_typename_east,
	FOB_box_outpost,
	ammobox_b_typename,
	ammobox_o_typename,
	ammobox_i_typename,
	waterbarrel_typename,
	fuelbarrel_typename,
	foodbarrel_typename,
	medicalbox_typename,
	repair_sling_typename_west,
	fuel_sling_typename_west,
	ammo_sling_typename_west,
	medic_sling_typename_west,
	repair_sling_typename_east,
	fuel_sling_typename_east,
	ammo_sling_typename_east,
	medic_sling_typename_east,
	A3W_BoxWps,
	canisterFuel
];

R3F_LOG_CFG_can_be_lifted = R3F_LOG_CFG_can_be_lifted +
[
	Arsenal_typename
];

//--------------- Static ---------------

R3F_LOG_CFG_can_be_transported_cargo = R3F_LOG_CFG_can_be_transported_cargo +
[
	["Land_CzechHedgehog_01_new_F", 5]
];

R3F_LOG_CFG_can_be_moved_by_player = R3F_LOG_CFG_can_be_moved_by_player +
[
	"StaticMGWeapon",
	"StaticGrenadeLauncher",
	"StaticMortar",
	"Land_CzechHedgehog_01_new_F"
];

//--------------- Camping ---------------

R3F_LOG_CFG_can_be_moved_by_player = R3F_LOG_CFG_can_be_moved_by_player +
[
	"Land_Suitcase_F",
	"Land_CncBarrierMedium4_F",
	"Land_CncWall1_F",
	"Land_BagFence_Round_F",
	"Land_BagFence_Long_F",
	"Land_BagFence_Short_F",
	"Land_BagFence_Corner_F",
	"Land_CncShelter_F",
	"Land_Cargo_House_V1_F",
	"Land_Cargo_Patrol_V1_F",
	"Land_Cargo_House_V2_F",
	"Land_Cargo_Patrol_V2_F",	
	"Land_Cargo_House_V3_F",
	"Land_Cargo_Patrol_V3_F",
	"Land_PortableLight_double_F",
	"FlagCarrier",
	"Land_MapBoard_F",
	"Land_HelipadSquare_F",
	"Land_Razorwire_F",
	"Land_ToolTrolley_02_F",
	"Land_WeldingTrolley_01_F",
	"Land_GasTank_02_F",
	"Land_Workbench_01_F",
	"Land_WaterTank_F",
	"Land_WaterBarrel_F",
	"Land_BarGate_F",
	"Land_MetalCase_01_large_F",
	"CargoNet_01_box_F",
	"Land_CampingChair_V1_F",
	"Land_CampingChair_V2_F",
	"Land_CampingTable_F",
	"Land_Metal_rack_Tall_F",
	"PortableHelipadLight_01_blue_F",
	"Land_DieselGroundPowerUnit_01_F",
	"Land_Pallet_MilBoxes_F",
	"Land_PaperBox_open_full_F",
	"Land_ClutterCutter_large_F"
];

R3F_LOG_CFG_can_be_transported_cargo = R3F_LOG_CFG_can_be_transported_cargo +
[
	["Land_Suitcase_F", 1],
	["Land_CncBarrierMedium4_F", 5],
	["Land_CncWall1_F", 5],
	["Land_BagFence_Round_F", 5],
	["Land_BagFence_Long_F", 5],
	["Land_BagFence_Short_F", 5],
	["Land_BagFence_Corner_F", 5],
	["Land_CncShelter_F", 5],
	["Land_Cargo_House_V1_F", 5],
	["Land_Cargo_Patrol_V1_F", 5],
	["Land_Cargo_House_V2_F", 5],
	["Land_Cargo_Patrol_V2_F", 5],	
	["Land_Cargo_House_V3_F", 5],
	["Land_Cargo_Patrol_V3_F", 5],
	["Land_PortableLight_double_F", 5],
	["FlagCarrier", 5],
	["Land_MapBoard_F", 5],
	["Land_HelipadSquare_F", 5],
	["Land_Razorwire_F", 5],
	["Land_ToolTrolley_02_F", 5],
	["Land_WeldingTrolley_01_F", 5],
	["Land_GasTank_02_F", 5],
	["Land_Workbench_01_F", 5],
	["Land_WaterTank_F", 5],
	["Land_WaterBarrel_F", 5],
	["Land_BarGate_F", 5],
	["Land_MetalCase_01_large_F", 5],
	["CargoNet_01_box_F", 5],
	["Land_CampingChair_V1_F", 5],
	["Land_CampingChair_V2_F", 5],
	["Land_CampingTable_F", 5],
	["Land_Metal_rack_Tall_F", 5],
	["PortableHelipadLight_01_blue_F", 5],
	["Land_DieselGroundPowerUnit_01_F", 5],
	["Land_Pallet_MilBoxes_F", 5],
	["Land_PaperBox_open_full_F", 5],
	["Land_ClutterCutter_large_F", 5]
];