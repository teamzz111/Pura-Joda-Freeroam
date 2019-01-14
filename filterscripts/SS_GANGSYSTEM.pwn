
/*

  _________ _________         ________                              _________               __
 /   _____//   _____/        /  _____/_____    ____    ____        /   _____/__.__. _______/  |_  ____   _____
 \_____  \ \_____  \        /   \  ___\__  \  /    \  / ___\       \_____  <   |  |/  ___/\   __\/ __ \ /     \
 /        \/        \       \    \_\  \/ __ \|   |  \/ /_/  >      /        \___  |\___ \  |  | \  ___/|  Y Y  \
/_______  /_______  /        \______  (____  /___|  /\___  /      /_______  / ____/____  > |__|  \___  >__|_|  /
        \/        \/                \/     \/     \//_____/               \/\/         \/            \/      \/
                                     __________
                                     \______   \___.__.
                                      |    |  _<   |  |
                                      |    |   \\___  |
                                      |______  // ____|
                                             \/ \/ _________
                                                  /   _____/______   ____ ___.__._____    ______
                                                  \_____  \\_  __ \_/ __ <   |  |\__  \  /  ___/
                                                  /        \|  | \/\  ___/\___  | / __ \_\___ \
                                                 /_______  /|__|    \___  > ____|(____  /____  >
                                                         \/             \/\/          \/     \/




                                      |----------------------------------------------------------------|
                                      |       ==ADVANCED GANG SYSTEM SQLLITE==                         |
                                      |       ==AUTHOR:SREYAS==                                        |
                                      |       ==Version:1.0==                                          |
                                      |                                                                |
                                      |   =======Commands=========                                     |
                                      |   /gcp        - to enter gang control panel                    |
                                      |   /creategang - to create new gang                             |
                                      |   /gangtag    - to add tag to your gang                        |
                                      |   /gwar       - to challenge other gang memcers for a gang war |
                                      |   /gkick      - to kick a member from gang                     |
                                      |   /setleader  - to set a member to leader                      |
                                      |   /gmembers   - to see whole members of gang                   |
                                      |   /top        - to see top 10 gangs                            |
                                      |   /ginvite    - to invite some to your gang                    |
                                      |   /accept     - to accept an invitation                        |
                                      |   /decline    - to decline an invitation                       |
                                      |   /gangcolor  - to change your gang color                      |
                                      |   /lg         - to leave the gang                              |
                                      |   /capture    - to capture a gangzone                          |
                                      |   /createzone - to create a gang zone(Rcon only)               |
                                      |   /zones      -  to show all gang zone and their details       |
                                      |   /ghelp      - to view all cmds                               |
                                      |                                                                |
                                      |    ======Other Features=====                                   |
                                      |    Use '#' to gang chat                                        |
                                      |    Each kill give 1 score for gang                             |
                                      |    Gang Member's death will be notified                        |
                                      |    Gang will be destroyed if a leader leaves it                |
                                      |    Gang Members will get 100$ per each 10 minutes              |
                                      |    Gang Zone will locked for certain time given by user        |
                                      |    Capturing gang zone gives 10 score to the gang              |
                                      |    In game dynamic gang zone creator                           |
                                      |    On entering the zone zone info will be displayed to player  |
                                      |                                                                |
                                      |                                                                |
                                      |----------------------------------------------------------------|
*/


#define FILTERSCRIPT


#include <a_samp> //SA - MP TEAM

#include <zcmd> //ZEEX

#include <sscanf2> //Y LESS
#if !defined isnull
    #define isnull(%1) ((!(%1[0])) || (((%1[0]) == '\1') && (!(%1[1]))))
#endif
#include <YSI\y_iterate> //Y LESS
//#define _FOREACH_CUR_VERSION _Y_ITERATE_LOCAL_VERSION //Line 191
#include <YSI\y_areas>
#if !defined isnull
    #define isnull(%1) ((!(%1[0])) || (((%1[0]) == '\1') && (!(%1[1]))))
#endif
#define DIALOG_CW 152
#define DIALOG_ID 153
#define DIALOG_ID2 154
native db_get_field_int(DBResult:result, field = 0);
// directly returns an integer value according to the field ID specified
native Float:db_get_field_float(DBResult:result, field = 0);
// directly returns a float value according to the field ID specified
new idsoli = -1;
native db_get_field_assoc_int(DBResult:result, const field[]);
// directly returns an integer value according to the field name specified
native Float:db_get_field_assoc_float(DBResult:result, const field[]);
// directly returns an float value according to the field name specified
native db_get_mem_handle(DB:db);
// Get memory handle for an SQLite database that was opened with db_open.
native db_get_result_mem_handle(DBResult:result);
// Get memory handle for an SQLite query that was executed with db_query.
new bool:Convoqued[MAX_PLAYERS], timered;
//-----Dialogs--------------

#define GANG_COLOR 120
#define GTOP 122
#define GMEMBERS 123
#define GCP 124
#define GKICK 125
#define GWAR 126
#define GLEADER 127
#define GTAG 128
#define ZONECREATE 129
#define ZONES 130
#define GHELP 131
#define DIALOG_GUN 132
#define DIALOG_GUN2 133
//--------------Custom Defines-----------------------------------------------------------

#define MAX_GANGS           100

#define MAX_GZONES          250

#define ZONE_COLOR          0xF3F0E596

#define ZONE_LOCK_TIME      120                //NOTE:The time should be given in seconds

#define ZONE_CAPTURE_TIME   120                //Same as above note

#define MAX_SCORE           15              //Maximum score to create a gang

//----------------------------------------------------------------------------------------

#pragma tabsize 0
new Float:RandomSpawnsGW[][] =
{
    {1390.2234,-46.3298,1000.9236,5.7688},

    {1417.2269,-45.6457,1000.9274,53.0826},

    {1393.3025,-33.7530,1007.8823,89.6141},

    {1365.5669,2.3778,1000.9285,11.9068}

};
new Min_Player;
new members[MAX_PLAYERS][5];
new optiongun[MAX_PLAYERS];
static bool:ActiveWar = false, bool:Solicited = false;
new JoinCount;
static Iterator:Zones<MAX_GZONES>,
Float:Coords[MAX_PLAYERS][4],
Iterator:CW_PLAYER<5>,
Iterator:CW_PLAYER2<5>,
Iterator:SS_Player<MAX_PLAYERS>;//custom player iterator to overcome a bug in foreach's default one
new Messages[MAX_PLAYERS];

//-----GANG COLORS--------------------------

#define G_PURPLE                0xD526D9FF

#define G_GREEN                 0x00FF00FF

#define G_PINK                  0xFF66FFAA

#define G_CYAN                  0x33CCFFAA

#define G_GREY                  0xAFAFAFAA

#define G_WHITE                 0xFFFFFFFF

#define G_ORANGE                0xFF8000FF

#define G_YELLOW                0xFFFF00FF

#define G_BLUE                  0x0080FFC8

#define G_RED                   0xFF0000FF

//------------------------------------------



//------Colors-----------------------------

#define R "{FF0000}"

#define GR "{C0C4C4}"

#define O "{F07F1D}"

#define C "{00FFFF}"

#define G "{00FF00}"

#define W "{FFFFFF}"

#define V "{8000FF}"

#define Y "{FFFF00}"

#define B "{0000FF}"

#define P "{FF66FF}"

//---------------------------------------



enum G_USER_DATA
{

	gangmember,

    gangleader,

    gangname[32],

    gangid,

    bool:ganginvite,

    username[MAX_PLAYER_NAME],

    ginvitedname[32],

    gangcolor,

    gangtag[4],

    bool:Capturing,

    bool:inwar,

    bool:creatingzone,

    tempzone,

    Float:minX, 

    Float:minY,

    Float:maxX,

    Float:maxY,

	bool:Spawn,

	Float:sX,

	Float:sY,

	Float:sZ,

    PlayerText:TextDraw,

    PlayerText:TimerTD
};
static GInfo[MAX_PLAYERS][G_USER_DATA];
static DB:Database;


enum Zone_Data
{
    Color,

    Owner[32],

    bool:Owned,

    bool:locked,

    bool:U_Attack,

    timer,

    timer_main,

    timercap_main,

    timercap,

    Name[32],

    Float:ZminX,

    Float:ZminY,

    Float:ZmaxX,

    Float:ZmaxY,

    Region,

    _Zone
}

static ZInfo[MAX_GZONES][Zone_Data];


public OnFilterScriptInit()
{

    print("-------------------------------------------------------");

    print("---SS_Gang---SQLITE----system---by---Sreyas---Loaded---");

    print("-------------------------------------------------------");


    Database = db_open("gang.db");

    db_query( Database, "PRAGMA synchronous = OFF" );

    db_query(Database,"CREATE TABLE IF NOT EXISTS Gangs (GangID INTEGER PRIMARY KEY AUTOINCREMENT,GangName VARCHAR(24) COLLATE NOCASE ,GangColor INTEGER,GangTag VARCHAR(4),GangScore INTEGER DEFAULT 0)");

    db_query(Database,"CREATE TABLE IF NOT EXISTS Zones (Name VARCHAR(32) COLLATE NOCASE, MinX FLOAT, MinY FLOAT, MaxX FLOAT, MaxY FLOAT, Owner VARCHAR(32) COLLATE NOCASE, Color INTEGER )");

    db_query(Database,"CREATE TABLE IF NOT EXISTS Members (UserID INTEGER PRIMARY KEY AUTOINCREMENT,UserName VARCHAR(24) COLLATE NOCASE,GangMember TINYINT DEFAULT 0,GangName VARCHAR(24) COLLATE NOCASE,GangLeader TINYINT DEFAULT 0)");


    new  DBResult: Result,var;

    Result = db_query(Database,"SELECT * FROM Zones");

    if(db_num_rows(Result))
    {

        
        
        do
        {
            var = Iter_Free(Zones);

            ZInfo[var][ZminX] = db_get_field_assoc_float(Result, "MinX");

            ZInfo[var][ZminY] = db_get_field_assoc_float(Result, "MinY");

            ZInfo[var][ZmaxX] = db_get_field_assoc_float(Result, "MaxX");

            ZInfo[var][ZmaxY] = db_get_field_assoc_float(Result, "MaxY");

            db_get_field_assoc(Result, "Name", ZInfo[var][Name], 32);

            db_get_field_assoc(Result, "Owner", ZInfo[var][Owner], 32);

            ZInfo[var][Color] = db_get_field_assoc_int(Result, "Color");

            ZInfo[var][locked] = false;

            ZInfo[var][Owned] = false;

            ZInfo[var][U_Attack] = false;

            ZInfo[var][Region]  = Area_AddBox( ZInfo[var][ZminX] ,ZInfo[var][ZminY],  ZInfo[var][ZmaxX], ZInfo[var][ZmaxY]);

            ZInfo[var][_Zone] = GangZoneCreate( ZInfo[var][ZminX] ,ZInfo[var][ZminY],  ZInfo[var][ZmaxX], ZInfo[var][ZmaxY]);

            Iter_Add(Zones, var);

            
        }
        while(db_next_row(Result));

    }

    db_free_result( Result );


    return 1;
}



public OnFilterScriptExit()
{
    foreach(new i : Zones)
    {
        GangZoneDestroy(ZInfo[i][_Zone]);

        Area_Delete(ZInfo[i][Region]);
    }

    Iter_Clear(Zones);

    Iter_Clear(SS_Player);

    db_close( Database );

    print("---------------------------------------------------------");

    print("---SS_Gang---SQLITE----system---by---Sreyas---UnLoaded---");

    print("-------------------------------------------------------\n");

    return 1;
}



