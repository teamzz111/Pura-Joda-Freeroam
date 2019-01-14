#include <a_samp>
//=================================DEFINES======================================
#define COLOR_DUELO 0x5db8d7ff
#define red 0xFF0000AA
#define ARENAS 5
#pragma tabsize 0
#define DUELOSMENU 136
#define DUELOSMENU2 146
#define COLOR_ROJO 0xFF0000AA
#define COLOR_YELLOW   0xFFFF00FF
#define dcmd(%1,%2,%3) if ((strcmp((%3)[1], #%1, true, (%2)) == 0) && ((((%3)[(%2) + 1] == 0) && (dcmd_%1(playerid, "")))||(((%3)[(%2) + 1] == 32) && (dcmd_%1(playerid, (%3)[(%2) + 2]))))) return 1
//================================ENUMS=========================================
enum DueloData
{
	DesaId,
	DesafiadoId,
	ArmasId,
	Libre,
};
new NODUEL[MAX_PLAYERS];
//==================================NEWS========================================
new Duelos[ARENAS][DueloData];
new p1duelo1;
new p2duelo1;
new EnDuelo[MAX_PLAYERS];
new ViendoDuelo[MAX_PLAYERS];
new Float:DuelosSpec1[4][4] = {
{2664.1482,1216.1522,28.1049,95.2520},
{2663.8528,1206.1810,28.0187,88.9853},
{2626.4121,1206.4113,28.0460,270.0703},
{2625.8770,1215.9166,28.2018,270.0703}
};
new Float:DuelosSpec2[4][4] = {
{-2046.8956,-151.8644,35.3274,273.0374},
{-2047.2686,-176.8742,35.3203,267.3973},
{-2037.1031,-193.7050,35.3203,0.7715},
{-2022.0725,-194.2935,35.3203,355.1314}
};
new Float:DuelosSpec3[4][4] = {
{1296.7688,2125.8865,19.8482,265.4070},
{1297.3258,2107.3101,19.8482,276.6871},
{1397.5118,2128.2173,20.2477,92.1554},
{1398.0309,2112.7026,20.2477,89.6487}
};
new Float:DuelosSpec4[2][4] = {
{2791.2883,-1470.9528,16.7069,3.4818},
{2813.4968,-1471.3683,16.2580,357.8418}
};
new Float:DuelosSpec5[4][4] = {
{-2061.2974,-147.8633,35.3203,85.6623},
{-2060.4802,-177.4833,35.3203,81.2756},
{-2087.9924,-194.4944,35.3203,3.5682},
{-2072.3088,-195.2733,35.3203,355.4214}
};
new Float:DuelosSpec6[4][4] = {
{-2046.5425,-229.0362,35.3203,270.1940},
{-2047.0101,-262.6578,35.3203,280.2207},
{-2016.6174,-213.7045,35.3203,174.9398},
{-2036.0265,-212.8107,35.3203,173.6865}
};
new Float:DuelosSpec7[4][4] = {
{-2060.6614,-228.4423,35.3203,87.8323},
{-2060.1682,-269.3360,35.3274,87.8323},
{-2069.1121,-214.7752,35.3203,176.1931},
{-2086.6960,-214.1076,35.3203,181.8332}
};
//==================================Stocks======================================
stock IsNumeric(string[])
{
	for (new i = 0, j = strlen(string); i < j; i++)
	{
		if (string[i] > '9' || string[i] < '0') return 0;
	}
	return 1;
}

