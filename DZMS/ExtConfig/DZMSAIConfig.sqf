/*
	DZMSAIConfig.sqf
	This is a configuration for the AI that spawn at missions.
	This includes their skin, weapons, gear, and skills.
	You can adjust these to your liking, but it is for advanced users.
*/

///////////////////////////////////////////////
// Array of skin classnames for the AI to use
DZMSBanditSkins = ["Bandit1_DZ","BanditW1_DZ"];

////////////////////////
// Array of AI Skills
DZMSSkills0 = [
	["aimingAccuracy",0.10,0.125],
	["aimingShake",0.45,0.55],
	["aimingSpeed",0.45,0.55],
	["endurance",0.40,0.50],
	["spotDistance",0.30,0.45],
	["spotTime",0.30,0.45],
	["courage",0.40,0.60],
	["reloadSpeed",0.50,0.60],
	["commanding",0.40,0.50],
	["general",0.40,0.60]
];

DZMSSkills1 = [
	["aimingAccuracy",0.125,0.15],
	["aimingShake",0.60,0.70],
	["aimingSpeed",0.60,0.70],
	["endurance",0.55,0.65],
	["spotDistance",0.45,0.60],
	["spotTime",0.45,0.60],
	["courage",0.55,0.75],
	["reloadSpeed",0.60,0.70],
	["commanding",0.55,0.65],
	["general",0.55,0.75]
];

DZMSSkills2 = [
	["aimingAccuracy",0.15,0.20],
	["aimingShake",0.75,0.85],
	["aimingSpeed",0.70,0.80],
	["endurance",0.70,0.80],
	["spotDistance",0.60,0.75],
	["spotTime",0.60,0.75],
	["courage",0.70,0.90],
	["reloadSpeed",0.70,0.80],
	["commanding",0.70,0.90],
	["general",0.70,0.90]
];

DZMSSkills3 = [	
	["aimingAccuracy",0.20,0.25],
	["aimingShake",0.85,0.95],
	["aimingSpeed",0.80,0.90],
	["endurance",0.80,0.90],
	["spotDistance",0.70,0.85],
	["spotTime",0.70,0.85],
	["courage",0.80,1.00],
	["reloadSpeed",0.80,0.90],
	["commanding",0.80,0.90],
	["general",0.80,1.00]
];

//////////////////////////////////////////////////////////////
// This is the primary weaponlist that can be assigned to AI
// These are assigned based on AI difficulty level
DZMSWeps0 = [
"M16A2_DZ",
"M16A2_GL_DZ",
"AK74_DZ",
"M4A1_CCO_DZ",
"AK74_Kobra_DZ",
"AKS74U_DZ",
"AKM_DZ",
"M24_DZ",
"M1014_DZ",
"DMR_DZ",
"M4A1_DZ",
"M14_CCO_DZ",
"Remington870_FL_DZ",
"MP5_DZ",
"MP5_SD_DZ",
"M4A3_CCO_EP1"
];

DZMSWeps1 = [
"M16A2_DZ",
"M16A2_GL_DZ",
"M249_DZ",
"AK74_DZ",
"M4A1_CCO_DZ",
"AK74_Kobra_DZ",
"AKS74U_DZ",
"AKM_DZ",
"M24_DZ",
"SVD_PSO1_Gh_DZ",
"M1014_DZ",
"DMR_DZ",
"M4A1_DZ",
"M14_CCO_DZ",
"Remington870_FL_DZ",
"M240_DZ",
"M4A1_AIM_SD_camo",
"M16A4_ACOG_DZ",
"M4A1_HWS_GL_camo",
"Mk48_CCO_DZ",
"M4A3_CCO_EP1",
"Sa58V_RCO_EP1",
"Sa58V_CCO_EP1",
"M40A3_Gh_DZ",
"SA58_DZ",
"SA58_DZ"
];

DZMSWeps2 = [
"FNFAL_DZ",
"FNFAL_ANPVS4_DZ",
"Mk48_CCO_DZ",
"M249_DZ",
"L85A2_DZ",
"G36C_DZ",
"G36C_camo",
"G36A_Camo_DZ",
"G36K_Camo_DZ",
"AKM_DZ",
"AKS74U_DZ",
"M14_CCO_DZ",
"Bizon_SD_DZ",
"DMR_DZ",
"RPK74_DZ"
];

DZMSWeps3 = [
"FNFAL_DZ",
"FNFAL_ANPVS4_DZ",
"Mk48_CCO_DZ",
"M249_DZ",
"L85A2_DZ",
"G36C_DZ",
"G36C_camo",
"G36A_Camo_DZ",
"G36K_Camo_DZ",
"AKM_DZ",
"AKS74U_DZ",
"M14_CCO_DZ",
"Bizon_SD_DZ",
"DMR_DZ",
"RPK74_DZ"
];

/////////////////////////////////////////////////////////////
// These are gear sets that will be randomly given to the AI
// They are all the same, but can be customized.
DZMSGear0 = [
["ItemBandage","ItemBandage","ItemPainkiller"],
["ItemKnife","ItemFlashlight"]
];

DZMSGear1 = [
["ItemBandage","ItemBandage","ItemPainkiller"],
["ItemKnife","ItemFlashlight"]
];

DZMSGear2 = [
["ItemBandage","ItemBandage","ItemPainkiller"],
["ItemKnife","ItemFlashlight"]
];

DZMSGear3 = [
["ItemBandage","ItemBandage","ItemPainkiller"],
["ItemKnife","ItemFlashlight"]
];

DZMSGear4 = [
["ItemBandage","ItemBandage","ItemPainkiller"],
["ItemKnife","ItemFlashlight"]
];

////////////////////////////////////////////////////////////
// These are the backpacks that can be assigned to AI units.
DZMSPacklist = [
"DZ_Patrol_Pack_EP1",
"DZ_Assault_Pack_EP1",
"DZ_Czech_Vest_Pouch",
"DZ_ALICE_Pack_EP1",
"DZ_TK_Assault_Pack_EP1",
"DZ_British_ACU",
"DZ_CivilBackpack_EP1",
"DZ_Backpack_EP1"
];