public OnPlayerSpawn(playerid){
if(GInfo[playerid][Spawn] && !GetPVarInt(playerid, "MINION") && !GetPVarInt(playerid, "RACE")){
SetTimerEx("SpawnPlayerEx", 2300, 0, "ifff", playerid, GInfo[playerid][sX], GInfo[playerid][sY], GInfo[playerid][sZ]);
}
return 1;
}
forward SpawnPlayerEx(playerid, Float:aX, Float: aY,Float: aZ);
public SpawnPlayerEx(playerid, Float:aX, Float: aY,Float: aZ){
SetPlayerPos(playerid, aX, aY, aZ);
return 1;
}
public OnPlayerConnect(playerid)
{
	for(new i; i < 5; i++) members[playerid][i] = -1;
	Messages[playerid] = true;
    for( new i; i < _: G_USER_DATA; ++i ) GInfo[ playerid ][ G_USER_DATA: i ] = 0;

    Iter_Add(SS_Player,playerid);

    GetPlayerName( playerid, GInfo[playerid][username], MAX_PLAYER_NAME );

    GInfo[playerid][Capturing] = false;


    GInfo[playerid][TextDraw] = CreatePlayerTextDraw(playerid,468.500823, 333.937500, " ");

    PlayerTextDrawLetterSize(playerid, GInfo[playerid][TextDraw],0.201999, 0.789999);

    PlayerTextDrawTextSize(playerid, GInfo[playerid][TextDraw],572.496704, -2714.384277);

    PlayerTextDrawAlignment(playerid, GInfo[playerid][TextDraw],1);

    PlayerTextDrawColor(playerid, GInfo[playerid][TextDraw],-100663297);

    PlayerTextDrawUseBox(playerid, GInfo[playerid][TextDraw],2);

    PlayerTextDrawBoxColor(playerid, GInfo[playerid][TextDraw], 255);

    PlayerTextDrawSetShadow(playerid, GInfo[playerid][TextDraw], 0);

    PlayerTextDrawSetOutline(playerid, GInfo[playerid][TextDraw], 0);

    PlayerTextDrawBackgroundColor(playerid, GInfo[playerid][TextDraw], 255);

    PlayerTextDrawFont(playerid, GInfo[playerid][TextDraw], 1);

    PlayerTextDrawSetProportional(playerid, GInfo[playerid][TextDraw], 1);

    PlayerTextDrawSetShadow(playerid, GInfo[playerid][TextDraw], 0);



    GInfo[playerid][TimerTD] = CreatePlayerTextDraw(playerid, 590.000000, 392.125000, "00-00");

    PlayerTextDrawLetterSize(playerid, GInfo[playerid][TimerTD], 0.400000, 1.600000);

    PlayerTextDrawAlignment(playerid, GInfo[playerid][TimerTD], 1);

    PlayerTextDrawColor(playerid, GInfo[playerid][TimerTD], -10241);

    PlayerTextDrawSetShadow(playerid, GInfo[playerid][TimerTD], -1);

    PlayerTextDrawSetOutline(playerid, GInfo[playerid][TimerTD], 0);

    PlayerTextDrawBackgroundColor(playerid, GInfo[playerid][TimerTD], 255);

    PlayerTextDrawFont(playerid, GInfo[playerid][TimerTD], 2);

    PlayerTextDrawSetProportional(playerid, GInfo[playerid][TimerTD], 1);

    PlayerTextDrawSetShadow(playerid, GInfo[playerid][TimerTD], -1);


    foreach(new i:Zones)
    {

        if(isnull(ZInfo[i][Owner]))
        GangZoneShowForPlayer(playerid,ZInfo[i][_Zone], ZONE_COLOR);

        else
        GangZoneShowForPlayer(playerid,ZInfo[i][_Zone], ZInfo[i][Color]);
    }

    new  Query[ 89 ],DBResult: Result;

    format( Query, sizeof( Query ), "SELECT * FROM Members WHERE UserName = '%q' LIMIT 0, 1", GInfo[ playerid ][ username ] );

    Result = db_query( Database, Query );

    if( db_num_rows( Result ) )
    {

        db_get_field_assoc( Result, "GangMember", Query, 7 );

        GInfo[ playerid ][ gangmember ] = strval( Query );

        db_get_field_assoc( Result, "GangLeader", Query, 7 );

        GInfo[ playerid ][ gangleader] = strval( Query );

        db_get_field_assoc(Result, "GangName", GInfo[playerid][gangname], 56);
		if(isnull(GInfo[playerid][gangname])) format(GInfo[playerid][gangname], 56, "null");
        GInfo[playerid][creatingzone] = false;

        db_get_field_assoc( Result, "GangID", Query, 7 );

        GInfo[playerid][gangid] = strval(Query);

        if(GInfo[playerid][gangmember] == 1)
        {
            new str[128];

           // SetTimerEx("GMoney",600000,true,"u",playerid);

            /*if(GInfo[playerid][gangleader] == 1)
            {

                format(str,sizeof(str),""Y"[CLAN INFO]"ORANGE"Leader"GREEN" %s "ORANGE"has Logged in!!",GInfo[playerid][username]);

                SendGangMessage(playerid,str);
            }

            else if(GInfo[playerid][gangleader] == 0)
            {

                format(str,sizeof(str),""RED"[CLAN INFO]"CYAN"Member"YELLOW" %s "ORANGE"has Logged in!!",GInfo[playerid][username]);

                SendGangMessage(playerid,str);
            }


*/          new query[105],DBResult:result;

            format(query,sizeof(query),"SELECT * FROM Gangs Where GangName = '%q' ",GInfo[playerid][gangname]);

            result = db_query(Database,query);

			new field[40];
			
            if(db_num_rows(result))
            {
                db_get_field_assoc(result,"GangColor",query,10);

                GInfo[playerid][gangcolor] = strval(query);

                SetPlayerColor(playerid,GInfo[playerid][gangcolor]);

                db_get_field_assoc(result, "GangTag", GInfo[playerid][gangtag], 4);

				db_get_field_assoc(result, "GangSpawnX", field, 40);

				if(!isnull(field)){
				GInfo[playerid][Spawn] = true;
				GInfo[playerid][sX] = floatstr(field);
				
				db_get_field_assoc(result, "GangSpawnY", field, 40);
				
				GInfo[playerid][sY] = floatstr(field);

				db_get_field_assoc(result, "GangSpawnZ", field, 40);

				GInfo[playerid][sZ] = floatstr(field);
                GInfo[playerid][Spawn] = true;
				}
				else {
				
				GInfo[playerid][Spawn] = false;
				}
                db_free_result( result );
            }

            db_free_result( Result );

            SetTimerEx("FullyConnected",3000,false,"u",playerid);



            return 1;

        }

        return 1;

    }

    else
    {
        new GQuery[107];

        format( GQuery, sizeof( GQuery ), "INSERT INTO Members (UserName) VALUES ('%q')", GInfo[ playerid ][ username ] );

        db_query( Database, GQuery );

        return 1;
    }
}



public OnPlayerDisconnect(playerid,reason)
{

    //SetPlayerName(playerid,GInfo[playerid][username]);//just to avoid some bugs

    if(GInfo[playerid][inwar])
    {
        GInfo[playerid][inwar] = false;
        CheckVict(GInfo[playerid][gangname],"INVALID");

    }
/*
    if(GInfo[playerid][gangmember] == 1)
    {
        new str[128];

        format(str,sizeof(str),""ORANGE"[GANGINFO]"RED" Member "CYAN"%s"RED" has Logged Out ",GInfo[playerid][username]);

        SendGangMessage(playerid,str);
    }
*/
    for( new i; i < _: G_USER_DATA; ++i ) GInfo[ playerid ][ G_USER_DATA: i ] = 0;

    Iter_Remove(SS_Player,playerid);
    return 1;
}



