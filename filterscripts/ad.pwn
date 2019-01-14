#include <a_samp>
#include <zcmd>
#include <lethaldudb2>//LethaL
#define AAD_TIME_TempoDeEsperaLobby 20000 //5 seg
#define AAD_TIME_DuracaoDaPartida 300000 // 5 min
#define AAD_TIME_IntervaloEntrePartidas 3600000 //1 hr
//#define START_TIME 300000
#define cinza 0xBABABAFF
#define W "{FFFFFF}" //white
#define G "{00FF00}"
#define LB "{00C2EC}"
new arena[MAX_PLAYERS];
new DB:LadminDB;
new AAD_Vai[MAX_PLAYERS];
new AAD_Team[MAX_PLAYERS];
new AAD_Lobby;
new AAD_EmProgresso;
new AAD_KillsPerPlayer[MAX_PLAYERS];
new AAD_Kills_1;
new AAD_Kills_2;
new AAD_Balancer;
new AAD_Participantes;
new AAD_TopKillerID_Kills;
new AAD_TopKillerID;
new AAD_TopKillerID_NAME[MAX_PLAYER_NAME];
new AAD_Vencedor;
new AAD_Vencedor_STR[40];
new AAD_OldPlayerColor[MAX_PLAYERS];
new AAD_DominandoTimer[MAX_PLAYERS];
new AAD_DominandoINT[MAX_PLAYERS];
new AAD_Dominado;
new AAD_Timer;
new AAD_Local;
new AAD_Local_STR[20];
new bool:inAD[MAX_PLAYERS] = false;
new string[1500];
new string22[166];

new bool:PATT[MAX_PLAYERS];
new bool:PDEFF[MAX_PLAYERS];

new PlayerText:PinCP[MAX_PLAYERS] = {PlayerText: INVALID_TEXT_DRAW, ...};
new PlayerText:cptime[MAX_PLAYERS] = {PlayerText: INVALID_TEXT_DRAW, ...};
new PlayerText:totalp[MAX_PLAYERS] = {PlayerText: INVALID_TEXT_DRAW, ...};
//new Text:TOTALHPATT[MAX_PLAYERS];
//new Text:TOTALHPDEF[MAX_PLAYERS];
new Text:textcont;
new TempoMostrarText[MAX_PLAYERS];
new MostrandoText[MAX_PLAYERS];

new GZEB,GZOF,GZJH,GZDO,GZCAL,GZGAN,GZBB,GZAP,GZLB,GZMARK,GZSK8;

new Float:AttacksEB[][4] = {
{-1564.8308,2625.8884,55.8403,268.1628},
{-1564.8308,2625.8884,55.8403,268.1628}};


new Float:DeffendsEB[][4] = {
{-1480.9575,2626.4058,58.7813,7.3566},
{-1480.9575,2626.4058,58.7813,7.3566}};

new Float:AttacksOF[][4] = {
{-2673.7610,40.3333,4.1797,74.6692},
{-2673.7610,40.3333,4.1797,74.6692}};


new Float:DeffendsOF[][4] = {
{-2748.2119,125.6231,7.3377,211.9940},
{-2748.2119,125.6231,7.3377,211.9940}};

new Float:AttacksJH[][4] = {
{2231.4514,-1301.1141,23.8378,23.1672},
{2231.4514,-1301.1141,23.8378,23.1672}};

new Float:DeffendsJH[][4] = {
{2216.5342,-1179.3043,29.7971,174.9386},
{2216.5342,-1179.3043,29.7971,174.9386}};

new Float:AttacksDO[][4] = {
{2676.3750,-2438.1458,13.6306,275.8143},
{2676.3750,-2438.1458,13.6306,275.8143}};


new Float:DeffendsDO[][4] = {
{2783.7666,-2455.7747,13.6346,267.3059},
{2783.7666,-2455.7747,13.6346,267.3059}};

new Float:AttacksCAL[][4] = {
{2054.1160,1284.3907,10.6719,274.6094},
{2054.1160,1284.3907,10.6719,274.6094}};


new Float:DeffendsCAL[][4] = {
{2211.1270,1284.7239,10.8203,119.2131},
{2211.1270,1284.7239,10.8203,119.2131}};

//NOVOS

new Float:AttacksGAN[][4] = {
{2393.7244,-1501.7429,23.8349,306.3554},
{2393.7244,-1501.7429,23.8349,306.3554}};


new Float:DeffendsGAN[][4] = {
{2246.2173,-1436.7993,25.7566,105.7917},
{2246.2173,-1436.7993,25.7566,105.7917}};

new Float:AttacksBB[][4] = {
{208.3047,-145.5398,1.5859,95.2822},
{208.3047,-145.5398,1.5859,95.2822}};


new Float:DeffendsBB[][4] = {
{208.1822,-231.1275,1.7786,306.8443},
{208.1822,-231.1275,1.7786,306.8443}};

new Float:AttacksAP[][4] = {
{-2072.9636,-2506.6931,30.4697,61.9069},
{-2072.9636,-2506.6931,30.4697,61.9069}};


new Float:DeffendsAP[][4] = {
{-2187.7422,-2427.8452,35.5162,142.1160},
{-2187.7422,-2427.8452,35.5162,142.1160}};

new Float:AttacksLB[][4] = {
{-863.2654,1562.4991,24.4756,269.9603},
{-863.2654,1562.4991,24.4756,269.9603}};


new Float:DeffendsLB[][4] = {
{-725.7443,1545.0908,39.0630,259.0364},
{-725.7443,1545.0908,39.0630,259.0364}};

new Float:AttacksMARK[][4] = {
{1148.5477,-1589.9414,13.4836,28.3246},
{1148.5477,-1589.9414,13.4836,28.3246}};


new Float:DeffendsMARK[][4] = {
{1128.9072,-1488.0807,22.7690,181.9221},
{1128.9072,-1488.0807,22.7690,181.9221}};

new Float:AttacksSK8[][4] = {
{1944.3647,-1367.6292,18.5781,96.1388},
{1944.3647,-1367.6292,18.5781,96.1388}};


new Float:DeffendsSK8[][4] = {
{1771.9834,-1375.5273,15.7578,160.4254},
{1771.9834,-1375.5273,15.7578,160.4254}};

public OnFilterScriptInit(){
LadminDB = db_open("lUser.db");
SetTimer("TimerPorSegundo", 2000, 1);
///AAD_Timer = SetTimer("AAD_DefLobby",AAD_TIME_IntervaloEntrePartidas, 0);
for(new playerid; playerid < MAX_PLAYERS; playerid++){
if(!IsPlayerConnected(playerid)) continue;
OnPlayerConnect(playerid);
}
//SetTimer("AAD_DefLobby", START_TIME, 0);
GZEB = GangZoneCreate(-1536.830810, 2555.888427, -1396.830810, 2723.888427); // el quebrados
GZOF = GangZoneCreate(-2799.760986, 68.333297, -2701.760986, 180.333297); // ocean flats
GZDO = GangZoneCreate(2704.375000, -2564.145751, 2844.375000, -2340.145751); // dockas
GZCAL = GangZoneCreate(2123.260498, 1216.821166, 2305.260498, 1342.821166); // come a lot
GZBB = GangZoneCreate(124.304702, -313.539794, 278.304687, -201.539794); // blue berry
GZAP = GangZoneCreate(-2250.789550, -2481.484375, -2082.789550, -2397.484375); //angel pine
GZLB = GangZoneCreate(-792.546691, 1492.499145, -680.546691, 1604.499145);// las barrancas
GZMARK = GangZoneCreate(1064.547729, -1547.941406, 1176.547729, -1421.941406); // market
GZSK8 = GangZoneCreate(1725.245117, -1440.484497, 1809.245117, -1300.484497); // sk8
GZGAN = GangZoneCreate(2184.289550, -1486.367919, 2296.289550, -1374.367919); // ganton
GZJH = GangZoneCreate(2175.639404, -1224.106445, 2259.639404, -1140.106445); // jefferson

textcont = TextDrawCreate(2.000000, 436.000000, "~r~~h~                   ATTACK  ~w~%i   x   %i  ~b~~h~DEFFEND");
TextDrawBackgroundColor(textcont, 0x000000FF);
TextDrawFont(textcont, 2);
TextDrawLetterSize(textcont, 0.330000, 1.299999);
TextDrawColor(textcont, 0x00FFB0FF);
TextDrawSetOutline(textcont, 1);
TextDrawSetProportional(textcont, 1);
TextDrawSetShadow(textcont, 1);
TextDrawUseBox(textcont, 1);
TextDrawBoxColor(textcont, 90);
TextDrawTextSize(textcont, 639.000000, 639.000000);


return 1;}

