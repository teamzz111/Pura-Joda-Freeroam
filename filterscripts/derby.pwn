
/*
	Script comenzado el día 29/01/2017
	Sistema Derby 1.10 (30/01/2017) por adri1
	
	Juega a derby en:
	Super FreeRoam - 149.56.102.58:7777 -
*/

#include <a_samp>
#include <sscanf2>
#include <streamer>
#include <zcmd>

/*      DERBY SYSTEM	*/

#define	DERBY_SYSTEM_VERSION	"1.10"
#define DERBY_SYSTEM_DATE		"30/01/2017"

#define MAX_DERBY_PLAYERS   	20
#define MAX_DERBYS          	100
#define MAX_DERBY_OBJECTS   	500
#define DERBY_VIRTUAL_WORLD 	666
#define DERBY_TIME_COUNTDOWN	20	// 10 segundos de espera para que se unan jugadores
#define DERBY_WINNER_SCORE		5 	// score que se llevara el jugador ganador del derby
#define	FREEROAM_VIRTUAL_WORLD	0
native IsValidVehicle(vehicleid);

enum //JUEGOS GM
{
	GAME_NONE,
	GAME_FREEROAM,
	GAME_DERBY
};

enum //ESTADOS GENERALES JUGADOR
{
	STATUS_CONNECTED,
	STATUS_DEAD,
	STATUS_CLASS,
	STATUS_SPAWNED
};

enum //ESTADOS JUGADOR EN DERBY
{
	PD_NORMAL,
	PD_DEAD
};

enum //ESTADOS DERBY
{
	DERBY_CLOSED,
	DERBY_WAIT,
	DERBY_RUNNING
};

enum DERBY_INFO
{
	MAP_ID,
	STATUS,
	NAME[24],
	MODELID,
	Float:ZPOS, //Posicion a la que sera descalificado
	PLAYERS,
	ACTIVE_PLAYERS,
	COUNTDOWN_TIMER,
	COUNTDOWN_COUNTER,
	MESSAGE_TIMER,
	MAX_PRIZE,
	TIME_OUT_COUNTER,
	TIME_OUT_TIMER,
	TEXTDRAW_ANIMATION,
	NEXT_DERBY_TIMER
};

enum DERBY_OBJECTS_INFO
{
	OBJECT_ID,
	OBJECT_MODELID,
	Float:OBJECT_POS[6]
};

enum PLAYER_INFO
{
	P_NAME[24],
	P_STATUS, //estos deben de ser variables o algo que tengas por tu gm
	P_GAMEMODE,
	
	P_DERBY_VEHICLEID,
	P_DERBY_STATUS,
	P_DERBY_SPECTATEPLAYER,
	P_DERBY_SLOT
};

enum DERBY_INFO_LOAD
{
	DERBY_FILE_EXISTS,
	DERBY_NAME[24],
	DERBY_FILE_VALID
};

new
	
	TOTAL_DERBYS,
	TOTAL_DERBYS_OK,
	
	DERBY_FILE_INFO[MAX_DERBYS][DERBY_INFO_LOAD],
	DI[DERBY_INFO],
	DERBY_OBJECTS[MAX_DERBY_OBJECTS][DERBY_OBJECTS_INFO],
	DERBY_SLOT_USED[MAX_DERBY_PLAYERS],
	Float:DERBY_SPAWN_POS[MAX_DERBY_PLAYERS][4],
	Text:TD_DERBY_Message, Text: TD_DERBY,
	WaitTextDrawAnimation [] [] = 
	{
		"esperando_jugadores.",
		"esperando_jugadores..",
		"esperando_jugadores..."
	},
	
	Float:FREEROAM_POS[] = {1958.3783, 1343.1572, 15.3746, 270.0},
	PI[MAX_PLAYERS][PLAYER_INFO],
	
	Object_String[512];

forward DerbyCountdown();
forward TD_DERBY_SetString(text[]);
forward DerbyTimeOut();
forward NextDerby();
	
AutoPositionOffsets(modelid, &Float:X, &Float:Y, &Float:Z, &Float:RX, &Float:RY, &Float:RZ)
{
	new Float:pos[6];
	switch(modelid)
	{
		case 3458, 8838, 8557, 8558:
		{
			switch(random(4)) // 4 posibles offset para un mismo objeto
			{
				case 0: pos = Float:{-12.0, 0.0, 2.3, 0.0, 0.0, 90.0};
				case 1: pos = Float:{12.0, 0.0, 2.3, 0.0, 0.0, -90.0};
				case 2: pos = Float:{0.0, 0.0, 2.3, 0.0, 0.0, 90.0};
				case 3: pos = Float:{0.0, 0.0, 2.3, 0.0, 0.0, -90.0};
			}
		}
		default: return 0;
	}
	
	X = pos[0]; Y = pos[1]; Z = pos[2];
	RX = pos[3]; RY = pos[4]; RZ = pos[5];
	return 1;
}
#define W "{FFFFFF}" //white
#define G "{00FF00}"
#define LB "{00C2EC}"
public OnFilterScriptInit()
{
	for(new i = 0; i != MAX_DERBY_OBJECTS; i ++) DERBY_OBJECTS[i][OBJECT_ID] = INVALID_OBJECT_ID;
    LoadDerbyNames("DERBY/lista_derby.txt");
	CheckDerbys();
	
	TD_DERBY_Message = TextDrawCreate(320.0, 325.0, "_");
	TextDrawLetterSize(TD_DERBY_Message, 0.295051, 1.197498);
	TextDrawAlignment(TD_DERBY_Message, 2);
	TextDrawColor(TD_DERBY_Message, -1);
	TextDrawSetShadow(TD_DERBY_Message, 0);
	TextDrawSetOutline(TD_DERBY_Message, 1);
	TextDrawBackgroundColor(TD_DERBY_Message, 255);
	TextDrawFont(TD_DERBY_Message, 3);
	TextDrawSetProportional(TD_DERBY_Message, 1);
	TextDrawSetShadow(TD_DERBY_Message, 0);
	
	TD_DERBY = TextDrawCreate(320.0, 345.0, "_");
	TextDrawLetterSize(TD_DERBY, 0.295051, 1.197498);
	TextDrawAlignment(TD_DERBY, 2);
	TextDrawColor(TD_DERBY, -1);
	TextDrawSetShadow(TD_DERBY, 0);
	TextDrawSetOutline(TD_DERBY, 1);
	TextDrawBackgroundColor(TD_DERBY, 255);
	TextDrawFont(TD_DERBY, 3);
	TextDrawSetProportional(TD_DERBY, 1);
	TextDrawSetShadow(TD_DERBY, 0);
	
	print("\r\n\r\n----------------------------------------------");
	print("  Sistema Derby "DERBY_SYSTEM_VERSION" a "DERBY_SYSTEM_DATE" por adri1.");
	print("----------------------------------------------\r\n\r\n");
	for(new i; i!= GetMaxPlayers(); i++){
	if(!IsPlayerConnected(i)) continue;
	OnPlayerConnect(i);
	}
 			DI[STATUS] = DERBY_WAIT;
			DI[PLAYERS] = 0;
			DI[COUNTDOWN_COUNTER] = DERBY_TIME_COUNTDOWN + 1;
			DI[TEXTDRAW_ANIMATION] = 0;
			TextDrawSetString(TD_DERBY_Message, WaitTextDrawAnimation[ DI[TEXTDRAW_ANIMATION] ]);
			KillTimer(DI[COUNTDOWN_TIMER]);
			DI[COUNTDOWN_TIMER] = SetTimer("DerbyCountdown", 900, true);
			SendClientMessageToAll(-1,""G"| DERBY | "W"20 "G"segundos para que "W"derby "G"comience. Útilice "W"/derby "G"para unirse");


	return 1;
}

public OnPlayerConnect(playerid)
{
	PI[playerid][P_STATUS] = STATUS_CONNECTED;
	PI[playerid][P_DERBY_VEHICLEID] = INVALID_VEHICLE_ID;
	GetPlayerName(playerid, PI[playerid][P_NAME], 24);
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	if(PI[playerid][P_GAMEMODE] == GAME_DERBY) KickPlayerFromDerby(playerid);
	
	new tmp[PLAYER_INFO];
	PI[playerid] = tmp;
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
	if(PI[playerid][P_STATUS] != STATUS_CONNECTED && PI[playerid][P_STATUS] != STATUS_CLASS)
	{
		if(PI[playerid][P_GAMEMODE] == GAME_DERBY) KickPlayerFromDerby(playerid);
	}
	PI[playerid][P_STATUS] = STATUS_CLASS;
	return 1;
}