public OnPlayerText(playerid, text[])
{
    if(text[0] == '!' && GInfo[playerid][gangmember] == 1)
    {
        new str[150];
       
        format(str,sizeof(str),""Y"[GANG CHAT]"W" %s "Y"["W"%d"Y"]: "W"%s",GInfo[playerid][username],playerid,text[1]);

        SendGangMessage(playerid,str);

        return 0;
    }
/*    else
    {

        new pText[144];

        format(pText, sizeof (pText), "(%d) %s", playerid, text);

        SetPlayerChatBubble(playerid, text, 0xFFFFFFFF, 100.0, 10000);

        SendPlayerMessageToAll(playerid, pText);

        return 0;
    }
*/
	return 1;
}
/*
	1\tSniper Rifle\tShotgun\n\
	2\tDesert Eagle\tShotgun\n\
	3\tDesert Eagle\tSniper Rifle
*/
stock IsNumeric(string[])
{
	for (new i = 0, j = strlen(string); i < j; i++)
	{
		if (string[i] > '9' || string[i] < '0') return 0;
	}
	return 1;
}
new Editing[MAX_PLAYERS] = -1;
public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    switch(dialogid)
    {
        case DIALOG_ID2:
        {
            if(response)
            {
				new id = -1;
				foreach(new i : SS_Player)
				{
					if(!strcmp(GInfo[i][gangname], inputtext, true)){
			    	if(GInfo[i][gangleader] == 1){
		  			id = i;
					break;
					}
					}
	    		}
	    		if(id == -1) return ShowPlayerDialog(playerid, DIALOG_ID2, DIALOG_STYLE_INPUT, ""R"Escriba el nombre del clan",""R"Gang no encontrado / El líder no está conectado","Solicitar","Cancelar");

			 	new Guns[4], Counter, namee[139];
				for(new i; i < 5; i++)
				{
					if(members[playerid][i] == -1) continue;
					Counter++;
				}
				if(optiongun[playerid]) format(Guns, sizeof Guns, "WW2");
				else format(Guns, sizeof Guns, "RW");

				format(namee, sizeof namee, ""Y"[Pura Joda] clan "W"%s convocó una CW %d vs %d  Armas: "W"%s "Y"/gacept",GInfo[playerid][gangname],Counter, Counter, Guns);
				SendClientMessage(id, -1, namee);
				SendClientMessage(id, -1, "[Pura Joda] /gcancel para denegar la cw. Tiene 1 minuto para aceptar, en su contrario será desechada.");
				Convoqued[id] = true;
				idsoli = playerid;
				SendClientMessage(playerid, -1, "Invitación enviada con éxito");
				Solicited = true;
				timered = SetTimerEx("Invitation",60000,false,"u",playerid);
				Min_Player = Counter;
			}
		}

        case DIALOG_ID:
        {
        if(response)
        {
        if(!IsNumeric(inputtext)) return ShowPlayerDialog(playerid, DIALOG_ID, DIALOG_STYLE_INPUT, "Escriba la ID del jugador",""R"Por favor escriba ID válida","Aceptar", "Cancelar");
        if(!IsPlayerConnected(strval(inputtext))) return ShowPlayerDialog(playerid, DIALOG_ID, DIALOG_STYLE_INPUT, "Escriba la ID del jugador",""R"Jugador no conectado.","Aceptar", "Cancelar");
		if(strcmp(GInfo[playerid][gangname],GInfo[strval(inputtext)][gangname],true) != 0) return ShowPlayerDialog(playerid, DIALOG_ID, DIALOG_STYLE_INPUT, "Escriba la ID del jugador",""R"Miembros de su clan únicamente.","Aceptar", "Cancelar");
/*		for(new i; i < 5; i++)
		{
			if(members[playerid][i] == strval(inputtext)) return ShowPlayerDialog(playerid, DIALOG_ID, DIALOG_STYLE_INPUT, "Escriba la ID del jugador",""R"La ID ya está en algún slot.","Aceptar", "Cancelar");

		}*/
		switch(Editing[playerid]){
		case 0: members[playerid][0] = strval(inputtext);
		case 1: members[playerid][1] = strval(inputtext);
		case 2: members[playerid][2] = strval(inputtext);
		case 3: members[playerid][3] = strval(inputtext);
		case 4: members[playerid][4] = strval(inputtext);
		}
		Editing[playerid] = -1;
		new stin[400], sep[128];
		for(new i; i < 5; i++)
		{
		if(members[playerid][i] == -1)
		{
		format(sep, 128, ""G"<Slot Libre>\n");
		strcat(stin, sep);
		}
		else
		{
		format(sep, 128, ""W"%s\n",PlayerName2(members[playerid][i]));
		strcat(stin, sep);
		}
		}
		strcat(stin, ""R"Solicitar CW "W"/  "G"Aceptar CW");
		ShowPlayerDialog(playerid, DIALOG_CW, DIALOG_STYLE_LIST, "Seleccione los miembros", stin, "Ok", "Cancelar");
		}
        }
        case DIALOG_CW:
		{
        	if(response){
        		switch(listitem){
                	case 0:
					{
                		if(members[playerid][0] == -1)
                		{
						ShowPlayerDialog(playerid, DIALOG_ID, DIALOG_STYLE_INPUT, "Escriba la ID del jugador","Recuerde que debe ser de su clan.","Aceptar", "Cancelar");
						Editing[playerid] = 0;
						}
                		else if(members[playerid][0] != -1)
						{
						new stin[400], sep[128];
						members[playerid][0] = -1;
						for(new i; i < 5; i++)
						{
							if(members[playerid][i] == -1)
							{
								format(sep, 128, ""G"<Slot Libre>\n");
								strcat(stin, sep);
							}
							else
							{
							format(sep, 128, ""R"%s\n",PlayerName2(members[playerid][i]));
							strcat(stin, sep);
							}
						}
						strcat(stin, ""R"Solicitar CW "W"/  "G"Aceptar CW");
						ShowPlayerDialog(playerid, DIALOG_CW, DIALOG_STYLE_LIST, "Seleccione los miembros", stin, "Ok", "Cancelar");
                		}
                	}

                	case 1:
					{
                		if(members[playerid][1] == -1)
                		{
						ShowPlayerDialog(playerid, DIALOG_ID, DIALOG_STYLE_INPUT, "Escriba la ID del jugador","Recuerde que debe ser de su clan.","Aceptar", "Cancelar");
                        Editing[playerid] = 1;
						}
                		else if(members[playerid][1] != -1) {
						new stin[400], sep[128];
						members[playerid][1] = -1;
						for(new i; i < 5; i++)
						{
							if(members[playerid][i] == -1)
							{
								format(sep, 128, ""G"<Slot Libre>\n");
								strcat(stin, sep);
							}
							else
							{
							format(sep, 128, ""R"%s\n",PlayerName2(members[playerid][i]));
							strcat(stin, sep);
							}
						}
						strcat(stin, ""R"Solicitar CW "W"/  "G"Aceptar CW");
						ShowPlayerDialog(playerid, DIALOG_CW, DIALOG_STYLE_LIST, "Seleccione los miembros", stin, "Ok", "Cancelar");
                		}
                	}
                	case 2:
					{
                		if(members[playerid][2] == -1)
                		{
                		Editing[playerid] = 2;
						ShowPlayerDialog(playerid, DIALOG_ID, DIALOG_STYLE_INPUT, "Escriba la ID del jugador","Recuerde que debe ser de su clan.","Aceptar", "Cancelar");
                		}
                		else if(members[playerid][2] != -1) {
						new stin[400], sep[128];
						members[playerid][2] = -1;
						for(new i; i < 5; i++)
						{
							if(members[playerid][i] == -1)
							{
								format(sep, 128, ""G"<Slot Libre>\n");
								strcat(stin, sep);
							}
							else
							{
							format(sep, 128, ""R"%s\n",PlayerName2(members[playerid][i]));
							strcat(stin, sep);
							}
						}
						strcat(stin, ""R"Solicitar CW "W"/  "G"Aceptar CW");
						ShowPlayerDialog(playerid, DIALOG_CW, DIALOG_STYLE_LIST, "Seleccione los miembros", stin, "Ok", "Cancelar");
                		}
                	}
                	case 3:
					{
                		if(members[playerid][3] == -1)
                		{
						ShowPlayerDialog(playerid, DIALOG_ID, DIALOG_STYLE_INPUT, "Escriba la ID del jugador","Recuerde que debe ser de su clan.","Aceptar", "Cancelar");
                        Editing[playerid] = 3;
						}
                		else if(members[playerid][3] != -1) {
						new stin[400], sep[128];
						members[playerid][3] = -1;
						for(new i; i < 5; i++)
						{
							if(members[playerid][i] == -1)
							{
								format(sep, 128, ""G"<Slot Libre>\n");
								strcat(stin, sep);
							}
							else
							{
							format(sep, 128, ""R"%s\n",PlayerName2(members[playerid][i]));
							strcat(stin, sep);
							}
						}
						strcat(stin, ""R"Solicitar CW "W"/  "G"Aceptar CW");
						ShowPlayerDialog(playerid, DIALOG_CW, DIALOG_STYLE_LIST, "Seleccione los miembros", stin, "Ok", "Cancelar");
                		}
                	}
                	case 4:
					{
                		if(members[playerid][4] == -1)
                		{
						ShowPlayerDialog(playerid, DIALOG_ID, DIALOG_STYLE_INPUT, "Escriba la ID del jugador","Recuerde que debe ser de su clan.","Aceptar", "Cancelar");
                        Editing[playerid] = 4;
						}
                		else if(members[playerid][4] != -1)
						{
						new stin[400], sep[128];
						members[playerid][4] = -1;
						for(new i; i < 5; i++)
						{
							if(members[playerid][i] == -1)
							{
								format(sep, 128, ""G"<Slot Libre>\n");
								strcat(stin, sep);
							}
							else
							{
							format(sep, 128, ""R"%s\n",PlayerName2(members[playerid][i]));
							strcat(stin, sep);
							}
						}
						strcat(stin, ""R"Solicitar CW "W"/  "G"Aceptar CW");
      					ShowPlayerDialog(playerid, DIALOG_CW, DIALOG_STYLE_LIST, "Seleccione los miembros", stin, "Ok", "Cancelar");
			  			}
                	}
					case 5:
					{
					    if(idsoli == -1){
					   // print("Aqui esya XDxdXDx");
					    new Counter;
						for(new i; i < 5; i++)
						{
							if(members[playerid][i] == -1) continue;
							Counter++;
						}
						//printf("%d",Counter);
						if(Counter < 2) return SendClientMessage(playerid, -1,""R"[Pura Joda] Mínimo dos usuarios.");
                       
						ShowPlayerDialog(playerid, DIALOG_ID2, DIALOG_STYLE_INPUT, ""R"Escriba el nombre del clan","Recuerde que debe estar bien escrito","Solicitar","Cancelar");
						}
						else {
						new Float:xe,Float:y,Float:z,oe;
					    new Counter;
						for(new i; i < 5; i++)
						{
							if(members[playerid][i] == -1) continue;
							Counter++;
						}
						if(Min_Player < Counter || Counter > Min_Player) return SendClientMessage(playerid, -1, ""R"[Pura Joda] Por favor no debe exceder ni tener minimo por debajo de jugadores");
						for(new i; i < 5; i++)
						{
						    if(members[playerid][i] == -1) continue;
						    if(members[idsoli][i] == -1) continue;
						    
							if(IsPlayerInAnyVehicle(members[idsoli][i])){
							GetPlayerPos(members[idsoli][i],xe,y,z); SetPlayerPos(members[idsoli][i],xe,y,z+5); PlayerPlaySound(members[idsoli][i],1190,0.0,0.0,0.0);}
							if(IsPlayerInAnyVehicle(members[idsoli][i])){
							GetPlayerPos(members[idsoli][i],xe,y,z); SetPlayerPos(members[idsoli][i],xe,y,z+5); PlayerPlaySound(members[idsoli][i],1190,0.0,0.0,0.0);}
						    SetPlayerColor(members[idsoli][i], G_RED);
							GInfo[members[idsoli][i]][inwar] = true;
							new Random = random(sizeof(RandomSpawnsGW));
							SetPlayerPos(members[idsoli][i],RandomSpawnsGW[Random][0], RandomSpawnsGW[Random][1], RandomSpawnsGW[Random][2]);
							SetPlayerInterior(members[idsoli][i],1);
							if(optiongun[idsoli])
							ShowPlayerDialog(members[idsoli][i], DIALOG_GUN, DIALOG_STYLE_TABLIST_HEADERS, "Selecciona un paquete de armas",\
							""G"ID\t"G"Arma primaria\t"G"Arma secundaria\n\
							1\tSniper Rifle\tShotgun\n\
							2\tDesert Eagle\tShotgun\n\
							3\tDesert Eagle\tSniper Rifle","Seleccionar", "Cancelar");
							else if(!optiongun[idsoli])
							ShowPlayerDialog(members[idsoli][i], DIALOG_GUN, DIALOG_STYLE_TABLIST_HEADERS, "Selecciona un paquete de armas",\
							""G"ID\t"G"Arma primaria\t"G"Arma secundaria\n\
							1\tSawnoff Shotgun\tMicro Uzi\n\
							2\tSawnoff Shotgun\tTec9\n\
							3\tMicro Uzi\tTec9","Seleccionar", "Cancelar");
							SetPlayerVirtualWorld(members[idsoli][i], 10);
							ResetPlayerWeapons(members[idsoli][i]);
							TogglePlayerControllable(members[idsoli][i], false );
						    SetPlayerTeam(members[idsoli][i],1);

							if(IsPlayerInAnyVehicle(members[playerid][i])){
							GetPlayerPos(members[playerid][i],xe,y,z); SetPlayerPos(members[playerid][i],xe,y,z+5); PlayerPlaySound(members[playerid][i],1190,0.0,0.0,0.0);}
							if(IsPlayerInAnyVehicle(members[playerid][i])){
							GetPlayerPos(members[playerid][i],xe,y,z); SetPlayerPos(members[playerid][i],xe,y,z+5); PlayerPlaySound(members[playerid][i],1190,0.0,0.0,0.0);}
						    SetPlayerColor(members[playerid][i], G_BLUE);
							GInfo[members[playerid][i]][inwar] = true;
							SetPlayerPos(members[playerid][i],RandomSpawnsGW[Random][0], RandomSpawnsGW[Random][1], RandomSpawnsGW[Random][2]);
							SetPlayerInterior(members[playerid][i],1);
							if(optiongun[idsoli])
							ShowPlayerDialog(members[playerid][i], DIALOG_GUN, DIALOG_STYLE_TABLIST_HEADERS, "Selecciona un paquete de armas",\
							""G"ID\t"G"Arma primaria\t"G"Arma secundaria\n\
							1\tSniper Rifle\tShotgun\n\
							2\tDesert Eagle\tShotgun\n\
							3\tDesert Eagle\tSniper Rifle","Seleccionar", "Cancelar");
							else if(!optiongun[idsoli])
							ShowPlayerDialog(members[playerid][i], DIALOG_GUN, DIALOG_STYLE_TABLIST_HEADERS, "Selecciona un paquete de armas",\
							""G"ID\t"G"Arma primaria\t"G"Arma secundaria\n\
							1\tSawnoff Shotgun\tMicro Uzi\n\
							2\tSawnoff Shotgun\tTec9\n\
							3\tMicro Uzi\tTec9","Seleccionar", "Cancelar");
							SetPlayerVirtualWorld(members[playerid][i], 10);
							ResetPlayerWeapons(members[playerid][i]);
							TogglePlayerControllable(members[playerid][i], false );
						    SetPlayerTeam(members[playerid][i],2);
							}

SetTimerEx("GangWar",10000,false,"uu",playerid,members[idsoli][0]);

new str[128];
format(str,sizeof(str),""Y"[Pura Joda] En 10 segundos comenzará Clan War "W"%s "Y"vs "W"%s",GInfo[playerid][gangname],GInfo[members[idsoli][0]][gangname]);

SendClientMessageToAll(-1,str);

Convoqued[playerid] = false;
KillTimer(timered);
						}
					}

	        	}
        
	        }
        
        }
        case DIALOG_GUN:
        {
        	if(response)
			{
				switch(listitem)
				{
				    case 0:{
				    ResetPlayerWeapons(playerid);
				    GivePlayerWeapon(playerid, 34, 9000);
				    GivePlayerWeapon(playerid, 25, 9000);
				    }
				    case 1:{
				    ResetPlayerWeapons(playerid);
				    GivePlayerWeapon(playerid, 24, 9000);
				    GivePlayerWeapon(playerid, 25, 9000);
				    }
				    case 2:{
				    ResetPlayerWeapons(playerid);
				    GivePlayerWeapon(playerid, 24, 9000);
				    GivePlayerWeapon(playerid, 34, 9000);
				    }
				}
        	}
        	else {
			ShowPlayerDialog(playerid, DIALOG_GUN, DIALOG_STYLE_TABLIST_HEADERS, "Selecciona un paquete de armas",\
			""G"ID\t"G"Arma primaria\t"G"Arma secundaria\n\
			1\tSniper Rifle\tShotgun\n\
			2\tDesert Eagle\tShotgun\n\
			3\tDesert Eagle\tSniper Rifle","Seleccionar", "Cancelar");
        	}
        }
        case DIALOG_GUN2:
        {
        if(response)
		{
			switch(listitem){
			case 0:{
			ResetPlayerWeapons(playerid);
			GivePlayerWeapon(playerid, 26, 9000);
			GivePlayerWeapon(playerid, 28, 9000);

			}
			case 1:{
			ResetPlayerWeapons(playerid);
			GivePlayerWeapon(playerid, 26, 9000);
			GivePlayerWeapon(playerid, 32, 9000);

			}
			case 2:{
			ResetPlayerWeapons(playerid);
			GivePlayerWeapon(playerid, 32, 9000);
			GivePlayerWeapon(playerid, 28, 9000);
			}

		}
        }
        else{
		ShowPlayerDialog(playerid, DIALOG_GUN, DIALOG_STYLE_TABLIST_HEADERS, "Selecciona un paquete de armas",\
		""G"ID\t"G"Arma primaria\t"G"Arma secundaria\n\
		1\tSawnoff Shotgun\tMicro Uzi\n\
		2\tSawnoff Shotgun\tTec9\n\
		3\tMicro Uzi\tTec9","Seleccionar", "Cancelar");


		}
        }
        case GANG_COLOR:
        {
            if(response)
            {
                switch(listitem)
                {
                    case 0:
                    {
                        GInfo[playerid][gangcolor] = G_BLUE;

                        SetPlayerColor(playerid,G_BLUE);

                    }

                    case 1:
                    {

                        GInfo[playerid][gangcolor] = G_RED;

                        SetPlayerColor(playerid,G_RED);
                    }

                    case 2:
                    {

                        GInfo[playerid][gangcolor] = G_WHITE;

                        SetPlayerColor(playerid,G_WHITE);
                    }

                    case 3:
                    {

                        GInfo[playerid][gangcolor] = G_PINK;

                        SetPlayerColor(playerid,G_PINK);
                    }

                    case 4:
                    {

                        GInfo[playerid][gangcolor] = G_CYAN;

                        SetPlayerColor(playerid,G_CYAN);
                    }

                    case 5:
                    {

                        GInfo[playerid][gangcolor] = G_ORANGE;

                        SetPlayerColor(playerid,G_ORANGE);
                    }

                    case 6:
                    {

                        GInfo[playerid][gangcolor] = G_GREEN;

                        SetPlayerColor(playerid,G_GREEN);
                    }

                    case 7:
                    {

                        GInfo[playerid][gangcolor] = G_YELLOW;

                        SetPlayerColor(playerid,G_YELLOW);
                    }

                }
            }

            else
            {
                GInfo[playerid][gangcolor] = -1;

                SetPlayerColor(playerid,-1);

            }

            new Query[116];

            format(Query,sizeof(Query),"UPDATE Gangs SET GangColor = %d Where GangName = '%q'",GInfo[playerid][gangcolor],GInfo[playerid][gangname]);

            db_query(Database,Query);

            SendGangMessage(playerid,""R"El líder ha cambiado el color del clan.");

            return 1;

        }

        case GCP:
        {
            if(response)
            {
                switch(listitem)
                {
                    case 0:return cmd_gcp(playerid);

                    case 1:return cmd_gcp(playerid);

                    case 2:return cmd_gmembers(playerid);

                    //case 3:return cmd_top(playerid);

                    case 4:return ShowPlayerDialog(playerid, GWAR, DIALOG_STYLE_INPUT, ""R"Escriba el nombre del enemigo", ""W"Debe ser exacto.", "Comenzar", "Cancelar");

                    case 5:return ShowPlayerDialog(playerid, GKICK, DIALOG_STYLE_INPUT, ""R"Kick Member", ""W"Ingrese nombre o ID", "Kick", "Cancel");

                    case 6:return ShowPlayerDialog(playerid, GTAG, DIALOG_STYLE_INPUT, ""R"Ingrese el tag", ""W"Ingrese el nuevo tag", "Poner", "Cancel");

                    case 7:return cmd_ccolor(playerid);

                    case 8:return ShowPlayerDialog(playerid, GLEADER, DIALOG_STYLE_INPUT, ""R"Ingrese nombre o ID", ""W"Será líder, cuidado. ", "Aceptar", "Cancel");
                }
            }
            return 1;
        }


        case GWAR :
        {
            if(response)
            {

                return cmd_gcw(playerid,inputtext);
            }
        }

        case GKICK:
        {
            if(response)
            {
                return cmd_gkick(playerid,inputtext);
            }
        }

        case GLEADER:
        {
            if(response)
            {
                return cmd_glider(playerid,inputtext);
            }
        }

        case GTAG:
        {
            if(response)
            {
                return cmd_gangtag(playerid,inputtext);
            }
        }


        case ZONECREATE:
        {
            if(response)
            {
                new query[160];

                format(query,sizeof query,"INSERT INTO Zones (Name,MinX,MinY,MaxX,MaxY) VALUES('%q','%f','%f','%f','%f')",inputtext,GInfo[playerid][minX],GInfo[playerid][minY],GInfo[playerid][maxX],GInfo[playerid][maxY]);
				printf(query);
                db_query(Database,query);

                new var = Iter_Free(Zones);

                ZInfo[var][ZminX] = GInfo[playerid][minX];

                ZInfo[var][ZminY] = GInfo[playerid][minY];

                ZInfo[var][ZmaxX] = GInfo[playerid][maxX];

                ZInfo[var][ZmaxY] = GInfo[playerid][maxY];

                format(ZInfo[var][Name],24,"%s",inputtext);

                strcpy(ZInfo[var][Owner],"");

                ZInfo[var][locked] = false;

                ZInfo[var][Owned] = false;

                ZInfo[var][Region]  = Area_AddBox(GInfo[playerid][minX],GInfo[playerid][minY], GInfo[playerid][maxX], GInfo[playerid][maxY]);

                ZInfo[var][_Zone] = GangZoneCreate(GInfo[playerid][minX],GInfo[playerid][minY], GInfo[playerid][maxX], GInfo[playerid][maxY]);

                Iter_Add(Zones, var);

                GangZoneShowForAll(ZInfo[var][_Zone],ZONE_COLOR);
            }
        }

    }
    return 1;
}