forward SetDuel(id1,id2,armas,arena);
public SetDuel(id1,id2,armas,arena)
{
	ResetPlayerWeapons(id1);
	ResetPlayerWeapons(id2);
	SetPlayerHealth(id1,100);
	SetPlayerHealth(id2,100);
	SetPlayerArmour(id1,100);
	SetPlayerArmour(id2,100);
	TogglePlayerControllable(id2,0);
	TogglePlayerControllable(id1,0);
	SetCameraBehindPlayer(id1);
	SetCameraBehindPlayer(id2);
	switch (arena)
	{
	  case 1: {SetPlayerPos(id1,2646.0796,1232.5236,26.9182); SetPlayerFacingAngle(id1,180.4801); SetPlayerPos(id2,2646.4988,1189.6237,26.9182); SetPlayerFacingAngle(id2,1.9051); SetObjectPos(p1duelo1, 2646.205811, 1230.074219, 26.962353); SetObjectPos(p2duelo1, 2646.165771, 1191.811157, 26.957216);}
	  case 2: {SetPlayerPos(id1,-2029.0785,-132.0135,35.2654); SetPlayerFacingAngle(id1,174.3599); SetPlayerPos(id2,-2030.3761,-185.8199,35.3203); SetPlayerFacingAngle(id2,358.7466); /*SetObjectPos(p1duelo1, 2646.205811, 1230.074219, 26.962353); SetObjectPos(p2duelo1, 2646.165771, 1191.811157, 26.957216);*/}
  	  case 3: {SetPlayerPos(id1,1362.6705,2117.3650,14.1503); SetPlayerFacingAngle(id1,89.6487); SetPlayerPos(id2,1334.4459,2117.9766,14.1503); SetPlayerFacingAngle(id2,269.6487); /*SetObjectPos(p1duelo1, 2646.205811, 1230.074219, 26.962353); SetObjectPos(p2duelo1, 2646.165771, 1191.811157, 26.957216);*/}
  	  case 4: {SetPlayerPos(id1,2815.0596,-1429.7235,16.2500); SetPlayerFacingAngle(id1,139.7597); SetPlayerPos(id2,2791.1196,-1464.7419,16.2500); SetPlayerFacingAngle(id2,317.1080); /*SetObjectPos(p1duelo1, 2646.205811, 1230.074219, 26.962353); SetObjectPos(p2duelo1, 2646.165771, 1191.811157, 26.957216);*/}
  	  case 5: {SetPlayerPos(id1,-2080.9038,-130.2143,35.3274); SetPlayerFacingAngle(id1,179.3265); SetPlayerPos(id2,-2081.8176,-186.6424,35.3203); SetPlayerFacingAngle(id2,359.3264);}
  	  case 6: {SetPlayerPos(id1,-2029.0835,-220.7787,35.3203); SetPlayerFacingAngle(id1,187.1832); SetPlayerPos(id2,-2027.3015,-277.0641,35.3274); SetPlayerFacingAngle(id2,1.5432);}
  	  case 7: {SetPlayerPos(id1,-2081.4543,-220.5226,35.3203); SetPlayerFacingAngle(id1,183.0866); SetPlayerPos(id2,-2080.2744,-277.6646,35.3203); SetPlayerFacingAngle(id2,358.6998);}
	}
	switch (armas)
	{
		case 1: {GivePlayerWeapon(id1,23,1000); GivePlayerWeapon(id2,23,1000); GivePlayerWeapon(id1,26,1000); GivePlayerWeapon(id2,26,1000); GivePlayerWeapon(id1,32,1000); GivePlayerWeapon(id2,32,1000); SetTimerEx("ComenzarDuelo",5000,false,"iii",id1,id2,arena);}
		case 2: {GivePlayerWeapon(id1,24,1000); GivePlayerWeapon(id2,24,1000); GivePlayerWeapon(id1,27,1000); GivePlayerWeapon(id2,27,1000); GivePlayerWeapon(id1,29,1000); GivePlayerWeapon(id2,29,1000); SetTimerEx("ComenzarDuelo",5000,false,"iii",id1,id2,arena);}
		case 3: {GivePlayerWeapon(id1,24,1000); GivePlayerWeapon(id1,25,1000); GivePlayerWeapon(id1,34,1000); GivePlayerWeapon(id2,24,1000); GivePlayerWeapon(id2,25,1000); GivePlayerWeapon(id2,34,1000); SetTimerEx("ComenzarDuelo",5000,false,"iii",id1,id2,arena);}
	}
}

forward ComenzarDuelo(id1,id2,arena);
public ComenzarDuelo(id1,id2,arena)
{
   	TogglePlayerControllable(id2,1);
	TogglePlayerControllable(id1,1);
	switch (arena)
	{
		case 1: {MoveObject(p1duelo1,2646.205811, 1230.074219, (26.962353+5),1); MoveObject(p2duelo1,2646.165771, 1191.811157, (26.957216+5),1);}
	}
}

