/* ________________________________
__,__(								)
.--..-""-..--.(Monkyfix,goodnow,happybe!)
/..\/.-..-.\/..\(Keepthecredits!		)
||'|/Y\|'||/	(							)
|\\\0|0///|/¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
\'-,\.-"````"-./,-'//
`'-'/_^^_\'-'`/
.--'|\.___./|'--.
/`\\.-.//`\
/'._/|-'_.'\
/;/--~'|\
/.'\|.-\--.\\
/.'-./.-.;\|\|'~'-.|\\
\`-./`|_\_/``\'.\
'.;___)'.`;/
'-.,_;___)\//
\``'------'\\`/
'.\'.|;/_
___>'.\___/,'--.
.''..-~~~~~-./|--'`~~-.\
///.---'/.-~~-._////---..__.'/
((_(_///(_(_(_(---.__.'
||_`~~`
||\'.
\'....'|
'.,___.'

		#Name:[FilterScript]Don'tGetWet
	#Author:iMonk3y
	#ReleaseDate:31/01/2011
	#Credits:
			¤zcmd			-Zeex(http://forum.sa-mp.com/showthread.php?t=91354)
			¤foreach-Y_Less(http://forum.sa-mp.com/showthread.php?t=92679)
*/

#define  FILTERSCRIPT

#include<a_samp>
#include<zcmd>
#include <     y_iterate    >

#define  isOdd2(%1)\
	((%1)&0x01)

#define iseven2(%1)\
	(!isOdd2((%1)))

#define ALL_PLAYERS	100//define numberofplayersonyourserver
#define MAX_SLOTS 54//Don'tchangethis
#define TIMEE 180000
#define PRIZE_MONEY	10000
#define MAX_PLAYER 100
#define LIME		0x88AA62FF
#define WHITE		0xFFFFFFAA
#define RULE		0xFBDF89AA
#define ORANGE		0xDB881AAA
#define W "{FFFFFF}"//white
#define R "{FF0000}"//redy/
#define G "{00FF00}"
#define LB "{00C2EC}"
#define COL_LIME\
	"{88AA62}"
#define COL_WHITE	\
	"{FFFFFF}"
#define COL_RULE	\
	"{FBDF89}"
#define COL_ORANGE	\
	"{DB881A}"
#pragma tabsize 0
forward SpeedUp(object,Float:x,Float:y,Float:z);
forward RespawnPlayer(player);
forward MinigameWinner(player);
forward MinigameCountdown();
forward MinigameUpdate();
forward EndMinigame();

new bool:Minigamer[MAX_PLAYERS];
new bool:VIEW_FROM_ABOVE;
new inProgress,uTimer;
new Objects_[2][MAX_SLOTS];
new pWeaponData[ALL_PLAYERS][13];
new pSavedAmmo[ALL_PLAYERS][13];
new Float:pCoords[ALL_PLAYERS][3];
new pInterior[ALL_PLAYERS];

new Iterator:Minigamer<MAX_SLOTS>;
new Iterator:Objects<MAX_SLOTS>;

new pReadyText[2][64]=
{
	"~n~~n~~n~~g~~h~preparado?",
	"~n~~n~~n~~y~estaslisto?"
};

new pFellOffText[2][28]=
{
	"~n~~r~~h~hasperdido",
	"~n~~r~~h~vergonzoso"
};