public OnFilterScriptExit(){
db_close(LadminDB);
return 1;}

public OnPlayerConnect(playerid){
		PinCP[playerid] = CreatePlayerTextDraw(playerid, 100.000000, 270.000000, " ");
		PlayerTextDrawBackgroundColor(playerid, PinCP[playerid], 0x000000FF);
        PlayerTextDrawFont(playerid, PinCP[playerid], 1);
        PlayerTextDrawColor(playerid, PinCP[playerid], 0xFFFFFFFF);
        PlayerTextDrawLetterSize(playerid, PinCP[playerid], 0.330000, 1.500000);
	  	PlayerTextDrawSetProportional(playerid, PinCP[playerid], 1);
	  	PlayerTextDrawSetShadow(playerid, PinCP[playerid], 1);

	  	cptime[playerid] = CreatePlayerTextDraw(playerid, 293.000000, 400.000000, " ");
        PlayerTextDrawBackgroundColor(playerid, cptime[playerid], 0x000000FF);
        PlayerTextDrawFont(playerid, cptime[playerid], 1);
        PlayerTextDrawColor(playerid, cptime[playerid], 0xFFFFFFFF);
        PlayerTextDrawLetterSize(playerid, cptime[playerid], 0.300000, 0.950000);
	  	PlayerTextDrawSetProportional(playerid, cptime[playerid], 1);
	  	PlayerTextDrawSetOutline(playerid, cptime[playerid], 1);
	  	PlayerTextDrawSetShadow(playerid, cptime[playerid], 1);

        totalp[playerid] = CreatePlayerTextDraw(playerid, 238.000000, 423.000000, " ");
        PlayerTextDrawBackgroundColor(playerid, totalp[playerid], 0x000000FF);
        PlayerTextDrawFont(playerid, totalp[playerid], 1);
        PlayerTextDrawColor(playerid, totalp[playerid], 0xFFFFFFFF);
        PlayerTextDrawLetterSize(playerid, totalp[playerid], 0.300000, 0.950000);
	  	PlayerTextDrawSetProportional(playerid,totalp[playerid], 1);
	  	PlayerTextDrawSetOutline(playerid, totalp[playerid], 1);
	  	PlayerTextDrawSetShadow(playerid, totalp[playerid], 1);

	    /*TOTALHPATT[i] = CreatePlayerTextDraw(238.000000, 423.000000, " ");
        PlayerTextDrawBackgroundColor(TOTALHPATT[i], 0x000000FF);
        PlayerTextDrawFont(TOTALHPATT[i], 1);
        PlayerTextDrawColor(TOTALHPATT[i], 0xFFFFFFFF);
        PlayerTextDrawLetterSize(TOTALHPATT[i], 0.300000, 0.950000);
	  	PlayerTextDrawSetProportional(TOTALHPATT[i], 1);
	  	TextDrawSetOutline(TOTALHPATT[i], 1);
	  	PlayerTextDrawSetShadow(TOTALHPATT[i], 1);

        TOTALHPDEF[i] = CreatePlayerTextDraw(238.000000, 423.000000, " ");
        PlayerTextDrawBackgroundColor(TOTALHPDEF[i], 0x000000FF);
        PlayerTextDrawFont(TOTALHPDEF[i], 1);
        PlayerTextDrawColor(TOTALHPDEF[i], 0xFFFFFFFF);
        PlayerTextDrawLetterSize(TOTALHPDEF[i], 0.300000, 0.950000);
	  	PlayerTextDrawSetProportional(TOTALHPDEF[i], 1);
	  	TextDrawSetOutline(TOTALHPDEF[i], 1);
	  	PlayerTextDrawSetShadow(TOTALHPDEF[i], 1);*/
		arena[playerid] = 0;
		AAD_Vai[playerid] = 0;
		KillTimer(AAD_DominandoTimer[playerid]);
		PATT[playerid] = false;
		PDEFF[playerid] = false;
		inAD[playerid] = false;
		return 1;
}

public OnPlayerSpawn(playerid){
if(AAD_Vai[playerid] == 1) {AAD_Vai[playerid] = 0;}
arena[playerid] = 0;
inAD[playerid] = false;
PATT[playerid] = false;
PDEFF[playerid] = false;

if(AAD_Team[playerid] == 1 && AAD_EmProgresso == 1 && AAD_Vai[playerid] == 1){AAD_SpawnAttack(playerid);}
if(AAD_Team[playerid] == 2 && AAD_EmProgresso == 1 && AAD_Vai[playerid] == 1){AAD_SpawnDeffend(playerid);}

TextDrawHideForPlayer(playerid, textcont);
PlayerTextDrawHide(playerid, PinCP[playerid]);
PlayerTextDrawHide(playerid, cptime[playerid]);
PlayerTextDrawHide(playerid, totalp[playerid]);
//TextDrawHideForPlayer(playerid, TOTALHPATT[playerid]);
//TextDrawHideForPlayer(playerid, TOTALHPDEF[playerid]);

return 1;}

public OnPlayerDisconnect(playerid,reason){
arena[playerid] = 0;
PDEFF[playerid] = false;
PATT[playerid] = false;
new DEFF, ATT;
if(!AAD_EmProgresso) return 1;
for(new i; i < GetMaxPlayers(); i++)
{
	if(IsPlayerConnected(i) && inAD[i])
	{
		if(PDEFF[i] == true) DEFF++;
		if(PATT[i] == true) ATT++;
	}
}
if(DEFF < 1){
KillTimer(AAD_Timer);
AAD_DefFinalizar();
}
else if(ATT < 1) {
KillTimer(AAD_Timer);
AAD_DefFinalizar();
}
return 1;}

public OnPlayerDeath(playerid, killerid, reason)
{
if(killerid != INVALID_PLAYER_ID){
if(AAD_Team[killerid] == 1 && AAD_EmProgresso == 1 && AAD_Vai[killerid] == 1){AAD_Kills_1++;AAD_KillsPerPlayer[killerid]++;}
if(AAD_Team[killerid] == 2 && AAD_EmProgresso == 1 && AAD_Vai[killerid] == 1){AAD_Kills_2++;AAD_KillsPerPlayer[killerid]++;}
}
if(inAD[playerid] && AAD_EmProgresso)
{
PDEFF[playerid] = false;
PATT[playerid] = false;
inAD[playerid] = false;
TextDrawHideForPlayer(playerid, textcont);
PlayerTextDrawHide(playerid, PinCP[playerid]);
PlayerTextDrawHide(playerid, cptime[playerid]);
SetPlayerTeam(playerid, NO_TEAM);
PlayerTextDrawHide(playerid, totalp[playerid]);
SetPVarInt(playerid, "MINION", 0);
new DEFF, ATT;
for(new i; i < GetMaxPlayers(); i++)
{
	if(IsPlayerConnected(i) && inAD[i])
	{
		if(PDEFF[i] == true) DEFF++;
		if(PATT[i] == true) ATT++;
	}
}
if(DEFF < 1){
KillTimer(AAD_Timer);
AAD_DefFinalizar();
}
else if(ATT < 1) {
KillTimer(AAD_Timer);
AAD_DefFinalizar();
}
}
return 1;
}


