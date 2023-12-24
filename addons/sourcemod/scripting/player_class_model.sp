#pragma semicolon 1
#pragma newdecls required

#include <sdktools_functions>
#include <sdktools_stringtables>
#include <smartdm>

ConVar
	cvModels[8];

char
	sModels[8][PLATFORM_MAX_PATH];

public Plugin myinfo = 
{
	name	= "Player Class Model",
	author	= "wS (World-Source.Ru) FiX Nek.'a 2x2",
	version	= "1.4.1",
};

public void OnPluginStart()
{
	cvModels[0] = CreateConVar("sm_model_t_phoenix", "", "Замена модели Т Феникс");
	
	cvModels[1] = CreateConVar("sm_model_t_leet", "", "Замена модели Т Лит");
	
	cvModels[2] = CreateConVar("sm_model_t_arctic", "", "Замена модели Т Арктик");
	
	cvModels[3] = CreateConVar("sm_model_t_guerilla", "", "Замена модели Т Гурилла");
	
	cvModels[4] = CreateConVar("sm_model_ct_seal_team", "", "Замена модели КТ Сеал");
	
	cvModels[5] = CreateConVar("sm_model_ct_gsg9", "", "Замена модели КТ ГСГ9");
	
	cvModels[6] = CreateConVar("sm_model_ct_sas", "", "Замена модели КТ САС");
	
	cvModels[7] = CreateConVar("sm_model_ct_gign", "", "Замена модели КТ Гигн");

	HookEvent("player_spawn", PlayerSpawn);
	
	AutoExecConfig(true, "player_class_model_new");
}

public void OnMapStart()
{
	for(int i; i < 8; i++)
	{
		cvModels[i].GetString(sModels[i], sizeof(sModels[]));
		if(!sModels[i][0])
			continue;
		PrecacheModel(sModels[i], true);
		Downloader_AddFileToDownloadsTable(sModels[i]);
	}
}

void PlayerSpawn(Event hEvent, const char[] name, bool silent)
{
	int client = GetClientOfUserId(GetEventInt(hEvent, "userid"));
	int xclass = GetEntProp(client, Prop_Send, "m_iClass");

	if(IsClientInGame(client) && IsPlayerAlive(client) && 0 < xclass < 9 && sModels[xclass-1][0])
		SetEntityModel(client, sModels[xclass-1]);
}