public OnPlayerDeath(playerid,killerid,reason)
{
//    SendDeathMessage(killerid, playerid, reason);

    if(killerid != INVALID_PLAYER_ID)
    {
        if(GInfo[playerid][inwar])
        {
            GInfo[playerid][inwar] = false;
            SetPVarInt(playerid, "MINION", 0);
            SetPlayerInterior(playerid,0);
			SetPlayerTeam(playerid,NO_TEAM);
            CheckVict(GInfo[playerid][gangname],GInfo[killerid][gangname]);
        }

        if(GInfo[playerid][gangmember] == 1)
        {
            new rvg[300];

            if(GInfo[killerid][gangmember] == 1)
            {
                //format(rvg,sizeof(rvg),""GREY"The member of your Gang "YELLOW"%s"GREY" has been killed by a Member "RED"(%s)"GREY" of Gang %s%s",GInfo[playerid][username],GInfo[killerid][username],IntToHex(GInfo[killerid][gangcolor]),GInfo[killerid][gangname]);

                new Query[120];
                 
                format(Query,sizeof(Query),"UPDATE Gangs SET GangScore = GangScore+1  WHERE GangName = '%q'",GInfo[killerid][gangname]);

                db_query(Database,Query);
            }

            else
            {
             //   format(rvg,sizeof(rvg),""GREY"The member of your Gang "RED"%s "GREY"has been killed by a Player Named "RED"%s ",GInfo[playerid][username],GInfo[killerid][username]);
            }

           // SendGangMessage(playerid,rvg);
        }
    }

    else
    {

        if(GInfo[playerid][inwar])
        {
            GInfo[playerid][inwar] = false;
			SetPVarInt(playerid, "MINION", 0);
			SetPlayerTeam(playerid,NO_TEAM);
			SetPlayerTeam(playerid,NO_TEAM);
            CheckVict(GInfo[playerid][gangname],"INVALID");
        }

    }

    return 1;

}
/*9


public OnPlayerUpdate(playerid) //By RyDer
{
    if(GInfo[playerid][creatingzone])
    {
        new keys,ud,lr;

        GetPlayerKeys(playerid,keys,ud,lr);
        

        if(lr == KEY_LEFT)
        {

            GInfo[playerid][minX] -= 6.0;

            GangZoneDestroy(GInfo[playerid][tempzone]);

            GInfo[playerid][tempzone] =  GangZoneCreate(GInfo[playerid][minX],GInfo[playerid][minY],GInfo[playerid][maxX],GInfo[playerid][maxY]);

            GangZoneShowForPlayer(playerid, GInfo[playerid][tempzone], ZONE_COLOR);

        }
        else
        if(lr == KEY_RIGHT)
        {

            GInfo[playerid][maxX] += 6.0;

            GangZoneDestroy(GInfo[playerid][tempzone]);

            GInfo[playerid][tempzone] =  GangZoneCreate(GInfo[playerid][minX],GInfo[playerid][minY],GInfo[playerid][maxX],GInfo[playerid][maxY]);

            GangZoneShowForPlayer(playerid, GInfo[playerid][tempzone],ZONE_COLOR);

        }

        else
        if(ud == KEY_UP)
        {

            GInfo[playerid][maxY] += 6.0;

            GangZoneDestroy(GInfo[playerid][tempzone]);

            GInfo[playerid][tempzone] =  GangZoneCreate(GInfo[playerid][minX],GInfo[playerid][minY],GInfo[playerid][maxX],GInfo[playerid][maxY]);

            GangZoneShowForPlayer(playerid, GInfo[playerid][tempzone], ZONE_COLOR);

        }

        else
        if(ud == KEY_DOWN)
        {

            GInfo[playerid][minY] -= 6.0;

            GangZoneDestroy(GInfo[playerid][tempzone]);

            GInfo[playerid][tempzone] =  GangZoneCreate(GInfo[playerid][minX],GInfo[playerid][minY],GInfo[playerid][maxX],GInfo[playerid][maxY]);

            GangZoneShowForPlayer(playerid, GInfo[playerid][tempzone], ZONE_COLOR);

        }


        else if(keys & KEY_WALK)
        {

            GInfo[playerid][creatingzone] = false;

            TogglePlayerControllable(playerid,true);

            ShowPlayerDialog(playerid,ZONECREATE,DIALOG_STYLE_INPUT,"Input Zone Name ","Input the name of this gang zone","Create","");

            GangZoneDestroy(GInfo[playerid][tempzone]);
        }
    }
    return 1;

}
*/
public OnPlayerEnterArea(playerid, areaid)
{
    foreach(new i : Zones)
    {
        if(areaid == ZInfo[i][Region])
        {
        	if(!Messages[playerid]) break;
            new str[128];
            
            if(isnull(ZInfo[i][Owner]))
            {

 //           format(str,sizeof str,"~y~Zone_Info~n~~b~Name:_~r~%s~n~~b~Status:_~r~Un_Owned",ZInfo[i][Name]);
	          format(str, sizeof str, "~w~~h~welcome to:~n~~g~~h~%s",ZInfo[i][Name]);
//            PlayerTextDrawSetString(playerid, GInfo[playerid][TextDraw],str);

            }
            else
            {

                //format(str,sizeof str,"~y~Zone_Info_~n~~b~Name:_~r~%s~n~~b~Status:_~r~Owned-by_~g~%s",ZInfo[i][Name],ZInfo[i][Owner]);
				format(str, sizeof str, "~w~~h~welcome to:~n~~r~~h~%s ~g~~h~%s",ZInfo[i][Owner],ZInfo[i][Name]);

                //PlayerTextDrawSetString(playerid, GInfo[playerid][TextDraw],str);

            }

            //PlayerTextDrawShow(playerid,GInfo[playerid][TextDraw]);
			GameTextForPlayer(playerid, str, 5000, 1);
            return 1;
        }

    }

    return 1;
}