public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    if(dialogid == 166)
    {
        if(response) // If they clicked 'Yes' or pressed enter
        {
		AAD_Vai[playerid] = 1;
		PlayerPlaySound(playerid,1057,0.0,0.0,0.0);
		inAD[playerid] = true;
        }
        else // Pressed ESC or clicked cancel
        {

        }
        return 1; // We handled a dialog, so return 1. Just like OnPlayerCommandText.
    }

    return 0; // You MUST return 0 here! Just like OnPlayerCommandText.
}


new bool:Attacking = false;
new TimerCP;
new timee;
public OnPlayerLeaveCheckpoint(playerid)
{
if(!inAD[playerid]) return 1;
if(!PATT[playerid]) return 1;
if(AAD_Team[playerid] == 1 && AAD_EmProgresso == 1 && AAD_Vai[playerid] == 1)
{
	AAD_DominandoINT[playerid] = 0;
	new count;
	for(new i; i < MAX_PLAYERS; i++)
	{
		if(inAD[i]) continue;
		if(!IsPlayerInCheckpoint(i)) continue;
		if(!PATT[i]) continue;
		if(!AAD_DominandoINT[i]) continue;
		count++;
	}
	if(count < 1)
	{
		for(new i; i < MAX_PLAYERS; i++)
		{
		if(!inAD[i]) continue;
		if(AAD_DominandoINT[i]) AAD_DominandoINT[i] = 0;
		PlayerTextDrawHide(i, PinCP[i]);
		PlayerTextDrawHide(i, cptime[i]);
		//PlayerTextDrawSetString(i,cptime[i], string);
		PlayerTextDrawHide(i, cptime[i]);
		}
		KillTimer(TimerCP);
		Attacking = false;
		timee = 0;
	}
}
return 1;
}

public OnPlayerEnterCheckpoint(playerid)
{
	if(!inAD[playerid]) return 1;
	if(PATT[playerid])
	{
		if(AAD_EmProgresso == 1 && AAD_Vai[playerid] == 1)
		{
			if(!Attacking) TimerCP = SetTimer("Dominando", 999, 1), Attacking = true;
			AAD_DominandoINT[playerid] = 1;
		}


	}
	else if(PDEFF[playerid])
	{
		if(!Attacking) return 1;
		KillTimer(TimerCP);
		Attacking = false;
		for(new i; i < MAX_PLAYERS; i++)
		{
			if(!inAD[i]) continue;
			if(AAD_DominandoINT[playerid]) AAD_DominandoINT[playerid] = 0;
 			PlayerTextDrawHide(i, PinCP[i]);
			PlayerTextDrawHide(i, cptime[i]);
		}
	}
	return 1;
}

forward Dominando();
public Dominando()
{
	new string3[600], count;
	for(new i; i < MAX_PLAYERS; i++)
	{
		if(inAD[i] && AAD_DominandoINT[i] && IsPlayerInCheckpoint(i))
		{
		if(!i) format(string,sizeof(string),"Players en CP~n~~r~%s(ID:%i)",PlayerName2(i),i);
		else format(string,sizeof(string),"~n~~r~%s(ID:%i)",PlayerName2(i),i);
		strcat(string3, string);
		count++;
		}
	}

	if(count == 0)
	{
		KillTimer(TimerCP);
		Attacking = false;
		for(new i; i < MAX_PLAYERS; i++)
		{
			if(!inAD[i]) continue;
			if(AAD_DominandoINT[i]) AAD_DominandoINT[i] = 0;
			PlayerTextDrawHide(i, PinCP[i]);
			PlayerTextDrawHide(i, cptime[i]);
			//PlayerTextDrawSetString(i,cptime[i], string);
			PlayerTextDrawHide(i, cptime[i]);

		}
	return 1;
	}
	for(new i; i < GetMaxPlayers(); i++)
	{
		if(IsPlayerConnected(i) && inAD[i])
		{
			PlayerTextDrawShow(i, PinCP[i]);
			PlayerTextDrawSetString(i, PinCP[i], string3);
			MostrandoText[i] = 1;
			format(string,sizeof(string),"~w~TIME: %i~r~/~w~25", timee);
			PlayerTextDrawSetString(i,cptime[i], string);
			PlayerTextDrawShow(i, cptime[i]);
            PlayerPlaySound(i,1057,0.0,0.0,0.0);
		}
	}
	timee++;
	if(timee == 25)
	{
 		AAD_Dominado = 1;
  		KillTimer(AAD_Timer);
		AAD_DefFinalizar();
	}
	return 1;
}
/*forward AAD_DominarTimer();
public AAD_DominarTimer(){
for(new i; i < MAX_PLAYERS; i++){
if(IsPlayerInCheckpoint(playerid)){
AAD_DominandoINT[playerid]++;
PlayerPlaySound(playerid,1057,0.0,0.0,0.0);
//format(string, sizeof(string), "~n~~n~~n~~n~~n~~n~~n~~n~~w~%i~r~/~w~25", AAD_DominandoINT[playerid]);
//GameTextForPlayer(playerid, string, 3000, 3);
KillTimer(TempoMostrarText[playerid]);
PlayerTextDrawShow(playerid, cptime[playerid]);
format(string,sizeof(string),"~w~TIME: %i~r~/~w~25", AAD_DominandoINT[playerid]);
PlayerTextDrawSetString(playerid,cptime[playerid], string);
MostrandoText[playerid] = 1;
}
if(AAD_DominandoINT[playerid] >= 25){
AAD_DominandoINT[playerid] = 1;
KillTimer(AAD_DominandoTimer[playerid]);
KillTimer(TempoMostrarText[playerid]);
PlayerTextDrawShow(playerid, cptime[playerid]);
format(string,sizeof(string),"~w~dominado!", AAD_DominandoINT[playerid]);
PlayerTextDrawSetString(playerid, cptime[playerid], string);
MostrandoText[playerid] = 1;
//format(string, sizeof(string), "~n~~n~~n~~n~~n~~n~~n~~n~~b~Dominado!", AAD_DominandoINT[playerid]);
//GameTextForPlayer(playerid, string, 5000, 3);
PlayerTextDrawHide(playerid, cptime[playerid]);
TextDrawHideForAll(textcont);
//TextDrawHideForAll(TOTALHPATT[playerid]);
//TextDrawHideForAll(TOTALHPDEF[playerid]);
AAD_Dominado = 1;
KillTimer(AAD_Timer);
AAD_DefFinalizar();
return 1;}

}else{
AAD_DominandoINT[playerid] = 1;
KillTimer(AAD_DominandoTimer[playerid]);}
return 1;}*/
CMD:playersad(playerid,params[]){
new ATT,DEFF;
if(!IsPlayerAdminEx(playerid)) return 0;
for(new i; i < GetMaxPlayers(); i++){ if(IsPlayerConnected(i) && inAD[i]){
if(PDEFF[i] == true) DEFF++;
if(PATT[i] == true) ATT++;}}
format(string, sizeof(string), "{FFFFFF}» Players {FF0000}ATTACK: {FFFFFF}%i", ATT);
format(string22, sizeof(string22), "{FFFFFF}» Players {3344FF}DEFFEND: {FFFFFF}%i", DEFF);
SendClientMessage(playerid, cinza, string);
SendClientMessage(playerid, cinza, string22);
return 1;}

