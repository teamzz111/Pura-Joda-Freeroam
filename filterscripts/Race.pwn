
#include <a_samp>
//#include <moneyhax_FS>
#include <dini>
//#include <moneyhax_FS>
//#include <strlib>
new DentroCS[MAX_PLAYERS];
#define amarillo 0xFFE700FF
#include <zcmd>
#include IsPlayerLAdmin
#pragma tabsize 0
#define LIGHTGREEN 		0x38FF06FF
#pragma unused \
	ret_memcpy
#define MAX_PLAYER 100
#define SpeedCheck(%0,%1,%2,%3,%4) floatround(floatsqroot(%4?(%0*%0+%1*%1+%2*%2):(%0*%0+%1*%1)) *%3*1.6)
#define R "{FF0000}" //redy/
#define G "{00FF00}"
#define LB "{33CCFF}"
#define W "{FFFFFF}"
#define ForEach(%0,%1) \
	for(new %0 = 0; %0 != %1; %0++) if(IsPlayerConnected(%0) && !IsPlayerNPC(%0))
	new vNames[212][] =
	{
		{"Landstalker"},
		{"Bravura"},
		{"Buffalo"},
		{"Linerunner"},
		{"Perrenial"},
		{"Sentinel"},
		{"Dumper"},
		{"Firetruck"},
		{"Trashmaster"},
		{"Stretch"},
		{"Manana"},
		{"Infernus"},
		{"Voodoo"},
		{"Pony"},
		{"Mule"},
		{"Cheetah"},
		{"Ambulance"},
		{"Leviathan"},
		{"Moonbeam"},
		{"Esperanto"},
		{"Taxi"},
		{"Washington"},
		{"Bobcat"},
		{"Mr Whoopee"},
		{"BF Injection"},
		{"Hunter"},
		{"Premier"},
		{"Enforcer"},
		{"Securicar"},
		{"Banshee"},
		{"Predator"},
		{"Bus"},
		{"Rhino"},
		{"Barracks"},
		{"Hotknife"},
		{"Trailer 1"},
		{"Previon"},
		{"Coach"},
		{"Cabbie"},
		{"Stallion"},
		{"Rumpo"},
		{"RC Bandit"},
		{"Romero"},
		{"Packer"},
		{"Monster"},
		{"Admiral"},
		{"Squalo"},
		{"Seasparrow"},
		{"Pizzaboy"},
		{"Tram"},
		{"Trailer 2"},
		{"Turismo"},
		{"Speeder"},
		{"Reefer"},
		{"Tropic"},
		{"Flatbed"},
		{"Yankee"},
		{"Caddy"},
		{"Solair"},
		{"Berkley's RC Van"},
		{"Skimmer"},
		{"PCJ-600"},
		{"Faggio"},
		{"Freeway"},
		{"RC Baron"},
		{"RC Raider"},
		{"Glendale"},
		{"Oceanic"},
		{"Sanchez"},
		{"Sparrow"},
		{"Patriot"},
		{"Quad"},
		{"Coastguard"},
		{"Dinghy"},
		{"Hermes"},
		{"Sabre"},
		{"Rustler"},
		{"ZR-350"},
		{"Walton"},
		{"Regina"},
		{"Comet"},
		{"BMX"},
		{"Burrito"},
		{"Camper"},
		{"Marquis"},
		{"Baggage"},
		{"Dozer"},
		{"Maverick"},
		{"News Chopper"},
		{"Rancher"},
		{"FBI Rancher"},
		{"Virgo"},
		{"Greenwood"},
		{"Jetmax"},
		{"Hotring"},
		{"Sandking"},
		{"Blista Compact"},
		{"Police Maverick"},
		{"Boxville"},
		{"Benson"},
		{"Mesa"},
		{"RC Goblin"},
		{"Hotring Racer A"},
		{"Hotring Racer B"},
		{"Bloodring Banger"},
		{"Rancher"},
		{"Super GT"},
		{"Elegant"},
		{"Journey"},
		{"Bike"},
		{"Mountain Bike"},
		{"Beagle"},
		{"Cropdust"},
		{"Stunt"},
		{"Tanker"},
		{"Roadtrain"},
		{"Nebula"},
		{"Majestic"},
		{"Buccaneer"},
		{"Shamal"},
		{"Hydra"},
		{"FCR-900"},
		{"NRG-500"},
		{"HPV1000"},
		{"Cement Truck"},
		{"Tow Truck"},
		{"Fortune"},
		{"Cadrona"},
		{"FBI Truck"},
		{"Willard"},
		{"Forklift"},
		{"Tractor"},
		{"Combine"},
		{"Feltzer"},
		{"Remington"},
		{"Slamvan"},
		{"Blade"},
		{"Freight"},
		{"Streak"},
		{"Vortex"},
		{"Vincent"},
		{"Bullet"},
		{"Clover"},
		{"Sadler"},
		{"Firetruck LA"},
		{"Hustler"},
		{"Intruder"},
		{"Primo"},
		{"Cargobob"},
		{"Tampa"},
		{"Sunrise"},
		{"Merit"},
		{"Utility"},
		{"Nevada"},
		{"Yosemite"},
		{"Windsor"},
		{"Monster A"},
		{"Monster B"},
		{"Uranus"},
		{"Jester"},
		{"Sultan"},
		{"Stratum"},
		{"Elegy"},
		{"Raindance"},
		{"RC Tiger"},
		{"Flash"},
		{"Tahoma"},
		{"Savanna"},
		{"Bandito"},
		{"Freight Flat"},
		{"Streak Carriage"},
		{"Kart"},
		{"Mower"},
		{"Duneride"},
		{"Sweeper"},
		{"Broadway"},
		{"Tornado"},
		{"AT-400"},
		{"DFT-30"},
		{"Huntley"},
		{"Stafford"},
		{"BF-400"},
		{"Newsvan"},
		{"Tug"},
		{"Trailer 3"},
		{"Emperor"},
		{"Wayfarer"},
		{"Euros"},
		{"Hotdog"},
		{"Club"},
		{"Freight Carriage"},
		{"Trailer 3"},
		{"Andromada"},
		{"Dodo"},
		{"RC Cam"},
		{"Launch"},
		{"Police Car (LSPD)"},
		{"Police Car (SFPD)"},
		{"Police Car (LVPD)"},
		{"Police Ranger"},
		{"Picador"},
		{"S.W.A.T. Van"},
		{"Alpha"},
		{"Phoenix"},
		{"Glendale"},
		{"Sadler"},
		{"Luggage Trailer A"},
		{"Luggage Trailer B"},
		{"Stair Trailer"},
		{"Boxville"},
		{"Farm Plow"},
		{"Utility Trailer"}
	};
#define Loop(%0,%1) \
	for(new %0 = 0; %0 != %1; %0++)
	
#define IsOdd(%1) \
	((%1) & 1)
	
#define ConvertTime(%0,%1,%2,%3,%4) \
	new \
	    Float: %0 = floatdiv(%1, 60000) \
	;\
	%2 = floatround(%0, floatround_tozero); \
	%3 = floatround(floatmul(%0 - %2, 60), floatround_tozero); \
	%4 = floatround(floatmul(floatmul(%0 - %2, 60) - %3, 1000), floatround_tozero)
	
#define function%0(%1) \
	forward%0(%1); public%0(%1)
#define RANDOM_TIME_RACE 180000
#define MAX_RACE_CHECKPOINTS_EACH_RACE \
 	120

#define MAX_RACES \
 	100

#define COUNT_DOWN_TILL_RACE_START \
	30 // seconds
#define LIGHTBLUE 0x00C2ECFF
#define MAX_RACE_TIME \
	600 // seconds

#define RACE_CHECKPOINT_SIZE \
	13.5

#define DEBUG_RACE \
 0
//	new ret_memcpy;
#define RACE_IN_OTHER_WORLD 2 // Uncomment to enable

#define GREY \
	0xAFAFAFAA
	
#define GREEN \
	0x9FFF00FF
	
#define RED \
	0xE60000FF
	
#define YELLOW \
	0xFFFF00AA
	
#define WHITE \
	0xFFFFFFAA
