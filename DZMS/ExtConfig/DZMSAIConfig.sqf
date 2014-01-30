/*
	DZMSAIConfig.sqf
	This is a configuration for the AI that spawn at missions.
	This includes their skin, weapons, gear, and skills.
	You can adjust these to your liking, but it is for advanced users.
*/

// Array of skin classnames for the AI to use
DZMSBanditSkins = ["Bandit1_DZ","BanditW1_DZ","BanditW2_DZ","Bandit2_DZ"];

DZMSSkills1 = [
["aimingAccuracy",0.60],
["aimingShake",0.60],
["aimingSpeed",1.00],
["endurance",1.00],
["spotDistance",1.00],
["spotTime",1.00],
["courage",1.00],
["reloadSpeed",1.00],
["commanding",1.00],
["general",1.00]
];

DZMSSkills2 = [
["aimingAccuracy",0.15],
["aimingShake",0.20],
["aimingSpeed",1.00],
["endurance",1.00],
["spotDistance",1.00],
["spotTime",1.00],
["courage",1.00],
["reloadSpeed",1.00],
["commanding",1.00],
["general",1.00]
];

DZMSSkills3 = [
["aimingAccuracy",0.60],
["aimingShake",0.60],
["aimingSpeed",1.00],
["endurance",1.00],
["spotDistance",1.00],
["spotTime",1.00],
["courage",1.00],
["reloadSpeed",1.00],
["commanding",1.00],
["general",1.00]
];

//This is the primary weaponlist that can be assigned to AI
//These are assigned based on AI difficulty level
DZMSWeps0 = [
["AKS_74_UN_kobra","30Rnd_545x39_AKSD"], 
["M4A3_CCO_EP1","30Rnd_556x45_Stanag"], 
["M4A1_AIM_SD_camo","30Rnd_556x45_StanagSD"], 
["M16A4","30Rnd_556x45_Stanag"], 
["m8_carbine","30Rnd_556x45_Stanag"], 
["BAF_L85A2_RIS_Holo","30Rnd_556x45_Stanag"], 
["Sa58V_CCO_EP1","30Rnd_762x39_AK47"]
];

DZMSWeps1 = [
["AK_107_pso","30Rnd_545x39_AK"], 
["M16A4_ACG","30Rnd_556x45_Stanag"], 
["Sa58V_RCO_EP1","30Rnd_762x39_AK47"], 
["SCAR_L_STD_Mk4CQT","30Rnd_556x45_Stanag"], 
["BAF_L86A2_ACOG","30Rnd_556x45_Stanag"], 
["M4A1_AIM_SD_camo","30Rnd_556x45_StanagSD"], 
["M14_EP1","20Rnd_762x51_DMR"], 
["M8_sharpshooter","30Rnd_556x45_Stanag"]
];

DZMSWeps2 = [
["AK_107_GL_pso","30Rnd_545x39_AK"], 
["AK_107_GL_kobra","30Rnd_545x39_AK"], 
["M4A1_HWS_GL","30Rnd_556x45_Stanag"], 
["M16A4_ACG_GL","30Rnd_556x45_Stanag"], 
["M8_carbineGL","30Rnd_556x45_Stanag"], 
["SCAR_L_STD_EGLM_RCO","30Rnd_556x45_Stanag"], 
["BAF_L85A2_UGL_Holo","30Rnd_556x45_Stanag"], 
["M4A3_RCO_GL_EP1","30Rnd_556x45_Stanag"]
];

DZMSWeps3 = [ 
["SCAR_H_STD_EGLM_Spect","20rnd_762x51_B_SCAR"], 
["M110_NVG_EP1","20rnd_762x51_B_SCAR"], 
["SCAR_H_LNG_Sniper_SD","20rnd_762x51_SB_SCAR"], 
["SVD_CAMO","10Rnd_762x54_SVD"], 
["VSS_Vintorez","20Rnd_9x39_SP5_VSS"], 
["DMR","20Rnd_762x51_DMR"], 
["M40A3","5Rnd_762x51_M24"]
];

DZMSWeps4 = [
["RPK_74","75Rnd_545x39_RPK"], 
["MK_48_DZ","100Rnd_762x51_M240"], 
["M249_DZ","200Rnd_556x45_M249"], 
["Pecheneg_DZ","100Rnd_762x54_PK"], 
["M240_DZ","100Rnd_762x51_M240"]
];

//These are gear sets that will be randomly given to the AI
//They are all the same, but can be customized.
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

//These are the backpacks that can be assigned to AI units.
DZMSPacklist = [
"DZ_Patrol_Pack_EP1",
"DZ_Assault_Pack_EP1",
"DZ_Czech_Vest_Puch",
"DZ_ALICE_Pack_EP1",
"DZ_TK_Assault_Pack_EP1",
"DZ_British_ACU",
"DZ_CivilBackpack_EP1",
"DZ_Backpack_EP1"
];