stock PlayerName2(playerid){
new name[24];
GetPlayerName(playerid, name, 24);
return name;
}
CMD:startad(playerid,params[])
{
if(!IsPlayerAdminEx(playerid)) return 0;
if(AAD_EmProgresso == 1 || AAD_Lobby == 1) return SendClientMessage(playerid, cinza, "[AD] En progreso.");
KillTimer(AAD_Timer);
AAD_DefLobby();
for(new i; i < GetMaxPlayers(); i++){
if(!IsPlayerConnected(playerid)) continue;
if(GetPVarInt(i, "MINION") || GetPVarInt(i, "RACE")) continue;
ShowPlayerDialog(i, 166, DIALOG_STYLE_MSGBOX, "¿Desea participar en el A/D?", "Clic en sí para entrar.", "Sí", "No");
/*TogglePlayerControllable(i, false);*/}
return 1;}
forward IsPlayerAdminEx(playerid);
public IsPlayerAdminEx(playerid)
{
new strin[128], level[40],t;
format(strin, 128, "SELECT pLevel FROM user WHERE pName = '%s'", udb_encode(PlayerName2(playerid)));
new DBResult:r = db_query(LadminDB, strin);
db_get_field_assoc(r, "pLevel", level, 40);
t = strval(level);
if(t < 1) return false;
db_free_result(r);
return true;
}

CMD:end(playerid,params[]) {
//if(AAD_Vai[playerid] == 1){
if(!IsPlayerAdminEx(playerid)) return 0;
for(new i; i < GetMaxPlayers(); i++){
if(!inAD[i]) continue;
TextDrawHideForPlayer(i, textcont);
PlayerTextDrawHide(i, PinCP[i]);
PlayerTextDrawHide(i, cptime[i]);
SetPVarInt(i, "MINION", 0);
//TextDrawHideForPlayer(playerid, TOTALHPATT[playerid]);
//TextDrawHideForPlayer(playerid, TOTALHPDEF[playerid]);
arena[i] = 0;
SpawnPlayer(i);
DisablePlayerCheckpoint(i);}
AAD_CancelaLobby(playerid);
GangZoneHideForAll(GZEB);
GangZoneHideForAll(GZOF);
GangZoneHideForAll(GZDO);
GangZoneHideForAll(GZCAL);
GangZoneHideForAll(GZBB);
GangZoneHideForAll(GZAP);
GangZoneHideForAll(GZLB);
GangZoneHideForAll(GZMARK);
GangZoneHideForAll(GZSK8);
GangZoneHideForAll(GZGAN);
GangZoneHideForAll(GZJH);
return 1;}

CMD:noautoad(playerid,params[]) {
if(!IsPlayerAdmin(playerid)) return 0;
if(AAD_EmProgresso == 1 || AAD_Lobby == 1) return SendClientMessage(playerid, cinza, "[AD] Está en progreso.");
KillTimer(AAD_Timer);
SendClientMessage(playerid, cinza, "[AD] A/D desactivado.");
return 1;}

CMD:autoad(playerid,params[]) {
if(!IsPlayerAdmin(playerid)) return 0;
if(AAD_EmProgresso == 1 || AAD_Lobby == 1) return SendClientMessage(playerid, cinza, "[Pura Joda] En progreso.");
KillTimer(AAD_Timer);
AAD_Timer = SetTimer("AAD_DefLobby",AAD_TIME_IntervaloEntrePartidas, 0);
SendClientMessage(playerid, cinza, "[Pura Joda] ACTIVADO.");
return 1;}

CMD:salirdm(playerid,params[]){
if(!inAD[playerid]) return 0;
PDEFF[playerid] = false;
PATT[playerid] = false;
TextDrawHideForPlayer(playerid, textcont);
PlayerTextDrawHide(playerid, totalp[playerid]);

if(arena[playerid] == 1)
{
	if(AAD_Vai[playerid] == 1 && AAD_EmProgresso == 1)
	{
		AAD_Vai[playerid] = 0;
		AAD_Team[playerid] = 0;
		DisablePlayerCheckpoint(playerid);
		//SetPlayerHealth(playerid,0.0);
	}
}
new DEFF, ATT;
for(new i; i < GetMaxPlayers(); i++)
{
	if(IsPlayerConnected(i) && inAD[i])
	{
		if(PDEFF[i] == true) DEFF++;
		if(PATT[i] == true) ATT++;
	}
}
if(DEFF < 1){
KillTimer(AAD_Timer);
AAD_DefFinalizar();
}
else if(ATT < 1) {
KillTimer(AAD_Timer);
AAD_DefFinalizar();
}
TextDrawHideForPlayer(playerid, textcont);
PlayerTextDrawHide(playerid, totalp[playerid]);
PlayerTextDrawHide(playerid, PinCP[playerid]);
PlayerTextDrawHide(playerid, cptime[playerid]);
SetPVarInt(playerid, "MINION", 0);
inAD[playerid] = false;
GangZoneHideForPlayer(playerid, GZEB);
GangZoneHideForPlayer(playerid, GZOF);
GangZoneHideForPlayer(playerid, GZDO);
GangZoneHideForPlayer(playerid, GZCAL);
GangZoneHideForPlayer(playerid, GZBB);
GangZoneHideForPlayer(playerid, GZAP);
GangZoneHideForPlayer(playerid, GZLB);
GangZoneHideForPlayer(playerid, GZMARK);
GangZoneHideForPlayer(playerid, GZSK8);
GangZoneHideForPlayer(playerid, GZGAN);
GangZoneHideForPlayer(playerid, GZJH);
SetPlayerTeam(playerid, NO_TEAM);
return 0;
}

/*CMD:iraaffd(playerid,params[]){
if(GetPlayerInterior(playerid) != 0) return SendClientMessage(playerid,cinza,"Você está dentro de um interior.");
if(arena[playerid] == 1) return SendClientMessage(playerid, cinza, "Você já está em uma base");
if(AAD_Vai[playerid] == 1) return SendClientMessage(playerid, cinza, "{FFFFFF}» {BABABA}Quando iniciar, você irá automaticamente para Base, aguarde.");
if(AAD_Lobby == 0) return SendClientMessage(playerid, cinza, "{FFFFFF}» {BABABA}A base está indisponível no momento");
AAD_Vai[playerid] = 1;
format(string, sizeof(string), "{FFFFFF}» {BABABA}Você será teleportado automaticamente para a base %s, aguarde.",AAD_Local_STR);
SendClientMessage(playerid, cinza, string);
return 1;}*/