//forward strreplace(string[], const search[], const replacement[], bool:ignorecase = false, pos = 0, limit = -1, maxlength = sizeof(string));
new Niuly[MAX_PLAYERS];
new
	BuildRace,
	//Text:CarreraT = Text:INVALID_TEXT_DRAW,
	PlayerText:Race0[MAX_PLAYERS] = {PlayerText:INVALID_TEXT_DRAW, ...},
	contador=0,
	BuildRaceType,
	Text:TopDriver = Text:INVALID_TEXT_DRAW,
	Text:TopDriver2 = Text:INVALID_TEXT_DRAW,
 PlayerText:Info[MAX_PLAYERS],
 PlayerText:Info2[MAX_PLAYERS],
	BuildVehicle,
	BuildCreatedVehicle,
	BuildModeVID,
	BuildName[30],
	bool: BuildTakeVehPos,
	BuildVehPosCount,
	bool: BuildTakeCheckpoints,
	BuildCheckPointCount,
	RaceBusy = 0x00,
	RaceName[30],
	RaceVehicle,
	RaceType,
	TotalCP,
	Float: RaceVehCoords[2][4],
	Float: CPCoords[MAX_RACE_CHECKPOINTS_EACH_RACE][4],
	CreatedRaceVeh[MAX_PLAYERS],
	Index,
	PlayersCount[2],
	CountTimer,
	CountAmount,
	bool: Joined[MAX_PLAYERS],
	RaceTick,
	RaceStarted,
	CPProgess[MAX_PLAYERS],
	Position,
	FinishCount,
	JoinCount,
	rCounter,
	RaceTime,
	//Text: RaceInfo[MAX_PLAYERS],
	InfoTimer[MAX_PLAYERS],
	RacePosition[MAX_PLAYERS],
	RaceNames[MAX_RACES][128],
 	TotalRaces,
 	bool: AutomaticRace,
 	TimeProgress,
    AutoRace

;
public OnFilterScriptExit()

{
	BuildCreatedVehicle = (BuildCreatedVehicle == 0x01) ? (DestroyVehicle(BuildVehicle), BuildCreatedVehicle = 0x00) : (DestroyVehicle(BuildVehicle), BuildCreatedVehicle = 0x00);
	KillTimer(rCounter);
	KillTimer(CountTimer);
	Loop(i, MAX_PLAYERS)
	{
		DisablePlayerRaceCheckpoint(i);
	//	TextDrawDestroy(RaceInfo[i]);
		DestroyVehicle(CreatedRaceVeh[i]);
		Joined[i] = false;
		SetPVarInt(i, "RACE",0);
		KillTimer(InfoTimer[i]);
	}
	JoinCount = 0;
	FinishCount = 0;
	TimeProgress = 0;
	Autorace();
    AutomaticRace = true;
	return 1;
}


public OnFilterScriptInit() {
/*new string[128],rFile[128],file[128],string2[128];
format(rFile, sizeof(rFile), "/rRaceSystem/RaceNames/RaceNames.txt", RaceName);
for(new u; u < 28;u++){
format(string, sizeof(string), "Race_%d", u);
format(string2, sizeof(string2),"%s",dini_Get(rFile, string));
printf(string2);
format(file,sizeof(file),"/rRaceSystem/%s.RRACE",string2);
dini_Set(file, string, "noone");
for(new i; i < 6;i++){
format(string, sizeof(string), "BestRacerTime_%d",i);
dini_IntSet(file, string, 0);
format(string, sizeof(string), "BestRacer_%d",i);
dini_Set(file, string, "noone");
printf("%d, listo",u);
}
}*/
TopDriver = TextDrawCreate(38.125000, 275.916656, "Top drivers");
TextDrawLetterSize(TopDriver, 0.445625, 1.862499);
TextDrawAlignment(TopDriver, 1);
TextDrawColor(TopDriver, -16776961);
TextDrawSetShadow(TopDriver, 0);
TextDrawSetOutline(TopDriver, 1);
TextDrawBackgroundColor(TopDriver, 51);
TextDrawFont(TopDriver, 3);
TextDrawSetProportional(TopDriver, 1);

TopDriver2 = TextDrawCreate(6.875000, 293.999877, "eeeeeeeeeeeeeeeeeeeeeee time 1'06'00");
TextDrawLetterSize(TopDriver2, 0.239374, 1.424999);
TextDrawAlignment(TopDriver2, 1);
TextDrawColor(TopDriver2, -1);
TextDrawSetShadow(TopDriver2, 0);
TextDrawSetOutline(TopDriver2, 1);
TextDrawBackgroundColor(TopDriver2, 51);
TextDrawFont(TopDriver2, 1);
TextDrawSetProportional(TopDriver2, 1);


	print("\n--------------------------------------");
	print(" Sístema de carreras por Ryder, adaptado ");
	print("               por HolacheJr v1.1            ");
	print("----------------------------------------\n");
//	SetTimer("Start",RANDOM_TIME_RACE,false);
	return 1;
}
function Start(){
	LoadRaceNames();
	LoadAutoRace(RaceNames[random(TotalRaces)]);
return 1;

}CMD:buildrace(playerid, params[])
{
	if(!IsPlayerAdmin(playerid)) return SendClientMessage(playerid, RED, "<!> You are not an administrator!");
	if(BuildRace != 0) return SendClientMessage(playerid, RED, "<!> There's already someone building a race!");
	if(RaceBusy == 0x01) return SendClientMessage(playerid, RED, "<!> Wait first till race ends!");
	if(IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid, RED, "<!> Please leave your vehicle first!");
	BuildRace = playerid+1;
	ShowDialog(playerid, 599);
	return 1;
}
CMD:startrace(playerid, params[])
{
    if (!IsPlayerAdmin(playerid)) return SendClientMessage(playerid, RED, "[Pura Joda] Sólo administradores, gracias.");
    if(AutomaticRace == true) return SendClientMessage(playerid, RED, "[Pura Joda] No será posible, está en modo automático");
    if(BuildRace != 0) return SendClientMessage(playerid, RED, "[Pura Joda] Alguien está construyendo una carrera aquí!");
    if(RaceBusy == 0x01 || RaceStarted == 1) return SendClientMessage(playerid, RED, "[Pura Joda] Hay una carrera en progreso, sea paciente.");
    if(isnull(params)) return SendClientMessage(playerid, RED, "[Pura Joda] /startrace [Nombre de la carrera]");
    LoadRace(playerid, params);
    return 1;
}
/*CMD:srace(playerid, params[])
{
	if(RaceBusy == 0x01 || RaceStarted == 1) return SendClientMessage(playerid, RED, "[Pura Joda] Hay una carrera en progreso, porfavor espere!");
	if(AutomaticRace == true) return SendClientMessage(playerid, RED, "[Pura Joda] Está en funcionamiento.");
    LoadRaceNames();
	LoadAutoRace(RaceNames[random(TotalRaces)]);
	AutomaticRace = true;
	return 1;
}
*/
new Float:xe, Float:y, Float:z;
CMD:stoprace(playerid, params[])
{
   	if(!IsPlayerAdmin(playerid)) return SendClientMessage(playerid, RED, "[Pura Joda] Sólo administradores RCON");
    if(RaceBusy == 0x00 || RaceStarted == 0) return SendClientMessage(playerid, RED, "[Pura Joda] No hay carrera para detener!");
	SendClientMessageToAll(RED, "[Pura Joda] Un administrador detuvo esta carrera!");
	return StopRace();
}
CMD:entrar(playerid, params[])
{
//	if(contador >= 15) return SendClientMessage(playerid, RED, "[Pura Joda] Lo sentimos, la carrera está en su límite 15/15");
	if(RaceStarted == 1) return SendClientMessage(playerid, RED, "[Pura Joda] Una carrera está en progreso, espere porfavor");
	if(RaceBusy == 0x00) return SendClientMessage(playerid, RED, "[Pura Joda] No hay carrera para ingresar!");
	if(Joined[playerid] == true) return SendClientMessage(playerid, RED, "[Pura Joda] Actualmente estás en la carrera!");
	DisableRemoteVehicleCollisions(playerid,1);
	if(IsPlayerInAnyVehicle(playerid)) {
	GetPlayerPos(playerid,xe,y,z); SetPlayerPos(playerid,xe,y,z+5); PlayerPlaySound(playerid,1190,0.0,0.0,0.0);
}
	SetupRaceForPlayer(playerid);
	Joined[playerid] = true;
	contador++;
	SetPVarInt(playerid, "RACE",1);
	return 1;
}
CMD:startautorace(playerid, params[])
{
	if (!IsPlayerAdmin(playerid)) return SendClientMessage(playerid, RED, "[Pura Joda] Sólo administradores RCON");
	if(RaceBusy == 0x01 || RaceStarted == 1) return SendClientMessage(playerid, RED, "[Pura Joda] Hay una carrera en progreso, porfavor espere!");
	if(AutomaticRace == true) return SendClientMessage(playerid, RED, "[Pura Joda] Está en funcionamiento.");
    LoadRaceNames();
	LoadAutoRace(RaceNames[random(TotalRaces)]);
	AutomaticRace = true;
	SendClientMessage(playerid, GREEN, "[Pura Joda] Acaba de iniciar el sistema de carreras automático, en segundos comenzará su funcionamiento.");
	return 1;
}
CMD:stopautorace(playerid, params[])
{
    if(!IsPlayerAdmin(playerid)) return SendClientMessage(playerid, RED, "[Pura Joda] Sólo administradores RCON");
    if(AutomaticRace == false) return SendClientMessage(playerid, RED, "[Pura Joda] No hay carreras en progreso");
    AutomaticRace = false;
    return 1;
}
CMD:exitrace(playerid, params[])
{
    if(Joined[playerid] == true)
    {
        SetPVarInt(playerid, "RACE",0);
        DisableRemoteVehicleCollisions(playerid,1);
		JoinCount--;
		contador--;
		Joined[playerid] = false;
		DestroyVehicle(CreatedRaceVeh[playerid]);
	    DisablePlayerRaceCheckpoint(playerid);
	    	TextDrawHideForPlayer(playerid, TopDriver);
	TextDrawHideForPlayer(playerid, TopDriver2);
        PlayerTextDrawHide(playerid, Info[playerid]);
        PlayerTextDrawHide(playerid, Race0[playerid]);
        PlayerTextDrawHide(playerid, Info2[playerid]);
		//TextDrawHideForPlayer(playerid, RaceInfo[playerid]);
		CPProgess[playerid] = 0;
		KillTimer(InfoTimer[playerid]);
		TogglePlayerControllable(playerid, true);
		SetCameraBehindPlayer(playerid);
		#if defined RACE_IN_OTHER_WORLD
		SetPlayerVirtualWorld(playerid, 0);
		#endif
	} else return SendClientMessage(playerid, RED, "[Pura Joda] No está en una carrera");
	return 1;
}