public OnPlayerLeaveArea(playerid, areaid)
{

/*    foreach(new i : Zones)
    {
        if(areaid == ZInfo[i][Region])
        {

            if(GInfo[playerid][Capturing])
            {
			
			if(JoinCount < 2){
            new msg[200];

            GInfo[playerid][Capturing] = false;

            format(msg,sizeof msg,""Y"[Pura Joda] "W"%s "Y" falló capturando la zona"W"%s. No podrá ser capturada durante %d minuto(s)",GInfo[playerid][gangname],ZInfo[i][Name],((ZONE_LOCK_TIME)/60));

            KillTimer(ZInfo[i][timercap_main]);

            PlayerTextDrawHide(playerid,GInfo[playerid][TimerTD]);

            SendClientMessageToAll(-1,msg);

            ZInfo[i][timer] = ZONE_LOCK_TIME;

            ZInfo[i][locked] = true;

            ZInfo[i][timer_main] = SetTimerEx("UnlockZone",1000,true,"i",i);
            }

            ZInfo[i][U_Attack] = false;

            GangZoneStopFlashForAll(ZInfo[i][_Zone]);
            
            PlayerTextDrawHide(playerid, GInfo[playerid][TextDraw]);
            
            JoinCount = 0;
			}
        }
    }
*/
    return 1;
}




//--------------------------------COMMANDS---------------------------------------------------------------------------------------------------------------------------


CMD:cmensaje(playerid, params[]){
if(Messages[playerid]) {
SendClientMessage(playerid,-1, "Desactivado.");
Messages[playerid] = false;
}
else if(!Messages[playerid]){
SendClientMessage(playerid,-1,"Activado");
Messages[playerid] = true;
}
return 1;
}
CMD:crearclan(playerid,params[])
{
    new query[115],DBResult:result,string[128];

    

    if(GInfo[playerid][gangmember] == 1) return SendClientMessage(playerid,-1,""R"[Pura Joda] Ya estás en un clan.");

	if(GetPVarInt(playerid, "COIN")<14) return SendClientMessage(playerid, -1,""R"[Pura Joda] No tienes dinero pinche pobre.");
    
    if(isnull(params))return SendClientMessage(playerid,-1,""R"[Pura Joda] /crearclan [Nombre]");

    if(!strcmp(params,"INVALID",true)) return SendClientMessage(playerid,-1,""R"[Pura Joda] Por favor seleccione otro nombre.");

    format(query,sizeof(query),"SELECT GangName FROM Gangs WHERE GangName = '%q'",params);

    result = db_query( Database, query );

    if( db_num_rows( result ) )
    {
        db_free_result(result);

        return SendClientMessage(playerid,-1,""R"[Pura Joda] Ése nombre ya existe.");
    }
    db_free_result(result);

    GInfo[playerid][gangmember] = 1;

    format(GInfo[playerid][gangname], 32, params);

    GInfo[playerid][gangleader] = 1;

    ShowPlayerDialog(playerid,GANG_COLOR,DIALOG_STYLE_LIST,"Selecciona un color","Azul\nRojo\nBlanco\nRosado\nAzul claro\nNaranja\nVerde\nAmarillo","Ok","Cancel");


    new Query[217];

    format(Query,sizeof(query),"UPDATE Members SET GangName = '%q' ,GangMember = 1,GangLeader = 1 WHERE UserName = '%q' ",params,GInfo[playerid][username]);

    db_query( Database, Query );

    new gquery[190];

    format( gquery, sizeof( gquery ), "INSERT INTO Gangs (GangName,GangColor) VALUES ('%q','%q')", GInfo[ playerid ][ gangname ] ,GInfo[playerid][gangcolor]);

    db_query(Database,gquery);

   // SendClientMessage(playerid,-1,""RED"[CLAN INFO]:"GREY"You have sucessfully create a gang");

    format(string,sizeof(string),""Y"[Pura Joda] "W"%s"Y" ha creado un nuevo gang "W"%s",GInfo[playerid][username],GInfo[playerid][gangname]);

    SendClientMessageToAll(-1,string);
    
	SetPVarInt(playerid, "COIN",GetPVarInt(playerid, "COIN")-14);

    return 1;
}

CMD:aclan(playerid,params[])
{
    if(GInfo[playerid][gangmember] == 0) return SendClientMessage(playerid,-1,""R"[Pura Joda] No estás en un gang.");

    new gname [32],lquery[155] ;

    strcpy(gname,GInfo[playerid][gangname]) ;

    if(GInfo[playerid][gangleader] == 1)
    {
        foreach(new i : SS_Player)
        {
            if(!strcmp(GInfo[i][gangname],GInfo[playerid][gangname],false))
            {
                GInfo[i][gangmember] = 0;

                strdel(GInfo[i][gangname],0,32);

                if(GInfo[i][gangleader] == 1)
                {
                    GInfo[playerid][gangleader] = 0;
                }
            }
        }

        new  Query[105];

        format(Query,sizeof(Query),"DELETE FROM Gangs WHERE GangName = '%q'",gname);

        db_query(Database,Query);

        format(lquery,sizeof(lquery),"UPDATE Members SET GangMember = 0,GangLeader = 0,GangName = NULL WHERE GangName = '%q'",gname);

        db_query(Database,lquery);

        new str[128];

        format(str,sizeof(str),""Y"[Pura Joda] El líder "W"%s"Y" abandonó el clan "W"%s"Y" será destruido.",GInfo[playerid][username],gname);

        SetPlayerName(playerid,GInfo[playerid][username]);

        return SendClientMessageToAll(-1,str);
    }

    GInfo[playerid][gangmember] = 0;

    strcpy(GInfo[playerid][gangname],"");

    new query[102];

    format(query,sizeof(query),"UPDATE Members SET GangMember = 0,GangLeader = 0,GangName = NULL WHERE UserName = '%q'",GInfo[playerid][username]);

    db_query(Database,query);

    new ls[128];

    format(ls,sizeof(ls),""Y"[Pura Joda] "W"%s "Y"abandonó el clan "W"%s",GInfo[playerid][username],IntToHex(GInfo[playerid][gangcolor]),gname);

    SetPlayerName(playerid,GInfo[playerid][username]);
    
    SendClientMessageToAll(-1,ls);

    return 1;
}



CMD:glider(playerid,params[])
{
    new giveid,str[128],Query[256];

    if(sscanf(params,"u",giveid))return SendClientMessage(playerid,-1,""R"[Pura Joda] /gLider [id]");

    if(strcmp(GInfo[playerid][gangname],GInfo[giveid][gangname])) return SendClientMessage(playerid,-1,""R"[Pura Joda] No está en un gang.");

    if(GInfo[playerid][gangmember] == 0) return SendClientMessage(playerid,-1,""R"[Pura Joda] No estás en un gang.");

    if(GInfo[giveid][gangmember] == 0) return SendClientMessage(playerid,-1,""R"[Pura Joda] El jugador no está en ningún clan.");

    if(GInfo[giveid][gangleader] == 1) return SendClientMessage(playerid,-1,""R"[Pura Joda] El jugador ya tiene líder.");

    if(GInfo[playerid][gangleader] == 0) return SendClientMessage(playerid,-1,""R"[Pura Joda] Usted no tiene permiso.");

    if(giveid == INVALID_PLAYER_ID) return SendClientMessage(playerid,-1,""R"[Pura Joda] Jugador inválido.");

    GInfo[giveid][gangleader] = 1;

    format(str,sizeof(str),""Y"[Pura Joda] "W"%s"Y" ha sido ascendido a Líder del clan "W"%s",GInfo[giveid][username],GInfo[giveid][gangname]);

    SendClientMessageToAll(-1,str);

    format(Query,sizeof(Query),"UPDATE Members SET GangLeader = 1 WHERE UserName = '%q' ",GInfo[giveid][username]);

    db_query( Database, Query );

    return 1;
}
CMD:cstats(playerid, params[]){
new str[56], qery[130];
if(sscanf(params, "s[56]", str)) return SendClientMessage(playerid, -1, ""R"[Pura Joda] /gstats [NombreDelClan]");
format(qery, 130, "SELECT GangName, GangColor, GangScore FROM Members WHERE GangName = '%s',str");
return 1;
}
CMD:demote(playerid,params[])
{

    new giveid,str[128],Query[256];

    if(sscanf(params,"u",giveid))return SendClientMessage(playerid,-1,""R"[Pura Joda] /Demote [id]");

    if(strcmp(GInfo[playerid][gangname],GInfo[giveid][gangname])) return SendClientMessage(playerid,-1,""R"[Pura Joda] Usted no puede.");

    if(GInfo[playerid][gangmember] == 0) return SendClientMessage(playerid,-1,""R"[Pura Joda] No tienes clan.");

    if(GInfo[giveid][gangmember] == 0) return SendClientMessage(playerid,-1,""R"[Pura Joda] Este jugador no está en un clan");

    if(GInfo[giveid][gangleader] != 1) return SendClientMessage(playerid,-1,""R"[Pura Joda] Este jugador no es el líder.");

    if(GInfo[playerid][gangleader] == 0) return SendClientMessage(playerid,-1,""R"[Pura Joda] Usted no tiene permisos.");

    if(giveid == INVALID_PLAYER_ID) return SendClientMessage(playerid,-1,""R"[Pura Joda] Jugador inválido.");

    GInfo[giveid][gangleader] = 0;

    format(str,sizeof(str),""Y"[Pura Joda] "W"%s "Y"fue dado de baja (Líder) por "W"%s",GInfo[giveid][username],GInfo[giveid][gangname]);

    SendClientMessageToAll(-1,str);

    format(Query,sizeof(Query),"UPDATE Members SET GangLeader = 0 WHERE UserName = '%q' ",GInfo[giveid][username]);

    db_query( Database, Query );

    return 1;

}

CMD:ginvitar(playerid,params[])
{
    new giveid;

    if(sscanf(params,"u",giveid)) return SendClientMessage(playerid,-1,""R"[Pura Joda] /gInvitar [id]");

	if(!IsPlayerConnected(giveid)) return SendClientMessage(playerid, -1, ""R"[Pura Joda] Jugador no conectado.");

	if(GInfo[playerid][gangleader] == 0 ) return SendClientMessage(playerid,-1,""R"[Pura Joda] Usted no tiene permiso.");

    if(GInfo[giveid][gangmember] == 1) return SendClientMessage(playerid,-1,""R"[Pura Joda] Ya tiene clan.");

    GInfo[giveid][ganginvite] = true;
	new st[178];
    SendClientMessage(playerid,-1,""G"[Pura Joda] Invitación enviada con éxito.");
	format(st, 128, ""G"[Pura Joda] Has recibido una invitación para el clan %s "W"/aceptar "G"o "W"/rechazar",GInfo[playerid][gangname]);
    SendClientMessage(giveid, -1, st);
    strdel(GInfo[giveid][ginvitedname],0,32);

    strcat(GInfo[giveid][ginvitedname], GInfo[playerid][gangname], 32);

    return 1;
}

/*CMD:top(playerid)
{
    new query[256];

    new DBResult:result;

    format(query,sizeof(query),"SELECT GangName,GangScore FROM Gangs ORDER BY GangScore DESC limit 0,10");

    result = db_query( Database, query );

    new scores,name[30],string[250],color;
//	strcat();
	format(string, sizeof string, ""G"Bievenido "W"aquí los mejores clanes \nque tenemos en el momento.\n");
    for (new a,b=db_num_rows(result); a != b; a++, db_next_row(result))
    {
        db_get_field_assoc(result, "GangName", name, sizeof(name));

        scores = db_get_field_assoc_int(result, "GangScore");

        color = db_get_field_assoc_int(result, "GangColor");
  		if(a == 0) format(string,sizeof(string),"%s\n"W"%d. "G"%s - %i", string, a + 1,name, scores);
  		else  format(string,sizeof(string),"%s\n"W"%d. %s - %i", string, a + 1, name, scores);
    }

    ShowPlayerDialog(playerid, GTOP, DIALOG_STYLE_MSGBOX, ""R"Top Clanes ", string, "Close", "");

    db_free_result(result);

    return 1;
}
*/