/*CMD:vc(playerid,params[]) {
	    new tmp[256], tmp2[256], tmp3[256], Index; tmp = strval(params), tmp2 = strval(params); tmp3 = strval(params);
	    if(!isnull(tmp)) return SendClientMessage(playerid, cinza, "{BABABA}»{FFFFFF} /v [Modelid/Name] [colour1] [colour2]");
        if(CallRemoteFunction("GetPlayerCash", "i", playerid) < 500) return SendClientMessage(playerid, 0xFFFFFFFF, "{FFFFFF}» {BABABA}Você não possui dinheiro o suficiente. Necessário: $500");
		new car, colour1, colour2, string[128];
   		if(!IsNumeric(tmp)) car = GetVehicleModelIDFromName(tmp); else car = strval(tmp);
		if(car < 400 || car > 611) return  SendClientMessage(playerid, cinza, "{BABABA}» {FFFFFF} Este veiculo não é valido");
        if(car == 425 || car == 425) return SendClientMessage(playerid,cinza, "{BABABA}» {FFFFFF} Este veiculo não é valido");
        if(car == 432 || car == 432) return SendClientMessage(playerid,cinza, "{BABABA}» {FFFFFF} Este veiculo não é valido");
        if(car == 447 || car == 447) return SendClientMessage(playerid,cinza, "{BABABA}» {FFFFFF} Este veiculo não é valido");
        if(car == 520 || car == 520) return SendClientMessage(playerid,cinza, "{BABABA}» {FFFFFF} Este veiculo não é valido");
		if(!isnull(tmp2)) colour1 = random(126); else colour1 = strval(tmp2);
		if(!isnull(tmp3)) colour2 = random(126); else colour2 = strval(tmp3);
		CallRemoteFunction("GivePlayerCash", "ii", playerid, -500);
		new LVehicleID,Float:X,Float:Y,Float:Z, Float:Angle,int1;	GetPlayerPos(playerid, X,Y,Z);	GetPlayerFacingAngle(playerid,Angle);   int1 = GetPlayerInterior(playerid);
		LVehicleID = CreateVehicle(car, X+3,Y,Z, Angle, colour1, colour2, -1); LinkVehicleToInterior(LVehicleID,int1); PutPlayerInVehicle(playerid,LVehicleID,0);
		SetVehicleVirtualWorld(LVehicleID, GetPlayerVirtualWorld(playerid));
		format(string, sizeof(string), "{BABABA}Voce spawnou um {FFFFFF}\"%s\" {BABABA}(Modelo:%d) cor (%d, %d)", VehicleNames[car-400], car, colour1, colour2); SendClientMessage(playerid,lightblue, string);
        SendClientMessage(playerid,lightblue,"{BABABA}Isso lhe custou {FFFFFF}$500");
        return 1;
}


CMD:vc(playerid,params[]) {
	    if(!isnull(params)) return SendClientMessage(playerid, cinza, "{BABABA}»{FFFFFF} /v [Modelid/Name] [colour1] [colour2]");
        if(CallRemoteFunction("GetPlayerCash", "i", playerid) < 500) return SendClientMessage(playerid, 0xFFFFFFFF, "{FFFFFF}» {BABABA}Você não possui dinheiro o suficiente. Necessário: $500");
		new car, colour1, colour2, stringg[128];
   		if(!isnull(params)) car = GetVehicleModelIDFromName(params); else car = strval(params);
		if(car < 400 || car > 611) return  SendClientMessage(playerid, cinza, "{BABABA}» {FFFFFF} Este veiculo não é valido");
        if(car == 425 || car == 425) return SendClientMessage(playerid,cinza, "{BABABA}» {FFFFFF} Este veiculo não é valido");
        if(car == 432 || car == 432) return SendClientMessage(playerid,cinza, "{BABABA}» {FFFFFF} Este veiculo não é valido");
        if(car == 447 || car == 447) return SendClientMessage(playerid,cinza, "{BABABA}» {FFFFFF} Este veiculo não é valido");
        if(car == 520 || car == 520) return SendClientMessage(playerid,cinza, "{BABABA}» {FFFFFF} Este veiculo não é valido");
		CallRemoteFunction("GivePlayerCash", "ii", playerid, -500);
		new LVehicleID,Float:X,Float:Y,Float:Z, Float:Angle,int1;	GetPlayerPos(playerid, X,Y,Z);	GetPlayerFacingAngle(playerid,Angle);   int1 = GetPlayerInterior(playerid);
		LVehicleID = CreateVehicle(car, X+3,Y,Z, Angle, colour1, colour2, -1); LinkVehicleToInterior(LVehicleID,int1); PutPlayerInVehicle(playerid,LVehicleID,0);
		SetVehicleVirtualWorld(LVehicleID, GetPlayerVirtualWorld(playerid));
		format(stringg, sizeof(stringg), "{BABABA}Voce spawnou um {FFFFFF}\"%s\"", VehicleNames[car-400]); SendClientMessage(playerid,cinza, stringg);
        SendClientMessage(playerid,cinza,"{BABABA}Isso lhe custou {FFFFFF}$500");
        return 1;
}*/



forward AAD_CancelaLobby(adminid);
public AAD_CancelaLobby(adminid){
//if(AAD_Lobby == 0) return SendClientMessage(adminid, cinza,"{FFFFFF}» {BABABA}A base não pode ser cancelado a este ponto");
for(new i; i < GetMaxPlayers(); i++){if(IsPlayerConnected(i) && inAD[i]){if(AAD_Vai[i] == 1){AAD_Vai[i] = 0;
inAD[i] = false;}}}
new pname[MAX_PLAYER_NAME];
GetPlayerName(adminid, pname, sizeof(pname));
format(string, sizeof(string), ""G"| A/D | base %s detenida por {FFFFFF}%s",AAD_Local_STR,pname);
SendClientMessageToAll(cinza, string);
AAD_Lobby = 0;
AAD_EmProgresso = 0;
KillTimer(AAD_Timer);
//SetTimer("AAD_DefLobby", START_TIME, 0);
//AAD_Timer = SetTimer("AAD_DefLobby",AAD_TIME_IntervaloEntrePartidas, 0);
return 1;}