public OnPlayerEnterRaceCheckpoint(playerid)
{
	if(Niuly[playerid]) return 1;
	if(CPProgess[playerid] == TotalCP -1)
	{
		new
		    TimeStamp,
		    TotalRaceTime,
		    string[256],
		    rFile[256],
		    pName[MAX_PLAYER_NAME],
			rTime[3],
			Prize[2],
			TempTotalTime,
			TempTime[3]
		;
		Position++;
		GetPlayerName(playerid, pName, sizeof(pName));
		TimeStamp = GetTickCount();
		TotalRaceTime = TimeStamp - RaceTick;
		ConvertTime(var, TotalRaceTime, rTime[0], rTime[1], rTime[2]);
		if(contador>6){
		switch(Position)
		{
		    case 1: {
			Prize[0] = (random(random(5000)) + 10000), Prize[1] = 10;
			SetPVarInt(playerid,"COIN",GetPVarInt(playerid, "COIN")+1);}
		    case 2: Prize[0] = (random(random(4500)) + 9000), Prize[1] = 9;
		    case 3: Prize[0] = (random(random(4000)) + 8000), Prize[1] = 8;
		    case 4: Prize[0] = (random(random(3500)) + 7000), Prize[1] = 7;
		    case 5: Prize[0] = (random(random(3000)) + 6000), Prize[1] = 6;
		    case 6: Prize[0] = (random(random(2500)) + 5000), Prize[1] = 5;
		    case 7: Prize[0] = (random(random(2000)) + 4000), Prize[1] = 4;
		    case 8: Prize[0] = (random(random(1500)) + 3000), Prize[1] = 3;
		    case 9: Prize[0] = (random(random(1000)) + 2000), Prize[1] = 2;
		    default: Prize[0] = random(random(1000)), Prize[1] = 1;
		}}
		else if(contador < 6){
  switch(Position)
		{
		    case 1: {
			Prize[0] = (random(random(1000)) + 6000), Prize[1] = 0;}
		    case 2: Prize[0] = (random(random(500)) + 5000), Prize[1] = 0;
		    case 3: Prize[0] = (random(random(3)) + 4000), Prize[1] = 0;
		    case 4: Prize[0] = (random(random(3)) + 3000), Prize[1] = 0;
		    case 5: Prize[0] = (random(random(3)) + 2000), Prize[1] = 0;
		    case 6: Prize[0] = (random(random(3)) + 1000), Prize[1] = 0;
		    case 7: Prize[0] = (random(random(3)) + 500), Prize[1] = 0;
		    default: Prize[0] = random(random(1000)), Prize[1] = 1;
		}}
		if(Position == 1 && contador > 6){
		format(string, sizeof(string), "[Pura Joda] \"%s\" terminó la carrera en la posición %d.", pName, Position);
  		SendClientMessageToAll(LIGHTGREEN, string);
		format(string, sizeof(string), "    - Tiempo: \"%d:%d.%d\".", rTime[0], rTime[1], rTime[2]);
		SendClientMessageToAll(WHITE, string);
		format(string, sizeof(string), "    - Premio: \"$%d y +%d score +1 PJCoin\".", Prize[0], Prize[1]);
		SendClientMessageToAll(WHITE, string);
		}
		else if(Position == 1 && contador < 6){
		format(string, sizeof(string), "[Pura Joda] \"%s\" terminó la carrera en la posición %d.", pName, Position);
  		SendClientMessageToAll(LIGHTGREEN, string);
		format(string, sizeof(string), "    - Tiempo: \"%d:%d.%d\".", rTime[0], rTime[1], rTime[2]);
		SendClientMessageToAll(WHITE, string);
		format(string, sizeof(string), "    - Premio: \"$%d y +%d score\".", Prize[0], Prize[1]);
		SendClientMessageToAll(WHITE, string);

		}
		else if(Position > 1 && Position < 11) {
		format(string, sizeof(string), "[Pura Joda] \"%s\" terminó la carrera en la posición %d.", pName, Position);
		SendCarreraMessage(string);
		}
		//SendCarreraMessage(string);
		SetPlayerVirtualWorld(playerid, 0);
        SetVehicleVirtualWorld(CreatedRaceVeh[playerid], 0);
		PutPlayerInVehicle(playerid, CreatedRaceVeh[playerid], 0);
		DestroyVehicle(CreatedRaceVeh[playerid]);
		if(FinishCount <= 5)
		{
			format(rFile, sizeof(rFile), "/rRaceSystem/%s.RRACE", RaceName);
		    format(string, sizeof(string), "BestRacerTime_%d", TimeProgress);
		    TempTotalTime = dini_Int(rFile, string);
		    ConvertTime(var1, TempTotalTime, TempTime[0], TempTime[1], TempTime[2]);
		    if(TotalRaceTime < dini_Int(rFile, string) || TempTotalTime == 0)
		    {
		        dini_IntSet(rFile, string, TotalRaceTime);
				format(string, sizeof(string), "BestRacer_%d", TimeProgress);
		        if(TempTotalTime != 0) format(string, sizeof(string), ">> \"%s\" ha batido el récord de \"%s\" con \"%d\" segundos más rápido en la \"%d\"' lugar!", pName, dini_Get(rFile, string), -(rTime[1] - TempTime[1]), TimeProgress+1);
				else format(string, sizeof(string), ">> \"%s\" ha batido un nuevo récord de en la carrera \"%d\"'lugar!", pName, TimeProgress+1);
                DentroCS[playerid] = 0;
				SendClientMessageToAll(GREEN, string);
				SendClientMessageToAll(GREEN, "  ");
				format(string, sizeof(string), "BestRacer_%d", TimeProgress);

				dini_Set(rFile, string, pName);
				TimeProgress++;
	        	SetPlayerVirtualWorld(playerid,0);
			    SetVehicleVirtualWorld(CreatedRaceVeh[playerid], 0);
				PutPlayerInVehicle(playerid, CreatedRaceVeh[playerid], 0);

		    }
		}
		FinishCount++;
		GivePlayerMoneyEx(playerid, Prize[0]);
		SetPVarInt(playerid, "Score", GetPVarInt(playerid,"Score")+Prize[1]);
		DisablePlayerRaceCheckpoint(playerid);
		CPProgess[playerid]++;
		if(FinishCount >= JoinCount) return StopRace();
    }
	else
	{

		CPProgess[playerid]++;
		CPCoords[CPProgess[playerid]][3]++;

		SetCP(playerid, CPProgess[playerid], CPProgess[playerid]+1, TotalCP, RaceType);
	    PlayerPlaySound(playerid, 1137, 0.0, 0.0, 0.0);
	}
    return 1;
}
stock GetPlayerDistanceToPointEx(playerid,Float:x,Float:y,Float:z) {//By Sacky (Edited by Smugller)
	new Float:x1,Float:y1,Float:z1;
	new Float:dis;
	GetPlayerPos(playerid,x1,y1,z1);
	dis = floatsqroot((x-x1)*(x-x1)+(y-y1)*(y-y1)+(z-z1)*(z-z1));
	return floatround(dis);
}
forward SendCarreraMessage(message[]);
public SendCarreraMessage(message[]){
for(new i = 0; i < MAX_PLAYERS; i++){
if(Joined[i]){
SendClientMessage(i, LIGHTBLUE, message);
}
}

}
public OnPlayerDisconnect(playerid)
{
	if(Joined[playerid] == true)
    {
    SetPVarInt(playerid, "RACE",0);
		JoinCount--;
		DisableRemoteVehicleCollisions(playerid,1);
		Joined[playerid] = false;
		contador--;
		DisableRemoteVehicleCollisions(playerid,0);
		DestroyVehicle(CreatedRaceVeh[playerid]);
		DisablePlayerRaceCheckpoint(playerid);
        PlayerTextDrawHide(playerid, Info[playerid]);
        PlayerTextDrawHide(playerid, Race0[playerid]);
        	    	TextDrawHideForPlayer(playerid, TopDriver);
	TextDrawHideForPlayer(playerid, TopDriver2);
        PlayerTextDrawHide(playerid, Info2[playerid]);
		CPProgess[playerid] = 0;
		KillTimer(InfoTimer[playerid]);
		#if defined RACE_IN_OTHER_WORLD
		SetPlayerVirtualWorld(playerid, 0);
	    DentroCS[playerid] = 0;
	   // TextDrawDestroy(RaceInfo[playerid]);
		#endif
	}
	if(BuildRace == playerid+1) BuildRace = 0;
	return 1;
}