public OnPlayerSpawn(playerid)
{
	if(PI[playerid][P_GAMEMODE] == GAME_DERBY)
	{
		if(DI[STATUS] == DERBY_RUNNING)
		{
			if(PI[playerid][P_DERBY_STATUS] == PD_DEAD)
			{
				TogglePlayerSpectating(playerid, true);
				PlayerSpectateVehicle(playerid, PI[ PI[playerid][P_DERBY_SPECTATEPLAYER] ][P_DERBY_VEHICLEID]);
			}
			else PlayerDerbyDead(playerid);
		}
		else if(DI[STATUS] == DERBY_WAIT)
		{
			if(PI[playerid][P_DERBY_STATUS] == PD_NORMAL)
			{
				if(!IsValidVehicle(PI[playerid][P_DERBY_VEHICLEID]) && PI[playerid][P_DERBY_VEHICLEID] != INVALID_VEHICLE_ID)
				{
					PI[playerid][P_DERBY_VEHICLEID] = CreateVehicle(DI[MODELID], DERBY_SPAWN_POS[ PI[playerid][P_DERBY_SLOT] ][0], DERBY_SPAWN_POS[ PI[playerid][P_DERBY_SLOT] ][1], DERBY_SPAWN_POS[ PI[playerid][P_DERBY_SLOT] ][2] + 2.0, DERBY_SPAWN_POS[ PI[playerid][P_DERBY_SLOT] ][3], -1, -1, -1, false);
					SetVehicleParamsEx(PI[playerid][P_DERBY_VEHICLEID], VEHICLE_PARAMS_OFF, VEHICLE_PARAMS_OFF, VEHICLE_PARAMS_OFF, 1, 0, 0, 0);
					SetVehicleVirtualWorld(PI[playerid][P_DERBY_VEHICLEID], DERBY_VIRTUAL_WORLD);
					PutPlayerInVehicle(playerid, PI[playerid][P_DERBY_VEHICLEID], 0);
				}
				PutPlayerInVehicle(playerid, PI[playerid][P_DERBY_VEHICLEID], 0);
			}
		}
	}
	
	PI[playerid][P_STATUS] = STATUS_SPAWNED;
	return 1;
}

public OnPlayerDeath(playerid, killerid)
{
	if(PI[playerid][P_GAMEMODE] == GAME_DERBY && DI[STATUS] == DERBY_RUNNING && DI[ACTIVE_PLAYERS] > 1) PlayerDerbyDead(playerid);
	PI[playerid][P_STATUS] = STATUS_DEAD;
	return 1;
}

public OnVehicleDeath(vehicleid, killerid)
{
	if(!IsPlayerConnected(killerid)) return 1;
	if(PI[killerid][P_GAMEMODE] == GAME_DERBY)
	{
		if(vehicleid != PI[killerid][P_DERBY_VEHICLEID]) return 1;
		if(PI[killerid][P_STATUS] == STATUS_SPAWNED && PI[killerid][P_DERBY_STATUS] == PD_NORMAL)
		{
			if(DI[STATUS] == DERBY_RUNNING && DI[ACTIVE_PLAYERS] > 1) PlayerDerbyDead(killerid);
		}
		return 1;
	}
	return 1;
}
	
CMD:kill(playerid, params[])
{
	return SetPlayerHealth(playerid, 0.0);
}

CMD:nextderby(playerid, params[])
{
	if(IsPlayerAdmin(playerid))
	{
		if(DI[STATUS] == DERBY_RUNNING)
		{
			DI[TIME_OUT_COUNTER] = 3;
			SendClientMessage(playerid, -1, "Siguiente DERBY en 3 segundos.");
		}
		else SendClientMessage(playerid, -1, "DERBY no está activo.");
		return 1;
	}
	return 0;
}

CMD:did(playerid, params[])
{
	if(IsPlayerAdmin(playerid))
	{
		if(sscanf(params, "d", params[0])) return SendClientMessage(playerid, -1, "USO: /did <id>");
		if(params[0] < 0) return SendClientMessage(playerid, -1, "Map ID no válida.");
		if(isnull( DERBY_FILE_INFO[ params[0] ][DERBY_NAME] )) return SendClientMessage(playerid, -1, "Map ID no válida.");
		if(!DERBY_FILE_INFO[ params[0] ][DERBY_FILE_VALID]) return SendClientMessage(playerid, -1, "Este mapa no se pudo verificar.");
		if(DI[STATUS] == DERBY_CLOSED)
		{
			DI[MAP_ID] = params[0];
			
			new str[128]; format(str, 128, "Derby está cerrado cuando se active comenzará por el derby #%d, nombre: '%s'", DI[MAP_ID], DERBY_FILE_INFO[ DI[MAP_ID] ][DERBY_NAME]);
			SendClientMessage(playerid, -1, str);
		}
		else
		{
			DI[MAP_ID] = params[0] - 1;
			
			new str[128]; format(str, 128, "Derby está activo, el próximo derby será el derby #%d, nombre: '%s'", DI[MAP_ID] + 1, DERBY_FILE_INFO[ DI[MAP_ID] + 1 ][DERBY_NAME]);
			SendClientMessage(playerid, -1, str);
		}
		return 1;
	}
	return 0;
}

CMD:close(playerid, params[])
{
	if(IsPlayerAdmin(playerid))
	{
		CloseDerby();
		SendClientMessage(playerid, -1, "Derby cerrado.");
		return 1;
	}
	return 0;
}

CMD:reload(playerid, params[])
{
	if(IsPlayerAdmin(playerid))
	{
		LoadDerbyNames("DERBY/lista_derby.txt");
		CheckDerbys();
		
		new str[128]; format(str, 128, "Se han cargado %d mapas, se han verificado %d.", TOTAL_DERBYS, TOTAL_DERBYS_OK);
		SendClientMessage(playerid, -1, str);
		return 1;
	}
	return 0;
}