CMD:gmembers(playerid)
{
    new Query[256],name[30],string[1254];

    new DBResult:result;

    if(GInfo[playerid][gangmember] == 0) return SendClientMessage(playerid,-1,""R"[Pura Joda] No tienes clan.");

    format(Query,sizeof(Query),"SELECT UserName FROM Members WHERE GangName = '%q'",GInfo[playerid][gangname]);

    result = db_query(Database,Query);

    for (new a,b= db_num_rows(result); a !=b; a++, db_next_row(result))
    {

        db_get_field_assoc(result, "UserName", name, sizeof(name));

        format(string,sizeof(string),"%s\n"W"%d.)"R" %s ",string,a + 1,name);
    }

    ShowPlayerDialog(playerid, GMEMBERS, DIALOG_STYLE_MSGBOX, ""R"Miembros ", string, "Cerrar", "");

    db_free_result(result);

    return 1;
}


CMD:rechazar(playerid)
{
    if(GInfo[playerid][ganginvite] == false) return SendClientMessage(playerid,-1,""R"[Pura Joda] No has recibido ninguna invitación");

    SendClientMessage(playerid,-1,"[Pura Joda] Has rechazado la oferta.");

    GInfo[playerid][ganginvite] = false;

    return 1;
}

CMD:aceptar(playerid)
{
    new Query[140];

    if(GInfo[playerid][ganginvite] == false) return SendClientMessage(playerid,-1,""R"[Pura Joda] No tienes ningun invitación.");

    SendClientMessage(playerid,-1,""G"[Pura Joda] ¡Enhorabuena! Ahora tienes clan.");

    GInfo[playerid][gangmember] = 1;

    strdel(GInfo[playerid][gangname],0,56);

    strcat(GInfo[playerid][gangname],GInfo[playerid][ginvitedname],32);

    GInfo[playerid][ganginvite] = false;

    format(Query,sizeof(Query),"UPDATE Members SET GangMember = 1,GangLeader = 0,GangName = '%q' WHERE UserName = '%q' ",GInfo[playerid][gangname],GInfo[playerid][username]);

    db_query( Database, Query );

    new query[128],DBResult:result;
	foreach(new i : SS_Player){
	if(!strcmp(GInfo[playerid][gangname], GInfo[i][gangname])){
	format(Query, sizeof Query, ""Y"[Pura Joda] "W"%s se ha unido a tu clan.",PlayerName2(playerid));
	SendClientMessage(i, -1, Query);
	}
	}
    format(query,sizeof(query),"SELECT * FROM Gangs Where GangName = '%q'",GInfo[playerid][gangname]);

    result = db_query(Database,query);

    if(db_num_rows(result))
    {
        db_get_field_assoc(result,"GangColor",query,10);

        GInfo[playerid][gangcolor] = strval(query);

        SetPlayerColor(playerid,GInfo[playerid][gangcolor]);

        db_free_result( result );
    }

    return 1;
}
stock PlayerName2(playerid){
new strin[24];
GetPlayerName(playerid, strin, 24);
return strin;
}
CMD:gbase(playerid,params[])
{
if(GInfo[playerid][gangleader] == 0) return SendClientMessage(playerid,-1,""R"[Pura Joda] Usted no tiene permiso");
new quer[168],rwesult[40];
format(quer, 168, "SELECT GangSpawnX FROM Gangs WHERE GangName = '%s'",GInfo[playerid][gangname]);
new DBResult:r = db_query(Database, quer);
db_get_field_assoc(r, "GangSpawnX", rwesult, 40);
if(isnull(rwesult))
{
	new Float:eX, Float:eY, Float:eZ;
	GetPlayerPos(playerid, eX, eY, eZ);
	
	format(quer, 168, "UPDATE Gangs SET GangSpawnX = '%f', GangSpawnY = '%f', GangSpawnZ = '%f' WHERE GangName = '%s'", eX,eY,eZ,GInfo[playerid][gangname]);
	db_free_result(db_query(Database, quer));
	printf(quer);
	SendClientMessage(playerid, -1, "Listo");
	foreach(new i : SS_Player){
	
	if(!strcmp(GInfo[playerid][gangname], GInfo[i][gangname])){
	GInfo[i][Spawn] = true;
	GInfo[i][sX] = eX;
	GInfo[i][sY] = eY;
	GInfo[i][sZ] = eZ;

	}
}

}
else {
format(quer, 128, "UPDATE Gangs SET GangSpawnX = NULL, GangSpawnY = NULL, GangSpawnZ = NULL WHERE GangName = '%s'",GInfo[playerid][gangname]);
db_free_result(db_query(Database, quer));
SendClientMessage(playerid, -1, "Cancelada");

}
db_free_result(r);
return 1;
}
CMD:gkick(playerid,params[])
{
    new Query[300],giveid,str[128+24];

    if(sscanf(params,"u",giveid)) return SendClientMessage(playerid,-1,""R"[Pura Joda] /gKick ID");

    if(GInfo[playerid][gangmember] == 0) return SendClientMessage(playerid,-1,""R"[Pura Joda] Usted no es miembro");

    if(GInfo[playerid][gangleader] == 0) return SendClientMessage(playerid,-1,""R"[Pura Joda] Usted no tiene permiso");

    if(GInfo[giveid][gangleader] == 1) return SendClientMessage(playerid,-1,""R"[Pura Joda] Usted no puede sacar un líder.");

	if(strcmp(GInfo[giveid][gangname], GInfo[playerid][gangname], true) != 0) return SendClientMessage(playerid, -1, ""R"[Pura Joda] No es de su gang.");

	if(isnull(GInfo[giveid][gangname])) return SendClientMessage(playerid, -1, "Únicamente miembros de su clan");
    GInfo[giveid][gangmember] = 0;

    format(Query,sizeof(Query),"UPDATE Members SET GangMember = 0,GangName = NULL WHERE UserName = '%q' ",GInfo[giveid][username]);

    db_query( Database, Query );

    format(str,sizeof(str),""Y"[Pura Joda] "W"%s"Y" ha sido kickeado del clan "W"%s "Y"por "Y"%s",GInfo[giveid][username],GInfo[playerid][gangname],GInfo[playerid][username]);

    SendClientMessageToAll(-1,str);

    return 1;
}
//AQUI VOY
CMD:gangtag(playerid,params[])
{
    new newname[24],Query[245];

    if(GInfo[playerid][gangmember] == 0) return SendClientMessage(playerid,-1,""R"[Pura Joda] No eres parte de un clan.");

    if(GInfo[playerid][gangleader] == 0) return SendClientMessage(playerid,-1,""R"[Pura Joda] No tiene suficientes permisos.");

    if(isnull(params)) return SendClientMessage(playerid,-1,""R"[Pura Joda] /clantag [tag] 1 - 2 Carácteres");

    if(strlen(params)>2) return SendClientMessage(playerid,-1,""R"[Pura Joda] Máximo dos carácteres");

    format(Query,sizeof(Query),"UPDATE Gangs SET GangTag = '%q' WHERE GangName = '%q'",params,GInfo[playerid][gangname]);

    db_query(Database,Query);

    foreach(new i : SS_Player)
    {
        if(!strcmp(GInfo[i][gangname],GInfo[playerid][gangname],false))
        {

            GetPlayerName(i,newname,24);

            format(newname,sizeof(newname),"[%s]%s",params,newname);

            SetPlayerName(i,newname);

            SendClientMessage(i,-1,""R"[Pura Joda] El líder ha cambiado el tag.");
        }
    }

    return 1;
}

CMD:ccolor(playerid)
{
    ShowPlayerDialog(playerid,GANG_COLOR,DIALOG_STYLE_LIST,"Gang Color","Azul\nRojo\nBlanco\nRosa\nAzul claro\nNaranja\nVerde\nAmarillo","Ok","Cancel");

    return 1;
}
CMD:ghelp(playerid, params[]){
new string[700];
strcat(string, ""R"Bienvenido al sistema de clanes "W"Pura Joda\n\n"W"1. "R"/CrearClan Creas un clan\n");
strcat(string, ""W"2.  "R"/aClan - Abandonas un clan\n");
strcat(string, ""W"3.  "R"/gLider - ortorgas líder a un user\n");
strcat(string, ""W"4.  "R"/demote - Quitas líder a un usuario\n");
strcat(string, ""W"5.  "R"/gInvitar - Invitas un usuario a tu clan\n");
strcat(string, ""W"6.  "R"/gCP - Ves el estado del clan\n");
strcat(string, ""W"7.  "R"/gCW - Convocas una Clan War\n");
strcat(string, ""W"8.  "R"/cColor - Das un color al clan\n");
strcat(string, ""W"9.  "R"/gKick - Expulsas un miembro del clan\n");
strcat(string, ""W"10. "R"/Top - Vez top clanes\n");
strcat(string, ""W"11. "R"/Capture - Capturas una zona\n");
ShowPlayerDialog(playerid,1,DIALOG_STYLE_MSGBOX,""R"Ayuda",string,"Ok","Cancel");

return 1;
}

CMD:gcw(playerid,params[])
{
	if(Solicited) return SendClientMessage(playerid, -1,"[Pura Joda] Se encuentra en solicitud una CW.");
	
    if(GInfo[playerid][gangmember] == 0) return SendClientMessage(playerid,-1,""R"[Pura Joda] Usted no es miembro del clan");

    if(GInfo[playerid][gangleader] == 0) return SendClientMessage(playerid,-1,""R"[Pura Joda] No tiene suficientes permisos.");

    if(ActiveWar == true) return SendClientMessage(playerid,-1,""R"[Pura Joda] CW en progreso.");

    new cc,c1,nombre[24],tempid,p, namegang[40], sting[456], namee[140];

	if(sscanf(params, "i",optiongun[playerid])) return SendClientMessage(playerid, -1, ""R"[Pura Joda] /gCW [Armas RW = 0, WW2 = 1]");

	if(optiongun[playerid] != 0 && optiongun[playerid] != 1) return SendClientMessage(playerid, -1, "[Pura Joda] Seleccione una opción de armas válida.");

	if(!strcmp(params,"INVALID")) return 0;
	new stin[400], sep[128];
	for(new i; i < 5; i++)
	{
		if(members[playerid][i] == -1)
		{
		format(sep, 128, ""G"<Slot Libre>\n");
		strcat(stin, sep);
		}
		else
		{
		format(sep, 128, ""R"%s\n",PlayerName2(members[playerid][i]));
		strcat(stin, sep);
		}
	}
	strcat(stin, ""R"Solicitar CW "W"/  "G"Aceptar CW");
	ShowPlayerDialog(playerid, DIALOG_CW, DIALOG_STYLE_LIST, "Seleccione los miembros", stin, "Ok", "Cancelar");

/*	for(new i; i < 3; i++){
	
	if(!IsPlayerConnected(members[i]) || members[i] == INVALID_PLAYER_ID)  return SendClientMessage(playerid, -1, ""R"[Pura Joda] Usuarios válidos.");

	if(!strcmp(GInfo[playerid][gangname], GInfo[i][gangname], true)) continue;
 	else return SendClientMessage(playerid, -1, ""R"[Pura Joda] Únicamente miembros de su clan.");
	}
	new id = -1;

	foreach(new i : SS_Player)
	{
	if(!strcmp(GInfo[i][gangname], namegang, true))
	    if(GInfo[i][gangleader] == 1){
  		id = i;
		break;
	    }
	}
	if(id == -1) return SendClientMessage(playerid, -1, "[Pura Joda] El líder no está conectado / el clan no existe.");

//	Iter_Add(CW_PLAYER,playerid);
//	for(new i; i < 3; i++) Iter_Add(CW_PLAYER,members[i]);
 	new Guns[4];

	if(optiongun) format(Guns, sizeof Guns, "WW2");
	else format(Guns, sizeof Guns, "RW");

	format(namee, sizeof namee, ""Y"[Pura Joda] clan "W"%s convocó una CW 4v4 Armas: "W"%s "Y"/gacept [ID Member] [ID Member] [ID Member] ",GInfo[playerid][gangname], Guns);
	SendClientMessage(id, -1, namee);
	SendClientMessage(id, -1, "[Pura Joda] /gcancel para denegar la cw. Tiene 1 minuto para aceptar, en su contrario será desechada.");
	Convoqued[id] = true;
	idsoli = playerid;
	SendClientMessage(playerid, -1, "Invitación enviada con éxito");
	Solicited = true;
	timered = SetTimerEx("Invitation",60000,false,"u",playerid);
  */  return 1;
}