public OnPlayerConnect(playerid)
{
Race0[playerid] = CreatePlayerTextDraw(playerid, 367.625000, 403.416717, "usebox");
PlayerTextDrawLetterSize(playerid, Race0[playerid], 0.000000, 3.896296);
PlayerTextDrawTextSize(playerid,Race0[playerid], 276.125000, 0.000000);
PlayerTextDrawAlignment(playerid,Race0[playerid], 1);
PlayerTextDrawColor(playerid,Race0[playerid], 0);
PlayerTextDrawUseBox(playerid,Race0[playerid], true);
PlayerTextDrawBoxColor(playerid,Race0[playerid], 102);
PlayerTextDrawSetShadow(playerid,Race0[playerid], 0);
PlayerTextDrawSetOutline(playerid,Race0[playerid], 0);
PlayerTextDrawFont(playerid,Race0[playerid], 0);

Info[playerid] = CreatePlayerTextDraw(playerid, 285.000000, 403.083282, "05/50");
PlayerTextDrawLetterSize(playerid, Info[playerid], 0.571248, 3.209995);
PlayerTextDrawAlignment(playerid, Info[playerid], 1);
PlayerTextDrawColor(playerid, Info[playerid], -1);
PlayerTextDrawSetShadow(playerid, Info[playerid], 0);
PlayerTextDrawSetOutline(playerid, Info[playerid], 1);
PlayerTextDrawBackgroundColor(playerid, Info[playerid], 51);
PlayerTextDrawFont(playerid, Info[playerid], 2);
PlayerTextDrawSetProportional(playerid, Info[playerid], 1);

Info2[playerid] = CreatePlayerTextDraw(playerid, 271.092620, 393.166534, "Progreso: 56%");
PlayerTextDrawLetterSize(playerid, Info2[playerid], 0.312500, 0.929166);
PlayerTextDrawAlignment(playerid, Info2[playerid], 1);
PlayerTextDrawColor(playerid, Info2[playerid], 16711935);
PlayerTextDrawSetShadow(playerid, Info2[playerid], 0);
PlayerTextDrawSetOutline(playerid, Info2[playerid], 1);
PlayerTextDrawBackgroundColor(playerid, Info2[playerid], 51);
PlayerTextDrawFont(playerid, Info2[playerid], 2);
PlayerTextDrawSetProportional(playerid, Info2[playerid], 1);

	return 1;
}

public OnPlayerDeath(playerid)
{
    if(Joined[playerid] == true)
    {
    SetPVarInt(playerid, "RACE",0);
		JoinCount--;
		DisableRemoteVehicleCollisions(playerid,1);
		Joined[playerid] = false;
		DestroyVehicle(CreatedRaceVeh[playerid]);
		DisablePlayerRaceCheckpoint(playerid);
        PlayerTextDrawHide(playerid, Info[playerid]);
        PlayerTextDrawHide(playerid, Race0[playerid]);
        PlayerTextDrawHide(playerid, Info2[playerid]);
        	    	TextDrawHideForPlayer(playerid, TopDriver);
	TextDrawHideForPlayer(playerid, TopDriver2);
		CPProgess[playerid] = 0;
		KillTimer(InfoTimer[playerid]);
		#if defined RACE_IN_OTHER_WORLD
		SetPlayerVirtualWorld(playerid, 0);
		#endif
	}

	if(BuildRace == playerid+1) BuildRace = 0;
	return 1;
}
public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	new
 		string[256],
 		rNameFile[256],
   		rFile[256],
     	Float: vPos[4]
	;
	if(newkeys & KEY_FIRE)
	{
	    if(BuildRace == playerid+1)
	    {
		    if(BuildTakeVehPos == true)
		    {
		    	if(!IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid, RED, ">> You need to be in a vehicle");
				format(rFile, sizeof(rFile), "/rRaceSystem/%s.RRACE", BuildName);
				GetVehiclePos(GetPlayerVehicleID(playerid), vPos[0], vPos[1], vPos[2]);
				GetVehicleZAngle(GetPlayerVehicleID(playerid), vPos[3]);
		        dini_Create(rFile);
				dini_IntSet(rFile, "vModel", BuildModeVID);
				dini_IntSet(rFile, "rType", BuildRaceType);
		        format(string, sizeof(string), "vPosX_%d", BuildVehPosCount), dini_FloatSet(rFile, string, vPos[0]);
		        format(string, sizeof(string), "vPosY_%d", BuildVehPosCount), dini_FloatSet(rFile, string, vPos[1]);
		        format(string, sizeof(string), "vPosZ_%d", BuildVehPosCount), dini_FloatSet(rFile, string, vPos[2]);
		        format(string, sizeof(string), "vAngle_%d", BuildVehPosCount), dini_FloatSet(rFile, string, vPos[3]);
		        format(string, sizeof(string), ">> Vehicle Pos '%d' has been taken.", BuildVehPosCount+1);
		        SendClientMessage(playerid, YELLOW, string);
				BuildVehPosCount++;
			}
   			if(BuildVehPosCount >= 2)
		    {
		        BuildVehPosCount = 0;
		        BuildTakeVehPos = false;
		        ShowDialog(playerid, 605);
		    }
			if(BuildTakeCheckpoints == true)
			{
			    if(BuildCheckPointCount > MAX_RACE_CHECKPOINTS_EACH_RACE) return SendClientMessage(playerid, RED, ">> You reached the maximum amount of checkpoints!");
			    if(!IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid, RED, ">> You need to be in a vehicle");
				format(rFile, sizeof(rFile), "/rRaceSystem/%s.RRACE", BuildName);
				GetVehiclePos(GetPlayerVehicleID(playerid), vPos[0], vPos[1], vPos[2]);
				format(string, sizeof(string), "CP_%d_PosX", BuildCheckPointCount), dini_FloatSet(rFile, string, vPos[0]);
				format(string, sizeof(string), "CP_%d_PosY", BuildCheckPointCount), dini_FloatSet(rFile, string, vPos[1]);
				format(string, sizeof(string), "CP_%d_PosZ", BuildCheckPointCount), dini_FloatSet(rFile, string, vPos[2]);
    			format(string, sizeof(string), ">> Checkpoint '%d' has been setted!", BuildCheckPointCount+1);
		        SendClientMessage(playerid, YELLOW, string);
				BuildCheckPointCount++;
			}
		}
	}
	if(newkeys & KEY_SECONDARY_ATTACK)
	{
	    if(BuildTakeCheckpoints == true)
	    {
	        ShowDialog(playerid, 606);
			format(rNameFile, sizeof(rNameFile), "/rRaceSystem/RaceNames/RaceNames.txt");
			TotalRaces = dini_Int(rNameFile, "TotalRaces");
			TotalRaces++;
			dini_IntSet(rNameFile, "TotalRaces", TotalRaces);
			format(string, sizeof(string), "Race_%d", TotalRaces-1);
			format(rFile, sizeof(rFile), "/rRaceSystem/%s.RRACE", BuildName);
			dini_Set(rNameFile, string, BuildName);
			dini_IntSet(rFile, "TotalCP", BuildCheckPointCount);
			Loop(x, 5)
			{
				format(string, sizeof(string), "BestRacerTime_%d", x);
				dini_Set(rFile, string, "0");
				format(string, sizeof(string), "BestRacer_%d", x);
				dini_Set(rFile, string, "noone");
			}
	    }
	}
	return 1;
}

        new VehicleID, Float:Xx, Float:Yx, Float:Zx, Float:xAngle;