CMD:derby(playerid, params[])
{
	if(PI[playerid][P_STATUS] != STATUS_SPAWNED) return SendClientMessage(playerid, -1, "No puedes usar este comando por que no has spawneado.");
	if(PI[playerid][P_GAMEMODE] == GAME_DERBY) return SendClientMessage(playerid, -1, "Ya estás en derby.");
	if(DI[PLAYERS] >= MAX_DERBY_PLAYERS) return SendClientMessage(playerid, -1, "Derby está completo.");
	
	switch(DI[STATUS])
	{
		case DERBY_CLOSED:
		{
			if(TOTAL_DERBYS == 0) return SendClientMessage(playerid, -1, "No existe ningún derby.");
			if(TOTAL_DERBYS_OK == 0) return SendClientMessage(playerid, -1, "No se pudo verificar ningún derby.");
			
			new found, id = DI[MAP_ID];
			while(!found)
			{
				if(id >= TOTAL_DERBYS) id = 0;
				if(DERBY_FILE_INFO[id][DERBY_FILE_VALID])
				{
					found = true;
					DI[MAP_ID] = id;
					break;
				}
				
				id ++;
			}
			if(!LoadDerby(DERBY_FILE_INFO[ DI[MAP_ID] ][DERBY_NAME]))
			{
				CloseDerby();
				SendClientMessage(playerid, -1, "Derby no pudo cargar.");
				return 1;
			}
			
			DI[STATUS] = DERBY_WAIT;
			DI[PLAYERS] = 0;
			DI[COUNTDOWN_COUNTER] = DERBY_TIME_COUNTDOWN + 1;
			DI[TEXTDRAW_ANIMATION] = 0;
			TextDrawSetString(TD_DERBY_Message, WaitTextDrawAnimation[ DI[TEXTDRAW_ANIMATION] ]);
			KillTimer(DI[COUNTDOWN_TIMER]);
			DI[COUNTDOWN_TIMER] = SetTimer("DerbyCountdown", 900, true);
			SendClientMessageToAll(-1, ""G"| DERBY | "W"20 "G"segundos para que "W"derby "G"comience. Útilice "W"/derby "G" para unirse");
			
			PI[playerid][P_DERBY_SLOT] = GetDerbyVehicleSlot();
			if(PI[playerid][P_DERBY_SLOT] == -1) return KickPlayerFromDerby(playerid, true);
			DI[PLAYERS] ++;
			
			DERBY_SLOT_USED[ PI[playerid][P_DERBY_SLOT] ] = true;
			PI[playerid][P_GAMEMODE] = GAME_DERBY;
			SetPlayerHealth(playerid, 100.0);
			SetPlayerArmour(playerid, 0.0);
			SetPVarInt(playerid, "MINION", 1);
			SetPlayerInterior(playerid, 0);
			ResetPlayerWeapons(playerid);
			SetPlayerVirtualWorld(playerid, DERBY_VIRTUAL_WORLD);
			
			if(IsValidVehicle(PI[playerid][P_DERBY_VEHICLEID]) && PI[playerid][P_DERBY_VEHICLEID] != INVALID_VEHICLE_ID)
			{
				DestroyVehicle(PI[playerid][P_DERBY_VEHICLEID]);
				PI[playerid][P_DERBY_VEHICLEID] = INVALID_VEHICLE_ID;
			}
			TogglePlayerControllable(playerid, true);
			PI[playerid][P_DERBY_STATUS] = PD_NORMAL;
			PI[playerid][P_DERBY_VEHICLEID] = CreateVehicle(DI[MODELID], DERBY_SPAWN_POS[ PI[playerid][P_DERBY_SLOT] ][0], DERBY_SPAWN_POS[ PI[playerid][P_DERBY_SLOT] ][1], DERBY_SPAWN_POS[ PI[playerid][P_DERBY_SLOT] ][2] + 2.0, DERBY_SPAWN_POS[ PI[playerid][P_DERBY_SLOT] ][3], -1, -1, -1, false);
			SetVehicleParamsEx(PI[playerid][P_DERBY_VEHICLEID], VEHICLE_PARAMS_OFF, VEHICLE_PARAMS_OFF, VEHICLE_PARAMS_OFF, 1, 0, 0, 0);
			SetVehicleVirtualWorld(PI[playerid][P_DERBY_VEHICLEID], DERBY_VIRTUAL_WORLD);
			PutPlayerInVehicle(playerid, PI[playerid][P_DERBY_VEHICLEID], 0);
			TextDrawShowForPlayer(playerid, TD_DERBY_Message);
			GameTextForPlayer(playerid, DI[NAME], 3000, 6);
		}
		case DERBY_WAIT:
		{
			PI[playerid][P_DERBY_SLOT] = GetDerbyVehicleSlot();
			if(PI[playerid][P_DERBY_SLOT] == -1) return KickPlayerFromDerby(playerid, true);
			DI[PLAYERS] ++;
			
			DERBY_SLOT_USED[ PI[playerid][P_DERBY_SLOT] ] = true;
			PI[playerid][P_GAMEMODE] = GAME_DERBY;
			    SetPVarInt(playerid, "MINION", 1);
			SetPlayerHealth(playerid, 100.0);
			SetPlayerArmour(playerid, 0.0);
			SetPlayerInterior(playerid, 0);
			ResetPlayerWeapons(playerid);
			SetPlayerVirtualWorld(playerid, DERBY_VIRTUAL_WORLD);
			
			if(IsValidVehicle(PI[playerid][P_DERBY_VEHICLEID]) && PI[playerid][P_DERBY_VEHICLEID] != INVALID_VEHICLE_ID)
			{
				DestroyVehicle(PI[playerid][P_DERBY_VEHICLEID]);
				PI[playerid][P_DERBY_VEHICLEID] = INVALID_VEHICLE_ID;
			}
			TogglePlayerControllable(playerid, true);
			PI[playerid][P_DERBY_STATUS] = PD_NORMAL;
			PI[playerid][P_DERBY_VEHICLEID] = CreateVehicle(DI[MODELID], DERBY_SPAWN_POS[ PI[playerid][P_DERBY_SLOT] ][0], DERBY_SPAWN_POS[ PI[playerid][P_DERBY_SLOT] ][1], DERBY_SPAWN_POS[ PI[playerid][P_DERBY_SLOT] ][2] + 2.0, DERBY_SPAWN_POS[ PI[playerid][P_DERBY_SLOT] ][3], -1, -1, -1, false);
			SetVehicleParamsEx(PI[playerid][P_DERBY_VEHICLEID], VEHICLE_PARAMS_OFF, VEHICLE_PARAMS_OFF, VEHICLE_PARAMS_OFF, 1, 0, 0, 0);
			SetVehicleVirtualWorld(PI[playerid][P_DERBY_VEHICLEID], DERBY_VIRTUAL_WORLD);
			PutPlayerInVehicle(playerid, PI[playerid][P_DERBY_VEHICLEID], 0);
			TextDrawShowForPlayer(playerid, TD_DERBY_Message);
			GameTextForPlayer(playerid, DI[NAME], 3000, 6);
		}
		case DERBY_RUNNING:
		{
			DI[PLAYERS] ++;

			SetPlayerVirtualWorld(playerid, DERBY_VIRTUAL_WORLD);
			PI[playerid][P_DERBY_STATUS] = PD_NORMAL;
			SetPVarInt(playerid, "MINION", 1);
			PI[playerid][P_GAMEMODE] = GAME_DERBY;
			SetPlayerHealth(playerid, 100.0);
			SetPlayerArmour(playerid, 0.0);
			SetPlayerInterior(playerid, 0);
			ResetPlayerWeapons(playerid);
			SetPlayerVirtualWorld(playerid, DERBY_VIRTUAL_WORLD);
			if(IsValidVehicle(PI[playerid][P_DERBY_VEHICLEID]) && PI[playerid][P_DERBY_VEHICLEID] != INVALID_VEHICLE_ID)
			{
				DestroyVehicle(PI[playerid][P_DERBY_VEHICLEID]);
				PI[playerid][P_DERBY_VEHICLEID] = INVALID_VEHICLE_ID;
			}
			TogglePlayerControllable(playerid, true);
			
			TextDrawShowForPlayer(playerid, TD_DERBY);
			TextDrawShowForPlayer(playerid, TD_DERBY_Message);
			
			PI[playerid][P_DERBY_STATUS] = PD_DEAD;
			for(new i = 0, j = GetPlayerPoolSize(); i <= j; i++) 
			{
				if(IsPlayerConnected(i))
				{
					if(PI[i][P_GAMEMODE] == GAME_DERBY)
					{
						if(PI[i][P_DERBY_STATUS] == PD_NORMAL)
						{
							PI[playerid][P_DERBY_SPECTATEPLAYER] = i;
							break;
						}
					}
				}
			}
			
			TogglePlayerSpectating(playerid, true);
			PlayerSpectateVehicle(playerid, PI[ PI[playerid][P_DERBY_SPECTATEPLAYER] ][P_DERBY_VEHICLEID]);
			SendClientMessage(playerid, -1, "Usa la tecla INTRO para cambiar de jugador.");

			return 1;
		}
	}
	return 1;
}

CMD:salirdm(playerid, params[])
{
	if(PI[playerid][P_GAMEMODE] == GAME_DERBY) KickPlayerFromDerby(playerid, true);
	SetPVarInt(playerid, "MINION", 0);
	return 0;
}

public DerbyCountdown()
{
	if(DI[STATUS] != DERBY_WAIT) return KillTimer(DI[COUNTDOWN_TIMER]);
	
	if(DI[PLAYERS] <= 0) return CloseDerby();
	if(DI[PLAYERS] == 1)
	{
		DI[COUNTDOWN_COUNTER] = DERBY_TIME_COUNTDOWN + 1;
		DI[TEXTDRAW_ANIMATION] ++;
		if(DI[TEXTDRAW_ANIMATION] >= sizeof WaitTextDrawAnimation) DI[TEXTDRAW_ANIMATION] = 0;
		TextDrawSetString(TD_DERBY_Message, WaitTextDrawAnimation[ DI[TEXTDRAW_ANIMATION] ]);
		return 1;
	}
	
	DI[COUNTDOWN_COUNTER] --;
	
	new str[145]; format(str, 145, "%d/%d_jugadores~n~faltan_%d_segundos_para_empezar", DI[PLAYERS], MAX_DERBY_PLAYERS, DI[COUNTDOWN_COUNTER]);
	if(DI[COUNTDOWN_COUNTER] != 0) TextDrawSetString(TD_DERBY_Message, str);
	
	if(DI[COUNTDOWN_COUNTER] <= 0)
	{
		KillTimer(DI[COUNTDOWN_TIMER]);
		if(DI[PLAYERS] == 0) return CloseDerby();
		else if(DI[PLAYERS] == 1)
		{
			DI[TEXTDRAW_ANIMATION] ++;
			if(DI[TEXTDRAW_ANIMATION] >= sizeof WaitTextDrawAnimation) DI[TEXTDRAW_ANIMATION] = 0;
			TextDrawSetString(TD_DERBY_Message, WaitTextDrawAnimation[ DI[TEXTDRAW_ANIMATION] ]);
			DI[COUNTDOWN_COUNTER] = DERBY_TIME_COUNTDOWN + 1;
			KillTimer(DI[COUNTDOWN_TIMER]);
			DI[COUNTDOWN_TIMER] = SetTimer("DerbyCountdown", 900, true);
		}
		else StartDerby();
	}
	return 1;
}

StartDerby()
{
	DI[STATUS] = DERBY_RUNNING;
	DI[ACTIVE_PLAYERS] = DI[PLAYERS];
	DI[MAX_PRIZE] = DI[ACTIVE_PLAYERS] * 750;
	DI[TIME_OUT_COUNTER] = DI[ACTIVE_PLAYERS] * 20;
	
	TextDrawSetString(TD_DERBY, "_");
	KillTimer(DI[TIME_OUT_TIMER]);
	DI[TIME_OUT_TIMER] = SetTimer("DerbyTimeOut", 1000, true);
	
	TextDrawSetString(TD_DERBY_Message, "vamos");
	KillTimer(DI[MESSAGE_TIMER]);
	DI[MESSAGE_TIMER] = SetTimerEx("TD_DERBY_SetString", 3000, false, "s", "_");
	
	for(new i = 0, j = GetPlayerPoolSize(); i <= j; i++) 
	{
		if(IsPlayerConnected(i) && PI[i][P_GAMEMODE] == GAME_DERBY && PI[i][P_DERBY_STATUS] == PD_NORMAL)
		{
			TextDrawShowForPlayer(i, TD_DERBY);
			RepairVehicle(PI[i][P_DERBY_VEHICLEID]);
			SetVehicleParamsEx(PI[i][P_DERBY_VEHICLEID], VEHICLE_PARAMS_ON, VEHICLE_PARAMS_ON, VEHICLE_PARAMS_OFF, 1, 0, 0, 0);
		}
	}
	return 1;
}