forward Invitation(playerid);
public Invitation(playerid){
Iter_Clear(CW_PLAYER);

Iter_Clear(CW_PLAYER2);

SendClientMessage(idsoli, -1, "[Pura Joda] La cw expiró.");

Convoqued[playerid] = false;

ActiveWar = false;

Solicited = false;

idsoli = -1;
return 1;
}

CMD:gcancel(playerid, params[]){

if(!Convoqued[playerid]) return SendClientMessage(playerid, -1, ""R"[Pura Joda] Usted no tiene invitación a CW.");

SendClientMessage(idsoli, -1, "[Pura Joda] La cw fue rechazada.");

KillTimer(timered);

Convoqued[playerid] = false;

ActiveWar = false;

Solicited = false;

idsoli = -1;

for(new i; i < 5; i++)
{
members[playerid][i] = -1;
members[idsoli][i] = -1;
}
return 1;
}

CMD:gacept(playerid, params[])
{

if(!Convoqued[playerid]) return SendClientMessage(playerid, -1, ""R"[Pura Joda] Usted no tiene invitación a CW.");


//if(sscanf(params, "uuu",memb[0], memb[1], memb[2])) return SendClientMessage(playerid, -1, ""R"[Pura Joda] /gacept [Miembro ID] [Miembro ID] [Miembro ID]");

/*for(new i; i < 3; i++){

if(!IsPlayerConnected(members[i]) || members[i] == INVALID_PLAYER_ID)  return SendClientMessage(playerid, -1, ""R"[Pura Joda] Usuarios válidos.");

//if(strcmp(GInfo[playerid][gangname], GInfo[i][gangname], true) == 1 || strcmp(GInfo[playerid][gangname], GInfo[i][gangname], true) == -1)  return SendClientMessage(playerid, -1, ""R"[Pura Joda] Únicamente miembros de su clan.");
Iter_Add(CW_PLAYER2, memb[i]);
}

Iter_Add(CW_PLAYER2, playerid);*/
new oe;
new stin[400], sep[128];

for(new i; i < 5; i++)
{
if(members[playerid][i] == -1)
{
format(sep, 128, ""G"<Slot Libre>\n");
strcat(stin, sep);
}
else
{
format(sep, 128, ""R"%s\n",PlayerName2(members[playerid][i]));
strcat(stin, sep);
}
}
strcat(stin, ""R"Solicitar CW "W"/  "G"Aceptar CW");
ShowPlayerDialog(playerid, DIALOG_CW, DIALOG_STYLE_LIST, "Seleccione los miembros", stin, "Ok", "Cancelar");

/*foreach(new pu: CW_PLAYER)
{
	if(IsPlayerInAnyVehicle(pu)){
	GetPlayerPos(pu,xe,y,z); SetPlayerPos(pu,xe,y,z+5); PlayerPlaySound(pu,1190,0.0,0.0,0.0);}
	if(IsPlayerInAnyVehicle(pu)){
	GetPlayerPos(pu,xe,y,z); SetPlayerPos(pu,xe,y,z+5); PlayerPlaySound(pu,1190,0.0,0.0,0.0);}
    SetPlayerColor(pu, G_RED);
	GInfo[pu][inwar] = true;
	new Random = random(sizeof(RandomSpawnsGW));
	SetPlayerPos(pu,RandomSpawnsGW[Random][0], RandomSpawnsGW[Random][1], RandomSpawnsGW[Random][2]);
	SetPlayerInterior(pu,1);
	if(optiongun)
	ShowPlayerDialog(playerid, DIALOG_GUN, DIALOG_STYLE_TABLIST_HEADERS, "Selecciona un paquete de armas",\
	""G"ID\t"G"Arma primaria\t"G"Arma secundaria\n\
	1\tSniper Rifle\tShotgun\n\
	2\tDesert Eagle\tShotgun\n\
	3\tDesert Eagle\tSniper Rifle","Seleccionar", "Cancelar");
	else if(!optiongun)
	ShowPlayerDialog(playerid, DIALOG_GUN, DIALOG_STYLE_TABLIST_HEADERS, "Selecciona un paquete de armas",\
	""G"ID\t"G"Arma primaria\t"G"Arma secundaria\n\
	1\tSawnoff Shotgun\tMicro Uzi\n\
	2\tSawnoff Shotgun\tTec9\n\
	3\tMicro Uzi\tTec9","Seleccionar", "Cancelar");


	SetPlayerVirtualWorld(pu, 10);
	ResetPlayerWeapons(pu);
	TogglePlayerControllable(pu, false );
    SetPlayerTeam(pu,1);
    oe = pu;
}
foreach(new p: CW_PLAYER2)
{
	if(IsPlayerInAnyVehicle(p)){
	GetPlayerPos(p,xe,y,z); SetPlayerPos(p,xe,y,z+5); PlayerPlaySound(p,1190,0.0,0.0,0.0);}
	if(IsPlayerInAnyVehicle(p)){
	GetPlayerPos(p,xe,y,z); SetPlayerPos(p,xe,y,z+5); PlayerPlaySound(p,1190,0.0,0.0,0.0);}
    SetPlayerColor(p, G_BLUE);
	GInfo[p][inwar] = true;
	new Random = random(sizeof(RandomSpawnsGW));
	SetPlayerPos(p,RandomSpawnsGW[Random][0], RandomSpawnsGW[Random][1], RandomSpawnsGW[Random][2]);
	SetPlayerInterior(p,1);
	if(optiongun)
	ShowPlayerDialog(playerid, DIALOG_GUN, DIALOG_STYLE_TABLIST_HEADERS, "Selecciona un paquete de armas",\
	""G"ID\t"G"Arma primaria\t"G"Arma secundaria\n\
	1\tSniper Rifle\tShotgun\n\
	2\tDesert Eagle\tShotgun\n\
	3\tDesert Eagle\tSniper Rifle","Seleccionar", "Cancelar");
	else if(!optiongun)
	ShowPlayerDialog(playerid, DIALOG_GUN, DIALOG_STYLE_TABLIST_HEADERS, "Selecciona un paquete de armas",\
	""G"ID\t"G"Arma primaria\t"G"Arma secundaria\n\
	1\tSawnoff Shotgun\tMicro Uzi\n\
	2\tSawnoff Shotgun\tTec9\n\
	3\tMicro Uzi\tTec9","Seleccionar", "Cancelar");
	SetPlayerVirtualWorld(p, 10);
	ResetPlayerWeapons(p);
	TogglePlayerControllable(p, false );
    SetPlayerTeam(p,2);
}

SetTimerEx("GangWar",10000,false,"uu",playerid,members[0]);

new str[128];
format(str,sizeof(str),""Y"[Pura Joda] En 10 segundos comenzará Clan War "W"%s "Y"vs "W"%s",GInfo[playerid][gangname],GInfo[members[0]][gangname]);

SendClientMessageToAll(-1,str);

Convoqued[playerid] = false;
KillTimer(timered);*/
return 1;
}
CMD:gcp(playerid)
{

    if(GInfo[playerid][gangmember] == 0) return SendClientMessage(playerid,-1,""R"[Pura Joda] No eres miembro de clan.");

    new str[300],Query[80],DBResult:Result,GScore = -1;

    format(Query,sizeof(Query),"SELECT GangScore FROM Gangs WHERE GangName = '%q'",GInfo[playerid][gangname]);

	Result = db_query(Database, Query);
	
    if( db_num_rows( Result ) )
    {
        db_get_field_assoc( Result, "GangScore", Query, 80);

        GScore = strval(Query);

        db_free_result( Result );
    }


    format(str,sizeof(str),""R"Nombre del clan\t:\t"W"%s\n"R"Score\t:\t"W"%d\n"R"Miembros del clan\n"R"Top clanes\n"R"CW\n"R"Expulsar miembro\n"R"Cambiar tag\n"R"Cambiar color\n"R"Dar líder",GInfo[playerid][gangname],GScore);

    ShowPlayerDialog(playerid,GCP,DIALOG_STYLE_LIST,""R"Panel del control",str,"Ok","Cancel");

    return 1;
}

CMD:createzone(playerid,params[])
{
    if(!IsPlayerAdmin(playerid)) return 0;

    if(GInfo[playerid][creatingzone])return SendClientMessage(playerid,-1,""R"Ya está creando una zona por favor presione ALT.");

    if(!GInfo[playerid][creatingzone])
    {
        new Float:tempz;

        GetPlayerPos(playerid, GInfo[playerid][minX], GInfo[playerid][minY], tempz);

        GetPlayerPos(playerid, GInfo[playerid][maxX], GInfo[playerid][maxY], tempz);

        SendClientMessage(playerid,-1,"Use "Y" Left,Right Forward and Backward "R"keys to change size of zone");

        SendClientMessage(playerid,-1,"Use "Y"walk "R"key to stop the process");
        
        GInfo[playerid][creatingzone] = true;

        GInfo[playerid][tempzone] = -1;
        
        TogglePlayerControllable(playerid,false);
        
        return 1;
    }
    
    
    return 1;
}
new Li[24];
CMD:capture(playerid)
{

    if(GInfo[playerid][gangmember] == 0) return SendClientMessage(playerid,-1,""R"[Pura Joda] Usted no tiene clan");

    new bool:inzone = false,i,bool:roto = false;

    foreach( i : Zones)
    {
  		if(IsPlayerInArea(playerid, ZInfo[i][ZminX] ,ZInfo[i][ZminY],ZInfo[i][ZmaxX],ZInfo[i][ZmaxY]))
		{
		inzone = true;
		Coords[playerid][0] = ZInfo[i][ZminX];
		Coords[playerid][1] = ZInfo[i][ZminY];
		Coords[playerid][2] = ZInfo[i][ZmaxX];
		Coords[playerid][3] = ZInfo[i][ZmaxY];
		break;
		}

     }

    if(!inzone) return SendClientMessage(playerid,-1,""R"[Pura Joda] No estás en la zona.");

    if(ZInfo[i][locked])
    {
        new str[100];

        format(str,sizeof str,""R"[Pura Joda] Esta zona está protegida, vuelva en "W"%d "R"seconds ",ZInfo[i][timer]);

        return SendClientMessage(playerid,-1,str);
    }

    if(GInfo[playerid][Capturing]) return SendClientMessage(playerid,-1,""R"[Pura Joda] Ya estás capturandola");

    if(ZInfo[i][U_Attack]) return SendClientMessage(playerid,-1,""R"[Pura Joda] Esta zona ya está siendo atacada.");

    if(!strcmp(ZInfo[i][Owner],GInfo[playerid][gangname],true)&&!isnull(ZInfo[i][Owner])) return SendClientMessage(playerid,-1,""R"[Pura Joda] Esta zona ya es suya.");

    GangZoneFlashForAll(ZInfo[i][_Zone], HexToInt("FF0000AA"));

    GInfo[playerid][Capturing] = true;

    ZInfo[i][U_Attack] = true;

    new string[150];

    format(string,sizeof string,""Y"[Pura Joda] clan "W"%s "Y"está atacando la zona "W"%s",GInfo[playerid][gangname],ZInfo[i][Name]);

    SendClientMessageToAll(-1,string);

    ZInfo[i][timercap] = ZONE_CAPTURE_TIME;

	format(Li, sizeof Li, "%s",GInfo[playerid][gangname]);

    ZInfo[i][timercap_main] = SetTimerEx("CaptureZone", 1000, true, "uiffff", playerid, i, Coords[playerid][0],Coords[playerid][1],Coords[playerid][2],Coords[playerid][3]);

    return 1;
}