function SetCPEx(playerid, PrevCP)
{
    new cartype = GetPlayerVehicleID(playerid);
    SetVehiclePos(cartype,CPCoords[PrevCP][0], CPCoords[PrevCP][1], CPCoords[PrevCP][2]);
//
//		GetPlayerPos(playerid, Xx, Yx, Zx);
		VehicleID = GetPlayerVehicleID(playerid);
//				GetVehicleZAngle(VehicleID, xAngle);	SetVehiclePos(VehicleID, Xx, Yx, Zx); SetVehicleZAngle(VehicleID, xAngle); SetVehicleHealth(VehicleID,1000.0);
				GameTextForPlayer(playerid,"~r~~h~has regressado al checkpoint anterior!",3000,3);
				RepairVehicle(GetPlayerVehicleID(playerid));

	SetTimerEx("Repair",1000,false,"i",playerid);
	return 1;
}
function Repair(playerid){
GetPlayerPos(playerid, Xx, Yx, Zx);
VehicleID = GetPlayerVehicleID(playerid);
GetVehicleZAngle(VehicleID, xAngle);
SetVehiclePos(VehicleID, Xx, Yx, Zx);
SetVehicleZAngle(VehicleID, xAngle);
SetVehicleHealth(VehicleID,1000.0);
return 1;
}

function LoadRaceNames()
{

	new
	    rNameFile[64],
	    string[64]
	;
	format(rNameFile, sizeof(rNameFile), "/rRaceSystem/RaceNames/RaceNames.txt");
	TotalRaces = dini_Int(rNameFile, "TotalRaces");
	Loop(x, TotalRaces)
	{
	    format(string, sizeof(string), "Race_%d", x), strmid(RaceNames[x], dini_Get(rNameFile, string), 0, 20, sizeof(RaceNames));
	  //  printf(">> Loaded Races: %s", RaceNames[x]);
	}
	return 1;
}

function LoadAutoRace(rName[])
{
	new
		rFile[256],
		string[256],
		Runner[24],
		Timee,
		Float:Result,
		stri[100],
		ef[300]
 ;
	format(rFile, sizeof(rFile), "/rRaceSystem/%s.RRACE", rName);
	if(!dini_Exists(rFile)) return printf("Race \"%s\" doesn't exist!", rName);
	strmid(RaceName, rName, 0, strlen(rName), sizeof(RaceName));
	RaceVehicle = dini_Int(rFile, "vModel");
	RaceType = dini_Int(rFile, "rType");
	TotalCP = dini_Int(rFile, "TotalCP");
	new po[3];
	for(new i = 0; i != 3; i++){
	
		format(stri, sizeof(stri), "BestRacerTime_%d",i);
		Timee = dini_Int(rFile, stri);
		if(Timee == 0) continue;
		format(stri, sizeof(stri), "BestRacer_%d",i);
		format(Runner, 24, "%s", dini_Get(rFile, stri));
		ConvertTime(var3, Timee, po[0], po[1], po[2]);
		/*Result = (Timee/1000);
		Result = floatround(Result,floatround_round);
		Result = Result/60;
		format(stri, sizeof(stri),"%.2f",Result);
		Result = floatstr(stri);
		if(Result < 10) strdel(stri, );
		strreplace(stri, ".","'");*/
		format(stri, 256, "~w~%d. ~r~~h~%s ~w~Tiempo %d'%d'%d~n~",(i+1),Runner, po[0], po[1], po[2]);
		strcat(ef, stri);
	
	}
//	printf(ef);
	TextDrawSetString(TopDriver2, ef);
/*	#if DEBUG_RACE == 1
	printf("VehicleModel: %d", RaceVehicle);
	printf("RaceType: %d", RaceType);
	printf("TotalCheckpoints: %d", TotalCP);
	#endif
*/
	Loop(x, 2)
	{
		format(string, sizeof(string), "vPosX_%d", x), RaceVehCoords[x][0] = dini_Float(rFile, string);
		format(string, sizeof(string), "vPosY_%d", x), RaceVehCoords[x][1] = dini_Float(rFile, string);
		format(string, sizeof(string), "vPosZ_%d", x), RaceVehCoords[x][2] = dini_Float(rFile, string);
		format(string, sizeof(string), "vAngle_%d", x), RaceVehCoords[x][3] = dini_Float(rFile, string);
		#if DEBUG_RACE == 1
		#endif
	}
	Loop(x, TotalCP)
	{
 		format(string, sizeof(string), "CP_%d_PosX", x), CPCoords[x][0] = dini_Float(rFile, string);
 		format(string, sizeof(string), "CP_%d_PosY", x), CPCoords[x][1] = dini_Float(rFile, string);
 		format(string, sizeof(string), "CP_%d_PosZ", x), CPCoords[x][2] = dini_Float(rFile, string);
 		#if DEBUG_RACE == 1
 		#endif
	}
	Position = 0;
	FinishCount = 0;
	JoinCount = 0;
	Loop(x, 2) PlayersCount[x] = 0;
	CountAmount = COUNT_DOWN_TILL_RACE_START;
	RaceTime = MAX_RACE_TIME;
	RaceBusy = 0x01;
	CountTimer = SetTimer("CountTillRace", 999, 1);
	TimeProgress = 0;
	KillTimer(AutoRace);
	return 1;
}

function LoadRace(playerid, rName[])
{
	new
		rFile[256],
		string[256]
	;
	format(rFile, sizeof(rFile), "/rRaceSystem/%s.RRACE", rName);
	if(!dini_Exists(rFile)) return SendClientMessage(playerid, RED, "[Pura Joda] Carrera no existente."), printf("Race \"%s\" Carrera no existente.", rName);
	strmid(RaceName, rName, 0, strlen(rName), sizeof(RaceName));
	RaceVehicle = dini_Int(rFile, "vModel");
	RaceType = dini_Int(rFile, "rType"); 
	TotalCP = dini_Int(rFile, "TotalCP");
	
/*	#if DEBUG_RACE == 1
	printf("VehicleModel: %d", RaceVehicle);
	printf("RaceType: %d", RaceType);
	printf("TotalCheckpoints: %d", TotalCP);
	#endif
	*/
	Loop(x, 2)
	{
		format(string, sizeof(string), "vPosX_%d", x), RaceVehCoords[x][0] = dini_Float(rFile, string);
		format(string, sizeof(string), "vPosY_%d", x), RaceVehCoords[x][1] = dini_Float(rFile, string);
		format(string, sizeof(string), "vPosZ_%d", x), RaceVehCoords[x][2] = dini_Float(rFile, string);
		format(string, sizeof(string), "vAngle_%d", x), RaceVehCoords[x][3] = dini_Float(rFile, string);
		#if DEBUG_RACE == 1

		#endif
	}
	Loop(x, TotalCP)
	{
 		format(string, sizeof(string), "CP_%d_PosX", x), CPCoords[x][0] = dini_Float(rFile, string);
 		format(string, sizeof(string), "CP_%d_PosY", x), CPCoords[x][1] = dini_Float(rFile, string);
 		format(string, sizeof(string), "CP_%d_PosZ", x), CPCoords[x][2] = dini_Float(rFile, string);
 		#if DEBUG_RACE == 1
 		#endif
	}
	Position = 0;
	FinishCount = 0;
	JoinCount = 0;
	Loop(x, 2) PlayersCount[x] = 0;
	Joined[playerid] = true;
	CountAmount = COUNT_DOWN_TILL_RACE_START;
	RaceTime = MAX_RACE_TIME;
	RaceBusy = 0x01;
	TimeProgress = 0;
	SetupRaceForPlayer(playerid);
	CountTimer = SetTimer("CountTillRace", 999, 1);
	return 1;
}