new Float:gCoords[MAX_SLOTS][3]={
	
	{-5309.198120,-199.052383,22.593704},
	{-5309.198120,-195.786071,22.593704},
	{-5309.198120,-192.510620,22.593704},
	{-5309.198120,-189.250564,22.593704},
	{-5309.198120,-185.987960,22.593704},
	{-5309.198120,-182.727081,22.593704},
	{-5309.198120,-179.463394,22.593704},
	{-5309.198120,-176.205261,22.593704},
	{-5304.841796,-176.205261,22.593704},
	{-5304.841796,-179.468795,22.593704},
	{-5304.841796,-182.737884,22.593704},
	{-5304.841796,-185.989654,22.593704},
	{-5304.841796,-189.259185,22.593704},
	{-5304.841796,-192.518615,22.593704},
	{-5304.841796,-195.785491,22.593704},
	{-5304.841796,-199.054733,22.593704},
	{-5300.489990,-199.054733,22.593704},
	{-5300.489990,-195.782165,22.593704},
	{-5300.489990,-192.531250,22.593704},
	{-5300.489990,-189.274765,22.593704},
	{-5300.489990,-186.003005,22.593704},
	{-5300.489990,-182.735229,22.593704},
	{-5300.489990,-179.471069,22.593704},
	{-5300.489990,-176.208007,22.593704},
	{-5296.138061,-176.208007,22.593704},
	{-5296.138061,-179.479248,22.593704},
	{-5296.138061,-182.744735,22.593704},
	{-5296.138061,-186.002944,22.593704},
	{-5296.138061,-189.274505,22.593704},
	{-5296.138061,-192.533691,22.593704},
	{-5296.138061,-195.788970,22.593704},
	{-5296.138061,-199.048782,22.593704},
	{-5291.776000,-199.050140,22.593704},
	{-5291.776000,-195.790634,22.593704},
	{-5291.776000,-192.542922,22.593704},
	{-5291.776000,-189.277542,22.593704},
	{-5291.776000,-186.013275,22.593704},
	{-5291.776000,-182.742355,22.593704},
	{-5291.776000,-179.475021,22.593704},
	{-5291.776000,-176.215805,22.593704},
	{-5287.432250,-176.215805,22.593704},
	{-5287.432250,-179.485168,22.593704},
	{-5287.432250,-182.739608,22.593704},
	{-5287.432250,-186.016723,22.593704},
	{-5287.432250,-189.277816,22.593704},
	{-5287.432250,-192.539001,22.593704},
	{-5287.432250,-195.796325,22.593704},
	{-5287.432250,-199.053771,22.593704},
	{-5287.431274,-202.320648,22.593704},
	{-5291.781616,-202.320648,22.593704},
	{-5296.136718,-202.320648,22.593704},
	{-5300.493652,-202.320648,22.593704},
	{-5304.848876,-202.320648,22.593704},
	{-5309.201660,-202.320648,22.593704}
};

public OnFilterScriptInit()
{
SetTimer("Start",5000,false);

	return  1;
}

public OnFilterScriptExit()
{
if(inProgress>0)EndMinigame();
	return  1;
}

public OnPlayerDisconnect(playerid)
{
new str[128];
	if(Minigamer[playerid]==true)
	{
		if(inProgress>1)
		{
		/*if(Iter_Count(Minigamer)<2){
			format(str,sizeof(str),"*%s"COL_RULE"hasdroppedoutof"COL_ORANGE"Don'tGetWet"COL_RULE"minigame,"COL_LIME"rank%d",PlayerName(playerid),Iter_Count(Minigamer));
			SendClientMessageToAll(LIME,str);
			}*/
			Iter_Remove(Minigamer,playerid);
			Minigamer[playerid]=false;
			SetPVarInt(playerid,"MINION",0);
			if(Iter_Count(Minigamer)<2)
			{
			foreach(new i:Minigamer){MinigameWinner(i); break;}
			}

		}
		else
		{
		Iter_Remove(Minigamer,playerid);
			Minigamer[playerid]=false;
			SetPVarInt(playerid,"MINION",0);
		}
	}
	return  1;
}