forward AAD_DefIniciar();
public AAD_DefIniciar(){
AAD_Dominado = 0;
AAD_Kills_1 = 0;
AAD_Kills_2 = 0;
AAD_Participantes = 0;
AAD_Balancer = 0;
AAD_Lobby = 0;
AAD_EmProgresso = 1;
timee = 0;
for(new i; i < GetMaxPlayers(); i++)
{
	if(IsPlayerConnected(i) && inAD[i])
	{
		TextDrawShowForPlayer(i, textcont);
		PlayerTextDrawShow(i, totalp[i]);
		TogglePlayerControllable(i, true);
		SetPVarInt(i, "MINION", 1);
		SendClientMessage(i, -1, "¿estás listo?");
		//TextDrawShowForPlayer(i, TOTALHPATT[i]);
		//TextDrawShowForPlayer(i, TOTALHPDEF[i]);
		if(AAD_Vai[i] == 1 && arena[i] == 1)
		{
			AAD_Vai[i] = 0;
		}
		if(AAD_Vai[i] == 1)
		{
			AAD_OldPlayerColor[i] = GetPlayerColor(i);
			AAD_Participantes++;
			if(AAD_Balancer == 0)
			{
				AAD_Balancer = 1;
				AAD_Team[i] = 1;
			}
			else
			{
			AAD_Balancer = 0;
			AAD_Team[i] = 2;
			}
		}
	}
}

if(AAD_Participantes >= 1){
format(string, sizeof(string), ""G"| A/D | base aleatoria iniciada: "W"%s.",AAD_Local_STR);
//{01A2F7}has randomly started Base: {FFFFFF}SF Cityhall (ID: 31)
SendClientMessageToAll(cinza, string);
}else{
format(string, sizeof(string), ""G"| A/D | Base "W"%s "G"fue cancelada.",AAD_Local_STR);
SendClientMessageToAll(-1, string);
//SetTimer("AAD_DefLobby", START_TIME, 0);
AAD_Lobby = 0;
AAD_EmProgresso = 0;
for(new i; i < GetMaxPlayers(); i++){
if(IsPlayerConnected(i) && inAD[i]){
AAD_Vai[i] = 0;
inAD[i] = false;
cmd_salirdm(i, "");
SetPlayerTeam(i, NO_TEAM);
SetPVarInt(i, "MINION", 0);
AAD_Team[i] = 0;}}
//AAD_Timer = SetTimer("AAD_DefLobby",AAD_TIME_IntervaloEntrePartidas, 0);
return 1;}
for(new i; i < GetMaxPlayers(); i++){
if(IsPlayerConnected(i) && inAD[i]) {
if(AAD_Vai[i] == 1 && arena[i] == 0) {
if(AAD_Team[i] == 1 && AAD_EmProgresso == 1 && AAD_Vai[i] == 1){AAD_SpawnAttack(i);AAD_KillsPerPlayer[i] = 0;}
if(AAD_Team[i] == 2 && AAD_EmProgresso == 1 && AAD_Vai[i] == 1){AAD_SpawnDeffend(i);AAD_KillsPerPlayer[i] = 0;}

switch(AAD_Local){
case 0:{
new rand = random(sizeof(DeffendsEB));
SetPlayerCheckpoint(i, DeffendsEB[rand][0], DeffendsEB[rand][1], DeffendsEB[rand][2], 2.0);
SendRconCommand("mapname AAD El Quebrados");}
case 1:{
new rand = random(sizeof(DeffendsDO));
SetPlayerCheckpoint(i, DeffendsDO[rand][0], DeffendsDO[rand][1], DeffendsDO[rand][2], 2.0);
SendRconCommand("mapname AAD Docks");}
case 2:{
new rand = random(sizeof(DeffendsJH));
SetPlayerCheckpoint(i, DeffendsJH[rand][0], DeffendsJH[rand][1], DeffendsJH[rand][2], 2.0);
SendRconCommand("mapname AAD Jefferson Hotel");}
case 3:{
new rand = random(sizeof(DeffendsOF));
SetPlayerCheckpoint(i, DeffendsOF[rand][0], DeffendsOF[rand][1], DeffendsOF[rand][2], 2.0);
SendRconCommand("mapname AAD Ocean Flats");}
case 4:{
new rand = random(sizeof(DeffendsCAL));
SetPlayerCheckpoint(i, DeffendsCAL[rand][0], DeffendsCAL[rand][1], DeffendsCAL[rand][2], 2.0);
SendRconCommand("mapname AAD Come-A-Lot");}
case 5:{
new rand = random(sizeof(DeffendsGAN));
SetPlayerCheckpoint(i, DeffendsGAN[rand][0], DeffendsGAN[rand][1], DeffendsGAN[rand][2], 2.0);
SendRconCommand("mapname AAD Ganton");}
case 6:{
new rand = random(sizeof(DeffendsBB));
SetPlayerCheckpoint(i, DeffendsBB[rand][0], DeffendsBB[rand][1], DeffendsBB[rand][2], 2.0);
SendRconCommand("mapname AAD Blue Berry");}
case 7:{
new rand = random(sizeof(DeffendsLB));
SetPlayerCheckpoint(i, DeffendsLB[rand][0], DeffendsLB[rand][1], DeffendsLB[rand][2], 2.0);
SendRconCommand("mapname AAD Las Barrancas");}
case 8:{
new rand = random(sizeof(DeffendsMARK));
SetPlayerCheckpoint(i, DeffendsMARK[rand][0], DeffendsMARK[rand][1], DeffendsMARK[rand][2], 2.0);
SendRconCommand("mapname AAD Market");}
case 9:{
new rand = random(sizeof(DeffendsSK8));
SetPlayerCheckpoint(i, DeffendsSK8[rand][0], DeffendsSK8[rand][1], DeffendsSK8[rand][2], 2.0);
SendRconCommand("mapname AAD SK8");}
case 10:{
new rand = random(sizeof(DeffendsAP));
SetPlayerCheckpoint(i, DeffendsAP[rand][0], DeffendsAP[rand][1], DeffendsAP[rand][2], 2.0);
SendRconCommand("mapname AAD Angel Pine");}}
}}}
AAD_Timer = SetTimer("AAD_DefFinalizar",AAD_TIME_DuracaoDaPartida, 0);
return 1;}