/*CMD:zones(playerid)
{
   new string[3900];

   foreach(new i : Zones)
   {
        if(isnull(ZInfo[i][Owner]))
        format(string,sizeof string,"%s"G"%d."R"%s\n",string,(i+1),ZInfo[i][Name]);

        else
        format(string,sizeof string,"%s"G"%d)"R"%s"Y" %s(%s)\n",string,(i+1),ZInfo[i][Name],IntToHex(ZInfo[i][Color]),ZInfo[i][Owner]);

   }

   ShowPlayerDialog(playerid,ZONES,DIALOG_STYLE_MSGBOX,""O"Zones"P"           Owned By",string,"Cancel","");

   return 1;
}
*/
//-------------------------------------------------------------------------------------------------------------------------------------------------------------------------




//-Custom Functions--------------------------------------------------------------------------------------------------------------------------------------------------------
new bool:option = true;

forward CaptureZone(playerid,zoneid, Float: Coords1, Float: Coords2, Float: Coords3, Float: Coords4);
public CaptureZone(playerid,zoneid, Float: Coords1, Float: Coords2, Float: Coords3, Float: Coords4)
{
	new Counter,Float:xe,Float:y,Float:z;
	foreach(new op : SS_Player)
	{
    	if(!strcmp(GInfo[op][gangname],GInfo[playerid][gangname]))
    	{
    	    if(!strcmp(GInfo[op][gangname],"null", true)) continue;
   			if(IsPlayerInArea(op, Coords1, Coords2, Coords3, Coords4))
		    {
			Counter++;
			PlayerTextDrawShow(op,GInfo[playerid][TimerTD]);
			if(option) SetPlayerColor(op, G_RED),option = false;
			else SetPlayerColor(op, G_WHITE), option = true;
			if(IsPlayerInAnyVehicle(op)) {GetPlayerPos(op,xe,y,z); SetPlayerPos(op,xe,y,z+5); PlayerPlaySound(op,1190,0.0,0.0,0.0);}
   			}
    	}
	}
	if(Counter < 3)
			{
            GInfo[playerid][Capturing] = false;

			new msg[160];
			
            format(msg,sizeof msg,""Y"[Pura Joda] "W"%s "Y" falló capturando la zona "W"%s. No podrá ser capturada durante %d minuto(s)",GInfo[playerid][gangname],ZInfo[zoneid][Name],((ZONE_LOCK_TIME)/60));

            KillTimer(ZInfo[zoneid][timercap_main]);

            PlayerTextDrawHide(playerid,GInfo[playerid][TimerTD]);

            SendClientMessageToAll(-1,msg);

            ZInfo[zoneid][timer] = ZONE_LOCK_TIME;

            ZInfo[zoneid][locked] = true;

            ZInfo[zoneid][timer_main] = SetTimerEx("UnlockZone",1000,true,"i",zoneid);

            ZInfo[zoneid][U_Attack] = false;

            GangZoneStopFlashForAll(ZInfo[zoneid][_Zone]);

            PlayerTextDrawHide(playerid, GInfo[playerid][TextDraw]);

			return 1;
			}

    ZInfo[zoneid][timercap]--;

    new str[34];

    format(str,sizeof str,"%02d:%02d",(ZInfo[zoneid][timercap]/60),ZInfo[zoneid][timercap]);
    
    PlayerTextDrawSetString(playerid, GInfo[playerid][TimerTD],str);

    

    if(ZInfo[zoneid][timercap]==0)
    {

        new string[128];

        format(string,sizeof string,""Y"[Pura Joda] Tu zona ha sido capturada por "W"%s ",GInfo[playerid][gangname]);
        

        PlayerTextDrawHide(playerid,GInfo[playerid][TimerTD]);

        foreach(new i : SS_Player)
        {
            if(!strcmp(ZInfo[zoneid][Owner],GInfo[i][gangname]))
            {

                SendClientMessage(i,-1,string);

            }

        }

        if(ZInfo[zoneid][U_Attack])
        {

            GangZoneStopFlashForAll(ZInfo[zoneid][_Zone]);

            new colour[9],colour2[10];


            format(colour2,sizeof colour2,"%06x", GInfo[playerid][gangcolor] >>> 8);

            format(colour, sizeof colour, "%s50", colour2);

            GangZoneShowForAll(ZInfo[zoneid][_Zone], HexToInt(colour));

            format(ZInfo[zoneid][Owner],24,"%s",GInfo[playerid][gangname]);

            ZInfo[zoneid][locked] = true;

        


            ZInfo[zoneid][Color] = HexToInt(colour);

            new Query_[300],msg[150];

            format(Query_,sizeof Query_,"UPDATE Zones SET Owner = '%q',Color = %i WHERE Name = '%q'",ZInfo[zoneid][Owner],ZInfo[zoneid][Color],ZInfo[zoneid][Name]);

            db_query(Database,Query_);

            format(msg,sizeof msg,""Y"[Pura Joda] "W"%s "Y"ha capturado "W"%s.  "Y"Estará segura por "W"%d "Y"minuto(s)",GInfo[playerid][gangname],ZInfo[zoneid][Name],((ZONE_LOCK_TIME)/60));

            SendClientMessageToAll(-1,msg);

            ZInfo[zoneid][timer] = ZONE_LOCK_TIME;

            ZInfo[zoneid][timer_main] = SetTimerEx("UnlockZone",1000,true,"i",zoneid);

            ZInfo[zoneid][U_Attack] = false;

            GInfo[playerid][Capturing] = false;

        

           /* new Query[180];

            format(Query,sizeof(Query),"UPDATE Gangs SET GangScore = GangScore+10 WHERE GangName = '%q'",GInfo[playerid][gangname]);

            db_query(Database,Query);
*/
        }

        KillTimer(ZInfo[zoneid][timercap_main]);

     }

    return 1;
}

forward UnlockZone(zoneid);

public UnlockZone(zoneid)
{

    ZInfo[zoneid][timer]--;

    if(ZInfo[zoneid][timer] == 0)
    {

        KillTimer(ZInfo[zoneid][timer_main]);

        ZInfo[zoneid][locked] = false;

    }

    return 1;
}



forward GangWar(playerid,enemyid);

public GangWar(playerid,enemyid)
{
    
    new count1,count2;
    foreach(new i : SS_Player)
    {
        if(!strcmp(GInfo[playerid][gangname],GInfo[i][gangname]) && GInfo[i][inwar])
        {
            
          /*  GivePlayerWeapon(i,34,100);
            
            GivePlayerWeapon(i,24,1000);
            
            GivePlayerWeapon(i,25,1000);
            
            GivePlayerWeapon(i,29,1000);

		  */SetPVarInt(i, "MINION", 1);

            SetPlayerHealth(i,100);

            SetPlayerArmour(i,100);

            TogglePlayerControllable( i, true );

            GameTextForPlayer(i, "~W~La guerra ha comenzado", 5000, 5);

            count1++;
        }
		else
        if(!strcmp(GInfo[enemyid][gangname],GInfo[i][gangname]) && GInfo[i][inwar])
        {
            
/*            GivePlayerWeapon(i,34,1000);

            GivePlayerWeapon(i,24,1000);

            GivePlayerWeapon(i,25,1000);

            GivePlayerWeapon(i,29,1000);

*/
            SetPlayerHealth(i,100);

            SetPlayerArmour(i,100);
            
            SetPVarInt(i, "MINION", 1);

            TogglePlayerControllable( i, true );

            GameTextForPlayer(i, "~w~La guerra ha comenzado", 5000, 5);

            count2++;

        }
    }

    if(count1 ==0 || count2 ==0)
    {
       
        foreach(new i : SS_Player)
        {
            if(GInfo[i][inwar] == true)
            {

                GInfo[i][inwar] = false;
				SetPVarInt(i, "MINION", 0);
                SpawnPlayer(i);
            }
        }
		Iter_Clear(CW_PLAYER);
		Iter_Clear(CW_PLAYER2);
        ActiveWar = false;
        Solicited = false;
		idsoli = -1;
        return SendClientMessageToAll(-1,""R"[Pura Joda] La guerra terminó.");
    }

    return 1;
}


forward GMoney(playerid);

public GMoney(playerid)
{

    GivePlayerMoney(playerid,100);

    GameTextForPlayer(playerid,"~w~RECIEVED ~g~100$ ~w~FROM GANG HQ FOR YOUR SERVICE",5000,5);

    return 1;
}



forward FullyConnect(playerid);

public FullyConnect(playerid)
{
    if(!isnull(GInfo[playerid][gangtag]))
    {

        new newname[24];

        format(newname,sizeof newname,"%s[%s]",GInfo[playerid][username],GInfo[playerid][gangtag]);

        SetPlayerName(playerid,newname);

        SetPlayerColor(playerid,GInfo[playerid][gangcolor]);
    }

    return 1;

}

SendGangMessage(playerid,Message[])
{
    foreach(new i : SS_Player)
    {
        if(!strcmp(GInfo[playerid][gangname],GInfo[i][gangname],false)&& !isnull(GInfo[i][gangname]))
        {
            SendClientMessage(i,-1,Message);
        }
    }
    return 0;
}


IsPlayerInArea(playerid, Float:MinX, Float:MinY, Float:MaxX, Float:MaxY)
{
    new Float:Xe, Float:Ye, Float:Ze;

    GetPlayerPos(playerid, Xe, Ye, Ze);

    if(Xe >= MinX && Xe <= MaxX && Ye >= MinY && Ye <= MaxY) {
        return 1;
    }

    return 0;
}


CheckVict(gname1[],gname2[])
{
    new count1,count2,pid,eid;
  
    foreach(new i : SS_Player)
    {
        if(GInfo[i][inwar] == true)
        {
            if(!strcmp(gname1,GInfo[i][gangname]) || !strcmp(gname1,"INVALID"))
            {
                pid = i;
                
                count1++;
            }

            if(!strcmp(gname2,GInfo[i][gangname]) || !strcmp(gname2,"INVALID"))
            {
                eid = i;
                
                count2++;
            }
        }
    }

    if(count1 ==0 || count2 ==0)
    {
        new winner[32];
        
        foreach(new i : SS_Player)
        {
            if(GInfo[i][inwar])
            {
                
                GInfo[i][inwar] = false;

                SetPlayerInterior(i,0);

                SpawnPlayer(i);
                
                SetPVarInt(i, "MINION", 0);
            }
        }

        new str[128];

        

        if(count1 == 0)
        {
            
            format(str,sizeof(str),""Y"[Pura Joda] "W"%s "W"ganó la guerra.",GInfo[eid][gangname]);

            SendClientMessageToAll(-1,str);
			Iter_Clear(CW_PLAYER);
			Iter_Clear(CW_PLAYER2);
        	ActiveWar = false;
			Solicited = false;

			idsoli = -1;
      
            
            format(winner,sizeof winner,"%s",gname2);
        }

        else if(count2 == 0)
        {

            
            
            format(str,sizeof(str),""Y"[Pura Joda] "W"%s "Y"ganó la guerra.",GInfo[pid][gangname]);

            SendClientMessageToAll(-1,str);
			Iter_Clear(CW_PLAYER);
			Iter_Clear(CW_PLAYER2);
        	ActiveWar = false;
		    Solicited = false;

			idsoli = -1;
    
            
            format(winner,sizeof winner,"%s",gname1);
        }


       // new Query[180];
             
        //format(Query,sizeof(Query),"UPDATE Gangs SET GangScore = GangScore+ WHERE GangName = '%q'",winner);

        //db_query(Database,Query);
    }
    return 1;
}


IntToHex(var)
{
    new hex[10];

    format(hex,sizeof hex,"{%06x}", var >>> 8);

    return hex;
}

HexToInt(string[]) //By DracoBlue 
{

    if (string[0] == 0) return 0;

    new i, cur=1, res = 0;

    for (i=strlen(string);i>0;i--)
    {

        res += cur * ((string[i - 1] < 58) ? (string[i - 1] - 48) : (string[i - 1] - 65 + 10));
        
        cur=cur*16;

    }

    return res;

}