public DerbyTimeOut()
{
	if(DI[STATUS] != DERBY_RUNNING) KillTimer(DI[TIME_OUT_TIMER]);
	
	DI[TIME_OUT_COUNTER] --;
	if(DI[TIME_OUT_COUNTER] < 0)
	{
		KillTimer(DI[TIME_OUT_TIMER]);
		
		for(new playerid = 0, j = GetPlayerPoolSize(); playerid <= j; playerid++) 
		{
			if(IsPlayerConnected(playerid))
			{
				if(PI[playerid][P_GAMEMODE] == GAME_DERBY && PI[playerid][P_DERBY_STATUS] == PD_NORMAL)
				{
					GivePlayerMoney(playerid, DI[MAX_PRIZE] / DI[ACTIVE_PLAYERS]);
					new str[128]; format(str, 128, "Derby finalizado, se acabó el tiempo, ganaste %d$", DI[MAX_PRIZE] / DI[ACTIVE_PLAYERS]);
					SendClientMessage(playerid, -1, str);
				}
			}
		}
		DI[ACTIVE_PLAYERS] = 0;
		KillTimer(DI[NEXT_DERBY_TIMER]);
		DI[NEXT_DERBY_TIMER] = SetTimer("NextDerby", 5000, false);
		return 1;
	}
	
	new str[24]; 
	format(str, 24, "tiempo:_%s", TimeConvert(DI[TIME_OUT_COUNTER]) ); TextDrawSetString(TD_DERBY, str);
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	if(PI[playerid][P_GAMEMODE] == GAME_DERBY)
	{
		if(oldstate == PLAYER_STATE_DRIVER) 
		{
			if(PI[playerid][P_STATUS] == STATUS_SPAWNED && PI[playerid][P_DERBY_STATUS] == PD_NORMAL)
			{
				if(!IsValidVehicle(PI[playerid][P_DERBY_VEHICLEID]) && PI[playerid][P_DERBY_VEHICLEID] != INVALID_VEHICLE_ID)
				{
					PI[playerid][P_DERBY_VEHICLEID] = CreateVehicle(DI[MODELID], DERBY_SPAWN_POS[ PI[playerid][P_DERBY_SLOT] ][0], DERBY_SPAWN_POS[ PI[playerid][P_DERBY_SLOT] ][1], DERBY_SPAWN_POS[ PI[playerid][P_DERBY_SLOT] ][2] + 2.0, DERBY_SPAWN_POS[ PI[playerid][P_DERBY_SLOT] ][3], -1, -1, -1, false);
					SetVehicleParamsEx(PI[playerid][P_DERBY_VEHICLEID], VEHICLE_PARAMS_OFF, VEHICLE_PARAMS_OFF, VEHICLE_PARAMS_OFF, 1, 0, 0, 0);
					SetVehicleVirtualWorld(PI[playerid][P_DERBY_VEHICLEID], DERBY_VIRTUAL_WORLD);
					PutPlayerInVehicle(playerid, PI[playerid][P_DERBY_VEHICLEID], 0);
					return 1;
				}
				PutPlayerInVehicle(playerid, PI[playerid][P_DERBY_VEHICLEID], 0);
			}
		}
		return 1;
	}
	return 1;
}

public NextDerby()
{
	DI[MAP_ID] ++;
	
	if(TOTAL_DERBYS == 0)
	{
		SendClientMessageToAll(-1, "No se puede pasar al siguiente derby, no existe.");
		CloseDerby();
		return 0;
	}
	if(TOTAL_DERBYS_OK == 0)
	{
		SendClientMessageToAll(-1, "No se puede pasar al siguiente derby, no puede verificar.");
		CloseDerby();
		return 0;
	}
	
	new found, id = DI[MAP_ID];
	while(!found)
	{
		if(id >= TOTAL_DERBYS) id = 0;
		if(DERBY_FILE_INFO[id][DERBY_FILE_VALID])
		{
			found = true;
			DI[MAP_ID] = id;
			break;
		}
		
		id ++;
	}
	if(!LoadDerby(DERBY_FILE_INFO[ DI[MAP_ID] ][DERBY_NAME]))
	{
		CloseDerby();
		SendClientMessageToAll(-1, "Derby no pudo cargar.");
		return 1;
	}
	
	TextDrawSetString(TD_DERBY, "_");
	TextDrawHideForAll(TD_DERBY);
	
	KillTimer(DI[TIME_OUT_TIMER]);
	KillTimer(DI[MESSAGE_TIMER]);
	KillTimer(DI[COUNTDOWN_TIMER]);
	
	DI[STATUS] = DERBY_WAIT;
	DI[ACTIVE_PLAYERS] = 0;
	DI[COUNTDOWN_COUNTER] = DERBY_TIME_COUNTDOWN + 1;
	DI[TEXTDRAW_ANIMATION] = 0;
	TextDrawSetString(TD_DERBY_Message, WaitTextDrawAnimation[ DI[TEXTDRAW_ANIMATION] ]);
	DI[COUNTDOWN_TIMER] = SetTimer("DerbyCountdown", 900, true);

	SendClientMessageToAll(-1, ""G"| DERBY | "W"20 "G"segundos para que "W"derby "G"comience. Útilice "W"/derby "G" para unirse");



	
	for(new players = 0, j = GetPlayerPoolSize(); players <= j; players++) 
	{
		if(IsPlayerConnected(players))
		{
			if(PI[players][P_GAMEMODE] == GAME_DERBY)
			{
				if(GetPlayerState(players) == PLAYER_STATE_SPECTATING) TogglePlayerSpectating(players, false);
				
				PI[players][P_DERBY_SLOT] = GetDerbyVehicleSlot();
				if(PI[players][P_DERBY_SLOT] == -1) return KickPlayerFromDerby(players, true);
				DERBY_SLOT_USED[ PI[players][P_DERBY_SLOT] ] = true;
				
				SetPlayerHealth(players, 100.0);
				SetPlayerArmour(players, 0.0);
				SetPlayerInterior(players, 0);
				SetPlayerVirtualWorld(players, DERBY_VIRTUAL_WORLD);
				
				if(IsValidVehicle(PI[players][P_DERBY_VEHICLEID]) && PI[players][P_DERBY_VEHICLEID] != INVALID_VEHICLE_ID)
				{
					DestroyVehicle(PI[players][P_DERBY_VEHICLEID]);
					PI[players][P_DERBY_VEHICLEID] = INVALID_VEHICLE_ID;
				}
				TogglePlayerControllable(players, true);
				PI[players][P_DERBY_STATUS] = PD_NORMAL;
				PI[players][P_DERBY_VEHICLEID] = CreateVehicle(DI[MODELID], DERBY_SPAWN_POS[ PI[players][P_DERBY_SLOT] ][0], DERBY_SPAWN_POS[ PI[players][P_DERBY_SLOT] ][1], DERBY_SPAWN_POS[ PI[players][P_DERBY_SLOT] ][2] + 2.0, DERBY_SPAWN_POS[ PI[players][P_DERBY_SLOT] ][3], -1, -1, -1, false);
				SetVehicleParamsEx(PI[players][P_DERBY_VEHICLEID], VEHICLE_PARAMS_OFF, VEHICLE_PARAMS_OFF, VEHICLE_PARAMS_OFF, 1, 0, 0, 0);
				SetVehicleVirtualWorld(PI[players][P_DERBY_VEHICLEID], DERBY_VIRTUAL_WORLD);
				PutPlayerInVehicle(players, PI[players][P_DERBY_VEHICLEID], 0);
				TextDrawShowForPlayer(players, TD_DERBY_Message);
				GameTextForPlayer(players, DI[NAME], 3000, 6);
			}
		}
	}
	
	return 1;
}