function SetCP(playerid, PrevCP, NextCP, MaxCP, Type)
{
	if(Type == 0)
	{
		if(NextCP == MaxCP) SetPlayerRaceCheckpoint(playerid, 1, CPCoords[PrevCP][0], CPCoords[PrevCP][1], CPCoords[PrevCP][2], CPCoords[NextCP][0], CPCoords[NextCP][1], CPCoords[NextCP][2], RACE_CHECKPOINT_SIZE);
			else SetPlayerRaceCheckpoint(playerid, 0, CPCoords[PrevCP][0], CPCoords[PrevCP][1], CPCoords[PrevCP][2], CPCoords[NextCP][0], CPCoords[NextCP][1], CPCoords[NextCP][2], RACE_CHECKPOINT_SIZE);
	}
	else if(Type == 3)
	{
		if(NextCP == MaxCP) SetPlayerRaceCheckpoint(playerid, 4, CPCoords[PrevCP][0], CPCoords[PrevCP][1], CPCoords[PrevCP][2], CPCoords[NextCP][0], CPCoords[NextCP][1], CPCoords[NextCP][2], RACE_CHECKPOINT_SIZE);
			else SetPlayerRaceCheckpoint(playerid, 3, CPCoords[PrevCP][0], CPCoords[PrevCP][1], CPCoords[PrevCP][2], CPCoords[NextCP][0], CPCoords[NextCP][1], CPCoords[NextCP][2], RACE_CHECKPOINT_SIZE);
	}
	return 1;
}


function SetupRaceForPlayer(playerid)
{
	SetPlayerVirtualWorld(playerid, 10);
	DentroCS[playerid] = 1;
	CPProgess[playerid] = 0;
	Niuly[playerid] = true;
	//TogglePlayerControllable(playerid, false);
	CPCoords[playerid][3] = 0;
	SetCP(playerid, CPProgess[playerid], CPProgess[playerid]+1, TotalCP, RaceType);
		//		RaceVehCoords[0][0] -= (6 * floatsin(-RaceVehCoords[0][3], degrees));
		 //		RaceVehCoords[0][1] -= (6 * floatcos(-RaceVehCoords[0][3], degrees));
		   		CreatedRaceVeh[playerid] = CreateVehicle(RaceVehicle, RaceVehCoords[0][0], RaceVehCoords[0][1], RaceVehCoords[0][2]+2, RaceVehCoords[0][3], random(126), random(126), (60 * 60));
                SetVehicleVirtualWorld(CreatedRaceVeh[playerid], 10);
				SetPlayerPos(playerid, RaceVehCoords[0][0], RaceVehCoords[0][1], RaceVehCoords[0][2]+2);
				SetPlayerFacingAngle(playerid, RaceVehCoords[0][3]);
				PutPlayerInVehicle(playerid, CreatedRaceVeh[playerid], 0);
			//	Camera(playerid, RaceVehCoords[0][0], RaceVehCoords[0][1], RaceVehCoords[0][2], RaceVehCoords[0][3], 20);
	new
	    string[128],string2[128]
	;
	#if defined RACE_IN_OTHER_WORLD
	#endif
	InfoTimer[playerid] = SetTimerEx("TextInfo", 1000, 1, "e", playerid);
	if(JoinCount == 1) {
	//format(string, sizeof(string), "RaceName: ~w~%s~n~~p~~h~Checkpoint: ~w~%d/%d~n~~b~~h~RaceTime: ~w~%s~n~~y~RacePosition: ~w~1/1~n~ ", RaceName, CPProgess[playerid], TotalCP, TimeConvert(RaceTime));
 	format(string, sizeof(string), "01/01");
	format(string2, sizeof(string2), "Progreso: %d%",floatround((CPProgess[playerid]*100)/TotalCP),floatround_round);

}	else {
	format(string2, sizeof(string2), "Progreso: %d%",floatround((CPProgess[playerid]*100)/TotalCP),floatround_round);
	if(RacePosition[playerid]<9) format(string, sizeof(string), "0%d/%d",RacePosition[playerid], JoinCount);
	else format(string, sizeof(string), "%d/%d",RacePosition[playerid], JoinCount);
}//format(string, sizeof(string), "RaceName: ~w~%s~n~~p~~h~Checkpoint: ~w~%d/%d~n~~b~~h~RaceTime: ~w~%s~n~~y~RacePosition: ~w~%d/%d~n~ ", RaceName, CPProgess[playerid], TotalCP, TimeConvert(RaceTime), RacePosition[playerid], JoinCount);
PlayerTextDrawSetString(playerid, Info[playerid],string);
	PlayerTextDrawShow(playerid, Info[playerid]);
	PlayerTextDrawSetString(playerid, Info2[playerid],string2);
	PlayerTextDrawShow(playerid, Info2[playerid]);
	PlayerTextDrawShow(playerid, Race0[playerid]);
	JoinCount++;
	TextDrawShowForPlayer(playerid, TopDriver);
	TextDrawShowForPlayer(playerid, TopDriver2);
    SendClientMessage(playerid, GREEN, "[Pura Joda] Atención sus comandos fueron desactivados, luego de que finalice se re-activarán.");
    SendClientMessage(playerid, amarillo, "[Pura Joda] Para salir de la carrera útilice /ExitRace");
	return 1;
}

function CountTillRace()
{
	switch(CountAmount)
	{
 		case 0:
	    {
			//ForEach(i, MAX_PLAYERS)
		//	{
			   // if(Joined[i] == false)
			   // {
			    //    new
			       //     string[128]
				//	;
				//	format(string, sizeof(string), "[Pura Joda] La carrera \" %s \" ya comenzó", RaceName);
//					TextDrawHideForAll(CarreraT);
			//	//	SendClientMessage(i, RED, string);
			//	}
			//}//
			StartRace();
	    }
	    case 1..9:{
	        new
	            string[200]
			;
			format(string, sizeof(string), "~r~~h~%d~w~!~n~Recuerde presionar N para devolverse a un checkpoint", CountAmount);
			ForEach(i, MAX_PLAYERS)
			{
			    if(Joined[i] == true)
			    {
			    	GameTextForPlayer(i, string, 999, 5);
			    	PlayerPlaySound(i, 1056, 0.0, 0.0, 0.0);
			    }
			}
	    }
	    case 10..29:
	    {
	        new
	            string[10]
			;
			format(string, sizeof(string), "~w~%d", CountAmount);
			ForEach(i, MAX_PLAYERS)
			{
			    if(Joined[i] == true)
			    {
			    	GameTextForPlayer(i, string, 999, 5);
		//	    	PlayerPlaySound(i, 1056, 0.0, 0.0, 0.0);
			    }
			}
	    }
	    case 30:
	    {
	        new
	            string[149]
			;
   			   	for(new i = 0; i < MAX_PLAYER; i++) {
			if(IsPlayerConnected(i)) {
				PlayerPlaySound(i,1057,0.0,0.0,0.0);
						}
		}
			format(string, sizeof(string), ""G"[Pura Joda] "W"%d "G"segundos para que la carrera "W"%s "G"comience, útilice "W"/Entrar", CountAmount, RaceName);
		SendClientMessageToAll(GREEN, ""G"—————————————————————————————————————————————");
			SendClientMessageToAll(LIGHTBLUE, string);
		SendClientMessageToAll(GREEN, ""G"—————————————————————————————————————————————");

	    }
	}
	return CountAmount--;
}