public OnPlayerConnect(playerid)
{
	EnDuelo[playerid] = 0;
	return 1;
}

stock PlayerName2(playerid) {
  new name[MAX_PLAYER_NAME];
  GetPlayerName(playerid, name, sizeof(name));
  return name;
}

dcmd_duelo(playerid,params[])
{
	new index = 0, tmp[256];
	tmp = strtok(params,index);
	if (!strlen(tmp)) return SendClientMessage(playerid,COLOR_ROJO,"Aviso: Modo de uso correcto /duelo [invitar/ver]");
	if (!strcmp("invitar",tmp,false))
	{
	    if (EnDuelo[playerid] == 1) return SendClientMessage(playerid,COLOR_DUELO,"Duelo Info: Estas en un duelo, termina el duelo antes de iniciar otro.");
		ShowPlayerDialog(playerid, DUELOSMENU2, DIALOG_STYLE_LIST,"Escoje Una Arena","Arena 1 LV\nDuelo 2\nDuelo 3\nDuelo 4 \nDuelo 5 \nDuelo 6 \nDuelo 7","Escojer", "Cancelar");
		return 1;
	}
	if (!strcmp("ver",tmp,false))
	{
	    if (EnDuelo[playerid]==1) return SendClientMessage(playerid,COLOR_DUELO,"Duelo Info: No puedes usar este comando si estas en duelo.");
        ShowPlayerDialog(playerid, DUELOSMENU+3, DIALOG_STYLE_LIST,"Escoje Una Arena Para Ver","Arena 1 LV\nDuelo SF 1\nDuelo SF 2\nDuelo SF 3 \nDuelo 4 \nDuelo 5 \nDuelo 6","Escojer", "Cancelar");
        return 1;
	}
    return SendClientMessage(playerid,COLOR_ROJO,"Aviso: Modo de uso correcto /duelo [invitar/ver]");
}
	dcmd_noduelo(playerid,params[]) {
    #pragma unused params
    if(	NODUEL[playerid] == 0)
	{
	NODUEL[playerid] = 1;
	return SendClientMessage(playerid,red,"[INFO]: Ahora No Recibiras Duelos");
	}
    else return SendClientMessage(playerid,red,"[ERROR]: Ya Estas En NoDuelo Usa /SiDuelo Para Recibir Duelos");
	}

	dcmd_siduelo(playerid,params[]) {
    #pragma unused params
    if(	NODUEL[playerid] == 1)
	{
	NODUEL[playerid] = 0;
	return SendClientMessage(playerid,red,"[INFO]: Ahora Recibiras Duelos");
	}
    else return SendClientMessage(playerid,red,"[ERROR]: Ya Estas En SiDuelo Usa /NoDuelo Para No Recibir Duelos");
	}