public OnPlayerDeath(playerid,killerid,reason)
{
new str[128];
	if(Minigamer[playerid]==true)
	{
		if(inProgress>1)
		{
			//format(str,sizeof(str),"*%s"COL_RULE"hasdroppedoutof"COL_ORANGE"Don'tGetWet"COL_RULE"minigame,"COL_LIME"rank%d",PlayerName(playerid),Iter_Count(Minigamer));
		//	SendClientMessageToAll(LIME,str);
			Iter_Remove(Minigamer,playerid);
				SetPVarInt(playerid,"MINION",0);
			Minigamer[playerid]=false;
			if(Iter_Count(Minigamer)<2)
			{
			foreach(new i:Minigamer){MinigameWinner(i); break;}
			}
		}
		else
		{
	//		SendClientMessage(playerid,LIME,"Yoursignupfor"COL_ORANGE"Don'tGetWet"COL_LIME"minigamehasbeencancelled.");
			Iter_Remove(Minigamer,playerid);
				SetPVarInt(playerid,"MINION",0);
			Minigamer[playerid]=false;
		}
	}
	return  1;
}

//SendClientMessageToAll(LIME,""G"———————————————————————————————————————————————————————————————");
CMD:salirdm(playerid,params[]){

	if(Minigamer[playerid]==true)
	{
		if(inProgress>1)
		{
			//format(str,sizeof(str),"*%s"COL_RULE"hasdroppedoutof"COL_ORANGE"Don'tGetWet"COL_RULE"minigame,"COL_LIME"rank%d",PlayerName(playerid),Iter_Count(Minigamer));
		//	SendClientMessageToAll(LIME,str);
			Iter_Remove(Minigamer,playerid);
			Minigamer[playerid]=false;
				SetPVarInt(playerid,"MINION",0);
			if(Iter_Count(Minigamer)<2)
			{
			foreach(new i:Minigamer){MinigameWinner(i); break;}
			}
			return  1;
		}
		else
		{
		//	SendClientMessage(playerid,LIME,"Yoursignupfor"COL_ORANGE"Don'tGetWet"COL_LIME"minigamehasbeencancelled.");
	SetPVarInt(playerid,"MINION",0);
			Iter_Remove(Minigamer,playerid);
			Minigamer[playerid]=false;
			return  1;
		///	SetPVarInt(playerid,"MINION",0);
		}
	}
	return 0;
}
new Count;
CMD:mojados(playerid,params[])
{
	if(Minigamer[playerid]!=false)
		return SendClientMessage(playerid,LIME,""R"[Pura Joda]Ya estás inscrito.");
	else if(inProgress>1)
		return SendClientMessage(playerid,ORANGE,""R"[Pura Joda] Juego en progreso.");
	else if(Iter_Count(Minigamer)>MAX_SLOTS-1)
		return SendClientMessage(playerid,ORANGE,""R"[Pura Joda] Minijuego lleno.");


	Minigamer[playerid]=true;
		//SetPVarInt(playerid,"MINION",1);
		Iter_Add(Minigamer,playerid);
		SendClientMessage(playerid,RULE,""R"[Pura Joda] Te has inscrito al juego Mojados.");
	
	return  1;
}

public MinigameCountdown()
{
	/*if(Iter_Count(Minigamer)<2)//Endminigameiftherearen'tenoughsignups
	{
	//	SendClientMessageToAll(LIME,""R"[Pura Joda] No hay suficientesjugadoresparacomenzar"W"/Mojados.");
		foreach(new i:Minigamer)Minigamer[i]=false,SetPVarInt(i,"MINION",0);
		return EndMinigame();
	}*/
	//SendClientMessageToAll(-1,"staaqixdxd");
	if(inProgress!=2)
	{
	new  spot;
		foreach(new  i : Minigamer)
		{
		SetPVarInt(i,"MINION",1);
		GetPlayerPos(i,pCoords[i][0],pCoords[i][1],pCoords[i][2]);
		pInterior[i]=GetPlayerInterior(i);
		for(new a;a<13;a++)
			{
			GetPlayerWeaponData(i,a,pWeaponData[i][a],pSavedAmmo[i][a]);
			}
			ResetPlayerWeapons(i);
			SetPlayerInterior(i,0);
			spot=Iter_Random(Objects);
			Count++;
		//GameTextForPlayer(i,pReadyText[random(sizeof(pReadyText))],2050,3);
		Iter_Remove(Objects,spot);
		SetPlayerCameraPos(i,-5298.4814,-218.4391,42.1386);
		SetPlayerCameraLookAt(i,-5298.1616,-189.6903,23.6564);
		TogglePlayerControllable(i,false);
		SetPVarInt(i,"MINION",1);
			SetPlayerPos(i,gCoords[spot][0],gCoords[spot][1],gCoords[spot][2]+0.5);
		
		}
		
		Iter_Clear(Objects);
		for(new i;i<MAX_SLOTS;i++)Iter_Add(Objects,i);
		SetTimer("MinigameCountdown",2000,0);
		inProgress=2;
	}
	else
	{
		foreach(new  i : Minigamer)
		{
		if(!VIEW_FROM_ABOVE)
			SetCameraBehindPlayer(i);
			PlayerPlaySound(i,1057,0.0,0.0,0.0);
			TogglePlayerControllable(i,true);
		
		}
		uTimer=SetTimer("MinigameUpdate",2500,1);
	}
	return  1;
}