public TD_DERBY_SetString(text[])
{
	return TextDrawSetString(TD_DERBY_Message, text);
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(newkeys & KEY_SECONDARY_ATTACK)
	{
		if(PI[playerid][P_GAMEMODE] == GAME_DERBY)
		{
			if(PI[playerid][P_DERBY_STATUS] == PD_DEAD)
			{
				PI[playerid][P_STATUS] = STATUS_SPAWNED;
				
				new old = PI[playerid][P_DERBY_SPECTATEPLAYER];
				for(new i = PI[playerid][P_DERBY_SPECTATEPLAYER], j = GetPlayerPoolSize(); i <= j; i++) 
				{
					if(IsPlayerConnected(i))
					{
						if(PI[i][P_GAMEMODE] == GAME_DERBY)
						{
							if(PI[i][P_DERBY_STATUS] == PD_NORMAL)
							{
								if(PI[playerid][P_DERBY_SPECTATEPLAYER] != i)
								{
									PlayerSpectateVehicle(playerid, PI[i][P_DERBY_VEHICLEID]);
									PI[playerid][P_DERBY_SPECTATEPLAYER] = i;
									new str[70]; format(str, 70, "_~n~_~n~_~n~_~n~~y~-_~g~~h~%s_~b~~h~%d_~y~-~n~_", PI[ PI[playerid][P_DERBY_SPECTATEPLAYER] ][P_NAME], PI[playerid][P_DERBY_SPECTATEPLAYER]);
									GameTextForPlayer(playerid, str, 3000, 3);
									return 1;
								}
							}
						}
					}
				}
				if(PI[playerid][P_DERBY_SPECTATEPLAYER] == old)
				{
					for(new i = 0, j = GetPlayerPoolSize(); i <= j; i++) 
					{
						if(IsPlayerConnected(i))
						{
							if(PI[i][P_GAMEMODE] == GAME_DERBY)
							{
								if(PI[i][P_DERBY_STATUS] == PD_NORMAL)
								{
									if(PI[playerid][P_DERBY_SPECTATEPLAYER] != i)
									{
										PlayerSpectateVehicle(playerid, PI[i][P_DERBY_VEHICLEID]);
										PI[playerid][P_DERBY_SPECTATEPLAYER] = i;
										new str[70]; format(str, 70, "_~n~_~n~_~n~_~n~~y~-_~g~~h~%s_~b~~h~%d_~y~-~n~_", PI[ PI[playerid][P_DERBY_SPECTATEPLAYER] ][P_NAME], PI[playerid][P_DERBY_SPECTATEPLAYER]);
										GameTextForPlayer(playerid, str, 3000, 3);
										return 1;
									}
								}
							}
						}
					}
				}
				return 1;
			}
		}
	}
	return 1;
}
	