function StartRace()
{

	ForEach(i, MAX_PLAYERS)
	{
	    if(Joined[i] == true)
	    {
	        TogglePlayerControllable(i, true);
	        DisableRemoteVehicleCollisions(i,1);
	        PlayerPlaySound(i, 1057, 0.0, 0.0, 0.0);
  			GameTextForPlayer(i, "~g~~h~GO GO GO", 2000, 5);
			SetCameraBehindPlayer(i);
			Niuly[i] = false;
	    }
	}
	rCounter = SetTimer("RaceCounter", 900, 1);
	RaceTick = GetTickCount();
	RaceStarted = 1;
	KillTimer(CountTimer);
	return 1;
}

function StopRace()
{
	KillTimer(rCounter);
	RaceStarted = 0;
	RaceTick = 0;
	RaceBusy = 0x00;
	JoinCount = 0;
	FinishCount = 0;
    TimeProgress = 0;
	ForEach(i, MAX_PLAYERS)
	{
	    if(Joined[i] == true)
	    {
	        DisableRemoteVehicleCollisions(i,1);
	    	DisablePlayerRaceCheckpoint(i);
	    	DestroyVehicle(CreatedRaceVeh[i]);
	    	Joined[i] = false;
			contador--;
			SetPVarInt(i, "RACE",0);
	    	DisableRemoteVehicleCollisions(i,0);
        PlayerTextDrawHide(i, Info[i]);
        PlayerTextDrawHide(i, Race0[i]);
        PlayerTextDrawHide(i, Info2[i]);
       	    	TextDrawHideForPlayer(i, TopDriver);
	TextDrawHideForPlayer(i, TopDriver2);
			CPProgess[i] = 0;
			KillTimer(InfoTimer[i]);
		}
	}
	SendClientMessageToAll(YELLOW, ""G"[Pura Joda] En "W"3 "G"minutos iniciará una nueva "W"carrera.");
	contador = 0;
//	SetTimer("Start",RANDOM_TIME_RACE,false);
//	if(AutomaticRace == true) LoadRaceNames(), LoadAutoRace(RaceNames[random(TotalRaces)]);
	return 1;
}

function RaceCounter()
{
	if(RaceStarted == 1)
	{
		RaceTime--;
		if(JoinCount <= 0)
		{
			StopRace();
		}
	}
	if(RaceTime <= 0)
	{
	    StopRace();
	}
	return 1;
}
stock GetPlayerSpeed(playerid, get3d)
{
	new Float:xee, Float:ye, Float:ze;
	if(IsPlayerInAnyVehicle(playerid))
	    GetVehicleVelocity(GetPlayerVehicleID(playerid), xee, ye, ze);
	else
	    GetPlayerVelocity(playerid, xe, ye, ze);

	return SpeedCheck(xee, ye, ze, 100.0, get3d);
}
function TextInfo(playerid)
{
	if(GetPlayerSpeed(playerid, 0) > 251) return cmd_exitrace(playerid, "");
	new
	    string[128],string2[128]
	;
	if(JoinCount == 1) {
	//format(string, sizeof(string), "RaceName: ~w~%s~n~~p~~h~Checkpoint: ~w~%d/%d~n~~b~~h~RaceTime: ~w~%s~n~~y~RacePosition: ~w~1/1~n~ ", RaceName, CPProgess[playerid], TotalCP, TimeConvert(RaceTime));
 	format(string, sizeof(string), "01/01");
	format(string2, sizeof(string2), "Progreso: %d%",floatround((CPProgess[playerid]*100)/TotalCP),floatround_round);

}	else {
	new index = 0;
	for(new j = 0; j < MAX_PLAYERS; j++)
	{
	    if(Joined[j])
	    {
	    	if(j != playerid)
	    	{
				if(CPProgess[playerid] < CPProgess[j])
				{
				    index++; //for everyone who is in front of the player index goes ++
				}

				if(CPProgess[playerid] == CPProgess[j]) //who is in the same section as the player
				{
				    new PlayerCheckPoint = CPProgess[playerid];
				    new ElseCheckPoint = CPProgess[j];

    				if(GetPlayerDistanceFromPoint(playerid, CPCoords[TotalCP-1][0], CPCoords[TotalCP-1][1], CPCoords[TotalCP-1][2]) > GetPlayerDistanceFromPoint(j, CPCoords[TotalCP-1][0], CPCoords[TotalCP-1][1], CPCoords[TotalCP-1][2]))
					{
				    	index++;
	    }
				}
			}
		}
	}

	RacePosition[playerid] = index +1;
	format(string2, sizeof(string2), "Progreso: %d%",floatround((CPProgess[playerid]*100)/TotalCP),floatround_round);
	if(RacePosition[playerid]<9) format(string, sizeof(string), "0%d/%d",RacePosition[playerid], JoinCount);
	else format(string, sizeof(string), "%d/%d",RacePosition[playerid], JoinCount);
	}//format(string, sizeof(string), "RaceName: ~w~%s~n~~p~~h~Checkpoint: ~w~%d/%d~n~~b~~h~RaceTime: ~w~%s~n~~y~RacePosition: ~w~%d/%d~n~ ", RaceName, CPProgess[playerid], TotalCP, TimeConvert(RaceTime), RacePosition[playerid], JoinCount);
PlayerTextDrawSetString(playerid, Info[playerid],string);
	PlayerTextDrawShow(playerid, Info[playerid]);
	PlayerTextDrawSetString(playerid, Info2[playerid],string2);
	PlayerTextDrawShow(playerid, Info2[playerid]);
	RepairVehicle(GetPlayerVehicleID(playerid));
	return 1;
}

function Camera(playerid, Float:X, Float:Y, Float:Z, Float:A, Mul)
{
	SetPlayerCameraLookAt(playerid, X, Y, Z);
	SetPlayerCameraPos(playerid, X + (Mul * floatsin(-A, degrees)), Y + (Mul * floatcos(-A, degrees)), Z+6);
}