public MinigameUpdate()
{
	if(Iter_Count(Minigamer)<2) return EndMinigame();
	
	new str[128],Float:playerx,Float:playery,Float:playerz[ALL_PLAYERS];
	foreach(new i : Minigamer)
	{
		GetPlayerPos(i,playerx,playery,playerz[i]);
		if(playerz[i]<2.0)//Checksifplayerisinthewater
		{
			GameTextForPlayer(i,pFellOffText[random(sizeof(pFellOffText))],2500,3);
			Iter_Remove(Minigamer,i);
			Minigamer[i]=false;
			SetPVarInt(i,"MINION",0);
			RespawnPlayer(i);
			break;
		}
	
	}
	if(Iter_Count(Minigamer)<2)
	{
		foreach(new i : Minigamer) {MinigameWinner(i); break;}
	}
	new objectid,Float:ObjectX,Float:ObjectY,Float:ObjectZ;

if(!VIEW_FROM_ABOVE)
{
		foreach(new i:Objects)
		{
			if(isOdd2(random(10)))
			{
			GetObjectPos(Objects_[0][i],ObjectX,ObjectY,ObjectZ);
				MoveObject(Objects_[0][i],ObjectX,ObjectY,ObjectZ-1.5,0.2);
				MoveObject(Objects_[1][i],ObjectX,ObjectY,ObjectZ-1.5,0.2);
			}
			else
			{
				GetObjectPos(Objects_[0][i],ObjectX,ObjectY,ObjectZ);
				MoveObject(Objects_[0][i],ObjectX,ObjectY,ObjectZ+1.5,0.2);
				MoveObject(Objects_[1][i],ObjectX,ObjectY,ObjectZ+1.5,0.2);
			}
			break;
		}
	}

	objectid=Iter_Random(Objects);
	GetObjectPos(Objects_[0][objectid],ObjectX,ObjectY,ObjectZ);
	SetTimerEx("SpeedUp",500,0,"ifff",objectid,ObjectX,ObjectY,ObjectZ);
	MoveObject(Objects_[0][objectid],ObjectX,ObjectY,ObjectZ-5,1);
	if(!VIEW_FROM_ABOVE)
	MoveObject(Objects_[1][objectid],ObjectX,ObjectY,ObjectZ-5,1);
	Iter_Remove(Objects,objectid);
	return  1;
}

public SpeedUp(object,Float:x,Float:y,Float:z)
{
	MoveObject(Objects_[0][object],x,y,z-150,20);
	if(!VIEW_FROM_ABOVE)
	MoveObject(Objects_[1][object],x,y,z-150,20);
	foreach(new i : Minigamer){PlayerPlaySound(i,1039,0.0,0.0,0.0); }
}

