class liberation_airdrop {
  idd = 5205;
	movingEnable = false;
	controlsBackground[] = {};
	controls[] = {
	  "OuterBG1",
	  "OuterBG_F1",
	  "InnerBG1",
	  "InnerBG_F1",
	  "Header",
    "ButtonTaxi",
    "LabelTaxi",
	  "ButtonLight",
    "LabelLight",
	  "ButtonLight2",
    "LabelLight2",
	  "ButtonMed",
    "LabelMed",
	  "ButtonSup",
    "LabelSup",
	  "ButtonHeavy",
    "LabelHeavy",
    "ButtonAir",
    "LabelAir",
    "ButtonBoat",
    "LabelBoat",
	  "CancelButton"
	};
	objects[] = {};
  class CancelButton: StdButton
    {
      idc = 1610;
      action = "closeDialog 0";
      text = $STR_AIRDROP_CANCEL;
      x = 0.269271 * safezoneW + safezoneX;
      y = 0.71 * safezoneH + safezoneY;
      w = 0.09 * safezoneW;
      h = 0.035 * safezoneH;
      default = true;
    };

  class GREUH_RscStructuredText
  {
    type = 13;
    idc = -1;
    style = 0;
    colorText[] = {1,1,1,1};
      class Attributes
      {
        font = "PuristaMedium";
        color = "#ffffff";
        align = "left";
        shadow = 2;
      };
    x = 0;
    y = 0;
    h = 0.035;
    w = 0.1;
    text = "";
    size = "(((((safezoneW / safezoneH) min 1) / 1) / 30) * 1)";
    shadow = 2;
  };
  class ButtonTaxi: StdButton
  {
    idc = 1607;
    action = "air_type=8;do_action=1";
    text = $STR_AIRDROP_TAXI;
    x = 0.206094 * safezoneW + safezoneX;
    y = 0.2186 * safezoneH + safezoneY;
    w = 0.061875 * safezoneW;
    h = 0.033 * safezoneH;
  };
  class LabelTaxi: GREUH_RscStructuredText
  {
    idc = 1628;
    x = 0.283437 * safezoneW + safezoneX;
    y = 0.2176 * safezoneH + safezoneY;
    w = 0.149531 * safezoneW;
    h = 0.044 * safezoneH;
  };
  class ButtonLight: StdButton
  {
    idc = 1600;
    action = "air_type=1;do_action=1";
    text = $STR_AIRDROP_LIGHT;
    x = 0.206094 * safezoneW + safezoneX;
    y = 0.2786 * safezoneH + safezoneY;
    w = 0.061875 * safezoneW;
    h = 0.033 * safezoneH;
  };
  class LabelLight: GREUH_RscStructuredText
  {
    idc = 1621;    
    x = 0.283437 * safezoneW + safezoneX;
    y = 0.2776 * safezoneH + safezoneY;
    w = 0.149531 * safezoneW;
    h = 0.044 * safezoneH;
  };
  class ButtonLight2: StdButton
  {
    idc = 1601;
    action = "air_type=2;do_action=1";
    text = $STR_AIRDROP_LIGHTPLUS;
    x = 0.206094 * safezoneW + safezoneX;
    y = 0.3386 * safezoneH + safezoneY;
    w = 0.061875 * safezoneW;
    h = 0.033 * safezoneH;
  };
  class LabelLight2: GREUH_RscStructuredText
  {
    idc = 1622;
    x = 0.283437 * safezoneW + safezoneX;
    y = 0.3376 * safezoneH + safezoneY;
    w = 0.149531 * safezoneW;
    h = 0.044 * safezoneH;
  };
  class ButtonMed: StdButton
  {
    idc = 1602;
    action = "air_type=3;do_action=1";
    text = $STR_AIRDROP_ARMORED;
    x = 0.206094 * safezoneW + safezoneX;
    y = 0.3986 * safezoneH + safezoneY;
    w = 0.061875 * safezoneW;
    h = 0.033 * safezoneH;
  };
  class LabelMed: GREUH_RscStructuredText
  {
    idc = 1623;
    x = 0.283437 * safezoneW + safezoneX;
    y = 0.3976 * safezoneH + safezoneY;
    w = 0.149531 * safezoneW;
    h = 0.044 * safezoneH;
  };
  class ButtonSup: StdButton
  {
    idc = 1603;
    action = "air_type=4;do_action=1";
    text = $STR_AIRDROP_TRUCK;
    x = 0.206094 * safezoneW + safezoneX;
    y = 0.4586 * safezoneH + safezoneY;
    w = 0.061875 * safezoneW;
    h = 0.033 * safezoneH;
  };
  class LabelSup: GREUH_RscStructuredText
  {
    idc = 1624;
    x = 0.283437 * safezoneW + safezoneX;
    y = 0.4576 * safezoneH + safezoneY;
    w = 0.149531 * safezoneW;
    h = 0.044 * safezoneH;
  };
  class ButtonHeavy: StdButton
  {
    idc = 1604;
    action = "air_type=5;do_action=1";
    text = $STR_AIRDROP_APC;
    x = 0.206094 * safezoneW + safezoneX;
    y = 0.5186 * safezoneH + safezoneY;
    w = 0.061875 * safezoneW;
    h = 0.033 * safezoneH;
  };
  class LabelHeavy: GREUH_RscStructuredText
  {
    idc = 1625;
    x = 0.283437 * safezoneW + safezoneX;
    y = 0.5176 * safezoneH + safezoneY;
    w = 0.149531 * safezoneW;
    h = 0.044 * safezoneH;
  };
  class ButtonBoat: StdButton
  {
    idc = 1606;
    action = "air_type=6;do_action=1";
    text = $STR_AIRDROP_BOAT;
    x = 0.206094 * safezoneW + safezoneX;
    y = 0.5786 * safezoneH + safezoneY;
    w = 0.061875 * safezoneW;
    h = 0.033 * safezoneH;
  };
  class LabelBoat: GREUH_RscStructuredText
  {
    idc = 1626;
    x = 0.283437 * safezoneW + safezoneX;
    y = 0.5776 * safezoneH + safezoneY;
    w = 0.149531 * safezoneW;
    h = 0.044 * safezoneH;
  };
  class ButtonAir: StdButton
  {
    idc = 1605;
    action = "air_type=7;do_action=1";
    text = $STR_AIRDROP_AIRSUPREMACY;
    x = 0.206094 * safezoneW + safezoneX;
    y = 0.6386 * safezoneH + safezoneY;
    w = 0.061875 * safezoneW;
    h = 0.033 * safezoneH;
  };
  class LabelAir: GREUH_RscStructuredText
  {
    idc = 1627;
    x = 0.283437 * safezoneW + safezoneX;
    y = 0.6376 * safezoneH + safezoneY;
    w = 0.149531 * safezoneW;
    h = 0.044 * safezoneH;
  };
  class OuterBG1: StdBG
  {
    colorBackground[] = COLOR_BROWN;
    x = 0.19175 * safezoneW + safezoneX;
    y = 0.1324 * safezoneH + safezoneY;
    w = 0.25 * safezoneW;
    h = 0.62 * safezoneH;
  };
  class OuterBG_F1: OuterBG1
  {
		style = ST_FRAME;
  };
  class InnerBG1: OuterBG1
  {
    colorBackground[] = COLOR_GREEN;
    x = 0.1985 * safezoneW + safezoneX;
    y = 0.1916 * safezoneH + safezoneY;
    w = 0.2375 * safezoneW;
    h = 0.512 * safezoneH;
  };
  class InnerBG_F1: InnerBG1
  {
  	style = ST_FRAME;
  };
  class Header: StdHeader
  {
    text = $STR_AIRDROP_MENU;
    x = 0.1985 * safezoneW + safezoneX;
    y = 0.1444 * safezoneH + safezoneY;
    w = 0.2375 * safezoneW;
    h = 0.04 * safezoneH;
  };
};