//==============================================================================
public OnFilterScriptInit()
{
	print("\n--------------------------------------");
	print("                 Sitema De Dueloz");
	print("                  By [SOB]ChriS");
	print("--------------------------------------\n");
	//----------------------------Objects para duelos---------------------------
	    //------------------Duelo1--------------------------------------------------
	p1duelo1 = CreateObject(988, 2646.205811, 1230.074219, 26.962353, 0.0000, 0.0000, 0.0000); //Ete
	p2duelo1 = CreateObject(988, 2646.165771, 1191.811157, 26.957216, 0.0000, 0.0000, 180.0001); //Ete
	CreateObject(985, 2658.970215, 1223.538330, 27.633957, 0.0000, 0.0000, 270.0000);
    CreateObject(985, 2658.986816, 1215.675537, 27.633957, 0.0000, 0.0000, 270.0000);
    CreateObject(985, 2658.985840, 1207.797485, 27.633957, 0.0000, 0.0000, 270.0000);
    CreateObject(985, 2658.979736, 1199.929321, 27.633957, 0.0000, 0.0000, 270.0000);
    CreateObject(986, 2658.982178, 1191.978394, 27.633957, 0.0000, 0.0000, 90.0000);
    CreateObject(986, 2658.977051, 1231.471313, 27.633957, 0.0000, 0.0000, 90.0000);
    CreateObject(983, 2658.949463, 1187.323853, 29.151711, 269.7591, 0.0000, 0.0000);
    CreateObject(1468, 2659.028809, 1186.751099, 27.187063, 0.0000, 269.7591, 90.8594);
    CreateObject(1468, 2659.018799, 1186.741699, 30.462059, 0.0000, 269.7591, 90.8594);
    CreateObject(986, 2631.377686, 1231.482178, 27.628822, 0.0000, 0.0000, 90.0000);
    CreateObject(986, 2631.388428, 1223.464844, 27.633957, 0.0000, 0.0000, 90.0000);
    CreateObject(986, 2631.394531, 1215.443848, 27.633957, 0.0000, 0.0000, 90.0000);
    CreateObject(986, 2631.390137, 1207.422729, 27.633957, 0.0000, 0.0000, 90.0000);
    CreateObject(986, 2631.381348, 1199.408691, 27.633957, 0.0000, 0.0000, 90.0000);
    CreateObject(986, 2631.377686, 1191.387939, 27.633957, 0.0000, 0.0000, 90.0000);
    CreateObject(1468, 2631.366455, 1186.160767, 28.562042, 0.0000, 90.2408, 270.4818);
    CreateObject(1468, 2631.366455, 1186.153198, 30.462032, 0.0000, 90.2408, 270.4818);
    CreateObject(987, 2631.459717, 1235.702637, 26.943138, 0.0000, 0.0000, 0.0000);
    CreateObject(987, 2643.423340, 1235.680054, 26.918139, 0.0000, 0.0000, 0.0000);
    CreateObject(987, 2647.087402, 1235.696777, 26.943146, 0.0000, 0.0000, 0.0000);
    CreateObject(987, 2643.238525, 1186.149048, 26.918150, 0.0000, 0.0000, 180.0000);
    CreateObject(987, 2655.192871, 1186.149292, 26.943138, 0.0000, 0.0000, 180.0000);
    CreateObject(987, 2658.893555, 1186.134644, 26.942057, 0.0000, 0.0000, 180.0000);
    CreateObject(988, 2648.857910, 1232.854370, 26.957216, 0.0000, 0.0000, 90.0000); //Ete
    CreateObject(988, 2643.476074, 1232.702881, 26.957216, 0.0000, 0.0000, 270.0000); //Ete
   	CreateObject(988, 2646.057373, 1234.208008, 31.012333, 270.6186, 0.0000, 180.0000); //Ete
    CreateObject(988, 2643.485840, 1189.049438, 26.957216, 0.0000, 0.0000, 270.0000); //Ete
    CreateObject(988, 2648.908447, 1189.160889, 26.957216, 0.0000, 0.0000, 90.0002); //Ete
    CreateObject(988, 2646.254639, 1187.700806, 31.018589, 270.6186, 0.0000, 0.0001); //Ete
    CreateObject(3819, 2663.851807, 1223.966431, 26.921049, 0.0000, 0.0000, 0.0000);
    CreateObject(3819, 2663.856934, 1215.374878, 26.921049, 0.0000, 0.0000, 0.0000);
    CreateObject(3819, 2663.853271, 1206.777344, 26.921049, 0.0000, 0.0000, 0.0000);
    CreateObject(3819, 2663.850586, 1198.169922, 26.921049, 0.0000, 0.0000, 0.0000);
    CreateObject(3819, 2626.504150, 1197.893921, 26.921049, 0.0000, 0.0000, 180.0000);
    CreateObject(3819, 2626.503906, 1206.491821, 26.921049, 0.0000, 0.0000, 180.0000);
    CreateObject(3819, 2626.495850, 1215.078491, 26.921049, 0.0000, 0.0000, 180.0000);
    CreateObject(3819, 2626.497559, 1223.673828, 26.921049, 0.0000, 0.0000, 180.0000);
    CreateObject(3528, 2645.738525, 1233.813354, 34.384354, 0.0000, 0.0000, 270.0000);
    CreateObject(3528, 2646.615234, 1188.384399, 34.487526, 0.0000, 0.0000, 90.0000);
    CreateObject(983,2631.422,1186.725,29.152,-89.381,0.0,0.859);
    CreateObject(976,2666.742,1220.184,27.222,0.0,0.0,90.241);
    CreateObject(976,2666.772,1211.328,27.230,0.0,0.0,90.241);
    CreateObject(976,2666.770,1202.507,27.228,0.0,0.0,90.241);
    CreateObject(976,2666.775,1193.651,27.216,0.0,0.0,90.241);
    CreateObject(976,2623.681,1220.203,27.222,0.0,0.0,90.241);
    CreateObject(976,2623.721,1211.391,27.222,0.0,0.0,90.241);
    CreateObject(976,2623.756,1202.563,27.211,0.0,0.0,90.241);
    CreateObject(976,2623.718,1193.721,27.172,0.0,0.0,90.241);
	return 1;
}