function IsPlayerInRace(playerid)
{
	if(Joined[playerid] == true) return true;
	    else return false;
}
public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	switch(dialogid)
	{
	    case 599:
	    {
	        if(!response) return BuildRace = 0;
	        switch(listitem)
	        {
	        	case 0: BuildRaceType = 0;
	        	case 1: BuildRaceType = 3;
			}
			ShowDialog(playerid, 600);
	    }
	    case 600..601:
	    {
	        if(!response) return ShowDialog(playerid, 599);
	        if(!strlen(inputtext)) return ShowDialog(playerid, 601);
	        if(strlen(inputtext) < 1 || strlen(inputtext) > 20) return ShowDialog(playerid, 601);
	        strmid(BuildName, inputtext, 0, strlen(inputtext), sizeof(BuildName));
	        ShowDialog(playerid, 602);
	    }
	    case 602..603:
	    {
	        if(!response) return ShowDialog(playerid, 600);
	        if(!strlen(inputtext)) return ShowDialog(playerid, 603);
	        if(isNumeric(inputtext))
	        {

	            if(!IsValidVehicle(strval(inputtext))) return ShowDialog(playerid, 603);
				new
	                Float: pPos[4]
				;
				GetPlayerPos(playerid, pPos[0], pPos[1], pPos[2]);
				GetPlayerFacingAngle(playerid, pPos[3]);
				BuildModeVID = strval(inputtext);
				BuildCreatedVehicle = (BuildCreatedVehicle == 0x01) ? (DestroyVehicle(BuildVehicle), BuildCreatedVehicle = 0x00) : (DestroyVehicle(BuildVehicle), BuildCreatedVehicle = 0x00);
	            BuildVehicle = CreateVehicle(strval(inputtext), pPos[0], pPos[1], pPos[2], pPos[3], random(126), random(126), (60 * 60));
	            PutPlayerInVehicle(playerid, BuildVehicle, 0);
				BuildCreatedVehicle = 0x01;
				ShowDialog(playerid, 604);
			}
	        else
	        {
	            if(!IsValidVehicle(ReturnVehicleID(inputtext))) return ShowDialog(playerid, 603);
				new
	                Float: pPos[4]
				;
				GetPlayerPos(playerid, pPos[0], pPos[1], pPos[2]);
				GetPlayerFacingAngle(playerid, pPos[3]);
				BuildModeVID = ReturnVehicleID(inputtext);
				BuildCreatedVehicle = (BuildCreatedVehicle == 0x01) ? (DestroyVehicle(BuildVehicle), BuildCreatedVehicle = 0x00) : (DestroyVehicle(BuildVehicle), BuildCreatedVehicle = 0x00);
	            BuildVehicle = CreateVehicle(ReturnVehicleID(inputtext), pPos[0], pPos[1], pPos[2], pPos[3], random(126), random(126), (60 * 60));
	            PutPlayerInVehicle(playerid, BuildVehicle, 0);
				BuildCreatedVehicle = 0x01;
				ShowDialog(playerid, 604);
	        }
	    }
	    case 604:
	    {
	        if(!response) return ShowDialog(playerid, 602);
			SendClientMessage(playerid, GREEN, ">> Go to the start line on the left road and press 'KEY_FIRE' and do the same with the right road block.");
			SendClientMessage(playerid, GREEN, "   - When this is done, you will see a dialog to continue.");
			BuildVehPosCount = 0;
	        BuildTakeVehPos = true;
	    }
	    case 605:
	    {
	        if(!response) return ShowDialog(playerid, 604);
	        SendClientMessage(playerid, GREEN, ">> Start taking checkpoints now by clicking 'KEY_FIRE'.");
	        SendClientMessage(playerid, GREEN, "   - IMPORTANT: Press 'ENTER' when you're done with the checkpoints! If it doesn't react press again and again.");
	        BuildCheckPointCount = 0;
	        BuildTakeCheckpoints = true;
	    }
	    case 606:
	    {
	        if(!response) return ShowDialog(playerid, 606);
	        BuildRace = 0;
	        BuildCheckPointCount = 0;
	        BuildVehPosCount = 0;
	        BuildTakeCheckpoints = false;
	        BuildTakeVehPos = false;
	        BuildCreatedVehicle = (BuildCreatedVehicle == 0x01) ? (DestroyVehicle(BuildVehicle), BuildCreatedVehicle = 0x00) : (DestroyVehicle(BuildVehicle), BuildCreatedVehicle = 0x00);
	    }
	}
	return 1;
}
function ShowDialog(playerid, dialogid)
{
	switch(dialogid)
	{
		case 599: ShowPlayerDialog(playerid, dialogid, DIALOG_STYLE_LIST, CreateCaption("Build New Race"), "\
		Normal Race\n\
		Air Race", "Next", "Exit");

	    case 600: ShowPlayerDialog(playerid, dialogid, DIALOG_STYLE_INPUT, CreateCaption("Build New Race (Step 1/4)"), "\
		Step 1:\n\
		********\n\
 		Welcome to wizard 'Build New Race'.\n\
		Before getting started, I need to know the name (e.g. SFRace) of the to save it under.\n\n\
		>> Give the NAME below and press 'Next' to continue.", "Next", "Back");

	    case 601: ShowPlayerDialog(playerid, dialogid, DIALOG_STYLE_INPUT, CreateCaption("Build New Race (Step 1/4)"), "\
	    ERROR: Name too short or too long! (min. 1 - max. 20)\n\n\n\
		Step 1:\n\
		********\n\
 		Welcome to wizard 'Build New Race'.\n\
		Before getting started, I need to know the name (e.g. SFRace) of the to save it under.\n\n\
		>> Give the NAME below and press 'Next' to continue.", "Next", "Back");

		case 602: ShowPlayerDialog(playerid, dialogid, DIALOG_STYLE_INPUT, CreateCaption("Build New Race (Step 2/4)"), "\
		Step 2:\n\
		********\n\
		Please give the ID or NAME of the vehicle that's going to be used in the race you are creating now.\n\n\
		>> Give the ID or NAME of the vehicle below and press 'Next' to continue. 'Back' to change something.", "Next", "Back");

		case 603: ShowPlayerDialog(playerid, dialogid, DIALOG_STYLE_INPUT, CreateCaption("Build New Race (Step 2/4)"), "\
		ERROR: Invalid Vehilce ID/Name\n\n\n\
		Step 2:\n\
		********\n\
		Please give the ID or NAME of the vehicle that's going to be used in the race you are creating now.\n\n\
		>> Give the ID or NAME of the vehicle below and press 'Next' to continue. 'Back' to change something.", "Next", "Back");

		case 604: ShowPlayerDialog(playerid, dialogid, DIALOG_STYLE_MSGBOX, CreateCaption("Build New Race (Step 3/4)"),
		"\
		Step 3:\n\
		********\n\
		We are almost done! Now go to the start line where the first and second car should stand.\n\
		Note: When you click 'OK' you will be free. Use 'KEY_FIRE' to set the first position and second position.\n\
		Note: After you got these positions you will automaticly see a dialog to continue the wizard.\n\n\
		>> Press 'OK' to do the things above. 'Back' to change something.", "OK", "Back");

		case 605: ShowPlayerDialog(playerid, dialogid, DIALOG_STYLE_MSGBOX, CreateCaption("Build New Race (Step 4/4)"),
		"\
		Step 4:\n\
		********\n\
		Welcome to the last stap. In this stap you have to set the checkpoints; so if you click 'OK' you can set the checkpoints.\n\
		You can set the checkpoints with 'KEY_FIRE'. Each checkpoint you set will save.\n\
		You have to press 'ENTER' button when you're done with everything. You race is aviable then!\n\n\
		>> Press 'OK' to do the things above. 'Back' to change something.", "OK", "Back");

		case 606: ShowPlayerDialog(playerid, dialogid, DIALOG_STYLE_MSGBOX, CreateCaption("Build New Race (Done)"),
		"\
		You have created your race and it's ready to use now.\n\n\
		>> Press 'Finish' to finish. 'Exit' - Has no effect.", "Finish", "Exit");
	}
	return 1;
}


CreateCaption(arguments[])
{
	new
	    string[128 char]
	;
	format(string, sizeof(string), "Race System - %s", arguments);
	return string;
}

/*stock IsValidVehicle(vehicleid)
{
	if(vehicleid < 400 || vehicleid > 611) return false;
	    else return true;
}

ReturnVehicleID(vName[])
{
	Loop(x, 211)
	{
	    if(strfind(vNames[x], vName, true) != -1)
		return x + 400;
	}
	return -1;
}*/

TimeConvert(seconds)
{
	new tmp[16];
 	new minutes = floatround(seconds/60);
  	seconds -= minutes*60;
   	format(tmp, sizeof(tmp), "%d:%02d", minutes, seconds);
   	return tmp;
}
function Autorace()
{
	if(AutomaticRace == true) LoadRaceNames(), LoadAutoRace(RaceNames[random(TotalRaces)]);
	return 1;
}
stock IsNumeric(string[])
    {
	for (new i = 0, j = strlen(string); i < j; i++)
	{
		if (string[i] > '9' || string[i] < '0') return 0;
	}
	return 1;
    }
    


/*stock strreplace(string[], const search[], const replacement[], bool:ignorecase = false, pos = 0, limit = -1, maxlength = sizeof(string)) {
    // No need to do anything if the limit is 0.
    if (limit == 0)
        return 0;

    new
             sublen = strlen(search),
             replen = strlen(replacement),
        bool:packed = ispacked(string),
             maxlen = maxlength,
             len = strlen(string),
             count = 0
    ;


    // "maxlen" holds the max string length (not to be confused with "maxlength", which holds the max. array size).
    // Since packed strings hold 4 characters per array slot, we multiply "maxlen" by 4.
    if (packed)
        maxlen *= 4;

    // If the length of the substring is 0, we have nothing to look for..
    if (!sublen)
        return 0;

    // In this line we both assign the return value from "strfind" to "pos" then check if it's -1.
    while (-1 != (pos = strfind(string, search, ignorecase, pos))) {
        // Delete the string we found
        strdel(string, pos, pos + sublen);

        len -= sublen;

        // If there's anything to put as replacement, insert it. Make sure there's enough room first.
        if (replen && len + replen < maxlen) {
            strins(string, replacement, pos, maxlength);

            pos += replen;
            len += replen;
        }

        // Is there a limit of number of replacements, if so, did we break it?
        if (limit != -1 && ++count >= limit)
            break;
    }

    return count;
}*/
stock IsValidVehicle(vehicleid)
{
	if(vehicleid < 400 || vehicleid > 611) return false;
	    else return true;
}

ReturnVehicleID(vName[])
{
	Loop(x, 211)
	{
	    if(strfind(vNames[x], vName, true) != -1)
		return x + 400;
	}
	return -1;
}