forward AAD_SpawnAttack(i);
public AAD_SpawnAttack(i){
if(AAD_Team[i] == 1 && AAD_EmProgresso == 1 && AAD_Vai[i] == 1){PATT[i] = true;}
SetPlayerColor(i, 0xFF0000FF);
SetPlayerSkin(i, 53);
SetPVarInt(i, "MINION", 1);
SetPlayerTeam(i, 1);
SetPlayerTeam(i, 1);
SetPlayerVirtualWorld(i, 20);
ResetPlayerWeapons(i);
SetPlayerHealth(i,100);
SetPlayerArmour(i,100);
SetPlayerInterior(i,0);
TogglePlayerControllable(i, true);
arena[i] = 1;

switch(AAD_Local){
case 0:{
new rand = random(sizeof(AttacksEB));
SetPlayerPos(i, AttacksEB[rand][0], AttacksEB[rand][1], AttacksEB[rand][2]);
SetCameraBehindPlayer(i);
SetPlayerFacingAngle(i,AttacksEB[rand][3]);
GangZoneShowForAll(GZEB, 0xFF0000AA);}
case 1:{
new rand = random(sizeof(AttacksDO));
SetPlayerPos(i, AttacksDO[rand][0], AttacksDO[rand][1], AttacksDO[rand][2]);
SetCameraBehindPlayer(i);
SetPlayerFacingAngle(i,AttacksDO[rand][3]);
GangZoneShowForAll(GZDO, 0xFF0000AA);}
case 2:{
new rand = random(sizeof(AttacksJH));
SetPlayerPos(i, AttacksJH[rand][0], AttacksJH[rand][1], AttacksJH[rand][2]);
SetCameraBehindPlayer(i);
SetPlayerFacingAngle(i,AttacksJH[rand][3]);
GangZoneShowForAll(GZJH, 0xFF0000AA);}
case 3:{
new rand = random(sizeof(AttacksOF));
SetPlayerPos(i, AttacksOF[rand][0], AttacksOF[rand][1], AttacksOF[rand][2]);
SetCameraBehindPlayer(i);
SetPlayerFacingAngle(i,AttacksOF[rand][3]);
GangZoneShowForAll(GZOF, 0xFF0000AA);}
case 4:{
new rand = random(sizeof(AttacksCAL));
SetPlayerPos(i, AttacksCAL[rand][0], AttacksCAL[rand][1], AttacksCAL[rand][2]);
SetCameraBehindPlayer(i);
SetPlayerFacingAngle(i,AttacksCAL[rand][3]);
GangZoneShowForAll(GZCAL, 0xFF0000AA);}
case 5:{
new rand = random(sizeof(AttacksGAN));
SetPlayerPos(i, AttacksGAN[rand][0], AttacksGAN[rand][1], AttacksGAN[rand][2]);
SetCameraBehindPlayer(i);
SetPlayerFacingAngle(i,AttacksGAN[rand][3]);
GangZoneShowForAll(GZGAN, 0xFF0000AA);}
case 6:{
new rand = random(sizeof(AttacksBB));
SetPlayerPos(i, AttacksBB[rand][0], AttacksBB[rand][1], AttacksBB[rand][2]);
SetCameraBehindPlayer(i);
SetPlayerFacingAngle(i,AttacksBB[rand][3]);
GangZoneShowForAll(GZBB, 0xFF0000AA);}
case 7:{
new rand = random(sizeof(AttacksLB));
SetPlayerPos(i, AttacksLB[rand][0], AttacksLB[rand][1], AttacksLB[rand][2]);
SetCameraBehindPlayer(i);
SetPlayerFacingAngle(i,AttacksLB[rand][3]);
GangZoneShowForAll(GZLB, 0xFF0000AA);}
case 8:{
new rand = random(sizeof(AttacksMARK));
SetPlayerPos(i, AttacksMARK[rand][0], AttacksMARK[rand][1], AttacksMARK[rand][2]);
SetCameraBehindPlayer(i);
SetPlayerFacingAngle(i,AttacksMARK[rand][3]);
GangZoneShowForAll(GZMARK, 0xFF0000AA);}
case 9:{
new rand = random(sizeof(AttacksSK8));
SetPlayerPos(i, AttacksSK8[rand][0], AttacksSK8[rand][1], AttacksSK8[rand][2]);
SetCameraBehindPlayer(i);
SetPlayerFacingAngle(i,AttacksSK8[rand][3]);
GangZoneShowForAll(GZSK8, 0xFF0000AA);}
case 10:{
new rand = random(sizeof(AttacksAP));
SetPlayerPos(i, AttacksAP[rand][0], AttacksAP[rand][1], AttacksAP[rand][2]);
SetCameraBehindPlayer(i);
SetPlayerFacingAngle(i,AttacksAP[rand][3]);}}
GangZoneShowForAll(GZAP, 0xFF0000AA);
new Float:xe, Float:y, Float:z;
/*if(IsPlayerInAnyVehicle(i)) {
GetPlayerPos(i,xe,y,z); SetPlayerPos(i,xe,y,z+5); PlayerPlaySound(i,1190,0.0,0.0,0.0);
}*/
GivePlayerWeapon(i, 24, 500);
GivePlayerWeapon(i, 25, 500);
GivePlayerWeapon(i, 34, 500);
return 1;}
/*CMD:ad(playerid, params[]){
PlayerPlaySound(playerid,1057,0.0,0.0,0.0);
inAD[playerid] = true;
AAD_Vai[playerid] = 1;
SendClientMessage(playerid, -1, "Inscrito");
return 1;
}*/
forward AAD_SpawnDeffend(i);
public AAD_SpawnDeffend(i){
if(AAD_Team[i] == 2 && AAD_EmProgresso == 1 && AAD_Vai[i] == 1){PDEFF[i] = true;}
SetPlayerColor(i, 0x0000FFFF);
SetPlayerSkin(i, 230);
SetPVarInt(i, "MINION", 1);
SetPlayerTeam(i, 2);
SetPlayerTeam(i, 2);
SetPlayerVirtualWorld(i, 20);
arena[i] = 1;
ResetPlayerWeapons(i);
SetPlayerHealth(i,100);
SetPlayerArmour(i,100);
SetPlayerInterior(i,0);
TogglePlayerControllable(i, true);

switch(AAD_Local){
case 0:{
new rand = random(sizeof(DeffendsEB));
SetPlayerPos(i, DeffendsEB[rand][0], DeffendsEB[rand][1], DeffendsEB[rand][2]);
SetCameraBehindPlayer(i);
SetPlayerFacingAngle(i,DeffendsEB[rand][3]);}
case 1:{
new rand = random(sizeof(DeffendsDO));
SetPlayerPos(i, DeffendsDO[rand][0], DeffendsDO[rand][1], DeffendsDO[rand][2]);
SetCameraBehindPlayer(i);
SetPlayerFacingAngle(i,DeffendsDO[rand][3]);}
case 2:{
new rand = random(sizeof(DeffendsJH));
SetPlayerPos(i, DeffendsJH[rand][0], DeffendsJH[rand][1], DeffendsJH[rand][2]);
SetCameraBehindPlayer(i);
SetPlayerFacingAngle(i,DeffendsJH[rand][3]);}
case 3:{
new rand = random(sizeof(DeffendsOF));
SetPlayerPos(i, DeffendsOF[rand][0], DeffendsOF[rand][1], DeffendsOF[rand][2]);
SetCameraBehindPlayer(i);
SetPlayerFacingAngle(i,DeffendsOF[rand][3]);}
case 4:{
new rand = random(sizeof(DeffendsCAL));
SetPlayerPos(i, DeffendsCAL[rand][0], DeffendsCAL[rand][1], DeffendsCAL[rand][2]);
SetCameraBehindPlayer(i);
SetPlayerFacingAngle(i,DeffendsCAL[rand][3]);}
case 5:{
new rand = random(sizeof(DeffendsGAN));
SetPlayerPos(i, DeffendsGAN[rand][0], DeffendsGAN[rand][1], DeffendsGAN[rand][2]);
SetCameraBehindPlayer(i);
SetPlayerFacingAngle(i,DeffendsGAN[rand][3]);}
case 6:{
new rand = random(sizeof(DeffendsBB));
SetPlayerPos(i, DeffendsBB[rand][0], DeffendsBB[rand][1], DeffendsBB[rand][2]);
SetCameraBehindPlayer(i);
SetPlayerFacingAngle(i,DeffendsBB[rand][3]);}
case 7:{
new rand = random(sizeof(DeffendsLB));
SetPlayerPos(i, DeffendsLB[rand][0], DeffendsLB[rand][1], DeffendsLB[rand][2]);
SetCameraBehindPlayer(i);
SetPlayerFacingAngle(i,DeffendsLB[rand][3]);}
case 8:{
new rand = random(sizeof(DeffendsMARK));
SetPlayerPos(i, DeffendsMARK[rand][0], DeffendsMARK[rand][1], DeffendsMARK[rand][2]);
SetCameraBehindPlayer(i);
SetPlayerFacingAngle(i,DeffendsMARK[rand][3]);}
case 9:{
new rand = random(sizeof(DeffendsSK8));
SetPlayerPos(i, DeffendsSK8[rand][0], DeffendsSK8[rand][1], DeffendsSK8[rand][2]);
SetCameraBehindPlayer(i);
SetPlayerFacingAngle(i,DeffendsSK8[rand][3]);}
case 10:{
new rand = random(sizeof(DeffendsAP));
SetPlayerPos(i, DeffendsAP[rand][0], DeffendsAP[rand][1], DeffendsAP[rand][2]);
SetCameraBehindPlayer(i);
SetPlayerFacingAngle(i,DeffendsAP[rand][3]);}}
GivePlayerWeapon(i, 24, 500);
GivePlayerWeapon(i, 25, 500);
GivePlayerWeapon(i, 34, 500);
return 1;}