public EndMinigame()
{
	for(new i;i<MAX_SLOTS;i++)
	{
	DestroyObject(Objects_[0][i]);
	if(!VIEW_FROM_ABOVE)
	DestroyObject(Objects_[1][i]);
	}
	inProgress=0;
	Iter_Clear(Objects);
	Iter_Clear(Minigamer);
	KillTimer(uTimer);
	SetTimer("Start",TIMEE,false);
	Count=0;
	SendClientMessageToAll(LIME,""G"[Pura Joda]"W" Mojados"G" iniciará de nuevo en"W"3"G" minutos.");
	return  1;
}
forward Start();
public Start(){
		new r=random(4);
		switch(r){
		case 0:VIEW_FROM_ABOVE=false;
		case 1:VIEW_FROM_ABOVE=true;
		case 2:VIEW_FROM_ABOVE=false;
		default:VIEW_FROM_ABOVE=true;
		}
		new str[128];
		format(str,sizeof(str),""G"[Pura Joda] Minijuego "W" Mojados "G" comenzará en "W"20"G" segs. Para entrar use "W"/Mojados");
		SendClientMessageToAll(LIME,""G"—————————————————————————————————————————————");
		SendClientMessageToAll(ORANGE,str);
		SendClientMessageToAll(LIME,""G"—————————————————————————————————————————————");
		for(new i=0; i < MAX_PLAYER; i++){
			if(IsPlayerConnected(i)){
				PlayerPlaySound(i,1057,0.0,0.0,0.0);
				}
		}
		SetTimer("MinigameCountdown",20000,0);
		for(new i;i<MAX_SLOTS;i++)
	{
	//Theobject(window)isonlyvisiblefromoneside
			Objects_[0][i] = CreateObject(1649,gCoords[i][0],gCoords[i][1],gCoords[i][2],-90.000000,0.000000,0.000000,150.0);
			if(!VIEW_FROM_ABOVE)//Incase/getwet2,weneedtomultiplynumberofobjectsandturnthemaroundsoplayerswouldbeabletoseethemfrombelow
			Objects_[1][i] = CreateObject(1649,gCoords[i][0],gCoords[i][1],gCoords[i][2],-270.000000,0.000000,0.000000,150.0);
			Iter_Add(Objects,i);
	}
	inProgress=1;

return 1;
}
public MinigameWinner(player)
{
	new str[128+24];
	if(Count>5){
	new Price=random(1000)*9+5000;
	format(str,sizeof(str),""G"[Pura Joda]"W" %s "G"ganó"W" Mojados. Premio +1 PJCoin, $%d",PlayerName(player),Price);
	SendClientMessageToAll(LIME,str);
	Reward(player,Price,1);
	}
	else{
	new Price;
	Price=random(200)*9+2000;
	format(str,sizeof(str),""G"[PuraJoda]"W" %s "G"ganó "W"Mojados. Premio $%d",PlayerName(player),Price);
	SendClientMessageToAll(LIME,str);
	Reward(player,Price,0);
	}
	SetPVarInt(player,"MINION",0);
	Minigamer[player]=false;
	Iter_Remove(Minigamer,player);
	SetTimerEx("RespawnPlayer",1400,0,"i",player);
	SetTimer("EndMinigame",1700,0);
}

public RespawnPlayer(player)
{
	for(new i=12;i>-1;i--)
	{
		GivePlayerWeapon(player,pWeaponData[player][i],pSavedAmmo[player][i]);
	}
	SetPlayerPos(player,pCoords[player][0],pCoords[player][1],pCoords[player][2]);
	SetPlayerInterior(player,pInterior[player]);
	SetCameraBehindPlayer(player);
}
forward Reward(playerid,money,pjcoin);
public Reward(playerid,money,pjcoin){
SetPVarInt(playerid,"MONEY",GetPVarInt(playerid,"MONEY")+money);
SetPVarInt(playerid,"COIN",GetPVarInt(playerid,"COIN")+pjcoin);
return  1;
}
stock PlayerName(playerid)
{
	new Name[MAX_PLAYER_NAME];
	GetPlayerName(playerid,Name,sizeof(Name));
	return  Name;
}