public OnPlayerUpdate(playerid)
{
	if(PI[playerid][P_GAMEMODE] == GAME_DERBY)
	{
		if(PI[playerid][P_STATUS] == STATUS_SPAWNED && PI[playerid][P_DERBY_STATUS] == PD_NORMAL && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
		{
			if(GetPlayerVirtualWorld(playerid) != DERBY_VIRTUAL_WORLD) SetPlayerVirtualWorld(playerid, DERBY_VIRTUAL_WORLD); // Si el jugador está en otro virtual world...
			
			if(DI[STATUS] == DERBY_RUNNING && DI[ACTIVE_PLAYERS] > 1)
			{
				new Float:p[3];
				GetVehiclePos(PI[playerid][P_DERBY_VEHICLEID], p[0], p[1], p[2]);
				if(p[2] <= DI[ZPOS]) PlayerDerbyDead(playerid);
			}
			else if(DI[STATUS] == DERBY_WAIT)
			{
				if(!IsValidVehicle(PI[playerid][P_DERBY_VEHICLEID])) // Si no existe el vehículo
				{
					PI[playerid][P_DERBY_VEHICLEID] = CreateVehicle(DI[MODELID], DERBY_SPAWN_POS[ PI[playerid][P_DERBY_SLOT] ][0], DERBY_SPAWN_POS[ PI[playerid][P_DERBY_SLOT] ][1], DERBY_SPAWN_POS[ PI[playerid][P_DERBY_SLOT] ][2] + 2.0, DERBY_SPAWN_POS[ PI[playerid][P_DERBY_SLOT] ][3], -1, -1, -1, false);
					SetVehicleParamsEx(PI[playerid][P_DERBY_VEHICLEID], VEHICLE_PARAMS_OFF, VEHICLE_PARAMS_OFF, VEHICLE_PARAMS_OFF, 1, 0, 0, 0);
					SetVehicleVirtualWorld(PI[playerid][P_DERBY_VEHICLEID], DERBY_VIRTUAL_WORLD);
					PutPlayerInVehicle(playerid, PI[playerid][P_DERBY_VEHICLEID], 0);
				}
				if(GetPlayerVehicleID(playerid) != PI[playerid][P_DERBY_VEHICLEID]) // Si el jugador está en otro vehículo
				{
					SetVehicleVirtualWorld(PI[playerid][P_DERBY_VEHICLEID], DERBY_VIRTUAL_WORLD);
					SetVehiclePos(PI[playerid][P_DERBY_VEHICLEID], DERBY_SPAWN_POS[ PI[playerid][P_DERBY_SLOT] ][0], DERBY_SPAWN_POS[ PI[playerid][P_DERBY_SLOT] ][1], DERBY_SPAWN_POS[ PI[playerid][P_DERBY_SLOT] ][2] + 2.0);
					SetVehicleZAngle(PI[playerid][P_DERBY_VEHICLEID], DERBY_SPAWN_POS[ PI[playerid][P_DERBY_SLOT] ][3]);
					PutPlayerInVehicle(playerid, PI[playerid][P_DERBY_VEHICLEID], 0);
					return 1;
				}
				
				new Float:p[3];
				GetVehiclePos(PI[playerid][P_DERBY_VEHICLEID], p[0], p[1], p[2]);
				if(p[2] <= (DERBY_SPAWN_POS[ PI[playerid][P_DERBY_SLOT] ][2] - 0.5)) // Si el vehículo se cae al vacío
				{
					SetVehiclePos(PI[playerid][P_DERBY_VEHICLEID], DERBY_SPAWN_POS[ PI[playerid][P_DERBY_SLOT] ][0], DERBY_SPAWN_POS[ PI[playerid][P_DERBY_SLOT] ][1], DERBY_SPAWN_POS[ PI[playerid][P_DERBY_SLOT] ][2] + 2.0);
					SetVehicleZAngle(PI[playerid][P_DERBY_VEHICLEID], DERBY_SPAWN_POS[ PI[playerid][P_DERBY_SLOT] ][3]);
				}
			}
		}
	}
	return 1;
}

CloseDerby()
{
	for(new i = 0, j = GetPlayerPoolSize(); i <= j; i++) 
	{
		if(IsPlayerConnected(i))
		{
			if(PI[i][P_GAMEMODE] == GAME_DERBY)
			{
				KickPlayerFromDerby(i, true);
			}
		}
	}
	
	KillTimer(DI[COUNTDOWN_TIMER]);
	KillTimer(DI[TIME_OUT_TIMER]);
	KillTimer(DI[NEXT_DERBY_TIMER]);
	
	TextDrawSetString(TD_DERBY_Message, "_");
	TextDrawSetString(TD_DERBY, "_");
	new tmp[DERBY_INFO], Float:tmp3[MAX_DERBY_PLAYERS][4], tmp4[MAX_DERBY_PLAYERS], old_id = DI[MAP_ID];
	DI = tmp;
	DERBY_SPAWN_POS = tmp3;
	DERBY_SLOT_USED = tmp4;
	
	for(new i = 0; i != MAX_DERBY_OBJECTS; i ++)
	{
		if(DERBY_OBJECTS[i][OBJECT_ID] != INVALID_OBJECT_ID && IsValidDynamicObject(DERBY_OBJECTS[i][OBJECT_ID])) DestroyDynamicObject(DERBY_OBJECTS[i][OBJECT_ID]);
        DERBY_OBJECTS[i][OBJECT_ID] = INVALID_OBJECT_ID;
        DERBY_OBJECTS[i][OBJECT_MODELID] = 0;
        DERBY_OBJECTS[i][OBJECT_POS][0] = 0.0;
        DERBY_OBJECTS[i][OBJECT_POS][1] = 0.0;
        DERBY_OBJECTS[i][OBJECT_POS][2] = 0.0;
        DERBY_OBJECTS[i][OBJECT_POS][3] = 0.0;
        DERBY_OBJECTS[i][OBJECT_POS][4] = 0.0;
        DERBY_OBJECTS[i][OBJECT_POS][5] = 0.0;
	}
	
	DI[MAP_ID] = old_id;
	return 1;
}

LoadDerbyNames(mapname[])
{
	new File:Handler = fopen(mapname, io_read);
    if(!Handler)
	{
		printf("--- Error cargando '%s', no se encontró la lista de mapas derby.", mapname);
		return 0;
	}
    
    for(new i = 0; i != sizeof DERBY_FILE_INFO; i ++)
	{
		DERBY_FILE_INFO[i][DERBY_NAME] = EOS;
		DERBY_FILE_INFO[i][DERBY_FILE_EXISTS] = false;
		DERBY_FILE_INFO[i][DERBY_FILE_VALID] = false;
	}
	
    TOTAL_DERBYS = 0;
    
    while(fread(Handler, Object_String))
    {
        StripNewLine(Object_String);
		if(!isnull(Object_String))
		{
			if(TOTAL_DERBYS >= MAX_DERBYS)
			{
				printf("--- Error, se ha supero el límite (%d) de mapas derby.", MAX_DERBYS);
				return 0;
			}
			DERBY_FILE_INFO[ TOTAL_DERBYS ][DERBY_FILE_EXISTS] = true;
			format(DERBY_FILE_INFO[ TOTAL_DERBYS ][DERBY_NAME], 24, "%s", Object_String);
			TOTAL_DERBYS ++;
		}
    }

    fclose(Handler);
    
	if(TOTAL_DERBYS == 0)
	{
		printf("--- Error cargando la lista de derbys '%s', no se encontró ningún derby.", mapname);
		return 0;
	}
    printf("--- LISTA '%s' OK. Se importaron %d mapas derby.", mapname, TOTAL_DERBYS);
	return 1;
}

CheckDerbys()
{
	if(TOTAL_DERBYS == 0)
	{
		printf("--- Error comprobando los derbys, no se importó ningún mapa desde la lista o esta no fue cargada.");
		return 0;
	}
	
	for(new i = 0; i != sizeof DERBY_FILE_INFO; i ++) DERBY_FILE_INFO[i][DERBY_FILE_VALID] = false;
	
	TOTAL_DERBYS_OK = 0;
	for(new i = 0; i != TOTAL_DERBYS; i ++)
	{
		if(DERBY_FILE_INFO[i][DERBY_FILE_EXISTS]) CheckDerbyFile(i);
	}
	if(TOTAL_DERBYS_OK == 0) print("--- No se pudo verificar ningún mapa, compruebelos.");
	else printf("--- Se han verificado %d de los %d mapas importados.", TOTAL_DERBYS_OK, TOTAL_DERBYS);
	return 1;
}

LoadDerby(mapname[])
{
	new File:Handler = fopen(mapname, io_read);
    if(!Handler)
	{
		printf("--- Error cargando '%s', archivo no encontrado.", mapname);
		return 0;
	}

	new tmp[DERBY_INFO], tmp2[DERBY_OBJECTS_INFO], Float:tmp3[MAX_DERBY_PLAYERS][4], tmp4[MAX_DERBY_PLAYERS], object_count, pos_count, txt_line;
	tmp = DI;
	DERBY_SPAWN_POS = tmp3;
	DERBY_SLOT_USED = tmp4;
	
	for(new i = 0; i != MAX_DERBY_OBJECTS; i ++)
	{
		if(DERBY_OBJECTS[i][OBJECT_ID] != INVALID_OBJECT_ID && IsValidDynamicObject(DERBY_OBJECTS[i][OBJECT_ID])) DestroyDynamicObject(DERBY_OBJECTS[i][OBJECT_ID]);
        DERBY_OBJECTS[i][OBJECT_ID] = INVALID_OBJECT_ID;
        DERBY_OBJECTS[i][OBJECT_MODELID] = 0;
        DERBY_OBJECTS[i][OBJECT_POS][0] = 0.0;
        DERBY_OBJECTS[i][OBJECT_POS][1] = 0.0;
        DERBY_OBJECTS[i][OBJECT_POS][2] = 0.0;
        DERBY_OBJECTS[i][OBJECT_POS][3] = 0.0;
        DERBY_OBJECTS[i][OBJECT_POS][4] = 0.0;
        DERBY_OBJECTS[i][OBJECT_POS][5] = 0.0;
	}
	
    while(fread(Handler, Object_String))
    {
        StripNewLine(Object_String);
		if(!isnull(Object_String))
		{
			if(txt_line == 0)
			{
				if(!sscanf(Object_String, "p<,>s[24]d", 	tmp[NAME], tmp[MODELID]))
				{
					DI = tmp;
					if(DI[MODELID] < 400 || DI[MODELID] > 611)
					{
						printf("--- Error cargando '%s', el módelo de vehículo no es correcto, revíselo.", mapname);
						fclose(Handler);
						return 0;
					}
				}
				else
				{
					printf("--- Error cargando '%s', el formato primera línea no válido, revíselo.", mapname);
					fclose(Handler);
					return 0;
				}
			}
			else
			{
				if(!sscanf(Object_String, "p<,>dffffff", 	tmp2[OBJECT_MODELID], tmp2[OBJECT_POS][0], tmp2[OBJECT_POS][1], tmp2[OBJECT_POS][2],
															tmp2[OBJECT_POS][3], tmp2[OBJECT_POS][4], tmp2[OBJECT_POS][5])
				)
				{
					if(object_count > MAX_DERBY_OBJECTS)
					{
						printf("--- Error cargando '%s', el mapa supera el máximo de objetos permitidos (%d).", mapname, MAX_DERBY_OBJECTS);
						fclose(Handler);
						return 0;
					}
					DERBY_OBJECTS[object_count] = tmp2;
					DERBY_OBJECTS[object_count][OBJECT_ID] = CreateDynamicObject(
																					DERBY_OBJECTS[object_count][OBJECT_MODELID],
																					DERBY_OBJECTS[object_count][OBJECT_POS][0],
																					DERBY_OBJECTS[object_count][OBJECT_POS][1],
																					DERBY_OBJECTS[object_count][OBJECT_POS][2],
																					DERBY_OBJECTS[object_count][OBJECT_POS][3],
																					DERBY_OBJECTS[object_count][OBJECT_POS][4],
																					DERBY_OBJECTS[object_count][OBJECT_POS][5],
																					DERBY_VIRTUAL_WORLD
																				);
																				
					if(object_count == 0) DI[ZPOS] = DERBY_OBJECTS[object_count][OBJECT_POS][2];
					if(DERBY_OBJECTS[object_count][OBJECT_POS][2] < DI[ZPOS]) DI[ZPOS] = DERBY_OBJECTS[object_count][OBJECT_POS][2];
					
					new Float:pos[6];
					if(AutoPositionOffsets(DERBY_OBJECTS[object_count][OBJECT_MODELID], pos[0], pos[1], pos[2], pos[3], pos[4], pos[5]))
					{
						if(DERBY_OBJECTS[object_count][OBJECT_POS][3] == 0.0 && DERBY_OBJECTS[object_count][OBJECT_POS][4] == 0.0)
						{
							if(pos_count >= MAX_DERBY_PLAYERS) continue;

							new Float:unused_rot[2];
							conversion(DERBY_OBJECTS[object_count][OBJECT_POS][0], DERBY_OBJECTS[object_count][OBJECT_POS][1], DERBY_OBJECTS[object_count][OBJECT_POS][2], DERBY_OBJECTS[object_count][OBJECT_POS][3], DERBY_OBJECTS[object_count][OBJECT_POS][4], DERBY_OBJECTS[object_count][OBJECT_POS][5], pos[0], pos[1], pos[2], pos[3], pos[4], pos[5], DERBY_SPAWN_POS[pos_count][0], DERBY_SPAWN_POS[pos_count][1], DERBY_SPAWN_POS[pos_count][2], unused_rot[0], unused_rot[1], DERBY_SPAWN_POS[pos_count][3]);
							pos_count ++;
						}
					}
					
					object_count ++;
				}
				else
				{
					printf("--- Error cargando '%s', se esperaba el formato 'modelid, x, y, z, rx, ry, rz' Revisa el mapa.", mapname);
					fclose(Handler);
					return 0;
				}
			}
			txt_line ++;
		}
	}
	fclose(Handler);
	
	DI[ZPOS] -= 10.0;
	if(DI[ZPOS] < 0.0) DI[ZPOS] = 0.0;
	
	if(txt_line < 4) 
	{
		printf("--- Error cargando '%s', tamaño del mapa demasiado pequeño para ser válido, revíselo.", mapname);
		return 0;
	}
	if(pos_count < MAX_DERBY_PLAYERS)
	{
		printf("--- Error cargando '%s', solo se pudieron obtener %d de %d posiciones.", mapname, pos_count, MAX_DERBY_PLAYERS);
		return 0;
	}
	return 1;
}

stock StripNewLine(string[]) //DracoBlue (bugfix idea by Y_Less)
{
	new len = strlen(string);
	if (string[0]==0) return ;
	if ((string[len - 1] == '\n') || (string[len - 1] == '\r')) {
		string[len - 1] = 0;
		if (string[0]==0) return ;
		if ((string[len - 2] == '\n') || (string[len - 2] == '\r')) string[len - 2] = 0;
	}
}

//-------------------------------------------------- STYLOCK --------------------------------------------------

conversion(Float:or_pos_x, Float:or_pos_y, Float:or_pos_z, Float:or_rot_x, Float:or_rot_y, Float:or_rot_z, Float:off_x, Float:off_y, Float:off_z, Float:rot_x, Float:rot_y, Float:rot_z, &Float:X, &Float:Y, &Float:Z, &Float:RX, &Float:RY, &Float:RZ) // By Stylock - http://forum.sa-mp.com/member.php?u=114165
{
	static
		Float:sin[3],
		Float:cos[3],
		Float:pos[3],
		Float:rot[3];

	pos[0] = or_pos_x;
	pos[1] = or_pos_y;
	pos[2] = or_pos_z;
	rot[0] = or_rot_x;
	rot[1] = or_rot_y;
	rot[2] = or_rot_z;

	EDIT_FloatEulerFix(rot[0], rot[1], rot[2]);
	cos[0] = floatcos(rot[0], degrees); cos[1] = floatcos(rot[1], degrees); cos[2] = floatcos(rot[2], degrees); sin[0] = floatsin(rot[0], degrees); sin[1] = floatsin(rot[1], degrees); sin[2] = floatsin(rot[2], degrees);
	pos[0] = pos[0] + off_x * cos[1] * cos[2] - off_x * sin[0] * sin[1] * sin[2] - off_y * cos[0] * sin[2] + off_z * sin[1] * cos[2] + off_z * sin[0] * cos[1] * sin[2];
	pos[1] = pos[1] + off_x * cos[1] * sin[2] + off_x * sin[0] * sin[1] * cos[2] + off_y * cos[0] * cos[2] + off_z * sin[1] * sin[2] - off_z * sin[0] * cos[1] * cos[2];
	pos[2] = pos[2] - off_x * cos[0] * sin[1] + off_y * sin[0] + off_z * cos[0] * cos[1];
	rot[0] = asin(cos[0] * cos[1]); rot[1] = atan2(sin[0], cos[0] * sin[1]) + rot_z; rot[2] = atan2(cos[1] * cos[2] * sin[0] - sin[1] * sin[2], cos[2] * sin[1] - cos[1] * sin[0] * -sin[2]);
	cos[0] = floatcos(rot[0], degrees); cos[1] = floatcos(rot[1], degrees); cos[2] = floatcos(rot[2], degrees); sin[0] = floatsin(rot[0], degrees); sin[1] = floatsin(rot[1], degrees); sin[2] = floatsin(rot[2], degrees);
	rot[0] = asin(cos[0] * sin[1]); rot[1] = atan2(cos[0] * cos[1], sin[0]); rot[2] = atan2(cos[2] * sin[0] * sin[1] - cos[1] * sin[2], cos[1] * cos[2] + sin[0] * sin[1] * sin[2]);
	cos[0] = floatcos(rot[0], degrees); cos[1] = floatcos(rot[1], degrees); cos[2] = floatcos(rot[2], degrees); sin[0] = floatsin(rot[0], degrees); sin[1] = floatsin(rot[1], degrees); sin[2] = floatsin(rot[2], degrees);
	rot[0] = atan2(sin[0], cos[0] * cos[1]) + rot_x; rot[1] = asin(cos[0] * sin[1]); rot[2] = atan2(cos[2] * sin[0] * sin[1] + cos[1] * sin[2], cos[1] * cos[2] - sin[0] * sin[1] * sin[2]);
	cos[0] = floatcos(rot[0], degrees); cos[1] = floatcos(rot[1], degrees); cos[2] = floatcos(rot[2], degrees); sin[0] = floatsin(rot[0], degrees); sin[1] = floatsin(rot[1], degrees); sin[2] = floatsin(rot[2], degrees);
	rot[0] = asin(cos[1] * sin[0]); rot[1] = atan2(sin[1], cos[0] * cos[1]) + rot_y; rot[2] = atan2(cos[0] * sin[2] - cos[2] * sin[0] * sin[1], cos[0] * cos[2] + sin[0] * sin[1] * sin[2]);
	X = pos[0];
	Y = pos[1];
	Z = pos[2];
	RX = rot[0];
	RY = rot[1];
 	RZ = rot[2];
}


EDIT_FloatEulerFix(&Float:rot_x, &Float:rot_y, &Float:rot_z)
{
    EDIT_FloatGetRemainder(rot_x, rot_y, rot_z);
    if((!floatcmp(rot_x, 0.0) || !floatcmp(rot_x, 360.0))
    && (!floatcmp(rot_y, 0.0) || !floatcmp(rot_y, 360.0)))
    {
        rot_y = 0.0000002;
    }
    return 1;
}

EDIT_FloatGetRemainder(&Float:rot_x, &Float:rot_y, &Float:rot_z)
{
    EDIT_FloatRemainder(rot_x, 360.0);
    EDIT_FloatRemainder(rot_y, 360.0);
    EDIT_FloatRemainder(rot_z, 360.0);
    return 1;
}

EDIT_FloatRemainder(&Float:remainder, Float:value)
{
    if(remainder >= value)
    {
        while(remainder >= value)
        {
            remainder = remainder - value;
        }
    }
    else if(remainder < 0.0)
    {
        while(remainder < 0.0)
        {
            remainder = remainder + value;
        }
    }
    return 1;
}

//-------------------------------------------------- STYLOCK --------------------------------------------------

GetDerbyVehicleSlot()
{
	for(new i = 0; i != MAX_DERBY_PLAYERS; i ++)
	{
		if(!DERBY_SLOT_USED[i]) return i;
	}
	return -1;
}

PlayerDerbyDead(playerid)
{
	if(PI[playerid][P_DERBY_STATUS] == PD_DEAD) return 1;
	PI[playerid][P_DERBY_STATUS] = PD_DEAD;
	if(IsValidVehicle(PI[playerid][P_DERBY_VEHICLEID]) && PI[playerid][P_DERBY_VEHICLEID] != INVALID_VEHICLE_ID)
	{
		DestroyVehicle(PI[playerid][P_DERBY_VEHICLEID]);
		PI[playerid][P_DERBY_VEHICLEID] = INVALID_VEHICLE_ID;
	}

	GivePlayerMoney(playerid, DI[MAX_PRIZE] / DI[ACTIVE_PLAYERS]); // premio	
	new str[190]; format(str, 190, ""G"[Pura Joda] "W"%s "G"ha terminado el derby en la posición %d/%d (premiado con %d$)", PI[playerid][P_NAME], DI[ACTIVE_PLAYERS], DI[PLAYERS], (DI[MAX_PRIZE] / DI[ACTIVE_PLAYERS]) );
	SendClientMessageToAll(-1, str);
	
	DI[ACTIVE_PLAYERS] --;
	if(DI[TIME_OUT_COUNTER] > (DI[ACTIVE_PLAYERS] * 20) ) DI[TIME_OUT_COUNTER] = DI[ACTIVE_PLAYERS] * 20;
	
	if(DI[ACTIVE_PLAYERS] == 1)
	{
		new winner;
		for(new i = 0, j = GetPlayerPoolSize(); i <= j; i++) 
		{
			if(IsPlayerConnected(i))
			{
				if(PI[i][P_GAMEMODE] == GAME_DERBY)
				{
					if(PI[i][P_DERBY_STATUS] == PD_NORMAL)
					{
						winner = i;
						SetPlayerScore(winner, GetPlayerScore(winner) + DERBY_WINNER_SCORE);
						GivePlayerMoney(winner, DI[MAX_PRIZE] / DI[ACTIVE_PLAYERS]);
						format(str, 128, "Eres el ganador del derby, has ganado %d$ y %d de score", (DI[MAX_PRIZE] / DI[ACTIVE_PLAYERS]), DERBY_WINNER_SCORE);
						SendClientMessage(winner, -1, str);
						break;
					}
				}
			}
		}
		KillTimer(DI[TIME_OUT_TIMER]);
		format(str, 128, "%s es el ganador del derby~n~ha ganado %d$ y %d score", PI[winner][P_NAME], (DI[MAX_PRIZE] / DI[ACTIVE_PLAYERS]), DERBY_WINNER_SCORE);
		TextDrawSetString(TD_DERBY_Message, str);
		
		format(str, 128, "%s ha ganado el derby (premiado con %d$ y %d score)", PI[winner][P_NAME], (DI[MAX_PRIZE] / DI[ACTIVE_PLAYERS]), DERBY_WINNER_SCORE);
		SendClientMessageToAll(-1, str);
		
		TextDrawSetString(TD_DERBY, "_");
		TextDrawHideForAll(TD_DERBY);
		TogglePlayerSpectating(playerid, true);
		PlayerSpectateVehicle(playerid, PI[winner][P_DERBY_VEHICLEID]);
		
		KillTimer(DI[NEXT_DERBY_TIMER]);
		DI[NEXT_DERBY_TIMER] = SetTimer("NextDerby", 5000, false);
		return 1;
	}
	else
	{
		PI[playerid][P_DERBY_STATUS] = PD_DEAD;
		for(new i = 0, j = GetPlayerPoolSize(); i <= j; i++) 
		{
			if(IsPlayerConnected(i))
			{
				if(PI[i][P_GAMEMODE] == GAME_DERBY)
				{
					if(PI[i][P_DERBY_STATUS] == PD_NORMAL)
					{
						PI[playerid][P_DERBY_SPECTATEPLAYER] = i;
						break;
					}
				}
			}
		}
		TogglePlayerSpectating(playerid, true);
		PlayerSpectateVehicle(playerid, PI[ PI[playerid][P_DERBY_SPECTATEPLAYER] ][P_DERBY_VEHICLEID]);
		SendClientMessage(playerid, -1, "Usa la tecla INTRO para cambiar de jugador.");
	}
	return 1;
}

stock TimeConvert(seconds)
{
	new tmp[16];
 	new minutes = floatround(seconds/60);
  	seconds -= minutes*60;
   	format(tmp, sizeof(tmp), "%d:%02d", minutes, seconds);
   	return tmp;
}

KickPlayerFromDerby(playerid, freeroam = false)
{
	if(PI[playerid][P_GAMEMODE] != GAME_DERBY) return 0;
	
	if( (DI[STATUS] == DERBY_RUNNING) && PI[playerid][P_DERBY_STATUS] == PD_NORMAL)
	{
		DI[ACTIVE_PLAYERS] --;
		if(DI[TIME_OUT_COUNTER] > (DI[ACTIVE_PLAYERS] * 20) ) DI[TIME_OUT_COUNTER] = DI[ACTIVE_PLAYERS] * 20;
	}
	DI[PLAYERS] --;
	
	TextDrawHideForPlayer(playerid, TD_DERBY);
	TextDrawHideForPlayer(playerid, TD_DERBY_Message);
	
	DERBY_SLOT_USED[ PI[playerid][P_DERBY_SLOT] ] = false;
	SetPlayerVirtualWorld(playerid, FREEROAM_VIRTUAL_WORLD);
	SetPlayerInterior(playerid, 0);
	SetPlayerArmour(playerid, 0.0);
	SetPlayerHealth(playerid, 100.0);
	PI[playerid][P_DERBY_SLOT] = 0;
	PI[playerid][P_DERBY_STATUS] = PD_NORMAL;
	TogglePlayerControllable(playerid, true);
	if(GetPlayerState(playerid) == PLAYER_STATE_SPECTATING) TogglePlayerSpectating(playerid, false);
	if(IsValidVehicle(PI[playerid][P_DERBY_VEHICLEID]) && PI[playerid][P_DERBY_VEHICLEID] != INVALID_VEHICLE_ID)
	{
		DestroyVehicle(PI[playerid][P_DERBY_VEHICLEID]);
		PI[playerid][P_DERBY_VEHICLEID] = INVALID_VEHICLE_ID;
	}
	SetCameraBehindPlayer(playerid);
	PI[playerid][P_GAMEMODE] = GAME_NONE;
	
	if(freeroam)
	{
		PI[playerid][P_GAMEMODE] = GAME_FREEROAM;
		SetPlayerPos(playerid, FREEROAM_POS[0], FREEROAM_POS[1], FREEROAM_POS[2]);
		SetPlayerFacingAngle(playerid, FREEROAM_POS[3]);
		SetSpawnInfo(playerid, GetPlayerTeam(playerid), GetPlayerSkin(playerid), FREEROAM_POS[0], FREEROAM_POS[1], FREEROAM_POS[2], FREEROAM_POS[3], 0, 0, 0, 0, 0, 0);
		ResetPlayerWeapons(playerid);
	}
	
	CheckDerby();
	return 1;
}

CheckDerby()
{
	if(DI[PLAYERS] <= 0 && DI[STATUS] != DERBY_CLOSED) return CloseDerby();
	switch(DI[STATUS])
	{
		case DERBY_CLOSED: return 1;
		case DERBY_RUNNING:
		{
			if(DI[ACTIVE_PLAYERS] == 1)
			{
				new winner, str[128];
				for(new i = 0, j = GetPlayerPoolSize(); i <= j; i++) 
				{
					if(IsPlayerConnected(i))
					{
						if(PI[i][P_GAMEMODE] == GAME_DERBY)
						{
							if(PI[i][P_DERBY_STATUS] == PD_NORMAL)
							{
								winner = i;
								SetPlayerScore(winner, GetPlayerScore(winner) + DERBY_WINNER_SCORE);
								GivePlayerMoney(winner, DI[MAX_PRIZE] / DI[ACTIVE_PLAYERS]);
								format(str, 128, "Eres el ganador del derby, has ganado %d$ y %d de score", (DI[MAX_PRIZE] / DI[ACTIVE_PLAYERS]), DERBY_WINNER_SCORE);
								SendClientMessage(winner, -1, str);
								break;
							}
						}
					}
				}
				KillTimer(DI[TIME_OUT_TIMER]);
				format(str, 128, "%s es el ganador del derby~n~ha ganado %d$ y %d score", PI[winner][P_NAME], (DI[MAX_PRIZE] / DI[ACTIVE_PLAYERS]), DERBY_WINNER_SCORE);
				TextDrawSetString(TD_DERBY_Message, str);
				
				format(str, 128, "%s ha ganado el derby (premiado con %d$ y %d score)", PI[winner][P_NAME], (DI[MAX_PRIZE] / DI[ACTIVE_PLAYERS]), DERBY_WINNER_SCORE);
				SendClientMessageToAll(-1, str);
				
				TextDrawSetString(TD_DERBY, "_");
				TextDrawHideForAll(TD_DERBY);
		
				KillTimer(DI[NEXT_DERBY_TIMER]);
				DI[NEXT_DERBY_TIMER] = SetTimer("NextDerby", 5000, false);
			}
			return 1;
		}
	}
	return 1;
}

CheckDerbyFile(id)
{
	new mapname[24]; format(mapname, 24, "%s", DERBY_FILE_INFO[id][DERBY_NAME]);

	new File:Handler = fopen(mapname, io_read);
    if(!Handler)
	{
		printf("--- COMPROBACION: Error cargando '%s', archivo no encontrado.", mapname);
		return 0;
	}

	new tmp[DERBY_INFO], tmp2[DERBY_OBJECTS_INFO], object_count, pos_count, txt_line;
	
    while(fread(Handler, Object_String))
    {
        StripNewLine(Object_String);
		if(!isnull(Object_String))
		{
			if(txt_line == 0)
			{
				if(!sscanf(Object_String, "p<,>s[24]d", 	tmp[NAME], tmp[MODELID]))
				{
					if(tmp[MODELID] < 400 || tmp[MODELID] > 611)
					{
						printf("--- COMPROBACION: Error cargando '%s', el módelo de vehículo no es correcto, revíselo.", mapname);
						printf("--- COMPROBACION: Este mapa será ignorado y se pasará al siguiente.");
						fclose(Handler);
						return 0;
					}
				}
				else
				{
					printf("--- COMPROBACION: Error cargando '%s', el formato primera línea no válido, revíselo.", mapname);
					printf("--- COMPROBACION: Este mapa será ignorado y se pasará al siguiente.");
					fclose(Handler);
					return 0;
				}
			}
			else
			{
				if(!sscanf(Object_String, "p<,>dffffff", 	tmp2[OBJECT_MODELID], tmp2[OBJECT_POS][0], tmp2[OBJECT_POS][1], tmp2[OBJECT_POS][2],
															tmp2[OBJECT_POS][3], tmp2[OBJECT_POS][4], tmp2[OBJECT_POS][5])
				)
				{
					if(object_count > MAX_DERBY_OBJECTS)
					{
						printf("--- COMPROBACION: Error cargando '%s', el mapa supera el máximo de objetos permitidos (%d).", mapname, MAX_DERBY_OBJECTS);
						printf("--- COMPROBACION: Este mapa será ignorado y se pasará al siguiente.");
						fclose(Handler);
						return 0;
					}
					
					new Float:pos[6];
					if(AutoPositionOffsets(tmp2[OBJECT_MODELID], pos[0], pos[1], pos[2], pos[3], pos[4], pos[5]))
					{
						if(tmp2[OBJECT_POS][3] == 0.0 && tmp2[OBJECT_POS][4] == 0.0)
						{
							if(pos_count >= MAX_DERBY_PLAYERS) continue;
							pos_count ++;
						}
					}
			
					object_count ++;
				}
				else
				{
					printf("--- COMPROBACION: Error cargando '%s', se esperaba el formato 'modelid, x, y, z, rx, ry, rz' Revisa el mapa.", mapname);
					printf("--- COMPROBACION: Este mapa será ignorado y se pasará al siguiente.");
					fclose(Handler);
					return 0;
				}
			}
			txt_line ++;
		}
	}
	fclose(Handler);
	
	if(txt_line < 4) 
	{
		printf("--- COMPROBACION: Error cargando '%s', tamaño del mapa demasiado pequeño para ser válido, revíselo.", mapname);
		printf("--- COMPROBACION: Este mapa será ignorado y se pasará al siguiente.");
		return 0;
	}
	if(pos_count < MAX_DERBY_PLAYERS)
	{
		printf("--- COMPROBACION: Error cargando '%s', solo se pudieron obtener %d de %d posiciones.", mapname, pos_count, MAX_DERBY_PLAYERS);
		printf("--- COMPROBACION: Este mapa será ignorado y se pasará al siguiente.");
		return 0;
	}
	
	TOTAL_DERBYS_OK ++;
	DERBY_FILE_INFO[id][DERBY_FILE_VALID] = true;
	printf("--- COMPROBACION: Mapa '%s' comprobado correctamente.", mapname);
	return 1;
}

// SFR - 149.56.102.58:7777 -