forward AAD_DefFinalizar();
public AAD_DefFinalizar()
{
if(!AAD_EmProgresso) return 1;
AAD_Lobby = 0;
AAD_EmProgresso = 0;

new MaiorKill = 0;
for(new x,a = GetMaxPlayers();x < a;x++){if(IsPlayerConnected(x) && inAD[x]){
if(AAD_Vai[x] == 1){
if(AAD_Team[x] != 0){
if(AAD_KillsPerPlayer[x] >= MaiorKill) {
MaiorKill = AAD_KillsPerPlayer[x];
AAD_TopKillerID = x;}}}}}

AAD_TopKillerID_Kills = MaiorKill;
GetPlayerName(AAD_TopKillerID, AAD_TopKillerID_NAME, sizeof(AAD_TopKillerID_NAME));

if(AAD_TopKillerID_Kills < 1){
AAD_TopKillerID = 0;
AAD_TopKillerID_Kills = 0;
AAD_TopKillerID_NAME = "{FFFFFF}NONE";}

if(AAD_Dominado == 1){
AAD_Vencedor = 1;
AAD_Vencedor_STR = "{FF0000}ATTACK";
AAD_Vencedor = 1;}else{
AAD_Vencedor = 2;
AAD_Vencedor_STR = "{3344FF}DEFFEND";}

for(new i; i < GetMaxPlayers(); i++){if(IsPlayerConnected(i) && inAD[i]){
if(AAD_Vai[i] == 1){
DisablePlayerCheckpoint(i);
GangZoneHideForAll(GZEB);
GangZoneHideForAll(GZOF);
GangZoneHideForAll(GZDO);
GangZoneHideForAll(GZCAL);
GangZoneHideForAll(GZBB);
GangZoneHideForAll(GZAP);
GangZoneHideForAll(GZLB);
GangZoneHideForAll(GZMARK);
GangZoneHideForAll(GZSK8);
SetPlayerTeam(i, NO_TEAM);
GangZoneHideForAll(GZGAN);
GangZoneHideForAll(GZJH);
SetPlayerColor(i, AAD_OldPlayerColor[i]);
TextDrawHideForPlayer(i, textcont);
PlayerTextDrawHide(i, totalp[i]);
PDEFF[i] = false;
PATT[i] = false;
SetPVarInt(i, "MINION", 0);
//TextDrawHideForPlayer(i, TOTALHPATT[i]);
//TextDrawHideForPlayer(i, TOTALHPDEF[i]);
SpawnPlayer(i);}
AAD_Vai[i] = 0;
AAD_Team[i] = 0;}}
SendClientMessageToAll(cinza, " ");
SendClientMessageToAll(cinza, " ");
new str[150];
new str2[200];
new str3[100];
//format(string, sizeof(string), "{FFFFFF}AAD: {BABABA}%s {FFFFFF}Team won: %s | Kills: [Attack %i x %i Deffend] [The BEST: {BABABA}%s {FFFFFF}| %i kills]",AAD_Local_STR,AAD_Vencedor_STR,AAD_Kills_1,AAD_Kills_2,AAD_TopKillerID_NAME,AAD_TopKillerID_Kills);
//SendClientMessageToAll(cinza, "{FFFFFF}===================================");
format(string, sizeof(string), "{FFFFFF}A/D %s",AAD_Local_STR);
SendClientMessageToAll(cinza, string);
format(str, sizeof(str), "{FFFFFF}Equipo ganador: %s "W"Top Player: "G"%s",AAD_Vencedor_STR,AAD_TopKillerID_NAME);
SendClientMessageToAll(cinza, str);
format(str2, sizeof(str2), "{FFFFFF}Kills: ["G"Attack {FFFFFF}%i  -  %i "G"Deffend]",AAD_Kills_1,AAD_Kills_2);
SendClientMessageToAll(cinza, str2);
//format(str3, sizeof(str3), "The Best: %s {FFFFFF}| %i kills",AAD_TopKillerID_NAME,AAD_TopKillerID_Kills);
//SendClientMessageToAll(cinza, str3);
if(AAD_TopKillerID == 0){/*NADA AQUI*/}
if(AAD_Vencedor == 0){/*NADA AQUI*/}
//AAD_Timer = SetTimer("AAD_DefLobby",AAD_TIME_IntervaloEntrePartidas, 0);
//SetTimer("AAD_DefLobby", START_TIME, 0);

return 1;
}

forward AAD_DefLobby();
public AAD_DefLobby(){
AAD_Local = random(11);
switch(AAD_Local){
case 0: AAD_Local_STR = "El Quebrados";
case 1: AAD_Local_STR = "Docks";
case 2: AAD_Local_STR = "Jefferson Hotel";
case 3: AAD_Local_STR = "Ocean Flats";
case 4: AAD_Local_STR = "Come-A-Lot";
case 5: AAD_Local_STR = "Ganton";
case 6: AAD_Local_STR = "Blue Berry";
case 7: AAD_Local_STR = "Las Barrancas";
case 8: AAD_Local_STR = "Market";
case 9: AAD_Local_STR = "SK8";
case 10: AAD_Local_STR = "Angel Pine";}
AAD_Lobby = 0;
for(new i; i < GetMaxPlayers(); i++){
if(IsPlayerConnected(i) && inAD[i])
{
AAD_Vai[i] = 0;
AAD_Team[i] = 0;
}
}
AAD_Lobby = 1;
AAD_EmProgresso = 0;
format(string, sizeof(string), ""G"| A/D | Base "W"%s "G"comenzará en 20 segundos." ,AAD_Local_STR);
SendClientMessageToAll(cinza, string);
//GameTextForAll("~r~~h~/AD", 6000, 3);
AAD_Timer = SetTimer("AAD_DefIniciar",AAD_TIME_TempoDeEsperaLobby, 0);}


forward TimerPorSegundo(playerid);
public TimerPorSegundo(playerid)
{
AttCONTAGEM();
//checkarplayers();
AttTotalp(playerid);
//AttTOTALHPATT(playerid);
//AttTOTALHPDEF(playerid);
return 1;
}

forward HideTextoText(playerid);
public HideTextoText(playerid)
{
	if(MostrandoText[playerid] == 1)
	{
	    PlayerTextDrawHide(playerid, PinCP[playerid]);
	    MostrandoText[playerid] = 0;
	}
	return 1;
}

stock AttCONTAGEM()
{
	format(string, sizeof(string), "                                                   ~r~~h~Attack   ~w~(%i)   x   (%i)   ~b~~h~Deffend", AAD_Kills_1,AAD_Kills_2);
	TextDrawSetString(textcont, string);
	return 1;
}

stock AttTotalp(playerid)
{

	new ATT,DEFF;
	for(new i; i < GetMaxPlayers(); i++){ if(IsPlayerConnected(i) && inAD[i]){
	if(PDEFF[i] == true) DEFF++;
	if(PATT[i] == true) ATT++;
	format(string, sizeof(string), "(~r~~h~%i~w~)                                (~b~~h~%i~w~)", ATT,DEFF);
	PlayerTextDrawSetString(i, totalp[i], string);}}
	return 1;
}

/*stock AttTOTALHPATT(playerid)
{
	for(new i; i < GetMaxPlayers(); i++){ if(IsPlayerConnected(i)){
	if(AAD_Team[i] == 1){
	new Float:life, Float:colete, Float:totallife;
	GetPlayerHealth(i, Float:life);
	GetPlayerArmour(i, Float:colete);
	totallife = life + colete;
	format(string, sizeof(string),"    HP: %i", floatround(totallife));
	TextDrawSetString(TOTALHPATT[playerid], string);
	TextDrawShowForAll(TOTALHPATT[playerid]);}}}
	return 1;
}

stock AttTOTALHPDEF(playerid)
{
	for(new i; i < GetMaxPlayers(); i++){ if(IsPlayerConnected(i)){
	if(AAD_Team[i] == 2){
	new Float:lfafife, Float:coletbbe, Float:safaf;
	GetPlayerHealth(i, Float:lfafife);
	GetPlayerArmour(i, Float:coletbbe);
	safaf = lfafife + coletbbe;
	format(string, sizeof(string),"                                       HP: %i", floatround(safaf));
	TextDrawSetString(TOTALHPDEF[playerid], string);
	TextDrawShowForAll(TOTALHPDEF[playerid]);}}}
	return 1;
}*/

stock checkarplayers()
{
if(AAD_Participantes <= 0 && AAD_EmProgresso == 1){
AAD_DefFinalizar();
KillTimer(AAD_Timer);
AAD_EmProgresso = 0;
for(new i; i < GetMaxPlayers(); i++){if(IsPlayerConnected(i) && inAD[i]){
arena[i] = 0;}}}
return 1;}


forward spawnarnoad(playerid);
public spawnarnoad(playerid){
if(AAD_Team[playerid] == 1 && AAD_EmProgresso == 1 && AAD_Vai[playerid] == 1){AAD_SpawnAttack(playerid);}
if(AAD_Team[playerid] == 2 && AAD_EmProgresso == 1 && AAD_Vai[playerid] == 1){AAD_SpawnDeffend(playerid);}
return 1;}

stock IsNumeric(sftring[])
{
	for (new i = 0, j = strlen(sftring); i < j; i++)
	{
		if (sftring[i] > '9' || sftring[i] < '0') return 0;
	}
	return 1;
}