public OnFilterScriptExit()
{
	return 1;
}


public OnPlayerDisconnect(playerid, reason)
{
	if (EnDuelo[playerid]==1)
 	{
		for (new i=1; i<=ARENAS; i++)
		{
			if ((Duelos[i][DesaId] == playerid || Duelos[i][DesafiadoId] == playerid) && (Duelos[i][Libre]==1))
			{
			    Duelos[i][Libre] = 0;
   				EnDuelo[Duelos[i][DesaId]] = 0;
				EnDuelo[Duelos[i][DesafiadoId]] = 0;
				if (playerid == Duelos[i][DesaId])
				{
				    new string2[128];
					format(string2,sizeof(string2),"Duelo Info: %s a abandonado el servidor en medio de un duelo, %s es el ganador por default.",PlayerName2(playerid),PlayerName2(Duelos[i][DesafiadoId]));
					SendClientMessageToAll(COLOR_DUELO,string2);
					switch (i)
			    	{
						case 1: {SetPlayerPos(Duelos[i][DesafiadoId],2626.5664,1206.4237,28.0004); SetPlayerFacingAngle(Duelos[i][DesafiadoId],274.9405);}
					}
					for (new j=0; j<= MAX_PLAYERS; j++)
					{
				    	if (ViendoDuelo[j] == i)
	    				{
	    			    	new str2[256];
			        		format(str2,sizeof(str2),"~r~%s ~w~es el ganador del duelo",PlayerName2(Duelos[i][DesafiadoId]));
							GameTextForPlayer(j,str2,5000,0);
							ViendoDuelo[j] =-1;
	    				}
					}
				}
				if (playerid == Duelos[i][DesafiadoId])
				{
				    new string2[128];
					format(string2,sizeof(string2),"Duelo Info: %s a abandonado el servidor en medio de un duelo, %s es el ganador por default.",PlayerName2(playerid),PlayerName2(Duelos[i][DesaId]));
					SendClientMessageToAll(COLOR_DUELO,string2);
					switch (i)
			    	{
						case 1: {SetPlayerPos(Duelos[i][DesaId],2626.5664,1206.4237,28.0004); SetPlayerFacingAngle(Duelos[i][DesaId],274.9405);}
					}
					for (new j=0; j<= MAX_PLAYERS; j++)
					{
				    	if (ViendoDuelo[j] == i)
	    				{
	    			    	new str2[256];
			        		format(str2,sizeof(str2),"~r~%s ~w~es el ganador del duelo",PlayerName2(Duelos[i][DesaId]));
							GameTextForPlayer(j,str2,5000,0);
							ViendoDuelo[j] =-1;
	    				}
					}
				}
				Duelos[i][DesaId] = -1;
				Duelos[i][DesafiadoId] = -1;
				Duelos[i][ArmasId] = -1;
				return 1;
			}
		}
	}
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	if (EnDuelo[playerid] == 1 && EnDuelo[killerid] == 1)
 	{
		for (new i=1; i<= ARENAS; i++)
		{
			if ((Duelos[i][DesaId] == playerid || Duelos[i][DesaId] == killerid) && (Duelos[i][DesafiadoId] == playerid) || (Duelos[i][DesafiadoId] == killerid))
			{
			    new str[128];
			    format(str,sizeof(str),"Duelo Info: Haz perdido el duelo contra %s",PlayerName2(killerid));
			    SendClientMessage(playerid,COLOR_DUELO,str);
			    format(str,sizeof(str),"Duelo Info: Haz ganado el duelo contra %s",PlayerName2(playerid));
		   	    SendClientMessage(killerid,COLOR_DUELO,str);
        		SendClientMessage(killerid,COLOR_DUELO,"Duelo Info: Ahora estas en las graderias, para volver a tener un duelo usa /duelo invitar.");
			 	EnDuelo[playerid] = 0;
				EnDuelo[killerid] = 0;
				Duelos[i][DesafiadoId] = -1;
   				Duelos[i][DesaId] = -1;
    			Duelos[i][ArmasId] = -1;
				Duelos[i][Libre] = 0;
			    switch (i)
			    {
					case 1: {SetPlayerPos(killerid,2626.5664,1206.4237,28.0004); SetPlayerFacingAngle(killerid,274.9405);}
				}
				for (new j=0; j<= MAX_PLAYERS; j++)
				{
				    if (ViendoDuelo[j] == i)
	    			{
	    			    new str2[256];
		        		format(str2,sizeof(str2),"~r~%s ~w~es el ganador del duelo",PlayerName2(killerid));
						GameTextForPlayer(j,str2,5000,0);
						ViendoDuelo[j] =-1;
	    			}
				}

				return 1;
			}
		}
	}
	if (EnDuelo[playerid] == 1 && EnDuelo[killerid] == 0)
	{
		//pushiment
	}
	return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
		if (dialogid == DUELOSMENU)
	{
		if (response)
		{
			for (new i=1; i<=ARENAS; i++)
			{
				if (Duelos[i][DesafiadoId] == playerid)
				{
                    new str[256];
				    format(str,sizeof(str),"Duelo Info: Tu duelo con %s a sido aceptado",PlayerName2(playerid));
				    SendClientMessage(playerid,COLOR_DUELO,"Duelo Info: Espera a que tu desafiante confirme el duelo.");
					ShowPlayerDialog(Duelos[i][DesaId], DUELOSMENU+1, DIALOG_STYLE_MSGBOX,"Invitacion Duelo",str,"Comenzar", "Abortar");
					return 1;
				}
			}
		}
		if (!response)
		{
            for (new i=1; i<=ARENAS; i++)
			{
				if (Duelos[i][DesafiadoId] == playerid)
				{
				    new str[256];
   				    format(str,sizeof(str),"Duelo Info: %s a rechazado tu invitacion de duelo.",PlayerName2(playerid));
					SendClientMessage(Duelos[i][DesaId],COLOR_DUELO,str);
				    Duelos[i][DesafiadoId] = -1;
   				    Duelos[i][DesaId] = -1;
    				Duelos[i][ArmasId] = -1;
				    Duelos[i][Libre] = 0;
					return 1;
				}
			}
		}
		return 1;
	}
	if (dialogid == DUELOSMENU+1)
	{
		if (response)
		{
			for (new i=1; i <=ARENAS; i++)
			{
				if (Duelos[i][DesaId] == playerid)
				{
				    Duelos[i][Libre] = 1;
				    EnDuelo[Duelos[i][DesafiadoId]] = 1;
				    EnDuelo[playerid] = 1;
					SetDuel(playerid,Duelos[i][DesafiadoId],Duelos[i][ArmasId],i);
					new wep[128];
					switch (Duelos[i][ArmasId])
					{
						case 1: wep = "Armas Rapidas";
						case 2: wep = "Armas Lentas";
						case 3: wep = "Armas Lentas (/ww2)";
					}
					new string2[256];
					format(string2,sizeof(string2),"El duelo entre %s y %s con armas %s, pon /duelo ver %d para espectar el duelo.",PlayerName2(Duelos[i][DesaId]),PlayerName2(Duelos[i][DesafiadoId]),wep,i,i);
					SendClientMessageToAll(COLOR_DUELO,string2);
					return 1;
				}
			}
  		}
  		if (!response)
  		{
            for (new i=1; i <=ARENAS; i++)
			{
				if (Duelos[i][DesaId] == playerid)
				{
				    new str[256];
				    format(str,sizeof(str),"Duelo Info: Por alguna razón %s a decidido abortar el duelo en ultimo momento.",PlayerName2(playerid));
				    SendClientMessage(Duelos[i][DesafiadoId],COLOR_DUELO,str);
				    Duelos[i][DesafiadoId] = -1;
   				    Duelos[i][DesaId] = -1;
    				Duelos[i][ArmasId] = -1;
				    Duelos[i][Libre] = 0;
				}
			}
		}
		return 1;
	}
	if (dialogid == DUELOSMENU2)
	{
	    if (response)
	    {
	        if (Duelos[listitem+1][Libre] == 1) return SendClientMessage(playerid,COLOR_DUELO,"Duelo Info: Esa arena esta ocupada, espera a que termine el duelo ó escoje otra arena.");
			Duelos[listitem+1][DesaId] = playerid;
            ShowPlayerDialog(playerid, DUELOSMENU2+1, DIALOG_STYLE_LIST,"Escoje El Tipo de Armas","Armas Rapidas\nArmas Lentas (/ww)\nArmas Lentas 2 (/ww2)","Escojer", "Cancelar");
		}
		if (!response)
		{
			SendClientMessage(playerid,COLOR_DUELO,"Duelo Info: Haz cancelado la invitacion de duelo.");
		}
		return 1;
	}
	if (dialogid == DUELOSMENU2+1)
	{
		if (response)
		{
			for (new i = 1; i <=ARENAS; i++)
			{
				if (Duelos[i][DesaId] == playerid)
				{
					Duelos[i][ArmasId] = listitem+1;
					ShowPlayerDialog(playerid, DUELOSMENU2+2, DIALOG_STYLE_INPUT,"Escribe la ID","Escribe La ID del Jugador\n al que quieras invitar","Invitar", "Cancelar");
					return 1;
				}
			}
		}
		if (!response)
		{
			for (new i = 1; i <= ARENAS; i++)
			{
				if (Duelos[i][DesaId] == playerid)
				{
					Duelos[i][DesaId] = -1;
					SendClientMessage(playerid,COLOR_DUELO,"Duelo Info: Haz cancelado la invitacion de duelo.");
					return 1;
				}
			}
		}
		return 1;
	}
	if (dialogid == DUELOSMENU2+2)
	{
		if (response)
		{
		    new str[256],string2[256];
			if (!strlen(inputtext)) return SendClientMessage(playerid,COLOR_DUELO,"Duelo Info: La ID que haz puesto es invalida.");
			if (!IsNumeric(inputtext))  return SendClientMessage(playerid,COLOR_DUELO,"Duelo Info: La ID que haz puesto es invalida.");
			new id = strval(inputtext);
			if (!IsPlayerConnected(id)) return SendClientMessage(playerid,COLOR_DUELO,"Duelo Info: El jugador no esta conectado.");
			if (id == playerid) return SendClientMessage(playerid,COLOR_DUELO,"Duelo Info: No puedes desafiarte a ti mismo a un duelo.");
			if (EnDuelo[id] == 1) return SendClientMessage(playerid,COLOR_DUELO,"Duelo Info: El jugador al que quieres invitar esta actuamente en un duelo.");
   			if(	NODUEL[id] == 1) return SendClientMessage(playerid,COLOR_DUELO,"Duelo Info: El Jugador Esta En /NoDuelo");
			for (new i = 1; i <= ARENAS; i++)
			{
				if (Duelos[i][DesaId] == playerid)
				{
					Duelos[i][DesafiadoId] = id;
					switch (Duelos[i][ArmasId])
					{
						case 1: str = "Armas Rapidas";
						case 2: str = "Armas Lentas";
						case 3: str = "Armas Lentas (/ww2)";
					}
					format(string2,sizeof(string2),"Duelo Info: %s Te a desafiado a un duelo \n Con %s en la arena %d",PlayerName2(playerid),str,i);
					ShowPlayerDialog(Duelos[i][DesafiadoId], DUELOSMENU, DIALOG_STYLE_MSGBOX,"Invitacion Duelo",string2,"Aceptar","Rechazar");
					format(string2,sizeof(string2),"Duelo Info: Tu invitacion se a enviado exitosamente a %s",PlayerName2(Duelos[i][DesafiadoId]));
					SendClientMessage(playerid,COLOR_DUELO,string2);
					return 1;
				}
			}
		}
		if (!response)
		{
			for (new i=1; i<= ARENAS; i++)
			{
				if (Duelos[i][DesaId] == playerid)
				{
					Duelos[i][DesaId] = -1;
					Duelos[i][ArmasId] = -1;
					Duelos[i][DesafiadoId] = -1;
					Duelos[i][Libre] = 0;
					SendClientMessage(playerid,COLOR_DUELO,"Duelo Info: Haz cancelado la invitacion de duelo.");
					return 1;
				}
			}
		}
		return 1;
	}
	if (dialogid == DUELOSMENU+3)
	{
	    if (response)
	    {
	        if (Duelos[listitem+1][Libre] == 0) return SendClientMessage(playerid,COLOR_DUELO,"Duelo Info: No hay ningun duelo en curso en esa arena.");
			switch (listitem)
			{
				case 0:{new rand=random(sizeof(DuelosSpec1));SetPlayerPos(playerid,DuelosSpec1[rand][0],DuelosSpec1[rand][1],DuelosSpec1[rand][2]);SetPlayerFacingAngle(playerid,DuelosSpec1[rand][3]);}
				case 1:{new rand=random(sizeof(DuelosSpec2));SetPlayerPos(playerid,DuelosSpec2[rand][0],DuelosSpec2[rand][1],DuelosSpec2[rand][2]);SetPlayerFacingAngle(playerid,DuelosSpec2[rand][3]);}
				case 2:{new rand=random(sizeof(DuelosSpec3));SetPlayerPos(playerid,DuelosSpec3[rand][0],DuelosSpec3[rand][1],DuelosSpec3[rand][2]);SetPlayerFacingAngle(playerid,DuelosSpec3[rand][3]);}
				case 3:{new rand=random(sizeof(DuelosSpec4));SetPlayerPos(playerid,DuelosSpec4[rand][0],DuelosSpec4[rand][1],DuelosSpec4[rand][2]);SetPlayerFacingAngle(playerid,DuelosSpec4[rand][3]);}
				case 4:{new rand=random(sizeof(DuelosSpec5));SetPlayerPos(playerid,DuelosSpec5[rand][0],DuelosSpec5[rand][1],DuelosSpec4[rand][2]);SetPlayerFacingAngle(playerid,DuelosSpec5[rand][3]);}
				case 5:{new rand=random(sizeof(DuelosSpec6));SetPlayerPos(playerid,DuelosSpec6[rand][0],DuelosSpec6[rand][1],DuelosSpec4[rand][2]);SetPlayerFacingAngle(playerid,DuelosSpec6[rand][3]);}
				case 6:{new rand=random(sizeof(DuelosSpec7));SetPlayerPos(playerid,DuelosSpec7[rand][0],DuelosSpec7[rand][1],DuelosSpec4[rand][2]);SetPlayerFacingAngle(playerid,DuelosSpec7[rand][3]);}
			}
		    ViendoDuelo[playerid] = (listitem+1);
		}
		return 1;
	}
	return 0;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	dcmd(duelo,5,cmdtext);
	dcmd(noduelo,7,cmdtext);
   	dcmd(siduelo,7,cmdtext);
	return 0;
}
 stock strtok(const string[], &index)
{
	new length = strlen(string);
	while ((index < length) && (string[index] <= ' '))
	{
		index++;
	}

	new offset = index;
	new result[20];
	while ((index < length) && (string[index] > ' ') && ((index - offset) < (sizeof(result) - 1)))
	{
		result[index - offset] = string[index];
		index++;
	}
	result[index - offset] = EOS;
	return result;
}
