//INCLUDES.
//165
#include <a_samp>//SA-MP team
#include <sscanf>
#include <lethaldudb2>//LethaL
#include <GeoIP_Plugin>//Slice
#include <dini>//DracoBlue
#include <mSelection>//d0
#include <foreach>//Y_LEss
#include <zcmd>
#include <streamer>

#define MAX_PLAYER 100
#define ConvertTime(%0,%1,%2,%3,%4) \
	new \
	    Float: %0 = floatdiv(%1, 60000) \
	;\
	%2 = floatround(%0, floatround_tozero); \
	%3 = floatround(floatmul(%0 - %2, 60), floatround_tozero); \
	%4 = floatround(floatmul(floatmul(%0 - %2, 60) - %3, 1000), floatround_tozero)

#define function%0(%1) \
	forward%0(%1); public%0(%1)
#define RANDOM_TIME_RACE 60000
#define MAX_RACE_CHECKPOINTS_EACH_RACE \
 	120

#define MAX_RACES \
 	100

#define COUNT_DOWN_TILL_RACE_START \
	30 
#define LIGHTBLUE 0x00C2ECFF

#define MAX_RACE_TIME \
	600 

#define RACE_CHECKPOINT_SIZE \
	13.5

#define DEBUG_RACE \
 0


new Warns[MAX_PLAYERS],Warnered[MAX_PLAYERS];
new MoneyEx[MAX_PLAYERS], rProgress = -1;
new bool:Sync[MAX_PLAYERS] = false;
new bool:SMusic[MAX_PLAYERS] = true;
new Dueled[MAX_PLAYERS];
new Float:FaceAngle[MAX_PLAYERS];
new Float:PlayerHPP[MAX_PLAYERS];
new VehicleIDD[MAX_PLAYERS];
new ammoo[13][MAX_PLAYERS];
new Float:APP[MAX_PLAYERS];
new vehicledd[MAX_PLAYERS];
new interiori[MAX_PLAYERS];
new Float:xx[MAX_PLAYERS];
new Float:yy[MAX_PLAYERS];
new Float:zz[MAX_PLAYERS];
new skinneg[MAX_PLAYERS];
new gun[13][MAX_PLAYERS];
new virt[MAX_PLAYERS];
#define W "{FFFFFF}" //white
#define G "{00FF00}"
#define LB "{00C2EC}"
#define KickEx Kick
#pragma dynamic 145000
#pragma tabsize 0
#define COLOR_GREY 0x808080FF
#define PJCoin 68456
#define amarillo 0xFFE700FF
#define STREAM_DISTANCES            0
#define  STREAM_DISTANCES2           25
#define  STREAM_DISTANCES3           20
#define MAX_PLAYER 100
#define COLOR_TEAL 0x3BAAC2AA
#define FIRST_PLACE_REWARD 20000
#define SECOND_PLACE_REWARD 10000
#define THIRD_PLACE_REWARD 5000
#define OVERALLFILE "Carreras/JumpHighscores.cfg"
#define PERSONALFILE "Carreras/JumpHighscores.cfg"
#define DEFAULT_BIKEMODEl 522   //NRG-500
#define VehicleHealthYellow 700
#define VehicleHealthRed 400
#define Verde 0x006900FF
#define Cafe 0x662F00FF
#define Negro 0x000000FF
#define Blanco 0x00000000
#define AzulOscuro 0x00008CFF
#define Celeste 0x00A2FFFF
#define Rosado 0xFF01FFFF
#define Verde_Agua 0x00FFC5FF
#define Morado 0x6D04C6FF
#define Gris 0x01000062
#define SpeedCheck(%0,%1,%2,%3,%4) floatround(floatsqroot(%4?(%0*%0+%1*%1+%2*%2):(%0*%0+%1*%1)) *%3*1.6)
#define ARENAS 8
#define COLOR_DUELO 0x5db8d7ff
#define DUELOSMENU 144
#define DUELOSMENU2 149
enum InfoArena{
Arena[30]
}
new arenas[][InfoArena] = {
"null",
"Arena 1 - LV",
"Arena 2 - L. DH",
"Arena 3 - STADIUM",
"Arena 4 - PARKING",
"Arena 5 - B. KILLER",
"Arena 6 - A. CEMENTERY",
"Arena 7 - LV2"
};

enum DueloData
{
	DesaId,
	DesafiadoId,
	ArmasId,
	Libre,
	Apuesta
};
new Readyd[MAX_PLAYERS] = false;
new NODUEL[MAX_PLAYERS];
//==================================NEWS========================================
new Duelos[ARENAS][DueloData];
new p1duelo1;
new p2duelo1;
new EnDuelo[MAX_PLAYERS];
new ViendoDuelo[MAX_PLAYERS];

enum attached_object_data
{
    ao_model,
    ao_bone,
    Float:ao_x,
    Float:ao_y,
    Float:ao_z,
    Float:ao_rx,
    Float:ao_ry,
    Float:ao_rz,
    Float:ao_sx,
    Float:ao_sy,
    Float:ao_sz
}
new PlayerText:statings[MAX_PLAYERS];
new Auto1;
new Auto2;
new Auto3;
new ao[MAX_PLAYERS][MAX_PLAYER_ATTACHED_OBJECTS][attached_object_data];
forward Esperar(playerid);
forward Conteo5(playerid);
forward Conteo4(playerid);
forward Conteo3(playerid);
forward Conteo2(playerid);
forward Conteo1(playerid);
forward ConteoGo(playerid);
forward Meta(playerid);
//new MyFirstNPCVehicle; //Global variable!
new  Precord, Drecord, Mrecord, Yrecord, THrecord, TMrecord;
//new mname[][] = {"Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembrer"};
new Timer1, Timer2, Timer3, MaxTimer;
new Racer = -1;
new Motor;
new EnDrift[MAX_PLAYERS];
new TotalEnDrift;
new Float:HS[3], HSN[3][MAX_PLAYER_NAME];
new Text:TD0 = Text:INVALID_TEXT_DRAW;
new Text:TD1= Text:INVALID_TEXT_DRAW;
new Text:TD2= Text:INVALID_TEXT_DRAW;
new Text:TD3= Text:INVALID_TEXT_DRAW;
new Text:TD4= Text:INVALID_TEXT_DRAW;
new TDS1[128] = " ";
new TDS2[128] = " ";
new TDS4[128] = " ";
new TDS5[40] = " ";
new LasttmpX;
new PlayerText:VehicleName[MAX_PLAYERS]= {PlayerText:INVALID_TEXT_DRAW, ...}, PlayerText:VehicleHealth[MAX_PLAYERS]= {PlayerText:INVALID_TEXT_DRAW, ...}, PlayerText:VehicleSpeed[MAX_PLAYERS]= {PlayerText:INVALID_TEXT_DRAW, ...}, Text:Title= Text:INVALID_TEXT_DRAW, Text:Underline =Text:INVALID_TEXT_DRAW, Text:KMH = Text:INVALID_TEXT_DRAW;
new TimeLeft;
new Float:Distance;
new Menu:AdminMenu;
new Menu:MotorMenu;
new Menu:YesNoGlobal;
new Menu:YesNoPersonal;
new BikeModel = DEFAULT_BIKEMODEl;
new FPR = FIRST_PLACE_REWARD;
new SPR = SECOND_PLACE_REWARD;
new TPR = THIRD_PLACE_REWARD;
new Weap[9][1];
new pSave[MAX_PLAYER] = 0;
new Jump[MAX_PLAYER], Velocity[MAX_PLAYER];
new Text:WebTextdraw = Text:INVALID_TEXT_DRAW;
new Buy[MAX_PLAYER] = false;
new Novel[MAX_PLAYER];
new bool:ammude[MAX_PLAYER];
new Dinero[MAX_PLAYER];
new antiflood[MAX_PLAYER];
new CurrentSpawnedVehicle[MAX_PLAYER];
new entrada,salida,compra;
new DB:LadminDB;
new String[128], Float:SpecX[MAX_PLAYER], Float:SpecY[MAX_PLAYER], Float:SpecZ[MAX_PLAYER], vWorld[MAX_PLAYER], Inter[MAX_PLAYER];
new IsSpecing[MAX_PLAYER], Name[MAX_PLAYER_NAME], IsBeingSpeced[MAX_PLAYER],spectatorid[MAX_PLAYER];
new congelado;
new Text3D:VIPS[MAX_PLAYER];
new Navidad[MAX_PLAYER];
new Str[100];
new tiempoenpdie[MAX_PLAYER], tiempoengranadas[MAX_PLAYER], tiempoenchaleco[MAX_PLAYER], tiempoenvida[MAX_PLAYER];  //RESTRICCIÓN PARA DIE PREMIUM LVL 4
new PlayerEnPGOD[MAX_PLAYER]; //Restricciòn de armas para /pgod
static bool:ActivadoS = false;
new NombreI;
new Text3D:VidaI[MAX_PLAYER];
new DLlast[MAX_PLAYER] = 0;
new FPS2[MAX_PLAYER] = 0;
new USERSURVIVOR[MAX_PLAYER];
new ADMINSURVIVOR[MAX_PLAYER];
new balason [MAX_PLAYER];
new vida[MAX_PLAYER];
new granadas[MAX_PLAYER];
new pdie[MAX_PLAYER];
new chaleco[MAX_PLAYER];


//Server Variables
new  Float:cX,
Float:cY, Float:cZ, Float:cAngle;

new bool:AceleracionBrutal[MAX_PLAYER];
new Act[MAX_PLAYER];
new saltar2[MAX_PLAYER];
new guerra;//variable global
new Reantiflood[MAX_PLAYER];
//================================================================
new ParteDelCuerpo[MAX_PLAYER],
	Slot[MAX_PLAYER][10],
	accesorios = mS_INVALID_LISTID,
	autoparts = mS_INVALID_LISTID,
	gorrosycascos = mS_INVALID_LISTID,
	navidad = mS_INVALID_LISTID,
	phones = mS_INVALID_LISTID,
	policeobjects = mS_INVALID_LISTID,
	weaps = mS_INVALID_LISTID,
	other = mS_INVALID_LISTID;
new vehlist = mS_INVALID_LISTID;
new boatlist = mS_INVALID_LISTID;
new planelist = mS_INVALID_LISTID;
	forward GetVehicleModelIDFromName(vname[]);
//========premiuns============//
#define DIALOG_OTROS 1
#define DIALOG_REGISTRO 2 // 3
#define DIALOG_INGRESO DIALOG_REGISTRO+1
#define JUMPSIZE 0.2
#define JUMPSIZE2 0.3
#define DIALOGID 4 //84
#define DIALOG_OBJECTSELECTION 85 //87 //------------- Sistema de Objetos By 43z
#define MENU_EVENTOS_CONFIG 89 // 89
#define MPN MAX_PLAYER_NAME
#define Ammu 118 // 116
#define DIALOG_COLOR 134
#define Tuning 135//136 141...
#define DIALOG_TOP 143
#define GUN1 156
#define GUN2 157
#define GUN3 158
#define GUN4 159
#define GUN5 160
#define GUN6 161
#define GUN7 162
#define GUN8 163
#define GUN9 164
//new Reantiflood[MAX_PLAYER];
forward antifloodreset(playerid);
//DEFINICIÓN DE COLORES}
// DEFINICIÓN

#define Cantidaddevida 100
#define Cantidaddearmadura 100
#define azul_claro 0x00D7FFFF
#define AMARELO 0xF9F900FF
#define Grey  0xC0C0C0FF
#define VERMELHO 0xFF0000FF
#define COLOR_BLANCO 0xFFFFFFAA
#define COLOR_ROJO 0xFF3300
#define COLOR_NARANJA 0xFF9900
#define COLOR_YELLOW 0xFFFF00AA
#define COLOR_INVISIBLE 0xFFFFFF00
#define COLOUR_WHITE 0xFFFFFFAA
#define COLOR_VIP 0xDDD100FF
#define W "{FFFFFF}" //white
#define R "{D50000}" //red
#define AC "{00E8E4}" //Azul claro
#define Ab "{33CCFF}" //Azul claro de la entrada
#define GREEN 			0x21DD00FF
#define RED 			0xE60000FF
#define ADMIN_RED 		0xFB0000FF
#define YELLOW 			0xFFFF00FF
#define ORANGE 			0xF97804FF
#define LIGHTRED 		0xFF8080FF
#define LIGHTBLUE 		0x00C2ECFF
#define PURPLE 			0xB360FDFF
#define PLAYER_COLOR 	0xFFFFFFFF
#define BLUE 			0x1229FAFF
#define LIGHTGREEN 		0x38FF06FF
#define DARKPINK 		0xE100E1FF
#define DARKGREEN 		0x008040FF
#define ANNOUNCEMENT 	0x6AF7E1FF
#define COLOR_SYSTEM 	0xEFEFF7AA
#define GREY 			0xCECECEFF
#define PINK 			0xD52DFFFF
#define DARKGREY    	0x626262FF
#define AQUAGREEN   	0x03D687FF
#define NICESKY 		0x99FFFFAA
#define WHITE 			0xFFFFFFFF
#define COLOR_LIGHTBLUE 0x33CCFFAA
#define Amarillo 0xFFFF00AA
#define Rojo 0xFF0000AA
//-=Main colours=-
#define blue 0x375FFFFF
#define red 0xFF0000AA
#define green 0x33FF33AA
#define yellow 0xFFFF00AA
#define grey 0xC0C0C0AA
#define blue1 0x2641FEAA
#define lightblue 0x33CCFFAA
#define orange 0xFF9900AA
#define black 0x2C2727AA
#define COLOR_GREEN 0x33AA33AA
#define COLOR_PINK 0xFF66FFAA
#define COLOR_BLUE 0x0000BBAA
#define COLOR_PURPLE 0x800080AA
#define COLOR_BLACK 0x000000AA
#define COLOR_WHITE 0xFFFFFFAA
#define COLOR_GREEN1 0x33AA33AA
#define COLOR_BROWN 0xA52A2AAA
#define COLOR_ORANGE 	0xFF8040FF
#define COLOR_YELLOW 	0xFFFF00AA
#define COLOR_RED 		0xFF0000AA
#define COLOR_WHITE  	0xFFFFFFAA
#define ROJO 0xAA3333AA
#define NARANJA 0xF97804FF
#define BLANCO 0xEFEFF7AA
#define CELESTE 0x00C8FFFF
#define NICESKY 0x99FFFFAA
//-----------------------------------------------------------------------------------//
// MACROS
#define W "{FFFFFF}" //white
#define G "{00FF00}"
#define LB "{00C2EC}"
#define KickEx Kick
#pragma dynamic 145000
#pragma tabsize 0
#define COLOR_GREY 0x808080FF
#define PJCoin 68456
#define STREAM_DISTANCES            0
#define  STREAM_DISTANCES2           25
#define  STREAM_DISTANCES3           20
#define MAX_PLAYER 100
#define COLOR_TEAL 0x3BAAC2AA
#define FIRST_PLACE_REWARD 20000
#define SECOND_PLACE_REWARD 10000
#define THIRD_PLACE_REWARD 5000
#define OVERALLFILE "Carreras/JumpHighscores.cfg"
#define PERSONALFILE "Carreras/JumpHighscores.cfg"
#define DEFAULT_BIKEMODEl 522   //NRG-500
#define VehicleHealthYellow 700
#define VehicleHealthRed 400
#define Verde 0x006900FF
#define Cafe 0x662F00FF
#define Negro 0x000000FF
#define Blanco 0x00000000
#define AzulOscuro 0x00008CFF
#define Celeste 0x00A2FFFF
#define Rosado 0xFF01FFFF
#define Verde_Agua 0x00FFC5FF
#define Morado 0x6D04C6FF
#define Gris 0x01000062
#define SpeedCheck(%0,%1,%2,%3,%4) floatround(floatsqroot(%4?(%0*%0+%1*%1+%2*%2):(%0*%0+%1*%1)) *%3*1.6)

#define ForEach(%0,%1) \
	for(new %0 = 0; %0 != %1; %0++) if(IsPlayerConnected(%0) && !IsPlayerNPC(%0))

#define Loop(%0,%1) \
	for(new %0 = 0; %0 != %1; %0++)

#if !defined function
#define function%0(%1) \
        forward%0(%1); public%0(%1)
#endif

//CONFIGURACIÓN

#define USE_MENUS       	// Comment to remove all menus.  Uncomment to enable menus
#define DISPLAY_CONFIG 	// displays configuration in console window on filterscript load
#define SAVE_LOGS           // Comment if your server runs linux (logs wont be saved)
#define ENABLE_SPEC         // Comment if you are using a spectate system already
#define USE_STATS           // Comment to disable /stats
//#define ANTI_MINIGUN        // Displays who has a minigun
//#define USE_AREGISTER       // Changes /register, /login etc to  /areister, /alogin etc
//#define HIDE_ADMINS 		// Displays number of admins online instead of level and names
#define ENABLE_FAKE_CMDS   	// Comment to disable /fakechat, /fakedeath, /fakecmd commanads
#define MAX_WARNINGS 3      // /warn command
#define MAX_REPORTS 7
#define MAX_CHAT_LINES 7
#define SPAM_MAX_MSGS 5
#define SPAM_TIMELIMIT 8 // SECONDS
#define PING_TIMELIMIT 2 // SECONDS
#define MAX_FAIL_LOGINS 4
#define TIME_LIMIT  	0   // In minutes
#define MAX_JOINS   	3   // Maximum allowed amount of joins from a same IP that the server allows in the TIME_LIMIT before banning.
#define EXPECTED_JOINS  100
#define SHOW_MESSAGE   	1   // 0 or 1. Whether to show a message to all players or not when a server-crash attempt is stopped.
#define LOG_FLOODER     1 	// 0 or 1, Log bans that are caused by the flooder ( default is set to 1 = log )
#define MAX_IP  32


//TERMINÓ.
//native gpci(playerid, PSerial[], len);
forward KickTime(playerid);
forward ResetRecord();
forward SpawnProtection(playerid);
new IPRecord[ EXPECTED_JOINS ][ MAX_IP ],
	IPIndex;
new Timer;
new ServerRestartPause = 0;

//-----------------------------------------------------------------------------------//

// Admin Area
new AdminArea[6] = {
377, 	// X
170, 	// Y
1008, 	// Z
90,     // Angle
3,      // Interior
0		// Virtual World
};

// DCMD
#define dcmd(%1,%2,%3) if ((strcmp((%3)[1], #%1, true, (%2)) == 0) && ((((%3)[(%2) + 1] == 0) && (dcmd_%1(playerid, "")))||(((%3)[(%2) + 1] == 32) && (dcmd_%1(playerid, (%3)[(%2) + 2]))))) return 1
#define SendError(%1,%2) SendClientMessage(%1,COLOR_RED,"ERROR: " %2)
#define SendUsage(%1,%2) SendClientMessage(%1,COLOR_WHITE,"USAGE: " %2)
// Caps
#define UpperToLower(%1) for ( new ToLowerChar; ToLowerChar < strlen( %1 ); ToLowerChar ++ ) if ( %1[ ToLowerChar ]> 64 && %1[ ToLowerChar ] < 91 ) %1[ ToLowerChar ] += 32

#define udb_query(%1,%2,%3) new query[200]; format(query, sizeof(query), %2, %3);  new DBResult:%1 = db_query(LadminDB, query)
// Spec
#define ADMIN_SPEC_TYPE_NONE 0
#define ADMIN_SPEC_TYPE_PLAYER 1
#define ADMIN_SPEC_TYPE_VEHICLE 2


enum jarvis { //OTACÓN
        bool:ActivarIronman,
        bool:IronmanVolando,
        MatarIronman[2],
        Float:TurbinasIronman,
        Float:EnergiaIronman[2],
        VestimentaTony, };

// Enums
enum ConfigEvento
{
	Float:x1,
	Float:y2,
	Float:z3,
	Interior,
	PosicionEvento,
	VirtualWorld,
	bool:Cerrado,
	bool:Creado,
};

//:v
//EVENTO SISTEMA
new Evento[ConfigEvento];//LA VARIABLE DEL EVENTO
new Int[MAX_PLAYER];//INTERIOR DEL EVENTO
new VW[MAX_PLAYER];// Virtual World del evento es el que guarda el virtual world osea para que no aiga bugs
new Skin[MAX_PLAYER];// Este es al auto skin osea si el evento tiene un skin cuando entre ese skin se le pondra
new Cars[MAX_PLAYER] = -1;// LOS CARROSg
new bool:FueraDeEvento[MAX_PLAYER];//ESTE CONFIRMA SI ESTA AFUERA O DENTRO DEL EVENTO

new Float:Pos[MAX_PLAYER][4];
new SinComandos[MAX_PLAYER];
new Ironman[MAX_PLAYER][jarvis];

#define PING_MAX_EXCEEDS 4
enum encolores
{
	colorNombre[24],
	colorHex
}
//Carreras
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
new const colores[][encolores] =
{
	{"Rojo", 0xFF0000FF},
	{"Celeste", 0x00CAFFFF},
	{"Azul", 0x0000FFFF},
	{"Rosa", 0xFF00FFFF},
	{"Verde", 0x00FF00FF},
	{"Lima", 0x00FF00FF},
	{"Naranja", 0xFF6400FF},
	{"Amarillo", 0xFFFF00FF},
	{"Violeta", 0x9400FFFF},
	{"Negro", 0x000000FF},
	{"Blanco", 0xFFFFFFFF},
	{"Marron", 0x833500FF},
	{"Aqua", 0x00FFFFFF}
};
enum PlayerData
{
	Registered,
	LoggedIn,
	Level,

	Muted,
	Hide,
	Caps,
	Jailed,
	JailTime,
	Frozen,
	FreezeTime,
	Kills,
	Deaths,
	hours,
	mins,
	secs,
	TotalTime,
	ConnectTime,
 	MuteWarnings,
	Warnings,
	Spawned,
	TimesSpawned,
	God,
	GodCar,
	DoorsLocked,
	SpamCount,
	SpamTime,
	PingCount,
	PingTime,
	BotPing,
	pPing[PING_MAX_EXCEEDS],
	blip,
	blipS,
	pColour,
	pCar,
	SpecID,
	SpecType,
	bool:AllowedIn,
	FailLogin,
	logtime,
	rcona,
	PreDia,
	PreMes,
	PreAno,
	UseSkin,
	FavSkin,
	TimeON,
	fColor
};
new PlayerInfo[MAX_PLAYER][PlayerData];

enum ServerData
{
	MaxPing,
	ReadPMs,
	ReadCmds,
	MaxAdminLevel,
	AdminOnlySkins,
	AdminSkin,
	AdminSkin2,
	NameKick,
	PartNameKick,
	AntiBot,
	AntiSpam,
 	AntiSwear,
 	NoCaps,
	Locked,
	Password[128],
	GiveWeap,
	GiveMoney,
	ConnectMessages,
	AdminCmdMsg,
	AutoLogin,
	MaxMuteWarnings,
	DisableChat,
	MustLogin,
	MustRegister,
};
new ServerInfo[ServerData];

///new Float:Pos[MAX_PLAYER][4];


// rcon
new Chat[MAX_CHAT_LINES][128];

//Timers
new PingTimer;
new GodTimer;
new BlipTimer[MAX_PLAYER];
new JailTimer[MAX_PLAYER];
new FreezeTimer[MAX_PLAYER];
new LockKickTimer[MAX_PLAYER];

//Duel
new CountDown = -1, cdt[MAX_PLAYER] = -1;
new InDuel[MAX_PLAYER];
//new Text:Information[MAX_PLAYER];

// Menus


// Forbidden Names & Words

/*forward VehicleOccupied(vehicleid);*/
new
    AntiSpamBot[100][100],
    AntiSpamBotCount = 0,
    AntiSpamBot2[100][100],
    AntiSpamBotCount2 = 0,
    BadNames[100][100], // Whole Names
    BadNameCount = 0,
	BadPartNames[100][100], // Part of name
    BadPartNameCount = 0,
    ForbiddenWords[100][100],
    ForbiddenWordCount = 0;

// Report
new Reports[MAX_REPORTS][328];

// Ping Kick
new PingPos;
forward Speedometer(playerid);
new VehicleNames[212][] = {
	"Landstalker","Bravura","Buffalo","Linerunner","Pereniel","Sentinel","Dumper","Firetruck","Trashmaster","Stretch","Manana","Infernus",
	"Voodoo","Pony","Mule","Cheetah","Ambulance","Leviathan","Moonbeam","Esperanto","Taxi","Washington","Bobcat","Mr Whoopee","BF Injection",
	"Hunter","Premier","Enforcer","Securicar","Banshee","Predator","Bus","Rhino","Barracks","Hotknife","Trailer","Previon","Coach","Cabbie",
	"Stallion","Rumpo","RC Bandit","Romero","Packer","Monster","Admiral","Squalo","Seasparrow","Pizzaboy","Tram","Trailer","Turismo","Speeder",
	"Reefer","Tropic","Flatbed","Yankee","Caddy","Solair","Berkley's RC Van","Skimmer","PCJ-600","Faggio","Freeway","RC Baron","RC Raider",
	"Glendale","Oceanic","Sanchez","Sparrow","Patriot","Quad","Coastguard","Dinghy","Hermes","Sabre","Rustler","ZR3 50","Walton","Regina",
	"Comet","BMX","Burrito","Camper","Marquis","Baggage","Dozer","Maverick","News Chopper","Rancher","FBI Rancher","Virgo","Greenwood",
	"Jetmax","Hotring","Sandking","Blista Compact","Police Maverick","Boxville","Benson","Mesa","RC Goblin","Hotring Racer A","Hotring Racer B",
	"Bloodring Banger","Rancher","Super GT","Elegant","Journey","Bike","Mountain Bike","Beagle","Cropdust","Stunt","Tanker","RoadTrain",
	"Nebula","Majestic","Buccaneer","Shamal","Hydra","FCR-900","NRG-500","HPV1000","Cement Truck","Tow Truck","Fortune","Cadrona","FBI Truck",
	"Willard","Forklift","Tractor","Combine","Feltzer","Remington","Slamvan","Blade","Freight","Streak","Vortex","Vincent","Bullet","Clover",
	"Sadler","Firetruck","Hustler","Intruder","Primo","Cargobob","Tampa","Sunrise","Merit","Utility","Nevada","Yosemite","Windsor","Monster A",
	"Monster B","Uranus","Jester","Sultan","Stratum","Elegy","Raindance","RC Tiger","Flash","Tahoma","Savanna","Bandito","Freight","Trailer",
	"Kart","Mower","Duneride","Sweeper","Broadway","Tornado","AT-400","DFT-30","Huntley","Stafford","BF-400","Newsvan","Tug","Trailer A","Emperor",
	"Wayfarer","Euros","Hotdog","Club","Trailer B","Trailer C","Andromada","Dodo","RC Cam","Launch","Police Car (LSPD)","Police Car (SFPD)",
	"Police Car (LVPD)","Police Ranger","Picador","S.W.A.T. Van","Alpha","Phoenix","Glendale","Sadler","Luggage Trailer A","Luggage Trailer B",
	"Stair Trailer","Boxville","Farm Plow","Utility Trailer"
};
new Monster[MAX_PLAYER];
new Adentro[MAX_PLAYER];

	new Count2 = 5;
	new CountText[5][5] ={
	"~r~1",
	"~r~2",
	"~r~3",
	"~b~4",
	"~b~5"
	};
new BloqueoDePrivados[MAX_PLAYER];
static bool:Activado = false;
static bool:ActivadoD = false;
forward CountDown2();
forward Mounster(playerid);
forward CosasAdmins(playerid);
static bool:ActivadoC = false;

new USERCHUCK[MAX_PLAYER];
new ADMINCHUCK[MAX_PLAYER];



stock
	g_GotInvitedToDuel[MAX_PLAYER],
	g_HasInvitedToDuel[MAX_PLAYER],
	g_IsPlayerDueling[MAX_PLAYER],
	g_DuelCountDown[MAX_PLAYER],
	g_DuelTimer[MAX_PLAYER],
	g_DuelInProgress,
	g_DuelingID1,
	g_DuelingID2;
//==============================================================================
/*#pragma tabsize 0*/
public OnGameModeInit()
{


WebTextdraw = TextDrawCreate(506.000000, 12.444412, "~w~www.fb.com/~r~PuraJodaFreeroaM");
TextDrawLetterSize(WebTextdraw, 0.196499, 1.064888);
TextDrawAlignment(WebTextdraw, 1);
TextDrawColor(WebTextdraw, -1);
TextDrawSetShadow(WebTextdraw, 0);
TextDrawSetOutline(WebTextdraw, 1);
TextDrawBackgroundColor(WebTextdraw, 51);
TextDrawFont(WebTextdraw, 1);
TextDrawSetProportional(WebTextdraw, 1);
/*

	for(new playerid; playerid < MAX_PLAYER; playerid++) {
	Information[playerid] = TextDrawCreate(2.000000, 437.000000, "Dinero: ~g~$400500~y~($500000)   ~w~Tlf: ~y~6291362   ~w~Faccion: ~b~LSPD/Teniente   ~y~Drogas:~y~ 10   ~w~Materiales:~r~ 20000");
	TextDrawBackgroundColor(Information[playerid], 255);
	TextDrawFont(Information[playerid], 2);
	TextDrawLetterSize(Information[playerid], 0.250000, 1.000000);
	TextDrawColor(Information[playerid], -1);
	TextDrawSetOutline(Information[playerid], 0);
	TextDrawSetProportional(Information[playerid], 1);
	TextDrawSetShadow(Information[playerid], 1);
	TextDrawUseBox(Information[playerid], 1);
	TextDrawBoxColor(Information[playerid], 255);
	TextDrawTextSize(Information[playerid], 661.000000, 0.000000);}
	return 1;*/
	entrada = CreatePickup(1318,1,2159.4011, 943.3164, 10.7319,0);
	salida = CreatePickup(1318,1,2263.3682, -1582.9407, 1493.3530,0);
	compra = CreatePickup(1274,2,2268.0896, -1581.0186, 1492.9275,0);
	new string[123];
	format(string, 123, ""W"Bievenido\n"W"Para comprar use\n"G"/Buy");
    CreateDynamic3DTextLabel(string, -1, 2268.0896, -1581.0186, 1492.9275, STREAM_DISTANCES3, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, 0, 0, -1, STREAM_DISTANCES3);
	format(string, 123, ""W"¡Abre tu "G"regalo"W"!\n"R""G"/Regalo");
	CreateDynamic3DTextLabel(string, -1, 5590.4727, -1391.2734, 20.2569, STREAM_DISTANCES3, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, 0, 0, -1, STREAM_DISTANCES3);

/*	stats0 = TextDrawCreate(934.800048, 433.820068, "usebox");
	TextDrawLetterSize(stats0, 0.000000, 4.924816);
	TextDrawTextSize(stats0, -10.800000, 0.000000);
	TextDrawAlignment(stats0, 1);
	TextDrawColor(stats0, 0);
	TextDrawUseBox(stats0, true);
	TextDrawBoxColor(stats0, 102);
	TextDrawSetShadow(stats0, 0);
	TextDrawSetOutline(stats0, 0);
	TextDrawFont(stats0, 0);

	stats1 = TextDrawCreate(-4.800004, 445.760131, "LD_SPAC:white");
	TextDrawLetterSize(stats1, 0.000000, 0.000000);
	TextDrawTextSize(stats1, 703.999755, 1.493319);
	TextDrawAlignment(stats1, 1);
	TextDrawColor(stats1, -16776961);
	TextDrawSetShadow(stats1, 0);
	TextDrawSetOutline(stats1, 0);
	TextDrawBackgroundColor(stats1, 16711935);
	TextDrawFont(stats1, 4);

	stats2 = TextDrawCreate(0.800005, 431.573394, "LD_SPAC:white");
	TextDrawLetterSize(stats2, 0.000000, 0.000000);
	TextDrawTextSize(stats2, 640.000000, 1.493347);
	TextDrawAlignment(stats2, 1);
	TextDrawColor(stats2, -16776961);
	TextDrawSetShadow(stats2, 0);
	TextDrawSetOutline(stats2, 0);
	TextDrawFont(stats2, 4);*/
}
new DB:Database;

public OnFilterScriptInit()
{
	SendRconCommand("loadfs ad");
	SendRconCommand("loadfs derby");
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
	SetTimer("Start",RANDOM_TIME_RACE,false);
  Database = db_open("gang.db");
Underline = TextDrawCreate(531.250000, 390.833404, "-");
TextDrawLetterSize(Underline, 6.205002, 0.759999);
TextDrawAlignment(Underline, 1);
TextDrawColor(Underline, -1);
TextDrawSetShadow(Underline, 0);
TextDrawSetOutline(Underline, 1);
TextDrawBackgroundColor(Underline, 51);
TextDrawFont(Underline, 1);
TextDrawSetProportional(Underline, 1);

	Title = TextDrawCreate(548.125000, 380.333404, "~w~Pura ~r~~h~Joda");
	TextDrawLetterSize(Title, 0.241248, 1.518332);
	TextDrawAlignment(Title, 1);
	TextDrawColor(Title, -1);
	TextDrawSetShadow(Title, 0);
	TextDrawSetOutline(Title, 1);
	TextDrawBackgroundColor(Title, 51);
	TextDrawFont(Title, 2);
	TextDrawSetProportional(Title, 1);


KMH = TextDrawCreate(573.125000, 414.166687, "KM/H");
TextDrawLetterSize(KMH, 0.340624, 1.436666);
TextDrawAlignment(KMH, 1);
TextDrawColor(KMH, -1);
TextDrawSetShadow(KMH, 0);
TextDrawSetOutline(KMH, 1);
TextDrawBackgroundColor(KMH, 51);
TextDrawFont(KMH, 2);
TextDrawSetProportional(KMH, 1);
	TD0 = TextDrawCreate(325.000000,137.000000,"Highscores:");
	TD1 = TextDrawCreate(157.000000,179.000000, TDS1);
	TD2 = TextDrawCreate(308.000000,179.000000, TDS2);
	TD3 = TextDrawCreate(205.000000,411.000000, TDS4);
	TD4 = TextDrawCreate(326.000000,240.000000,TDS5);
	TextDrawUseBox(TD1,1);
	TextDrawUseBox(TD4,1);
	TextDrawBoxColor(TD1,0x00000066);
	TextDrawBoxColor(TD3,0x00000066);
	TextDrawBoxColor(TD4,0x00000066);
	TextDrawTextSize(TD1,492.000000,-37.000000);
	TextDrawTextSize(TD3,490.000000,1.000000);
	TextDrawTextSize(TD4,470.000000,337.000000);
	TextDrawAlignment(TD0,2);
	TextDrawAlignment(TD1,1);
	TextDrawAlignment(TD2,0);
	TextDrawAlignment(TD3,0);
	TextDrawAlignment(TD4,2);
	TextDrawBackgroundColor(TD0,0x000000ff);
	TextDrawBackgroundColor(TD1,0x000000ff);
	TextDrawBackgroundColor(TD2,0x000000ff);
	TextDrawBackgroundColor(TD3,0x000000ff);
	TextDrawBackgroundColor(TD4,0x000000ff);
	TextDrawFont(TD0,3);
	TextDrawLetterSize(TD0,1.0, 3.000005);
	TextDrawFont(TD1,3);
	TextDrawLetterSize(TD1,0.499999,1.400000);
	TextDrawFont(TD2,3);
	TextDrawLetterSize(TD2,0.499999,1.400000);
	TextDrawFont(TD3,3);
	TextDrawLetterSize(TD3,0.799999,1.800000);
	TextDrawFont(TD4,3);
	TextDrawLetterSize(TD4,0.599999,1.900000);
	TextDrawColor(TD0,0xffffffff);
	TextDrawColor(TD1,0xffffffff);
	TextDrawColor(TD2,0xffffffff);
	TextDrawColor(TD3,0xffffffff);
	TextDrawColor(TD4,0xffffffff);
	TextDrawSetOutline(TD0,1);
	TextDrawSetOutline(TD1,1);
	TextDrawSetOutline(TD2,1);
	TextDrawSetOutline(TD3,1);
	TextDrawSetOutline(TD4,1);
	TextDrawSetProportional(TD0,1);
	TextDrawSetProportional(TD1,1);
	TextDrawSetProportional(TD2,1);
	TextDrawSetProportional(TD3,1);
	TextDrawSetProportional(TD4,1);
	TextDrawSetShadow(TD0,1);
	TextDrawSetShadow(TD1,1);
	TextDrawSetShadow(TD2,1);
	TextDrawSetShadow(TD3,1);
  	TextDrawSetShadow(TD4,1);
	LoadRecord();
	//oplayers=ConnectedPlayers();
  	AdminMenu = CreateMenu("Jump-AdminOptions:", 1, 157.000000,179.000000, 290.0);
  	AddMenuItem(AdminMenu, 0, "Reset Global Highscores");
  	AddMenuItem(AdminMenu, 0, "Reset Personal Highscores");
  	AddMenuItem(AdminMenu, 0, "Change BikeModel");
  	AddMenuItem(AdminMenu, 0, "Cancel");
  	MotorMenu = CreateMenu("Select Bike:", 1, 157.000000,179.000000, 290.0);
  	AddMenuItem(MotorMenu, 0, "NRG-500");
  	AddMenuItem(MotorMenu, 0, "BF-400");
  	AddMenuItem(MotorMenu, 0, "FCR-900");
  	AddMenuItem(MotorMenu, 0, "Freeway");
  	AddMenuItem(MotorMenu, 0, "PCJ-600");
  	AddMenuItem(MotorMenu, 0, "Sanchez");
  	AddMenuItem(MotorMenu, 0, "Cancel");
  	YesNoGlobal = CreateMenu("Are You Sure?", 1, 157.000000,179.000000, 290.0);
  	AddMenuItem(YesNoGlobal, 0, "No");
  	AddMenuItem(YesNoGlobal, 0, "Yes");
    YesNoPersonal = CreateMenu("Are You Sure?", 1, 157.000000,179.000000, 290.0);
  	AddMenuItem(YesNoPersonal, 0, "No");
  	AddMenuItem(YesNoPersonal, 0, "Yes");

	if(!dini_Exists(OVERALLFILE))
	{
        dini_Create(OVERALLFILE);
        printf("[File Created]: %s", OVERALLFILE);
	    dini_FloatSet(OVERALLFILE, "S1", 0.0000);
	    dini_FloatSet(OVERALLFILE, "S2", 0.0000);
	    dini_FloatSet(OVERALLFILE, "S3", 0.0000);
	    dini_Set(OVERALLFILE, "N1", "Empty");
	    dini_Set(OVERALLFILE, "N2", "Empty");
	    dini_Set(OVERALLFILE, "N3", "Empty");
	}
	if(!dini_Exists(PERSONALFILE))
	{
        dini_Create(PERSONALFILE);
        printf("[File Created]: %s", PERSONALFILE);
	}
	HS[0] = dini_Float(OVERALLFILE, "S1");
	HS[1] = dini_Float(OVERALLFILE, "S2");
	HS[2] = dini_Float(OVERALLFILE, "S3");
	format(HSN[0], MAX_PLAYER_NAME, "%s", dini_Get(OVERALLFILE, "N1"));
	format(HSN[1], MAX_PLAYER_NAME, "%s", dini_Get(OVERALLFILE, "N2"));
	format(HSN[2], MAX_PLAYER_NAME, "%s", dini_Get(OVERALLFILE, "N3"));
	print("-------------------------------------");
	print(" Jump Minigame by =>Sandra<= Loaded! ");
	print("-------------------------------------");
//ConnectNPC("PuraJoda","Avion");
    planelist = LoadModelSelectionMenu("planes.txt");
    boatlist = LoadModelSelectionMenu("boats.txt");
    vehlist = LoadModelSelectionMenu("vehicles.txt");
/*new field[40], aux,sti[140],aux2,ol[140],sti2[140];
	new DBResult:e = db_query(LadminDB,"SELECT * FROM pjHouse ORDER BY hPrice");
	for(new i = 0; i < db_num_rows(e); i++)
	{
	printf("konda");
	db_get_field_assoc(e, "hPrice", field, sizeof(field));
	aux = strval(field);
	db_get_field_assoc(e, "hOwner", field, sizeof(field));
	format(sti, sizeof(sti),"%s",udb_encode(field));
	format(sti2, sizeof(sti2),"%s",field);
	db_get_field_assoc(e, "hMSafe", field, sizeof(field));
	aux2 = strval(field);
	format(ol, sizeof(ol), "UPDATE user SET pCoin = '%d',pMoney='%d' WHERE pName = '%s'",aux,aux2,sti);
    	printf("%s",ol);
	db_free_result(db_query(LadminDB, ol));


	db_next_row(e);
	}

	db_free_result(e);
*/	print("\n________________________________________");
	print("________________________________________");
	print("           LAdmin 4v5 Loading...        ");
	print("________________________________________");
	LadminDB = db_open("lUser.db");
	if(LadminDB == DB:0) print("[SQL Ladmin]: Error al conectar con \"lUser.db\"") && SendRconCommand("Exit");
	else print("[SQL Ladmin]: Conexión Con ÉXITO");
	TextDrawShowForAll(WebTextdraw);
	//Sistema de Objetos by 43z
    accesorios = LoadModelSelectionMenu("eObjects/accesorios.txt");
	autoparts = LoadModelSelectionMenu("eObjects/autoparts.txt");
	gorrosycascos = LoadModelSelectionMenu("eObjects/gorrosycascos.txt");
	navidad = LoadModelSelectionMenu("eObjects/navidad.txt");
	phones = LoadModelSelectionMenu("eObjects/phones.txt");
	policeobjects = LoadModelSelectionMenu("eObjects/policeobjects.txt");
	weaps = LoadModelSelectionMenu("eObjects/weaps.txt");
	other = LoadModelSelectionMenu("eObjects/other.txt");

	if (!fexist("TempBans.ban"))
	{
		new File:open = fopen("TempBans.ban",io_write);
		if (open) fclose(open);
	}
    SetTimerEx("SpawnProtection", 10000, 0, "i");//////Anti Spawn Kill for 10 seconds
	print(" Anti-join-flooding script loaded.");
	Timer = SetTimer("ResetRecord", TIME_LIMIT * 60000, 1);
	SetTimer("ServerUptimeSetRestart", 11000, 0);
	if(!fexist("ladmin/"))
	{
	    print("\n\n > WARNING: Folder Missing From Scriptfiles\n");
	  	SetTimerEx("PrintWarning",2500,0,"s","ladmin");
		return 1;
	}
	if(!fexist("ladmin/logs/"))
	{
	    print("\n\n > WARNING: Folder Missing From Scriptfiles\n");
	  	SetTimerEx("PrintWarning",2500,0,"s","ladmin/logs");
		return 1;
	}
	if(!fexist("ladmin/config/"))
	{
	    print("\n\n > WARNING: Folder Missing From Scriptfiles\n");
	  	SetTimerEx("PrintWarning",2500,0,"s","ladmin/config");
		return 1;
	}
	if(!fexist("ladmin/users/"))
	{
	    print("\n\n > WARNING: Folder Missing From Scriptfiles\n");
	  	SetTimerEx("PrintWarning",2500,0,"s","ladmin/users");
		return 1;
	}

	UpdateConfig();

//	SetTimer("DestruirCarros",600000,true);
	#if defined DISPLAY_CONFIG
	ConfigInConsole();
	#endif



    /*TD_RANKINGSCORE[0] = TextDrawCreate(13.000000, 184.750000, "~r~TOP10 ~p~MAX SCORE");
	TextDrawLetterSize(TD_RANKINGSCORE[0], 0.196499, 0.786250);
	TextDrawAlignment(TD_RANKINGSCORE[0], 1);
	TextDrawColor(TD_RANKINGSCORE[0], -1);
	TextDrawSetShadow(TD_RANKINGSCORE[0], 0);
	TextDrawSetOutline(TD_RANKINGSCORE[0], 1);
	TextDrawBackgroundColor(TD_RANKINGSCORE[0], 255);
	TextDrawFont(TD_RANKINGSCORE[0], 3);
	TextDrawSetProportional(TD_RANKINGSCORE[0], 1);
	TextDrawSetShadow(TD_RANKINGSCORE[0], 0);*/

/*	TD_RANKINGSCORE[1] = TextDrawCreate(4.000000, 188.250000, "~n~~r~1. ~w~43z ~r~- ~p~200~n~~r~2. ~w~Cronos ~r~- ~p~100~n~~r~3. ~y~NINGUNO");
	TextDrawLetterSize(TD_RANKINGSCORE[1], 0.237500, 0.851876);
	TextDrawAlignment(TD_RANKINGSCORE[1], 1);
	TextDrawColor(TD_RANKINGSCORE[1], -1);
	TextDrawSetShadow(TD_RANKINGSCORE[1], 0);
	TextDrawSetOutline(TD_RANKINGSCORE[1], 1);
	TextDrawBackgroundColor(TD_RANKINGSCORE[1], 255);
	TextDrawFont(TD_RANKINGSCORE[1], 1);
	TextDrawSetProportional(TD_RANKINGSCORE[1], 1);
	TextDrawSetShadow(TD_RANKINGSCORE[1], 0);*/

	for(new i = 0; i < MAX_PLAYER; i++) if(IsPlayerConnected(i)) OnPlayerConnect(i);
	for(new i = 1; i < MAX_CHAT_LINES; i++) Chat[i] = "<none>";
	for(new i = 1; i < MAX_REPORTS; i++) Reports[i] = "<none>";

	//PingTimer = SetTimer("PingKick",5000,1);
	GodTimer = SetTimer("GodUpdate",20,true);

	new year,month,day;	getdate(year, month, day);
	new hour,minute,second; gettime(hour,minute,second);

	return 1;
}
//==============================================================================
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
	db_close( Database );
	TextDrawHideForAll(Underline);
	TextDrawDestroy(Underline);
	TextDrawHideForAll(Title);
	TextDrawDestroy(Title);
	TextDrawHideForAll(KMH);
	TextDrawDestroy(KMH);
	if(Racer != -1)
	{
	    EndRace();
	}
    if(dini_Exists(OVERALLFILE))
	{
	    dini_FloatSet(OVERALLFILE, "S1", HS[0]);
	    dini_FloatSet(OVERALLFILE, "S2", HS[1]);
	    dini_FloatSet(OVERALLFILE, "S3", HS[2]);
	    dini_Set(OVERALLFILE, "N1", HSN[0]);
	    dini_Set(OVERALLFILE, "N2", HSN[1]);
	    dini_Set(OVERALLFILE, "N3", HSN[2]);
	}
	TextDrawHideForAll(TD0);
	TextDrawHideForAll(TD1);
	TextDrawHideForAll(TD2);
	TextDrawHideForAll(TD3);
    TextDrawHideForAll(TD4);
	TextDrawDestroy(TD0);
	TextDrawDestroy(TD1);
	TextDrawDestroy(TD2);
	TextDrawDestroy(TD3);
	TextDrawDestroy(TD4);
	KillTimer(Timer);
	KillTimer(PingTimer);
	KillTimer(GodTimer);
	#if defined USE_MENUS

	#endif
	return 1;
}

forward Kickeado(playerid);
public Kickeado(playerid) {
	Kick(playerid);
	return 1;
}
forward Baneado(playerid);
public Baneado(playerid) {
	Ban(playerid);
	return 1;
}
new bool:Enterr[MAX_PLAYERS] = false;
//==============================================================================
public ServerUptimeSetRestart()	{ ServerRestartPause = 1; }
forward  ServerUptimeSetRestart();
public ResetRecord() { IPIndex = 0; } // Reset the IP list.
public OnPlayerConnect(playerid)
{
Warns[playerid] = 0;

SMusic[playerid] = true;
PlayAudioStreamForPlayer(playerid,"https://dl.dropboxusercontent.com/s/yqi33bod2l9vrqf/intro%20pura%20joda%20freeroam.mp3");
Enterr[playerid] = true;
EnDuelo[playerid] = 0;
statings[playerid] = CreatePlayerTextDraw(playerid, 395.625000, 433.999969, "score: 50000 - deaths: 20000 - PJCoins: 156");
PlayerTextDrawLetterSize(playerid, statings[playerid], 0.296249, 1.395833);
PlayerTextDrawAlignment(playerid, statings[playerid], 1);
PlayerTextDrawColor(playerid, statings[playerid], -1);
PlayerTextDrawSetShadow(playerid, statings[playerid], 0);
PlayerTextDrawSetOutline(playerid, statings[playerid], 1);
PlayerTextDrawBackgroundColor(playerid, statings[playerid], 51);
PlayerTextDrawFont(playerid, statings[playerid], 3);
PlayerTextDrawSetProportional(playerid, statings[playerid], 1);

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

VehicleHealth[playerid] = CreatePlayerTextDraw(playerid, 571.875000, 403.083312, "100");
PlayerTextDrawLetterSize(playerid, VehicleHealth[playerid], 0.325623, 1.582499);
PlayerTextDrawAlignment(playerid, VehicleHealth[playerid], 1);
PlayerTextDrawColor(playerid, VehicleHealth[playerid], -1);
PlayerTextDrawSetShadow(playerid, VehicleHealth[playerid], 0);
PlayerTextDrawSetOutline(playerid, VehicleHealth[playerid], 1);
PlayerTextDrawBackgroundColor(playerid, VehicleHealth[playerid], 51);
PlayerTextDrawFont(playerid, VehicleHealth[playerid], 2);
PlayerTextDrawSetProportional(playerid, VehicleHealth[playerid], 1);

VehicleName[playerid] = CreatePlayerTextDraw(playerid, 546.250000, 395.500000, "infernus");
PlayerTextDrawLetterSize(playerid, VehicleName[playerid], 0.250625, 1.203333);
PlayerTextDrawAlignment(playerid, VehicleName[playerid], 1);
PlayerTextDrawColor(playerid, VehicleName[playerid], -1);
PlayerTextDrawSetShadow(playerid, VehicleName[playerid], 0);
PlayerTextDrawSetOutline(playerid, VehicleName[playerid], 1);
PlayerTextDrawBackgroundColor(playerid, VehicleName[playerid], 51);
PlayerTextDrawFont(playerid, VehicleName[playerid], 2);
PlayerTextDrawSetProportional(playerid, VehicleName[playerid], 1);

VehicleSpeed[playerid] = CreatePlayerTextDraw(playerid, 541.875000, 399.000122, "100");
PlayerTextDrawLetterSize(playerid, VehicleSpeed[playerid], 0.396248, 3.408334);
PlayerTextDrawAlignment(playerid, VehicleSpeed[playerid], 1);
PlayerTextDrawColor(playerid, VehicleSpeed[playerid], -1);
PlayerTextDrawSetShadow(playerid, VehicleSpeed[playerid], 0);
PlayerTextDrawSetOutline(playerid, VehicleSpeed[playerid], 1);
PlayerTextDrawBackgroundColor(playerid, VehicleSpeed[playerid], 51);
PlayerTextDrawFont(playerid, VehicleSpeed[playerid], 2);
PlayerTextDrawSetProportional(playerid, VehicleSpeed[playerid], 1);

	for(new i; i < MAX_PLAYER_ATTACHED_OBJECTS; i++)
	{
	ao[playerid][i][ao_model] = -1;
	}
	RemoveBuildingForPlayer(playerid, 17885, 2457.8359, -1695.9375, 14.2891, 0.25);
	RemoveBuildingForPlayer(playerid, 17573, 2457.8359, -1695.9375, 14.2891, 0.25);
	RemoveBuildingForPlayer(playerid, 1498, 2460.2422, -1692.0859, 12.5156, 0.25);
	RemoveBuildingForPlayer(playerid, 17879, 2484.5313, -1667.6094, 21.4375, 0.25);
	RemoveBuildingForPlayer(playerid, 17971, 2484.5313, -1667.6094, 21.4375, 0.25);
	//SetPVarInt(playerid, "MONEY", 0);
	ammude[playerid] = false;
	Dinero[playerid] = 0;
    saltar2[playerid] = 0;
	vida[playerid] = 0;
	granadas[playerid] = 0;
	pdie[playerid] = 0;
	chaleco[playerid] = 0;
    for(new i = 0; i <= 9; i++) Slot[playerid][i] = -1; //sistema de Objetos by 43z

	if (ServerRestartPause){
		// start code;
		new JoinCount2;

		if(IPIndex > 0)
		{
			for(new i; i < IPIndex; i ++)
			{
				if(!strcmp(PlayerIP(playerid), IPRecord[i]))
				JoinCount2 ++;
		}

			if(JoinCount2 >= MAX_JOINS)
			{
				BanIP(playerid);
				ResetRecord();
				return 1;
			}
		}

		if(IPIndex >= EXPECTED_JOINS)
			ResetRecord();

		strmid(IPRecord[IPIndex], PlayerIP(playerid), 0, MAX_IP, MAX_IP); // Record the IP
		IPIndex ++;
		// end of code
	}

    PlayerInfo[playerid][logtime] = GetTickCount();
    PlayerEnPGOD[playerid] = 0;

    new PlayerName[MAX_PLAYER_NAME];
	GetPlayerName(playerid, PlayerName, MAX_PLAYER_NAME);
	new string[160];
	for(new s = 0; s < AntiSpamBotCount; s++) {
  		if(!strcmp(AntiSpamBot[s],PlayerName,true)) {
			//format(string,sizeof(string),""R"***Info: "W"%s "R"[%d] ["R"Pais: "R"Privado"W"] "R"ha entrado al servidor", PlayerName, playerid);
			//SendClientMessage(playerid,red,string);
			SendClientMessage(playerid,red, "Tu nombre esta en nuestra lista negra, has sido kickeado.");
			format(string,sizeof(string),"%s ID:%d ha sido kickeado. (Razon: Nombre prohibido)",PlayerName,playerid);
			SendClientMessage(playerid,grey, string);  print(string);
			SaveToFile("BotBanLog",string); Ban(playerid);

			return 1;
		}
	}

    AceleracionBrutal[playerid] = false;
	new tmp3[50]; GetPlayerIp(playerid,tmp3,50);
	if(ServerInfo[NameKick] == 1) {
		for(new s = 0; s < BadNameCount; s++) {
  			if(!strcmp(BadNames[s],PlayerName,true)) {
				SendClientMessage(playerid,red, "Tu nombre esta en nuestra lista negra, has sido kickeado.");
				format(string,sizeof(string),"%s ID:%d ha sido auto kickeado. (Razon: Nombre prohibido)",PlayerName,playerid);
				SendClientMessage(playerid,grey, string);  print(string);
				SaveToFile("KickLog",string);  Kick(playerid);
				return 1;
			}
		}
	}
	//-----------------------------------------------------
	if(ServerInfo[PartNameKick] == 1) {
		for(new s = 0; s < BadPartNameCount; s++) {
			new pos;
			while((pos = strfind(PlayerName,BadPartNames[s],true)) != -1) for(new i = pos, j = pos + strlen(BadPartNames[s]); i < j; i++)
			{
				SendClientMessage(playerid,red, "Su nombre no esta permitido en este servidor, has sido kickeado.");
				format(string,sizeof(string),"%s ID:%d ha sido auto kickeado. (Razon: Nombre prohibido)",PlayerName,playerid);
				SendClientMessage(playerid,grey, string);  print(string);
				SaveToFile("KickLog",string);  Kick(playerid);
				return 1;
			}
		}
	}


	BloqueoDePrivados[playerid] = 0;
	PlayerInfo[playerid][Deaths] = 0;
	PlayerInfo[playerid][Jailed] = 0;
	PlayerInfo[playerid][Hide] = 0;
	PlayerInfo[playerid][Frozen] = 0;
	PlayerInfo[playerid][Level] = 0;
	PlayerInfo[playerid][LoggedIn] = 0;
	PlayerInfo[playerid][Registered] = 0;
	PlayerInfo[playerid][God] = 0;
	PlayerInfo[playerid][GodCar] = 0;
	PlayerInfo[playerid][TimesSpawned] = 0;
	PlayerInfo[playerid][Muted] = 0;
	PlayerInfo[playerid][MuteWarnings] = 0;
	PlayerInfo[playerid][Warnings] = 0;
	PlayerInfo[playerid][Caps] = 0;
	PlayerInfo[playerid][DoorsLocked] = 0;
	PlayerInfo[playerid][pCar] = -1;
	for(new i; i<PING_MAX_EXCEEDS; i++) PlayerInfo[playerid][pPing][i] = 0;
	PlayerInfo[playerid][SpamCount] = 0;
	PlayerInfo[playerid][SpamTime] = 0;
	PlayerInfo[playerid][PingCount] = 0;
	PlayerInfo[playerid][PingTime] = 0;
	PlayerInfo[playerid][FailLogin] = 0;
	PlayerInfo[playerid][ConnectTime] = gettime();
	PlayerInfo[playerid][rcona] = 0;
	PlayerInfo[playerid][PreDia] = 0;
	PlayerInfo[playerid][PreMes] = 0;
	PlayerInfo[playerid][PreAno] = 0;
	PlayerInfo[playerid][UseSkin] = 0;
	PlayerInfo[playerid][FavSkin] = 0;
	PlayerInfo[playerid][TimeON] = 0;

	new sString[128];
	udb_query(result, "SELECT pName, pIP, pBanned FROM user WHERE pName = '%s' LIMIT 1", DB_Escape(udb_encode(PlayerName2(playerid))));
	if(!db_num_rows(result))
	{
		format(sString, sizeof(sString),"~n~~n~~w~Bienvenido %s",PlayerName2(playerid));
    	GameTextForPlayer(playerid,sString,9000,5);
    	new name[144];
    	format(name, sizeof name, "Bienvenido %s ingrese una contraseña\nPara contar con los beneficios\nde poder guardar una cuenta con todas sus estadísticas\n",PlayerName2(playerid));
	    ShowPlayerDialog(playerid, DIALOG_REGISTRO, DIALOG_STYLE_PASSWORD, "{FF0000}Pura Joda", "Bievenido ", "Registrar", "Salir");
		
	}
	else
	{
	    new field[30];
	    PlayerInfo[playerid][Registered] = 1;
	    db_get_field_assoc(result, "pIP", field, 30);
		if( (!strcmp(tmp3,field,true)) && (ServerInfo[AutoLogin] == 1) )
		{
			LoginPlayer(playerid);
			PlayerInfo[playerid][TimeON] = gettime();
			if(PlayerInfo[playerid][Level] > 0)
			{
				format(string,sizeof(string),"«» Bievenido de nuevo, Administrador (%d) autenticado con éxito.", PlayerInfo[playerid][Level] );
				SendClientMessage(playerid,green,string);
       		}
	   		else SendClientMessage(playerid,green,"CUENTA: Tu ip coincide con la de la cuenta, te has auto loggeado !.");
  	    } else {
			format(sString, sizeof(sString),"~w~Bienvenido %s Logueate!",PlayerName2(playerid));
    		GameTextForPlayer(playerid,sString,6000,5);

    		ShowPlayerDialog(playerid, DIALOG_INGRESO, DIALOG_STYLE_PASSWORD, ""G"Pura Joda", ""G"Nick registrado porfavor ingrese su "G"contraseña.", "Ingresar", "Salir");
            Readyd[playerid] = false;
			//SetPlayerPos(playerid, Pos_x,Pos_y,Pos_z);
		}

	}

	//-----------------------------------------------------
	if(Adentro[playerid] == 52)
	{
	    Adentro[playerid] = 0;
		return 1;
	}
	//-----------------------------------------------------
	new field[30];
	db_get_field_assoc(result, "pBanned", field, 30);
    if (strval(field) == 1)
    {
//	   new string[200];
       SendClientMessage(playerid, red, "Este nombre esta baneado de este servidor!");
	   format(string,sizeof(string),"%s ID:%d ha sido auto kickeado. Razon: Nombre baneado del servidor",PlayerName,playerid);
	   SendClientMessageToAll(grey, string); print(string);
	   SaveToFile("KickLog",string);  Kick(playerid);
    }
    db_free_result(result);
	//-----------------------------------------------------

	if(ServerInfo[Locked] == 1) {
		PlayerInfo[playerid][AllowedIn] = false;
		SendClientMessage(playerid,red,"El Servidor esta Bloqueado!  Tienes 20 segundos para ingresar la contraseña del servidor antes de ser kickeado!");
		SendClientMessage(playerid,red,"Escriba /password [contraseña]");
		LockKickTimer[playerid] = SetTimerEx("AutoKick", 30000, 0, "i", playerid);
	}
	//-----------------------------------------------------
//	new string[200];
//	new tmp3[200];
//	new file[100+MAX_PLAYER_NAME];
//	new str[128];
	//-----------------------------------------------------
	if(strlen(dini_Get("ladmin/config/aka.txt", tmp3)) == 0) dini_Set("ladmin/config/aka.txt", tmp3, PlayerName);
 	else
	{
	    if( strfind( dini_Get("ladmin/config/aka.txt", tmp3), PlayerName, true) == -1 )
		{
		    format(string,sizeof(string),"%s,%s", dini_Get("ladmin/config/aka.txt",tmp3), PlayerName);
		    dini_Set("ladmin/config/aka.txt", tmp3, string);
		}
	}
	//-----------------------------------------------------
	new plrIP[16];
	new str2[170];
	GetPlayerIp(playerid, plrIP, sizeof(plrIP));
       // SendDeathMessage(INVALID_PLAYER_ID, playerid, 200);
		new country[MAX_COUNTRY_NAME];
		country = GetPlayerCountryName(playerid);
        GetPlayerIp(playerid, plrIP, sizeof(plrIP));
	    new pAKA[256]; pAKA = dini_Get("ladmin/config/aka.txt",tmp3);
		new conect[300];

	//	format(str,sizeof(str),""R"***Info: "W"%s "R"["W"%d"R"] [País: "W"Privado"R"] [IP: "W"%s"R"] ha entrado al servidor.", PlayerName, playerid,country,plrIP);
		format(conect,sizeof(conect),""R"***Info: "W"%s "R"[%d] ha entrado al servidor [País: "W"%s"R"]", PlayerName, playerid,country);
		format(str2,sizeof(str2),""R"[IP: "W"%s"R"][Aka "W"%s"R"]",plrIP,pAKA);
		SendClientMessageToAll(-1, conect);
		//SendClientMessage(playerid, -1, conect);
	//printf(conect);
		// SaveToFile("Conecciones",str);
		TempBanCheck(playerid);
		if(!strcmp(PlayerName2(playerid), "[Ek]Holache", true)) return 1;
		for(new i = 0; i < MAX_PLAYER; i++)
		{
		if(IsPlayerConnected(i))
		{
			if(PlayerInfo[i][Level] > 1)
			{
		 	//SendClientMessage(i,COLOR_LIGHTBLUE,conect);
		  	SendClientMessage(i, COLOR_LIGHTBLUE,str2);
			}
		}
		}

	
 	return 1;
}
//==============================================================================

forward AutoKick(playerid);
public AutoKick(playerid)
{
	if( IsPlayerConnected(playerid) && ServerInfo[Locked] == 1 && PlayerInfo[playerid][AllowedIn] == false) {
		new string[128];
		SendClientMessage(playerid,grey,"Has sido automáticamente kickeado. Razón: Servidor bloqueado");
		format(string,sizeof(string),"%s ID:%d ha sido automáticamente kickeado. Razón: Servidor bloqueado",PlayerName2(playerid),playerid);
		SaveToFile("KickLog",string);  Kick(playerid);
		SendClientMessageToAll(grey, string); print(string);
	}
	return 1;
}

//==============================================================================
forward GetPlayerVar(playerid, vartype);
forward GetPlayerVarMoneyE(playerid);
forward SetPlayerVarMoneyE(playerid, value);
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
				    new string2[150];
					SetPVarInt(playerid, "MINION", 0);
					SetPVarInt(Duelos[i][DesafiadoId], "MINION", 0);
					format(string2,sizeof(string2),"[Pura Joda] "W"%s "G"abandonó el duelo. "W"%s "G"gana. Apuesta %d PJCoins",PlayerName2(playerid),PlayerName2(Duelos[i][DesafiadoId]),Duelos[i][Apuesta]);
					SendClientMessageToAll(LIGHTGREEN,string2);
					SetPVarInt(Duelos[i][DesafiadoId], "COIN", GetPVarInt(Duelos[i][DesafiadoId], "COIN")+Duelos[i][Apuesta]);
					SetPVarInt(playerid, "COIN", GetPVarInt(playerid, "COIN")-Duelos[i][Apuesta]);
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
			            	TogglePlayerSpectating(j, 0);
							ViendoDuelo[j] = -1;
							KillTimer(Dueled[j]);
							SetPVarInt(j, "MINION", 0);
	    				}
					}
				}
				if (playerid == Duelos[i][DesafiadoId])
				{
				    new string2[128];
					format(string2,sizeof(string2),"[Pura Joda] "W"%s "G"abandonó el duelo. "W"%s "G"gana. Apuesta %d PJCoins",PlayerName2(playerid),PlayerName2(Duelos[i][DesaId]),Duelos[i][Apuesta]);
                    SetPVarInt(Duelos[i][DesafiadoId], "COIN", GetPVarInt(Duelos[i][DesafiadoId], "COIN"));
					SendClientMessageToAll(LIGHTGREEN,string2);
					SetPVarInt(playerid, "MINION", 0);
					SetPVarInt(Duelos[i][DesafiadoId], "MINION", 0);
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
			            	TogglePlayerSpectating(j, 0);
							ViendoDuelo[j] = -1;
							KillTimer(Dueled[j]);
							SetPVarInt(j, "MINION", 0);
	    				}
					}
				}
				Duelos[i][DesaId] = -1;
				Duelos[i][DesafiadoId] = -1;
				Duelos[i][ArmasId] = -1;

			}
		}
	}
	SavePlayer(playerid);
	if(Joined[playerid] == true)
    {
    	SetPVarInt(playerid, "RACE", 0);
		JoinCount--;
		DisableRemoteVehicleCollisions(playerid,0);
		Joined[playerid] = false;
	//	contador--;
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
		SetPlayerVirtualWorld(playerid, 0);



	}
	if(BuildRace == playerid+1) BuildRace = 0;
	if(Racer == playerid)
	{
	    EndRace();
	}
 
 if(PlayerInfo[playerid][blip] == 1) {
				KillTimer( BlipTimer[playerid] );
				PlayerInfo[playerid][blip] = 0;
			}
	Buy[playerid] = false;
	if(IsVehicleOccupied(CurrentSpawnedVehicle[playerid])) {} else DestroyVehicle(CurrentSpawnedVehicle[playerid]);

    Delete3DTextLabel(VIPS[playerid]);
    Delete3DTextLabel(VidaI[playerid]);
    //TextDrawHideForPlayer(playerid, TD_RANKINGSCORE[0]);
	//TextDrawHideForPlayer(playerid, TD_RANKINGSCORE[1]);
    if(IsBeingSpeced[playerid] == 1)
    {
       foreach(new i : Player)
        {
          if(spectatorid[i] == playerid)
             {
               TogglePlayerSpectating(i,false);
             }
        }
    }

	vida[playerid] = 0;
	granadas[playerid] = 0;
	pdie[playerid] = 0;
	chaleco[playerid] = 0;
	SinComandos[playerid] = 0;
	FueraDeEvento[playerid] = false;
	DestroyAllAttachObject(playerid); //Sistema de Objetos by 43z
	if(Ironman[playerid][ActivarIronman])
	{
	    Ironman[playerid][TurbinasIronman] = -1;
        SetPlayerHealth(playerid, Ironman[playerid][EnergiaIronman][0]);
        SetPlayerArmour(playerid, Ironman[playerid][EnergiaIronman][1]);
        SetPlayerSkin(playerid, Ironman[playerid][VestimentaTony]);
        SetPlayerVelocity(playerid, 0, 0, 0);
        Ironman[playerid][IronmanVolando]=false;
		Ironman[playerid][ActivarIronman] = false;
		KillTimer(Ironman[playerid][MatarIronman][0]);
		//SendClientMessage(playerid, -1, "JARVIS: Señor, usted se ha quitado el traje 'Ironman'!.");
		ApplyAnimation(playerid,"CARRY","crry_prtial",4.0,0,0,0,0,0);
		for(new index=0; index<6; index++) { RemovePlayerAttachedObject(playerid,index); }
	}
	new PlayerName[MAX_PLAYER_NAME], str[128];
	GetPlayerName(playerid, PlayerName, sizeof(PlayerName));
    Reantiflood[playerid] = 0;
	if(playerid == g_DuelingID1 || playerid == g_DuelingID2)
	{
	    g_DuelInProgress = 0;
	}

    /*if(udb_Exists(PlayerName2(playerid))) dUserSetINT(PlayerName2(playerid)).("loggedin",0);*/
    PlayerInfo[playerid][LoggedIn] = 0;
	PlayerInfo[playerid][Jailed] = 0;
	PlayerInfo[playerid][Hide] = 0;
	PlayerInfo[playerid][Frozen] = 0;
	PlayerEnPGOD[playerid] = 0;
	balason[playerid] = true;
	SetPVarInt(playerid, "PREMIUM", 0);
	PlayerInfo[playerid][rcona] = 0;
	PlayerInfo[playerid][PreDia] = 0;
	PlayerInfo[playerid][PreMes] = 0;
	PlayerInfo[playerid][PreAno] = 0;
	if(PlayerInfo[playerid][Jailed] == 1) KillTimer( JailTimer[playerid] );
	if(PlayerInfo[playerid][Frozen] == 1) KillTimer( FreezeTimer[playerid] );
	if(ServerInfo[Locked] == 1)	KillTimer( LockKickTimer[playerid] );

	if(PlayerInfo[playerid][pCar] != -1) CarDeleter(PlayerInfo[playerid][pCar]);

	#if defined ENABLE_SPEC
	for(new x=0; x<MAX_PLAYER; x++)
	    if(GetPlayerState(x) == PLAYER_STATE_SPECTATING && PlayerInfo[x][SpecID] == playerid)
   		   	AdvanceSpectate(x);
	#endif

    Monster[playerid] = 0;
    USERCHUCK[playerid] = 0;
    ADMINCHUCK[playerid] = 0;
//	ShowInformationTxt(playerid);
	if(Adentro[playerid] == 52)
	{
    	Adentro[playerid] = 0;
		return 1;
	}
    Adentro[playerid] = 0;
	switch (reason) {
		case 0:	format(str, sizeof(str), "*** %s [%d] ha dejado el servidor (CRASH)", PlayerName, playerid);
		case 1:	format(str, sizeof(str), "*** %s [%d] ha dejado el servidor (SALIO)", PlayerName, playerid);
		case 2:	format(str, sizeof(str), "*** %s [%d] ha dejado el servidor (Kicked/Banned)", PlayerName, playerid);
	}
	
	SendClientMessage(playerid,grey, str);
	//SendDeathMessage(INVALID_PLAYER_ID, playerid, 201);
	if(ServerInfo[ConnectMessages] == 1)
	{
		switch (reason) {
			case 0:	format(str, sizeof(str), "*** %s [%d] ha dejado el servidor (CRASH)", PlayerName, playerid);
			case 1:	format(str, sizeof(str), "*** %s [%d] ha dejado el servidor (SALIO)", PlayerName, playerid);
			case 2:	format(str, sizeof(str), "*** %s [%d] ha dejado el servidor (Kicked/Banned)", PlayerName, playerid);
		}
		SendClientMessageToAll(grey, str);
	}

	PlayerInfo[playerid][Level] = 0;

 	return 1;
}

forward DelayKillPlayer(playerid);
public DelayKillPlayer(playerid)
{
	SetPlayerHealth(playerid,0.0);
	ForceClassSelection(playerid);
}


//==============================================================================
public OnPlayerSpawn(playerid)
{
Warns[playerid] = 0;
	if(Sync[playerid]) return 1;
    SetPlayerHealth(playerid, 99999.0);
    SetTimerEx("SpawnProtection", 5000, false, "i", playerid);

	if(Enterr[playerid]){
	Enterr[playerid] = false;
	StopAudioStreamForPlayer(playerid);
	}
	PlayerTextDrawShow(playerid, statings[playerid]);
	for(new i; i < MAX_PLAYER_ATTACHED_OBJECTS; i++)
 	if(ao[playerid][i][ao_model] != -1) SetPlayerAttachedObject(playerid, i, ao[playerid][i][ao_model], ao[playerid][i][ao_bone], ao[playerid][i][ao_x], ao[playerid][i][ao_y], ao[playerid][i][ao_z], ao[playerid][i][ao_rx], ao[playerid][i][ao_ry], ao[playerid][i][ao_rz], ao[playerid][i][ao_sx], ao[playerid][i][ao_sy], ao[playerid][i][ao_sz]);

	if(!Novel[playerid]){
	PNovel(playerid);
	Novel[playerid] = 1;
	}
	if(PlayerInfo[playerid][fColor] != -1) SetPlayerColor(playerid, colores[PlayerInfo[playerid][fColor]][colorHex]);
	Buy[playerid] = false;
	if(pSave[playerid] == 1 && GetPVarInt(playerid, "Save") == 1){
	for(new i = 0; i != 9; i++){
	if(Weap[i][0] != -1 && IsValidWeapon(Weap[i][0])){
 	GivePlayerWeapon(playerid,Weap[i][0], 9999);
 	}
	}
//	SendClientMessage(playerid, LIGHTGREEN, "[Pura Joda] Armas listas.");
	}
	TextDrawShowForPlayer(playerid, WebTextdraw);
	//PlayerTextDrawShow(playerid, Textdraw0[playerid]);
	//UpDateTopRankingPlayer();
    SetPlayerScore(playerid, GetPVarInt(playerid, "Score"));
	//TextDrawShowForPlayer(playerid, TD_RANKINGSCORE[0]);
	//TextDrawShowForPlayer(playerid, TD_RANKINGSCORE[1]);
    if(IsSpecing[playerid] == 1)
    {
	    SetPlayerPos(playerid,SpecX[playerid],SpecY[playerid],SpecZ[playerid]);
	    SetPlayerInterior(playerid,Inter[playerid]);
	    SetPlayerVirtualWorld(playerid,vWorld[playerid]);
	    IsSpecing[playerid] = 0;
	    IsBeingSpeced[spectatorid[playerid]] = 0;
    }
 /*   ShowInformationTxt(playerid);
	TextDrawShowForPlayer(playerid, stats0);
	TextDrawShowForPlayer(playerid, stats1);
	TextDrawShowForPlayer(playerid, stats2);
	TextDrawShowForPlayer(playerid, stats8);
	TextDrawShowForPlayer(playerid, stats7);
	TextDrawShowForPlayer(playerid, stats6);
	TextDrawShowForPlayer(playerid, stats5);
	TextDrawShowForPlayer(playerid, stats4);
	PlayerTextDrawShow(playerid, stats3[playerid] );*/
//	Show2(playerid);

	if(GetPVarInt(playerid, "PREMIUM") == 4)
	{
	    new dia, mes, ano;
	    getdate(ano, mes, dia);
	    if(PlayerInfo[playerid][PreDia] != 0 && PlayerInfo[playerid][PreMes] != 0 && PlayerInfo[playerid][PreAno] != 0)
	    {
		    if(PlayerInfo[playerid][PreDia] <= dia && PlayerInfo[playerid][PreMes] <= mes && PlayerInfo[playerid][PreAno] <= ano)
		    {
		        PlayerInfo[playerid][PreDia] = 0; PlayerInfo[playerid][PreMes] = 0; PlayerInfo[playerid][PreAno] = 0; SetPVarInt(playerid, "PREMIUM", 0);
		        SendClientMessage(playerid, red, "ATENCIÓN: {FFFFFF}Tu premium LVL 4 a VENCIDO.");
		        SendClientMessage(playerid, red, "[Pura Joda]: {FFFFFF}Tu premium lvl 4 fue revocado, si piensas que es un error habla con un administrador");
		        new string[256]; format(string, sizeof(string), "[%02d/%02d/%d] %s perdió el premium lvl 4 por el vencimiento",dia, mes, ano, PlayerName2(playerid));
		        SaveToFile("Premium4Log",string);
		    } else if(PlayerInfo[playerid][PreDia]-3 == dia && PlayerInfo[playerid][PreMes] == mes && PlayerInfo[playerid][PreAno] == ano)
		    {
		        SendClientMessage(playerid, red, "ATENCIÓN: {FFFFFF}Tu premium LVL 4 esta por VENCER.");
		        SendClientMessage(playerid, red, "[Pura Joda]: {FFFFFF}Tu premium lvl 4 esta por vencer en 3 dias, comunicate para efectuar el renovamiento");
		    }
		}
	}
//	TextDrawShowForPlayer(playerid, Information[playerid] );
    AceleracionBrutal[playerid] = false;
    balason[playerid] = true;
    //SendClientMessage(playerid, LIGHTGREEN, "[Pura Joda] ¡Estás siendo protegido por el anti-spawnkill!");
    /*if(PlayerInfo[playerid][LoggedIn] == 1)	SavePlayer(playerid);*/
    new playername[MAX_PLAYER_NAME];
    GetPlayerName(playerid, playername, sizeof(playername));

   // ShowInformationTxt(playerid);
	if(ServerInfo[Locked] == 1 && PlayerInfo[playerid][AllowedIn] == false)
	{
		GameTextForPlayer(playerid,"~r~Servidor Bloqueado~n~Debes ingresar la contraseña antes de jugar~n~/password <contraseña>",4000,3);
		SetTimerEx("DelayKillPlayer", 2500,0,"d",playerid);
		return 1;
	}

	PlayerInfo[playerid][Spawned] = 1;
    if (GetPVarInt(playerid, "PREMIUM") >= 1)
	{
    	if(GetPVarInt(playerid, "PREMIUM")  == 1)
		{
    		SetPlayerArmour(playerid, 25.0);
		}
    	if(GetPVarInt(playerid, "PREMIUM")  == 2)
		{
    		SetPlayerArmour(playerid, 50.0);
		}
    	if(GetPVarInt(playerid, "PREMIUM")  == 3)
		{
    		SetPlayerArmour(playerid, 75.0);
		}
    	if(GetPVarInt(playerid, "PREMIUM")  == 4)
		{
    		SetPlayerArmour(playerid, 100.0);
  		 	VIPS[playerid] = Create3DTextLabel("VIP 4 Member", COLOR_VIP, 0.0, 0.0, 0.0, 50.0, 0, 0);
            Attach3DTextLabelToPlayer(VIPS[playerid], playerid, 0.0, 0.0, 0.0);
		}
    	SetPlayerHealth(playerid, 100);
    }

	if(PlayerInfo[playerid][Frozen] == 1) {
		TogglePlayerControllable(playerid,false); return SendClientMessage(playerid,red,"¿Crees que escaparás? Sigues congelado.");
	}

	if(PlayerInfo[playerid][Jailed] == 1) {
	    SetTimerEx("JailPlayer",3000,0,"d",playerid); return SendClientMessage(playerid,red,"¿Crees que escaparás? Bievenido a la cárcel, de nuevo.");
	}

	if(ServerInfo[AdminOnlySkins] == 1) {
		if( (GetPlayerSkin(playerid) == ServerInfo[AdminSkin]) || (GetPlayerSkin(playerid) == ServerInfo[AdminSkin2]) ) {
			if(PlayerInfo[playerid][Level] >= 1)
				GameTextForPlayer(playerid,"~b~Bienvenido~n~~w~Administrador",3000,1);
			else {
				GameTextForPlayer(playerid,"~r~Este skin es para~n~Administradores~n~unicamente",4000,1);
				SetTimerEx("DelayKillPlayer", 2500,0,"d",playerid);
				return 1;
			}
		}
	}

	if(PlayerInfo[playerid][UseSkin] == 1)
		if((GetPVarInt(playerid, "PREMIUM") >= 1) || (PlayerInfo[playerid][Level] > 0))
    		SetPlayerSkin(playerid, PlayerInfo[playerid][FavSkin]);

	//if(ServerInfo[GiveWeap] == 1) {
		/*if(PlayerInfo[playerid][LoggedIn] == 1) {
			PlayerInfo[playerid][TimesSpawned]++;
			if(PlayerInfo[playerid][TimesSpawned] == 1)
			{
 				GivePlayerWeapon(playerid, dUserINT(PlayerName2(playerid)).("weap1"), dUserINT(PlayerName2(playerid)).("weap1ammo")	);
				GivePlayerWeapon(playerid, dUserINT(PlayerName2(playerid)).("weap2"), dUserINT(PlayerName2(playerid)).("weap2ammo")	);
				GivePlayerWeapon(playerid, dUserINT(PlayerName2(playerid)).("weap3"), dUserINT(PlayerName2(playerid)).("weap3ammo")	);
				GivePlayerWeapon(playerid, dUserINT(PlayerName2(playerid)).("weap4"), dUserINT(PlayerName2(playerid)).("weap4ammo")	);
				GivePlayerWeapon(playerid, dUserINT(PlayerName2(playerid)).("weap5"), dUserINT(PlayerName2(playerid)).("weap5ammo")	);
				GivePlayerWeapon(playerid, dUserINT(PlayerName2(playerid)).("weap6"), dUserINT(PlayerName2(playerid)).("weap6ammo")	);
			}
		}*/
	//}
	return 1;
}

//==============================================================================
public OnPlayerTakeDamage(playerid, issuerid, Float: amount, weaponid, bodypart)
{
/*	if(IsPlayerInAnyVehicle(issuerid))
	{
	    if(!GetPlayerVehicleSeat(issuerid) && !PlayerInfo[issuerid][Jailed] && !Warnered[issuerid])
		{
			new cade[128];
        	Warns[issuerid]++;
			format(cade, 128, "[Pura Joda] ¡Car Kill prohibido! estás advertido. (%d/3)",Warns[issuerid]);
			SendClientMessage(issuerid, -1, cade);
			if(Warns[issuerid] == 3)
			{
					PlayerInfo[issuerid][JailTime] = 3*1000*60;
    			    SetTimerEx("JailPlayer",5000,0,"d",issuerid);
		    	    SetTimerEx("Jail1",1000,0,"d",issuerid);
		        	PlayerInfo[issuerid][Jailed] = 1;
		        	Warns[issuerid] = 0;
			format(cade, 128, "[Pura Joda] ¡AHÍ ESTÁ TU CASTIGO WASHO! (%d/3)",Warns[issuerid]);
			SendClientMessage(issuerid, -1, cade);
			Warnered[issuerid] = true;
			SetTimerEx("Warnerede", 3000, 0, "i", issuerid);
			}
	    }

	}*/
	if(!PlayerInfo[playerid][God] && !GetPVarInt(playerid, "AFK")){
	if(issuerid != INVALID_PLAYER_ID && weaponid == 34 && bodypart == 9 && GetPVarInt(playerid, "MINION") == 0)
	{
		SetPlayerHealth(playerid, 0.0);
		SetPlayerArmour(playerid, 0.0);
//		SetPVarInt(issuerid, "Score", GetPVarInt(issuerid, "Score")+1);
		GameTextForPlayer(playerid, "~r~~h~BOOOOOOOOOOOM! ~W~HEADSHOT",5000,3);
		GameTextForPlayer(issuerid, "~r~~h~BOOOOOOOOOOOM! ~W~HEADSHOT",5000,3);

    }
    }
    return true;
}
function Warnerede(i){
Warnered[i] = false;
return 1;
}
public OnPlayerDeath(playerid, killerid, reason)
{
Warns[playerid] = 0;
	if(FueraDeEvento[playerid]) {
	cmd_salirdm(playerid, "");
	}
	if (EnDuelo[playerid] == 1 && EnDuelo[killerid] == 1)
 	{
		for (new i=1; i<= ARENAS; i++)
		{
			if ((Duelos[i][DesaId] == playerid || Duelos[i][DesaId] == killerid) && (Duelos[i][DesafiadoId] == playerid) || (Duelos[i][DesafiadoId] == killerid))
			{
			    new str[150];
			    format(str,sizeof(str),"[Pura Joda] "W"%s "G"ganó el duelo contra "W"%s. "G"Apuesta %d PJCoins",PlayerName2(killerid),PlayerName2(playerid),Duelos[i][Apuesta]);
			    SendClientMessageToAll(LIGHTGREEN,str);
			   /* format(str,sizeof(str),"[Pura Joda] Duelo Info: Haz ganado el duelo contra %s",PlayerName2(playerid));
		   	    SendClientMessage(killerid,LIGHTGREEN,str);
        		SendClientMessage(killerid,COLOR_DUELO,"Duelo Info: Ahora estas en las graderias, para volver a tener un duelo usa /duelo invitar.");
			 	*/EnDuelo[playerid] = 0;
				EnDuelo[killerid] = 0;
				Duelos[i][DesafiadoId] = -1;
   				Duelos[i][DesaId] = -1;
    			Duelos[i][ArmasId] = -1;
				Duelos[i][Libre] = 0;
				SetPVarInt(playerid, "MINION", 0);
				SetPVarInt(killerid, "MINION", 0);
				SetPVarInt(killerid, "COIN", GetPVarInt(killerid, "COIN")+Duelos[i][Apuesta]);
				SetPVarInt(playerid, "COIN", GetPVarInt(playerid, "COIN")-Duelos[i][Apuesta]);
				SpawnPlayer(killerid);
				for (new j=0; j< MAX_PLAYERS; j++)
				{
				    if (ViendoDuelo[j] == i)
	    			{
	    			    new str2[256];
		        		format(str2,sizeof(str2),"~r~%s ~w~es el ganador del duelo",PlayerName2(killerid));
						GameTextForPlayer(j,str2,5000,0);
						ViendoDuelo[j] =-1;
 						TogglePlayerSpectating(j, 0);
						KillTimer(Dueled[j]);
						SetPVarInt(j, "MINION", 0);

	    			}
				}


			}
		}
	}
    if(Joined[playerid] == true)
    {
    	SetPVarInt(playerid, "RACE",0);
		JoinCount--;
    //    contador--;
		DisableRemoteVehicleCollisions(playerid,0);
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
    Buy[playerid] = false;


	new
	 	sString[128],
	   	cName[MAX_PLAYER_NAME],
	   	zName[MAX_PLAYER_NAME],
	   	Float:Health,
	   	Float:Armor
	   	;
	/*if(PlayerInfo[playerid][LoggedIn] == 1)	SavePlayer(playerid);*/

	#if defined USE_STATS
    PlayerInfo[playerid][Deaths]++;
   // ShowInformationTxt(playerid);
	#endif
    InDuel[playerid] = 0;

	if(IsPlayerConnected(killerid) && killerid != INVALID_PLAYER_ID)
	{
		SetPVarInt(killerid, "Score", GetPVarInt(killerid, "Score")+1);
	}

	#if defined ENABLE_SPEC
	for(new x=0; x<MAX_PLAYER; x++)
	    if(GetPlayerState(x) == PLAYER_STATE_SPECTATING && PlayerInfo[x][SpecID] == playerid)
	       AdvanceSpectate(x);
	#endif
    //ShowInformationTxt(playerid);
	if(Adentro[playerid] == 2)
    {
    SendClientMessage(playerid,COLOR_RED,"¿Te salistes? ¡¡PIERDES BASURA INTERGALÁCTICA!!");
	SetPlayerPos(playerid,2032.1617,1545.1399,10.8203);
    SetPlayerVirtualWorld(playerid, 0);
    DestroyVehicle(Monster[playerid]);
    Adentro[playerid] = 0;
	SetPlayerInterior(playerid,0);
    }
    if(killerid != INVALID_PLAYER_ID)
	if(USERCHUCK[killerid] == 1 && ADMINCHUCK[playerid] == 1)
	{
     	GetPlayerName(killerid, zName, MAX_PLAYER_NAME);
		GameTextForPlayer(killerid,"~r~~h~HAS GANADO! ~N~~G~~H~FELICITACIONES",3000,3);
   		format(sString, sizeof(sString),"[Pura Joda] %s ha ganado el evento /DMCHUCK ¡felicitaciones! *-*", zName,cName,Health,Armor);
       	SendClientMessageToAll(COLOR_ORANGE, sString);
	}
	return 1;
}

//==============================================================================

public OnPlayerText(playerid, text[])
{

	if(text[0] == '#' && PlayerInfo[playerid][Level] >= 1) {
	    new string[144]; GetPlayerName(playerid,string,sizeof(string));
		format(string,sizeof(string),"Admin Chat | {FFFFFF}[ID:%d]{00E8E4}%s dice: {FFFFF8}%s.",playerid,string,text[1]); MessageToAdmins(green,string);
	    return 0;
	}
//===========================================================================================================//

	new dotcount;
    for(new s, l = strlen(text); s < l; s++)
    {
        if (text[s] == ':' && dotcount == 3) return 0;
        if (text[s] == '.' && dotcount < 3) dotcount++;
	}
	if(ServerInfo[MustLogin] == 1 && PlayerInfo[playerid][Registered] == 1 && PlayerInfo[playerid][LoggedIn] == 0)
	{
		GameTextForPlayer(playerid,"~r~~h~Para hablar debes loggearte antes!~n~~w~/LOGIN CONTRASEÑA",4000,3);

		return 0;
	}
	if(DetectarSpam(text))
	{
    	new string[128];
		new te[256];
    	new PlayerName[MAX_PLAYER_NAME];
		GetPlayerName(playerid, PlayerName, MAX_PLAYER_NAME);
		format(te, sizeof(te),"%s: [%d] %s",PlayerName, playerid , text);
    	SendClientMessage(playerid,0xEFEFF7AA, te);
    	format(string,sizeof(string),"[Pura Joda] ¡Pilas admin's! el usuario: %s [ID:%i] esta intentando hacer spam.",PlayerName,playerid);
    	MessageToAdmins(0x9FFF00FF,string);
    	format(string,sizeof(string),"[Pura Joda] Texto enviado: %s",text);
    	MessageToAdmins(0x9FFF00FF,string);
		new tmp3[50], string2[128];
    	GetPlayerIp(playerid,tmp3,50);
    	format(string2,sizeof(string2),"Nombre: %s Texto enviado: %s IP: %s",PlayerName,text,tmp3);
    	SaveToFile("SpamLog",string2);
		return 0;
	}

	if(ServerInfo[DisableChat] == 1) {
		SendClientMessage(playerid,red,"El chat ha sido desactivado");
	 	return 0;
	}

 	if(PlayerInfo[playerid][Muted] == 1)
	{
 		PlayerInfo[playerid][MuteWarnings]++;
 		new string[128];
		if(PlayerInfo[playerid][MuteWarnings] < ServerInfo[MaxMuteWarnings]) {
			format(string, sizeof(string),"[Pura Joda] Estás silenciado, si continuas hablando serás kickeado. (%d / %d)", PlayerInfo[playerid][MuteWarnings], ServerInfo[MaxMuteWarnings] );
			SendClientMessage(playerid,red,string);
		} else {
			SendClientMessage(playerid,red,"[Pura Joda] ¿No te importó la advertencia? ok. Ahora serás kickeado.");
			format(string, sizeof(string),"***%s (ID %d) ha sido kickeado por exceder las muteadas", PlayerName2(playerid), playerid);
			SendClientMessageToAll(grey,string);
			SaveToFile("KickLog",string); Kick(playerid);
		} return 0;
	}

	if(ServerInfo[AntiSpam] == 1 && (PlayerInfo[playerid][Level] == 0 && !IsPlayerAdmin(playerid)) )
	{
		if(PlayerInfo[playerid][SpamCount] == 0) PlayerInfo[playerid][SpamTime] = TimeStamp();

	    PlayerInfo[playerid][SpamCount]++;
		if(TimeStamp() - PlayerInfo[playerid][SpamTime] > SPAM_TIMELIMIT) { // Its OK your messages were far enough apart
			PlayerInfo[playerid][SpamCount] = 0;
			PlayerInfo[playerid][SpamTime] = TimeStamp();
		}
		else if(PlayerInfo[playerid][SpamCount] == SPAM_MAX_MSGS) {
			new string[64]; format(string,sizeof(string),"%s ha sido kickeado (Flood/Spam Protection)", PlayerName2(playerid));
			SendClientMessageToAll(grey,string); print(string);
			SaveToFile("KickLog",string);
			Kick(playerid);
		}
		else if(PlayerInfo[playerid][SpamCount] == SPAM_MAX_MSGS-1) {
			SendClientMessage(playerid,red,"¿Spam? si continúas será kick.");
			return 0;
		}
	}

	if(ServerInfo[AntiSwear] == 1 && PlayerInfo[playerid][Level] < ServerInfo[MaxAdminLevel])
	for(new s = 0; s < ForbiddenWordCount; s++)
    {
		new pos;
		while((pos = strfind(text,ForbiddenWords[s],true)) != -1) for(new i = pos, j = pos + strlen(ForbiddenWords[s]); i < j; i++) text[i] = '*';
	}

	if(PlayerInfo[playerid][Caps] == 1) UpperToLower(text);
	if(ServerInfo[NoCaps] == 1) UpperToLower(text);

	for(new i = 1; i < MAX_CHAT_LINES-1; i++) Chat[i] = Chat[i+1];
 	new ChatSTR[128]; GetPlayerName(playerid,ChatSTR,sizeof(ChatSTR)); format(ChatSTR,128,"[lchat]%s: %s",ChatSTR, text[0] );
	Chat[MAX_CHAT_LINES-1] = ChatSTR;

	return 1;
}

//==============================================================================
forward OnPlayerPrivmsg(playerid, recieverid, text[]);
public OnPlayerPrivmsg(playerid, recieverid, text[])
{
	if(ServerInfo[ReadPMs] == 1 && PlayerInfo[playerid][Level] != ServerInfo[MaxAdminLevel])
	{
    	new string[128],recievername[MAX_PLAYER_NAME];
		GetPlayerName(playerid, string, sizeof(string)); GetPlayerName(recieverid, recievername, sizeof(recievername));
		format(string, sizeof(string), "***PM: %s A %s: %s", string, recievername, text);
		for (new a = 0; a < MAX_PLAYER; a++) if (IsPlayerConnected(a) && (PlayerInfo[a][Level] >= ServerInfo[MaxAdminLevel]) && a != playerid)
		SendClientMessage(a, grey, string);
	}

 	if(PlayerInfo[playerid][Muted] == 1)
	{
		new string[128];
 		PlayerInfo[playerid][MuteWarnings]++;
		if(PlayerInfo[playerid][MuteWarnings] < ServerInfo[MaxMuteWarnings]) {
			format(string, sizeof(string),"[Pura Joda] Estás silenciado, si continuas hablando serás kickeado (Advertencia: %d/%d)", PlayerInfo[playerid][MuteWarnings], ServerInfo[MaxMuteWarnings] );
			SendClientMessage(playerid,red,string);
		} else {
			SendClientMessage(playerid,red,"[Pura Joda] ¿No te importó la advertencia? ok. Ahora serás kickeado.");
			GetPlayerName(playerid, string, sizeof(string));
			format(string, sizeof(string),"%s [ID %d] kickeado por exceder las muteadas", string, playerid);
			SendClientMessageToAll(grey,string);
			SaveToFile("KickLog",string); Kick(playerid);
		} return 0;
	}
	return 1;
}

forward HighLight(playerid);
public HighLight(playerid)
{
	if(!IsPlayerConnected(playerid)) return 1;
	if(PlayerInfo[playerid][blipS] == 0) { SetPlayerColor(playerid, 0xFF0000AA); PlayerInfo[playerid][blipS] = 1; }
	else { SetPlayerColor(playerid, 0x33FF33AA); PlayerInfo[playerid][blipS] = 0; }
	return 0;
}

//==============================================================================
//===================== [ DCMD Commands ]=======================================
 //Sistema de Objetos by 43z
dcmd_eobject(playerid, params[])
{
	#pragma unused params
	if(!IsSlotUsed(playerid)) return SendClientMessage(playerid, 0xFF0000FF, "Error: Tienes los 10 slot ocupados. Use {FFFFFF}/eoremove (0-9) {FF0000}para borrar un objeto");
    ShowPlayerDialog(playerid, DIALOG_OBJECTSELECTION, DIALOG_STYLE_LIST, "Elije en que parte de tu cuerpo quieres el objeto", "Espalda\nCabeza\nParte superior Brazo Izquierdo\nParte Superior Brazo Derecho\nMano Izquierda\nMano Derecha\nMuslo Izquierdo\nMuslo Derecho\nPie Izquierdo\nPie Derecho\nPantorrilla Derecha\nPantorrilla Izquierda\nAntebrazo Izquierdo\nAntebrazo Derecho\nHombro Izquierdo\nHombro Derecho\nCuello\nMandibula", "Ok", "");
    return 1;
}

dcmd_eoremove(playerid, params[])
{
	if(!strlen(params)) return SendClientMessage(playerid, 0xFF0000FF, "Use: /eoremove <0-9/all)"), SendClientMessage(playerid, 0xFF0000FF, "Si elijes 'All' se borraran todos los objetos");
	if(!IsNumeric(params)) return DestroyAllAttachObject(playerid), SendClientMessage(playerid, 0xFF0000FF, "[Pura Joda]: {FFFFFF}Borraste todos los objetos de tu cuerpo");
	if(strval(params) < 0 && strval(params) > 9) return SendClientMessage(playerid, 0xFF0000FF, "Use: /eoremove <0-9/all)"), SendClientMessage(playerid, 0xFF0000FF, "Si elijes 'All' se borraran todos los objetos");
	if(Slot[playerid][strval(params)] == -1) return SendClientMessage(playerid, 0xFF0000FF, "Este slot esta vacio"), SendClientMessage(playerid, 0xFF0000FF, "[Pura Joda]: {FFFFFF}Usa /eoedit para ver que slot los tenes con objetos");
	RemovePlayerAttachedObject(playerid, strval(params));
	Slot[playerid][strval(params)] = -1;
	ao[playerid][strval(params)][ao_model] = -1;
	new string[144];
	format(string,sizeof(string), "[Pura Joda] {FFFFFF}Eliminaste el objeto número {FF0000}%d{FFFFFF}, puedes colocar otro objeto", strval(params));
	SendClientMessage(playerid, 0xFF0000FF, string);
	return 1;
}

dcmd_eoedit(playerid, params[])
{
    #pragma unused params
	new string[300], str[50];
	format(string, sizeof(string), "Slot\tModel ID\n");
	for(new i = 0; i <= 9; i++)
	{
	    if(Slot[playerid][i] != -1)
	    {
	        format(str, sizeof(str), "%d\t%d\n", i, Slot[playerid][i]);
	        strcat(string, str);
		} else {
		    format(str, sizeof(str), "%d\tEste NO esta Usado\n", i);
	        strcat(string, str);
		}
	}
	ShowPlayerDialog(playerid, DIALOG_OBJECTSELECTION+2, DIALOG_STYLE_TABLIST_HEADERS, "¿Que slot desea editar?", string, "Ok", "Cancelar");
	return 1;
}

dcmd_menueventos(playerid,params[]){
	if(PlayerInfo[playerid][Level] >= 1) {
		#pragma unused params
		return ShowPlayerDialog(playerid,MENU_EVENTOS_CONFIG,DIALOG_STYLE_LIST,"Menú de eventos","Crear evento\nPosición del evento Aquí\nConfigurar El Evento!\nCerrar Evento\nTerminar Evento\nAnunciar Evento\nConsideraciones generales.\nAbrir Evento\nRecuerda divertir los users!","Seleccionar","Salir");
	}
	return 1;
}
dcmd_salirevento(playerid,params[]){
	//if(PlayerInfo[playerid][Level] >= 1) {
	#pragma unused params
	SinComandos[playerid] = 0;
	FueraDeEvento[playerid] = false;
	SetPlayerVirtualWorld(playerid, 0);
	return SpawnPlayer(playerid);
}
dcmd_msethealth(playerid, params[]){
if(PlayerInfo[playerid][Level] <= 1) return SendClientMessage(playerid, red, "[Pura Joda] Usted no tiene permisos suficientes.");
if(!Evento[Creado]) return SendClientMessage(playerid, VERMELHO, "[ERROR] No hay eventos creados /MenuEventos");
if(!strlen(params)) return SendClientMessage(playerid, -1, "[Pura Joda] /Msethealth [Cantidad]");
if(!isNumeric(params)) return SendClientMessage(playerid, -1, "[Pura Joda] /Msethealth [Cantidad]");
for(new i, p = GetMaxPlayers(); i < p; i ++)
{
		if(!FueraDeEvento[i]) continue;
		SetPlayerHealth(i, strval(params));
}
	new string[144];
	format(string, 256,"Administrador %s ha configurado la vida de todos en el evento a %d",PlayerName2(playerid),strval(params));
	SendClientMessageToAll(blue,string);

return 1;
}
dcmd_msetarmour(playerid, params[]){
if(PlayerInfo[playerid][Level] <= 1) return SendClientMessage(playerid, red, "[Pura Joda] Usted no tiene permisos suficientes.");
if(!Evento[Creado]) return SendClientMessage(playerid, VERMELHO, "[ERROR] No hay eventos creados /MenuEventos");
if(!strlen(params)) return SendClientMessage(playerid, -1, "[Pura Joda] /Msethealth [Cantidad]");
if(!isNumeric(params)) return SendClientMessage(playerid, -1, "[Pura Joda] /Msethealth [Cantidad]");
for(new i, p = GetMaxPlayers(); i < p; i ++)
{
		if(!FueraDeEvento[i]) continue;
		SetPlayerArmour(i, strval(params));
}
	new string[144];
	format(string, 256,"Administrador %s ha configurado el chaleco de todos en el evento a %d",PlayerName2(playerid),strval(params));
	SendClientMessageToAll(blue,string);

return 1;
}
dcmd_armasevento(playerid,params[]){
	if(PlayerInfo[playerid][Level] <= 1) return SendClientMessage(playerid, red, "[Pura Joda] Usted no tiene permisos suficientes.");
	if(!Evento[Creado]) return SendClientMessage(playerid, VERMELHO, "[ERROR] No hay eventos creados /MenuEventos");
	new tmp[256]; new idx;
	tmp = strtok(params, idx);
	if(!strlen(tmp)) return SendClientMessage(playerid, VERMELHO, "[ERROR] Use: /ArmasEvento [ID DE ARMA] [MUNICION]");
	new Arma, Municao;
	Arma = strval(tmp);
	tmp = strtok(params, idx);
	if(!strlen(tmp)) return SendClientMessage(playerid, VERMELHO, "[ERROR] Use: /ArmasEvento [ID DA ARMA] [MUNICION]");
	Municao = strval(tmp);
	if(Arma > 43) return SendClientMessage(playerid, VERMELHO, "[ERROR] ID De arma entre 0 e 43!");
	if(Municao < 1) return SendClientMessage(playerid, VERMELHO, "[ERROR] La Municion debe ser mayor a 0!");

	for(new i, p = GetMaxPlayers(); i < p; i ++)
	{
		if(!FueraDeEvento[i]) continue;
		FueraDeEvento[playerid] = true;
		GivePlayerWeapon(i, Arma, Municao);
	}
	new Nombre[MAX_PLAYER_NAME];
	new string[144];
	GetPlayerName(playerid, Nombre, sizeof(Nombre));
	format(string, 256,"Administrador %s dió en el evento armas %d y %d de munición.", Nombre,Arma,Municao);
	SendClientMessageToAll(blue,string);
	return SendClientMessage(playerid,red,"Has Armado el evento");
}
dcmd_autosevento(playerid,params[]){
	if(PlayerInfo[playerid][Level] <= 1) return SendClientMessage(playerid, red, "[Pura Joda] Usted no tiene permisos suficientes.");
	if(!Evento[Creado]) return SendClientMessage(playerid, VERMELHO, "[ERROR] No hay ni un evento usa /MenuEventos");
	new tmp[256],idx;
	tmp = strtok(params, idx);
	if(!strlen(tmp)) return SendClientMessage(playerid, VERMELHO, "[ERROR] Use: /AutosEvento [MODELO]");
	new Modelo = strval(tmp), Float:x, Float:y, Float:z;
	if(Modelo < 400 || Modelo > 611) return SendClientMessage(playerid, VERMELHO, "[ERROR] EL modelo del veiculo debe ser mayor que 400 y menor que 611!");
	for(new i = 0; i < sizeof Cars; i ++) { DestroyVehicle(Cars[i]); Cars[i] = -1; }
	SetPlayerVirtualWorld(playerid,0);
	for(new i, p = GetMaxPlayers(); i < p; i++)
	{
		if(!FueraDeEvento[i]) continue;
		GetPlayerPos(i, x, y, z);
		SetPlayerVirtualWorld(i,0);
		Cars[i] = CreateVehicle(Modelo, x, y, z, 0, random(255), random(255), -1);
		PutPlayerInVehicle(i, Cars[i], 0);
		LinkVehicleToInterior(Cars[i], GetPlayerInterior(i));
		AddVehicleComponent(Cars[i], 1010);
	}
	new Nombre[256];
	new string[256];
	GetPlayerName(playerid, Nombre, sizeof(Nombre));
	format(string, 256,"[Pura Joda] Administrador %s dió a todos autos en el evento %s",Nombre,VehicleNames[Modelo-400]);
	SendClientMessageToAll(blue,string);
	return SendClientMessage(playerid,red,"[Pura Joda] Has dado autos en el evento.");
}
dcmd_skinevento(playerid,params[]){
	if(PlayerInfo[playerid][Level] <= 2) return SendClientMessage(playerid, red, "[Pura Joda] Usted no tiene permisos suficientes.");
	if(!Evento[Creado]) return SendClientMessage(playerid, VERMELHO, "[ERROR] No hay un evento usa /MenuEventos");
	new tmp[256],idx;
	tmp = strtok(params,idx);
	if(!strlen(tmp)) return SendClientMessage(playerid, VERMELHO, "[ERROR] Use: /SkinEvento [ID Skin]");
	new skinmodel = strval(tmp);
	if(skinmodel < 0 || skinmodel > 309) return SendClientMessage(playerid, VERMELHO,"El skin tiene que ser mayor de 0 y menor de 309");
	for(new i, p = GetMaxPlayers(); i < p; i ++)
	{
		FueraDeEvento[playerid] = true;
		if(!FueraDeEvento[i]) continue;
		SetPlayerSkin(i,skinmodel);
	}
	new Nombre[MPN], string2[128];
	format(string2,sizeof(string2),"[Pura Joda] Administrador %s ha puesto el skin de todos en %d",Nombre,skinmodel);
	return SendClientMessageToAll(blue,string2);
}
dcmd_irevento(playerid,params[]){
	#pragma unused params
	if(!Evento[Creado]) return SendClientMessage(playerid, VERMELHO, "[ERROR] No hay ni un evento Creado");
	if(Evento[Cerrado]) return SendClientMessage(playerid, VERMELHO, "[ERROR] ¡EVENTO CERRADO!");
	if(FueraDeEvento[playerid]) return SendClientMessage(playerid, VERMELHO, "[ERROR] Ya estás en el evento!");
	GetPlayerPos(playerid, Pos[playerid][0], Pos[playerid][1], Pos[playerid][2]);
	GetPlayerFacingAngle(playerid, Pos[playerid][3]);
	SetCameraBehindPlayer(playerid);
	SinComandos[playerid] = 1;
	TogglePlayerControllable(playerid, 0);
	Int[playerid] = GetPlayerInterior(playerid);
	VW[playerid] = GetPlayerVirtualWorld(playerid);
	Skin[playerid] = GetPlayerSkin(playerid);
	SendClientMessage(playerid, AMARELO, "[Pura Joda] Has entrado al evento usa /SalirEvento si no quieres continuar");
	SetPlayerPos(playerid, Evento[x1]+1, Evento[y2], Evento[z3]+0.5);
	SetPlayerInterior(playerid, Evento[Interior]);
	SetPlayerVirtualWorld(playerid, Evento[VirtualWorld]);
	FueraDeEvento[playerid] = true;
	ResetPlayerWeapons(playerid);
	SetPlayerHealth(playerid, 100);
	SetPlayerArmour(playerid, 100);
	SetPVarInt(playerid, "MINION", 1);
	return 1;
}
/*CMD:s(playerid, params[]){
if(GetPlayerState(playerid) == 9|| GetPlayerState(playerid) == 5 || GetPlayerState(playerid) == 6 ||GetPlayerState(playerid) == 4|| GetPlayerState(playerid) == 0)
{
SendClientMessage(playerid,COLOR_YELLOW," No puede sincronizarse.");
return 1;
}else
SyncPlayer(playerid);
ClearAnimations(playerid);
SendClientMessage(playerid, -1, "Sincronizado");
//TogglePlayerControllable(playerid, 0);
//TogglePlayerControllable(playerid, 1);
//SendClientMessage(playerid,COLOR_YELLOW," Synchronization was made successfully");
return 1;

}*/
CMD:salirdm(playerid, params[]){
if(FueraDeEvento[playerid]) {
SinComandos[playerid] = 0;
FueraDeEvento[playerid] = false;
SetPlayerVirtualWorld(playerid, 0);
}
else
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
				    new string2[150];
					SetPVarInt(playerid, "MINION", 0);
					SetPVarInt(Duelos[i][DesafiadoId], "MINION", 0);
					format(string2,sizeof(string2),"[Pura Joda] "W"%s "G"abandonó el duelo. "W"%s "G"gana. Apuesta %d PJCoins",PlayerName2(playerid),PlayerName2(Duelos[i][DesafiadoId]),Duelos[i][Apuesta]);
					SendClientMessageToAll(LIGHTGREEN,string2);
					SetPVarInt(Duelos[i][DesafiadoId], "COIN", GetPVarInt(Duelos[i][DesafiadoId], "COIN")+Duelos[i][Apuesta]);
					SetPVarInt(playerid, "COIN", GetPVarInt(playerid, "COIN")-Duelos[i][Apuesta]);
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
			            	TogglePlayerSpectating(j, 0);
							ViendoDuelo[j] = -1;
							KillTimer(Dueled[j]);
							SetPVarInt(j, "MINION", 0);
	    				}
					}
				}
				if (playerid == Duelos[i][DesafiadoId])
				{
				    new string2[128];
					format(string2,sizeof(string2),"[Pura Joda] "W"%s "G"abandonó el duelo. "W"%s "G"gana. Apuesta %d PJCoins",PlayerName2(playerid),PlayerName2(Duelos[i][DesaId]),Duelos[i][Apuesta]);
					SendClientMessageToAll(LIGHTGREEN,string2);
					SetPVarInt(playerid, "MINION", 0);
					SetPVarInt(Duelos[i][DesafiadoId], "MINION", 0);
					SetPVarInt(Duelos[i][DesafiadoId], "COIN", GetPVarInt(Duelos[i][DesafiadoId], "COIN")+Duelos[i][Apuesta]);
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
			            	TogglePlayerSpectating(j, 0);
							ViendoDuelo[j] = -1;
							KillTimer(Dueled[j]);
							SetPVarInt(j, "MINION", 0);
	    				}
					}
				}
				Duelos[i][DesaId] = -1;
				Duelos[i][DesafiadoId] = -1;
				Duelos[i][ArmasId] = -1;

			}
		}
	}
return 0;
}
dcmd_subirme(playerid,params[])
{
	if(PlayerInfo[playerid][Level] > 1)
	{
		if(!strlen(params))return
		SendClientMessage(playerid, red, "USA: /subirme [playerid]") &&
		SendClientMessage(playerid, red, "INFO: te subes al vehiculo de un jugador.");

		new player1;
		new string[128];
		new playername[MAX_PLAYER_NAME];
		new adminname[MAX_PLAYER_NAME];
		player1 = strval(params);

		new encarro = GetPlayerVehicleID(player1);
		if(IsPlayerInVehicle(player1, encarro) == 0)
		{
			SendClientMessage(playerid,red,"[ERROR]: Jugador no esta en un auto.");
			return 1;
		}
		if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID && player1 != playerid)
		{
			CMDMessageToAdmins(playerid,"SUBIRME");
			PutPlayerInVehicle(playerid,GetPlayerVehicleID(player1), 1);
			GetPlayerName(player1, playername, sizeof(playername));
			GetPlayerName(playerid, adminname, sizeof(adminname));
			format(string,sizeof(string),"* Administrador %s se ha subido a tu vehiculo. ",adminname);
			SendClientMessage(player1,red,string);
			if(player1 != playerid)
			{
				format(string,sizeof(string),"Has subido al vehiculo de %s ", playername);
				return SendClientMessage(playerid,red,string);
			}
			return PutPlayerInVehicle(player1,GetPlayerVehicleID(player1),1);
		}
		else return (playerid, 4);
	}
	else return (playerid, 6);
}

dcmd_subir(playerid,params[])
{
	if(PlayerInfo[playerid][Level] > 1)
	{
    	if(!strlen(params))return
		SendClientMessage(playerid, red, "Usa: /subir [PlayerID]") &&
		SendClientMessage(playerid, red, "INFO: Subes a tu vehiculo un jugador.");

		new player1;
		new string[128];
		new playername[MAX_PLAYER_NAME];
		new adminname[MAX_PLAYER_NAME];
		player1 = strval(params);

		new encarro = GetPlayerVehicleID(playerid);
		if(IsPlayerInVehicle(playerid, encarro) == 0)
		{
			SendClientMessage(playerid,red,"No estas en un vehiculo");
			return 1;
		}
		if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID && player1 != playerid)
		{
			CMDMessageToAdmins(playerid,"SUBIR");
			PutPlayerInVehicle(player1,GetPlayerVehicleID(playerid), 1);
			GetPlayerName(player1, playername, sizeof(playername));
			GetPlayerName(playerid, adminname, sizeof(adminname));
			format(string,sizeof(string),"Administrador %s te ha puesto en su vehiculo ",adminname);
			SendClientMessage(player1,red,string);
			if(player1 != playerid)
			{
				format(string,sizeof(string),"Has puesto a %s en tu vehiculo ", playername);
				return SendClientMessage(playerid,red,string);
			}
			return PutPlayerInVehicle(player1,GetPlayerVehicleID(player1),1);
		}
		else return (playerid, 4);
	}
	else return (playerid, 6);
}

dcmd_giveweapon(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 2) {
	    new tmp[256], tmp2[256], tmp3[256], Index; tmp = strtok(params,Index), tmp2 = strtok(params,Index), tmp3 = strtok(params,Index);
	    if(!strlen(tmp) || !strlen(tmp2)) return SendClientMessage(playerid, red, "USE: /giveweapon [jugador] [ID del arma/nombre del arma] [municiones]");
		new player1 = strval(tmp), weap, ammo, WeapName[32], string[128];
		if(!strlen(tmp3) || !IsNumeric(tmp3) || strval(tmp3) <= 0 || strval(tmp3) > 99999) ammo = 500; else ammo = strval(tmp3);
		if(!IsNumeric(tmp2)) weap = GetWeaponIDFromName(tmp2); else weap = strval(tmp2);
        if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
        	if(!IsValidWeapon(weap)) return SendClientMessage(playerid,red,"ERROR: ID de arma invalida");
			CMDMessageToAdmins(playerid,"GIVEWEAPON");
			GetWeaponName(weap,WeapName,32);
			format(string, sizeof(string), "Le has dado a \"%s\" una %s (%d) con %d municiones", PlayerName2(player1), WeapName, weap, ammo); SendClientMessage(playerid,blue,string);
			if(player1 != playerid) { format(string,sizeof(string),"El administrador \"%s\" te ha dado una %s (%d) con %d municiones", PlayerName2(playerid), WeapName, weap, ammo); SendClientMessage(player1,blue,string); }
   			return GivePlayerWeapon(player1, weap, ammo);
	    } else return SendClientMessage(playerid,red,"ERROR: El jugador no esta conectado");
	} else return SendClientMessage(playerid,red,"SÓLO ADMINISTRADORES, SÍ USTED ES UNO DEBE SER DE MAYOR LVL.");
}

dcmd_sethealth(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 3) {
	    new tmp[256], tmp2[256], Index; tmp = strtok(params,Index), tmp2 = strtok(params,Index);
	    if(!strlen(tmp) || !strlen(tmp2) || !IsNumeric(tmp2)) return SendClientMessage(playerid, red, "USE: /sethealth [jugador] [cantidad]");
		if(strval(tmp2) < 0 || strval(tmp2) > 100 && PlayerInfo[playerid][Level] != ServerInfo[MaxAdminLevel]) return SendClientMessage(playerid, red, "ERROR: Cantidad de vida invalida");
		new player1 = strval(tmp), health = strval(tmp2), string[128];
		if(PlayerInfo[player1][Level] == ServerInfo[MaxAdminLevel] && PlayerInfo[playerid][Level] != ServerInfo[MaxAdminLevel]) return SendClientMessage(playerid,red,"ERROR: You cannot use this command on this admin");
        if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
			CMDMessageToAdmins(playerid,"SETHEALTH");
			format(string, sizeof(string), "Has puesto la vida de \"%s's\" en '%d", pName(player1), health); SendClientMessage(playerid,blue,string);
			if(player1 != playerid) { format(string,sizeof(string),"El Administrador \"%s\" ha puesto tu vida en '%d'", pName(playerid), health); SendClientMessage(player1,blue,string); }
   			return SetPlayerHealth(player1, health);
	    } else return SendClientMessage(playerid,red,"ERROR: El jugador no esta conectado");
	} else return SendClientMessage(playerid,red,"SÓLO ADMINISTRADORES, SÍ USTED ES UNO DEBE SER DE MAYOR LVL.");
}

dcmd_setarmour(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 3) {
	    new tmp[256], tmp2[256], Index; tmp = strtok(params,Index), tmp2 = strtok(params,Index);
	    if(!strlen(tmp) || !strlen(tmp2) || !IsNumeric(tmp2)) return SendClientMessage(playerid, red, "USE: /setarmour [jugador] [cantidad]");
		if(strval(tmp2) < 0 || strval(tmp2) > 100 && PlayerInfo[playerid][Level] != ServerInfo[MaxAdminLevel]) return SendClientMessage(playerid, red, "ERROR: Candidad de blindaje invalido");
		new player1 = strval(tmp), armour = strval(tmp2), string[128];
		if(PlayerInfo[player1][Level] == ServerInfo[MaxAdminLevel] && PlayerInfo[playerid][Level] != ServerInfo[MaxAdminLevel]) return SendClientMessage(playerid,red,"ERROR: You cannot use this command on this admin");
        if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
			CMDMessageToAdmins(playerid,"SETARMOUR");
			format(string, sizeof(string), "Has puesto el blindaje de \"%s\" en '%d", pName(player1), armour); SendClientMessage(playerid,blue,string);
			if(player1 != playerid) { format(string,sizeof(string),"El Administrador \"%s\" ha puesto tu blindaje en '%d'", pName(playerid), armour); SendClientMessage(player1,blue,string); }
   			return SetPlayerArmour(player1, armour);
	    } else return SendClientMessage(playerid,red,"ERROR: El jugador no esta conectado");
	} else return SendClientMessage(playerid,red,"SÓLO ADMINISTRADORES, SÍ USTED ES UNO DEBE SER DE MAYOR LVL.");
}
dcmd_givescore(playerid, params[])
{
   	if(PlayerInfo[playerid][Level] <= 4) return SendClientMessage(playerid, red, "No tiene privilegios suficientes");
	    new tmp[256], tmp2[256], Index; tmp = strtok(params,Index), tmp2 = strtok(params,Index);
	    if(!strlen(tmp) || !strlen(tmp2) || !IsNumeric(tmp2)) return SendClientMessage(playerid, red, "USE: /givescore [jugador] [cantidad]");
		new player1 = strval(tmp), score = strval(tmp2), string[128];
		if(PlayerInfo[player1][Level] == ServerInfo[MaxAdminLevel] && PlayerInfo[playerid][Level] != ServerInfo[MaxAdminLevel]) return SendClientMessage(playerid,red,"ERROR: You cannot use this command on this admin");
        if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID)
		{
			CMDMessageToAdmins(playerid,"GIVESCORE");
			format(string, sizeof(string), "Le has dado a \"%s\" %d de score", pName(player1), score); SendClientMessage(playerid,blue,string);
			if(player1 != playerid) { format(string,sizeof(string),"El Administrador \"%s\" ha añadido score a tu cuenta '%d'", pName(playerid), score); SendClientMessage(player1,blue,string); }
   			return SetPVarInt(player1, "Score", GetPVarInt(player1, "Score")+score) && SetPlayerScore(player1, GetPlayerScore(player1)+score);
	    } else return SendClientMessage(playerid,red,"ERROR: El jugador no esta conectado");
}
dcmd_setscore(playerid, params[]){
   	if(PlayerInfo[playerid][Level] <= 11) return 0;
	    new tmp[256], tmp2[256], Index; tmp = strtok(params,Index), tmp2 = strtok(params,Index);
	    if(!strlen(tmp) || !strlen(tmp2) || !IsNumeric(tmp2)) return SendClientMessage(playerid, red, "USE: /setscore [jugador] [cantidad]");
		new player1 = strval(tmp), score = strval(tmp2), string[128];
		if(PlayerInfo[player1][Level] == ServerInfo[MaxAdminLevel] && PlayerInfo[playerid][Level] != ServerInfo[MaxAdminLevel]) return SendClientMessage(playerid,red,"ERROR: You cannot use this command on this admin");
        if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID)
		{
			CMDMessageToAdmins(playerid,"SETSCORE");
			format(string, sizeof(string), "Le has seteado el score de \"%s\" a %d de score", pName(player1), score); SendClientMessage(playerid,blue,string);
			if(player1 != playerid) { format(string,sizeof(string),"El Administrador \"%s\" ha cambiado tu score a '%d'", pName(playerid), score); SendClientMessage(player1,blue,string); }
   			return SetPVarInt(player1, "Score", score) && SetPlayerScore(player1, score);
	    } else return SendClientMessage(playerid,red,"ERROR: El jugador no esta conectado");
}
dcmd_setcash(playerid,params[]) {
	if(PlayerInfo[playerid][Level] < 12) return 0;

	    new tmp[256], tmp2[256], Index; tmp = strtok(params,Index), tmp2 = strtok(params,Index);
	    if(!strlen(tmp) || !strlen(tmp2) || !IsNumeric(tmp2)) return SendClientMessage(playerid, red, "USE: /setcash [jugador] [cantidad]");
		new player1 = strval(tmp), cash = strval(tmp2), string[128];
		if(PlayerInfo[player1][Level] == ServerInfo[MaxAdminLevel] && PlayerInfo[playerid][Level] != ServerInfo[MaxAdminLevel]) return SendClientMessage(playerid,red,"ERROR: You cannot use this command on this admin");
        if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID)
		{
			CMDMessageToAdmins(playerid,"SETCASH");
			format(string, sizeof(string), "Has puesto el dinero de \"%s\" en '$%d", pName(player1), cash); SendClientMessage(playerid,blue,string);
			if(player1 != playerid) { format(string,sizeof(string),"El Administrador \"%s\" ha puesto tu dinero en '$%d'", pName(playerid), cash); SendClientMessage(player1,blue,string); }
			ResetPlayerMoneyEx(player1);
   			return GivePlayerMoneyEx(player1, cash);
	    } else return SendClientMessage(playerid,red,"ERROR: El jugador no esta conectado");
//	} else return SendClientMessage(playerid,red,"SÓLO ADMINISTRADORES, SÍ USTED ES UNO DEBE SER DE MAYOR LVL.");
}



dcmd_setskin(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 3) {
	    new tmp[256], tmp2[256], Index; tmp = strtok(params,Index), tmp2 = strtok(params,Index);
	    if(!strlen(tmp) || !strlen(tmp2) || !IsNumeric(tmp2)) return SendClientMessage(playerid, red, "USE: /setskin [jugador] [ID del skin]");
		new player1 = strval(tmp), skin = strval(tmp2), string[128];
		if(!IsValidSkin(skin)) return SendClientMessage(playerid, red, "ERROR: ID de skin invalida");
		if(PlayerInfo[player1][Level] == ServerInfo[MaxAdminLevel] && PlayerInfo[playerid][Level] != ServerInfo[MaxAdminLevel]) return SendClientMessage(playerid,red,"ERROR: You cannot use this command on this admin");
        if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
			CMDMessageToAdmins(playerid,"SETSKIN");
			format(string, sizeof(string), "Le has puesto a \"%s\" el skin '%d", pName(player1), skin); SendClientMessage(playerid,blue,string);
			if(player1 != playerid) { format(string,sizeof(string),"El Administrador \"%s\" te ha puesto el skin '%d'", pName(playerid), skin); SendClientMessage(player1,blue,string); }
   			return SetPlayerSkin(player1, skin);
	    } else return SendClientMessage(playerid,red,"ERROR: El jugador no esta conectado");
	} else return SendClientMessage(playerid,red,"SÓLO ADMINISTRADORES, SÍ USTED ES UNO DEBE SER DE MAYOR LVL.");
}

dcmd_setwanted(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 3) {
	    new tmp[256], tmp2[256], Index; tmp = strtok(params,Index), tmp2 = strtok(params,Index);
	    if(!strlen(tmp) || !strlen(tmp2) || !IsNumeric(tmp2)) return SendClientMessage(playerid, red, "USE: /setwanted [jugador] [nivel]");
		new player1 = strval(tmp), wanted = strval(tmp2), string[128];
//		if(wanted > 6) return SendClientMessage(playerid, red, "ERROR: Invaild wanted level");
		if(PlayerInfo[player1][Level] == ServerInfo[MaxAdminLevel] && PlayerInfo[playerid][Level] != ServerInfo[MaxAdminLevel]) return SendClientMessage(playerid,red,"ERROR: You cannot use this command on this admin");
        if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
			CMDMessageToAdmins(playerid,"SETWANTED");
			format(string, sizeof(string), "Has puesto el nivel de busqueda de \"%s\" en '%d", pName(player1), wanted); SendClientMessage(playerid,blue,string);
			if(player1 != playerid) { format(string,sizeof(string),"El Administrador \"%s\" ha puesto tu nivel de busqueda en '%d'", pName(playerid), wanted); SendClientMessage(player1,blue,string); }
   			return SetPlayerWantedLevel(player1, wanted);
	    } else return SendClientMessage(playerid,red,"ERROR: El jugador no esta conetado");
	} else return SendClientMessage(playerid,red,"SÓLO ADMINISTRADORES, SÍ USTED ES UNO DEBE SER DE MAYOR LVL.");
}

dcmd_setname(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 3 || IsPlayerAdmin(playerid)) {
	    new tmp[256], tmp2[256], Index; tmp = strtok(params,Index), tmp2 = strtok(params,Index);
	    if(!strlen(tmp) || !strlen(tmp2)) return SendClientMessage(playerid, red, "USE: /setname [jugador] [nuevo nombre]");
		new player1 = strval(tmp), length = strlen(tmp2), string[128];
		if(length < 3 || length > MAX_PLAYER_NAME) return SendClientMessage(playerid,red,"ERROR: Numero de caracteres incorrecto");
		if(PlayerInfo[player1][Level] == ServerInfo[MaxAdminLevel] && PlayerInfo[playerid][Level] != ServerInfo[MaxAdminLevel]) return SendClientMessage(playerid,red,"ERROR: You cannot use this command on this admin");
        if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
			CMDMessageToAdmins(playerid,"SETNAME");
			format(string, sizeof(string), "Has cambiado el nombre de \"%s\" a \"%s\" ", pName(player1), tmp2); SendClientMessage(playerid,blue,string);
			if(player1 != playerid) { format(string,sizeof(string),"El Administrador \"%s\" cambio tu nombre a \"%s\" ", pName(playerid), tmp2); SendClientMessage(player1,blue,string); }
			SetPlayerName(player1, tmp2);
   			return OnPlayerConnect(player1);
	    } else return SendClientMessage(playerid,red,"ERROR: El jugador no esta conectado");
	} else return SendClientMessage(playerid,red,"SÓLO ADMINISTRADORES, SÍ USTED ES UNO DEBE SER DE MAYOR LVL.");
}

dcmd_setcolour(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 2) {
	    new tmp[256], tmp2[256], Index; tmp = strtok(params,Index), tmp2 = strtok(params,Index);
	    if(!strlen(tmp) || !strlen(tmp2) || !IsNumeric(tmp2)) {
			SendClientMessage(playerid, red, "USE: /setcolour [jugador] [color]");
			return SendClientMessage(playerid, red, "Colores: 0=negro 1=blanco 2=rojo 3=naranja 4=amarillo 5=verde 6=azul 7=purpura 8=marron 9=rosa");
		}
		new player1 = strval(tmp), Colour = strval(tmp2), string[128], colour[24];
		if(Colour > 9) return SendClientMessage(playerid, red, "Colores: 0=negro 1=blanco 2=rojo 3=naranja 4=amarillo 5=verde 6=azul 7=purpura 8=marron 9=rosa");
		if(PlayerInfo[player1][Level] == ServerInfo[MaxAdminLevel] && PlayerInfo[playerid][Level] != ServerInfo[MaxAdminLevel]) return SendClientMessage(playerid,red,"ERROR: You cannot use this command on this admin");
        if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
	        CMDMessageToAdmins(playerid,"SETCOLOUR");
			switch (Colour)
			{
			    case 0: { SetPlayerColor(player1,black); colour = "Black"; }
			    case 1: { SetPlayerColor(player1,COLOR_WHITE); colour = "White"; }
			    case 2: { SetPlayerColor(player1,red); colour = "Red"; }
			    case 3: { SetPlayerColor(player1,orange); colour = "Orange"; }
				case 4: { SetPlayerColor(player1,orange); colour = "Yellow"; }
				case 5: { SetPlayerColor(player1,COLOR_GREEN1); colour = "Green"; }
				case 6: { SetPlayerColor(player1,COLOR_BLUE); colour = "Blue"; }
				case 7: { SetPlayerColor(player1,COLOR_PURPLE); colour = "Purple"; }
				case 8: { SetPlayerColor(player1,COLOR_BROWN); colour = "Brown"; }
				case 9: { SetPlayerColor(player1,COLOR_PINK); colour = "Pink"; }
			}
			if(player1 != playerid) { format(string,sizeof(string),"El administrador \"%s\" ha puesto tu color en '%s' ", pName(playerid), colour); SendClientMessage(player1,blue,string); }
			format(string, sizeof(string), "Has puesto el color de \"%s\" en '%s' ", pName(player1), colour);
   			return SendClientMessage(playerid,blue,string);
	    } else return SendClientMessage(playerid,red,"ERROR: El jugador no esta conectado");
	} else return SendClientMessage(playerid,red,"SÓLO ADMINISTRADORES, SÍ USTED ES UNO DEBE SER DE MAYOR LVL.");
}

dcmd_setweather(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 3) {
	    new tmp[256], tmp2[256], Index; tmp = strtok(params,Index), tmp2 = strtok(params,Index);
	    if(!strlen(tmp) || !strlen(tmp2) || !IsNumeric(tmp2)) return SendClientMessage(playerid, red, "USE: /setweather [jugador] [ID del clima]");
		new player1 = strval(tmp), weather = strval(tmp2), string[128];
		if(PlayerInfo[player1][Level] == ServerInfo[MaxAdminLevel] && PlayerInfo[playerid][Level] != ServerInfo[MaxAdminLevel]) return SendClientMessage(playerid,red,"ERROR: You cannot use this command on this admin");
        if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
			CMDMessageToAdmins(playerid,"SETWEATHER");
			format(string, sizeof(string), "Has puesto el clima de \"%s\" en '%d", pName(player1), weather); SendClientMessage(playerid,blue,string);
			if(player1 != playerid) { format(string,sizeof(string),"El Administrador \"%s\" ha puesto tu clima en  '%d'", pName(playerid), weather); SendClientMessage(player1,blue,string); }
			SetPlayerWeather(player1,weather); PlayerPlaySound(player1,1057,0.0,0.0,0.0);
   			return PlayerPlaySound(playerid,1057,0.0,0.0,0.0);
	    } else return SendClientMessage(playerid,red,"ERROR: El jugador no esta conectado");
	} else return SendClientMessage(playerid,red,"SÓLO ADMINISTRADORES, SÍ USTED ES UNO DEBE SER DE MAYOR LVL.");
}

dcmd_settime(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 3) {
	    new tmp[256], tmp2[256], Index; tmp = strtok(params,Index), tmp2 = strtok(params,Index);
	    if(!strlen(tmp) || !strlen(tmp2) || !IsNumeric(tmp2)) return SendClientMessage(playerid, red, "USE: /settime [jugador] [hora]");
		new player1 = strval(tmp), time = strval(tmp2), string[128];
		if(PlayerInfo[player1][Level] == ServerInfo[MaxAdminLevel] && PlayerInfo[playerid][Level] != ServerInfo[MaxAdminLevel]) return SendClientMessage(playerid,red,"ERROR: You cannot use this command on this admin");
        if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
			CMDMessageToAdmins(playerid,"SETTIME");
			format(string, sizeof(string), "Has puesto la hora de \"%s\" en %d:00", pName(player1), time); SendClientMessage(playerid,blue,string);
			if(player1 != playerid) { format(string,sizeof(string),"El Administrador \"%s\" ha puesto tu hora en %d:00", pName(playerid), time); SendClientMessage(player1,blue,string); }
			PlayerPlaySound(player1,1057,0.0,0.0,0.0);
   			return SetPlayerTime(player1, time, 0);
	    } else return SendClientMessage(playerid,red,"ERROR: El jugador no esta conectado");
	} else return SendClientMessage(playerid,red,"SÓLO ADMINISTRADORES, SÍ USTED ES UNO DEBE SER DE MAYOR LVL.");
}

dcmd_setworld(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 3) {
	    new tmp[256], tmp2[256], Index; tmp = strtok(params,Index), tmp2 = strtok(params,Index);
	    if(!strlen(tmp) || !strlen(tmp2) || !IsNumeric(tmp2)) return SendClientMessage(playerid, red, "USE: /setworld [jugador] [mundo virtual]");
		new player1 = strval(tmp), time = strval(tmp2), string[128];
		if(PlayerInfo[player1][Level] == ServerInfo[MaxAdminLevel] && PlayerInfo[playerid][Level] != ServerInfo[MaxAdminLevel]) return SendClientMessage(playerid,red,"ERROR: You cannot use this command on this admin");
        if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
			CMDMessageToAdmins(playerid,"SETWORLD");
			format(string, sizeof(string), "Has puesto el mundo virtual de \"%s\" en '%d'", pName(player1), time); SendClientMessage(playerid,blue,string);
			if(player1 != playerid) { format(string,sizeof(string),"El Administrador \"%s\" ha puesto tu mundo virtual en '%d' ", pName(playerid), time); SendClientMessage(player1,blue,string); }
			PlayerPlaySound(player1,1057,0.0,0.0,0.0);
   			return SetPlayerVirtualWorld(player1, time);
	    } else return SendClientMessage(playerid,red,"ERROR: El jugador no esta conectado");
	} else return SendClientMessage(playerid,red,"SÓLO ADMINISTRADORES, SÍ USTED ES UNO DEBE SER DE MAYOR LVL.");
}

dcmd_setinterior(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 3) {
	    new tmp[256], tmp2[256], Index; tmp = strtok(params,Index), tmp2 = strtok(params,Index);
	    if(!strlen(tmp) || !strlen(tmp2) || !IsNumeric(tmp2)) return SendClientMessage(playerid, red, "USE: /setinterior [jugador] [interior]");
		new player1 = strval(tmp), time = strval(tmp2), string[128];
		if(PlayerInfo[player1][Level] == ServerInfo[MaxAdminLevel] && PlayerInfo[playerid][Level] != ServerInfo[MaxAdminLevel]) return SendClientMessage(playerid,red,"ERROR: You cannot use this command on this admin");
        if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
			CMDMessageToAdmins(playerid,"SETINTERIOR");
			format(string, sizeof(string), "Has puesto el interior de \"%s\" en '%d' ", pName(player1), time); SendClientMessage(playerid,blue,string);
			if(player1 != playerid) { format(string,sizeof(string),"El Administrador \"%s\" ha puesto tu interior en '%d' ", pName(playerid), time); SendClientMessage(player1,blue,string); }
			PlayerPlaySound(player1,1057,0.0,0.0,0.0);
   			return SetPlayerInterior(player1, time);
	    } else return SendClientMessage(playerid,red,"ERROR: El jugador no esta conectado");
	} else return SendClientMessage(playerid,red,"SÓLO ADMINISTRADORES, SÍ USTED ES UNO DEBE SER DE MAYOR LVL.");
}

dcmd_setmytime(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 1) {
	    if(!strlen(params)) return SendClientMessage(playerid, red, "USE: /setmytime [hora]");
		new time = strval(params), string[128];
		CMDMessageToAdmins(playerid,"SETMYTIME");
		format(string,sizeof(string),"Has puesto tu hora en %d:00", time); SendClientMessage(playerid,blue,string);
		return SetPlayerTime(playerid, time, 0);
	} else return SendClientMessage(playerid,red,"ERROR: Necesitas ser Administrador nivel 1 para usar este comando");
}

dcmd_force(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 3) {
	    if(!strlen(params)) return SendClientMessage(playerid, red, "USE: /force [jugador]");
		new player1 = strval(params), string[128];
		if(PlayerInfo[player1][Level] == ServerInfo[MaxAdminLevel] && PlayerInfo[playerid][Level] != ServerInfo[MaxAdminLevel]) return SendClientMessage(playerid,red,"ERROR: You cannot use this command on this admin");
        if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
			CMDMessageToAdmins(playerid,"FORCE");
			if(player1 != playerid) { format(string,sizeof(string),"El Administrador \"%s\" te ha forzado a elegir otro skin", pName(playerid) ); SendClientMessage(player1,blue,string); }
			format(string,sizeof(string),"Has forzado a \"%s\" a elegir otro skin", pName(player1)); SendClientMessage(playerid,blue,string);
			ForceClassSelection(player1);
			return SetPlayerHealth(player1,0.0);
	    } else return SendClientMessage(playerid,red,"ERROR: El jugador no esta conectado");
	} else return SendClientMessage(playerid,red,"SÓLO ADMINISTRADORES, SÍ USTED ES UNO DEBE SER DE MAYOR LVL.");
}

dcmd_eject(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 3) {
	    if(!strlen(params)) return SendClientMessage(playerid, red, "USE: /eject [jugador]");
		new player1 = strval(params), string[128], Float:x, Float:y, Float:z;
		if(PlayerInfo[player1][Level] == ServerInfo[MaxAdminLevel] && PlayerInfo[playerid][Level] != ServerInfo[MaxAdminLevel]) return SendClientMessage(playerid,red,"ERROR: You cannot use this command on this admin");
        if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
			if(IsPlayerInAnyVehicle(player1)) {
		       	CMDMessageToAdmins(playerid,"EJECT");
				if(player1 != playerid) { format(string,sizeof(string),"El Administrador \"%s\" te ha sacado de tu vehiculo", pName(playerid) ); SendClientMessage(player1,blue,string); }
				format(string,sizeof(string),"Has sacado a \"%s\" de su vehiculo", pName(player1)); SendClientMessage(playerid,blue,string);
    		   	GetPlayerPos(player1,x,y,z);
				return SetPlayerPos(player1,x,y,z+3);
			} else return SendClientMessage(playerid,red,"ERROR: El jugador no esta en un vehiculo");
	    } else return SendClientMessage(playerid,red,"ERROR: El jugador no esta conectado");
	} else return SendClientMessage(playerid,red,"SÓLO ADMINISTRADORES, SÍ USTED ES UNO DEBE SER DE MAYOR LVL.");
}
dcmd_buy(playerid, params[]){
#pragma unused params
if(!IsPlayerInRangeOfPoint(playerid, 1.2,2268.0896, -1581.0186, 1492.9275)) return SendClientMessage(playerid, red, "[Pura Joda] Por favor en la tienda.");
ShowPlayerDialog(playerid, Ammu, DIALOG_STYLE_TABLIST_HEADERS, ""W"Pura Joda's "G"Shop",
""G"Producto\t"G"Precio\t"G"Cantidad\n\
PJCoin\t$68456\t1\n\
PJCoin\t$342280\t5\n\
PJCoin\t$684560\t10\n\
PJCoin\t$68445600\t100\n\
Chaleco\t$2990\t1\n\
Granadas\t$12 PJC\t10\nRockets\t$25 PJC\t10\nC4\t$16 PJC\t10",
"Select", "Cancel");
return 1;
}
dcmd_lockcar(playerid,params[]) {
	#pragma unused params
    if(PlayerInfo[playerid][Level] >= 2) {
	    if(IsPlayerInAnyVehicle(playerid)) {
		 	for(new i = 0; i < MAX_PLAYER; i++)
		 	{
		 	    if(!IsPlayerConnected(i)) continue;
		 	    if(i == playerid) continue;
 				SetVehicleParamsForPlayer(GetPlayerVehicleID(playerid),i,0,1);
			}
			CMDMessageToAdmins(playerid,"LOCKCAR");
			PlayerInfo[playerid][DoorsLocked] = 1;
			new string[128]; format(string,sizeof(string),"El Administrador \"%s\" ha bloqueado su vehiculo", pName(playerid));
			return SendClientMessageToAll(blue,string);
		} else return SendClientMessage(playerid,red,"ERROR: Necesitas estar en un vehiculo para bloquear/desbloquear las puertas");
	} else return SendClientMessage(playerid,red,"SÓLO ADMINISTRADORES, SÍ USTED ES UNO DEBE SER DE MAYOR LVL.");
}

dcmd_unlockcar(playerid,params[]) {
	#pragma unused params
    if(PlayerInfo[playerid][Level] >= 2) {
	    if(IsPlayerInAnyVehicle(playerid)) {
		 	for(new i = 0; i < MAX_PLAYER; i++) SetVehicleParamsForPlayer(GetPlayerVehicleID(playerid),i,false,false);
			CMDMessageToAdmins(playerid,"UNLOCKCAR");
			PlayerInfo[playerid][DoorsLocked] = 0;
			new string[128]; format(string,sizeof(string),"El Administrador \"%s\" ha desbloqueado su vehiculo", pName(playerid));
			return SendClientMessageToAll(blue,string);
		} else return SendClientMessage(playerid,red,"ERROR: Necesitas estar en un vehiculo para bloquear/desbloquear las puertas");
	} else return SendClientMessage(playerid,red,"SÓLO ADMINISTRADORES, SÍ USTED ES UNO DEBE SER DE MAYOR LVL.");
}

dcmd_burn(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 2) {
	    if(!strlen(params)) return SendClientMessage(playerid, red, "USE: /burn [jugador]");
		new player1 = strval(params), string[128], Float:x, Float:y, Float:z;
		if(PlayerInfo[player1][Level] == ServerInfo[MaxAdminLevel] && PlayerInfo[playerid][Level] != ServerInfo[MaxAdminLevel]) return SendClientMessage(playerid,red,"ERROR: You cannot use this command on this admin");
        if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
			CMDMessageToAdmins(playerid,"BURN");
			format(string, sizeof(string), "Has quemado a \"%s\" ", pName(player1)); SendClientMessage(playerid,blue,string);
			if(player1 != playerid) { format(string,sizeof(string),"El Administrador \"%s\" te ha quemado", pName(playerid));/* SendClientMessage(player1,blue,string);*/ }
			GetPlayerPos(player1, x, y, z);
			return CreateExplosion(x, y , z + 3, 1, 10);
	    } else return SendClientMessage(playerid,red,"ERROR: El jugador no esta conectado");
	} else return SendClientMessage(playerid,red,"SÓLO ADMINISTRADORES, SÍ USTED ES UNO DEBE SER DE MAYOR LVL.");
}

dcmd_spawnplayer(playerid,params[])
{
	return dcmd_spawn(playerid,params);
}

dcmd_spawn(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 2) {
	    if(!strlen(params)) return SendClientMessage(playerid, red, "USE: /spawn [jugador]");
		new player1 = strval(params), string[128];
		if(PlayerInfo[player1][Level] == ServerInfo[MaxAdminLevel] && PlayerInfo[playerid][Level] != ServerInfo[MaxAdminLevel]) return SendClientMessage(playerid,red,"ERROR: You cannot use this command on this admin");
        if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
			CMDMessageToAdmins(playerid,"SPAWN");
			format(string, sizeof(string), "Has reiniciado a \"%s\" ", pName(player1)); SendClientMessage(playerid,blue,string);
			if(player1 != playerid) { format(string,sizeof(string),"El Administrador \"%s\" te ha reiniciado", pName(playerid)); SendClientMessage(player1,blue,string); }
			SetPlayerPos(player1, 0.0, 0.0, 0.0);
			return SpawnPlayer(player1);
	    } else return SendClientMessage(playerid,red,"ERROR: El jugador no esta conectado");
	} else return SendClientMessage(playerid,red,"SÓLO ADMINISTRADORES, SÍ USTED ES UNO DEBE SER DE MAYOR LVL.");
}

dcmd_disarm(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 2) {
	    if(!strlen(params)) return SendClientMessage(playerid, red, "USE: /disarm [jugador]");
		new player1 = strval(params), string[128];
		if(PlayerInfo[player1][Level] == ServerInfo[MaxAdminLevel] && PlayerInfo[playerid][Level] != ServerInfo[MaxAdminLevel]) return SendClientMessage(playerid,red,"ERROR: You cannot use this command on this admin");
        if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
			CMDMessageToAdmins(playerid,"DISARM");  PlayerPlaySound(player1,1057,0.0,0.0,0.0);
			format(string, sizeof(string), "Has desarmado a \"%s\" ", pName(player1)); SendClientMessage(playerid,blue,string);
			if(player1 != playerid) { format(string,sizeof(string),"El Administrador \"%s\" te ha desarmado", pName(playerid)); SendClientMessage(player1,blue,string); }
			ResetPlayerWeapons(player1);
			return PlayerPlaySound(player1,1057,0.0,0.0,0.0);
	    } else return SendClientMessage(playerid,red,"ERROR: El jugador no esta conectado");
	} else return SendClientMessage(playerid,red,"SÓLO ADMINISTRADORES, SÍ USTED ES UNO DEBE SER DE MAYOR LVL.");
}

dcmd_crash(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 4) {
	    if(!strlen(params)) return SendClientMessage(playerid, red, "USE: /crash [jugador]");
		new player1 = strval(params);
		if(PlayerInfo[player1][Level] == ServerInfo[MaxAdminLevel] && PlayerInfo[playerid][Level] != ServerInfo[MaxAdminLevel]) return SendClientMessage(playerid,red,"ERROR: You cannot use this command on this admin");
        if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
   			CMDMessageToAdmins(playerid,"CRASH");
			crashear(player1);
			new string2[128];
			format(string2, sizeof(string2), "Has crasheado a \"%s\" ", pName(player1) );
			return SendClientMessage(playerid,blue, string2);
	    } else return SendClientMessage(playerid,red,"ERROR: El jugador no esta conectado");
	} else return SendClientMessage(playerid,red,"ERROR: Necesitas ser Administrador nivel 4 para usar este comando");
}

dcmd_ip(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 1) {
	    if(!strlen(params)) return SendClientMessage(playerid, red, "USAGE: /ip [jugador]");
		new player1 = strval(params), string[128];
		if(PlayerInfo[player1][Level] == ServerInfo[MaxAdminLevel] && PlayerInfo[playerid][Level] != ServerInfo[MaxAdminLevel]) return SendClientMessage(playerid,red,"ERROR: You cannot use this command on this admin");
        if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
			CMDMessageToAdmins(playerid,"IP");
			new tmp3[50]; GetPlayerIp(player1,tmp3,50);
			format(string,sizeof(string),"La IP de \"%s\" es '%s'", pName(player1), tmp3);
			return SendClientMessage(playerid,blue,string);
	    } else return SendClientMessage(playerid,red,"ERROR: El jugador no esta conectado");
	} else return SendClientMessage(playerid,red,"ERROR: Necesitas ser Administrador nivel 1 para usar este comando");
}

dcmd_pais(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 1) {
	    if(!strlen(params)) return SendClientMessage(playerid, red, "USAGE: /pais [jugador]");
		new player1 = strval(params), string[128];
		if(PlayerInfo[player1][Level] == ServerInfo[MaxAdminLevel] && PlayerInfo[playerid][Level] != ServerInfo[MaxAdminLevel]) return SendClientMessage(playerid,red,"ERROR: You cannot use this command on this admin");
        if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
			new country[MAX_COUNTRY_NAME];
			CMDMessageToAdmins(playerid,"PAIS");
            country = GetPlayerCountryName(player1);
			format(string,sizeof(string),"Pais de \"%s\" es '%s'", pName(player1), country);
			return SendClientMessage(playerid,blue,string);
	    } else return SendClientMessage(playerid,red,"ERROR: El jugador no esta conectado");
	} else return SendClientMessage(playerid,red,"ERROR: Necesitas ser Administrador nivel 1 para usar este comando");
}

dcmd_bankrupt(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 4) {
	    if(!strlen(params)) return SendClientMessage(playerid, red, "USE: /bankrupt [jugador]");
		new player1 = strval(params), string[128];
		if(PlayerInfo[player1][Level] == ServerInfo[MaxAdminLevel] && PlayerInfo[playerid][Level] != ServerInfo[MaxAdminLevel]) return SendClientMessage(playerid,red,"ERROR: You cannot use this command on this admin");
        if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
			CMDMessageToAdmins(playerid,"BANKRUPT");
			format(string, sizeof(string), "Has reseteado el dinero de \"%s\" ", pName(player1)); SendClientMessage(playerid,blue,string);
			if(player1 != playerid) { format(string,sizeof(string),"El Administrador \"%s\" ha reseteado tu dinero'", pName(playerid)); SendClientMessage(player1,blue,string); }
   			return ResetPlayerMoneyEx(player1);
	    } else return SendClientMessage(playerid,red,"ERROR: El jugador no esta conectado");
	} else return SendClientMessage(playerid,red,"SÓLO ADMINISTRADORES, SÍ USTED ES UNO DEBE SER DE MAYOR LVL.");
}

dcmd_sbankrupt(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 3) {
	    if(!strlen(params)) return SendClientMessage(playerid, red, "USE: /sbankrupt [jugador]");
		new player1 = strval(params), string[128];
		if(PlayerInfo[player1][Level] == ServerInfo[MaxAdminLevel] && PlayerInfo[playerid][Level] != ServerInfo[MaxAdminLevel]) return SendClientMessage(playerid,red,"ERROR: You cannot use this command on this admin");
        if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
			CMDMessageToAdmins(playerid,"BANKRUPT");
			format(string, sizeof(string), "Has reseteado el dinero de \"%s\" secretamente", pName(player1)); SendClientMessage(playerid,blue,string);
   			return ResetPlayerMoneyEx(player1);
	    } else return SendClientMessage(playerid,red,"ERROR: El jugador no esta conectado");
	} else return SendClientMessage(playerid,red,"SÓLO ADMINISTRADORES, SÍ USTED ES UNO DEBE SER DE MAYOR LVL.");
}


dcmd_time(playerid,params[]) {
	#pragma unused params
	new string[64], hour,minuite,second; gettime(hour,minuite,second);
	format(string, sizeof(string), "~g~|~w~%d:%d~g~|", hour, minuite);
	return GameTextForPlayer(playerid, string, 5000, 1);
}

dcmd_ubound(playerid,params[]) {
 	if(PlayerInfo[playerid][Level] >= 3) {
		if(!strlen(params)) return SendClientMessage(playerid, red, "USE: /ubound [jugador]");
	    new string[128], player1 = strval(params);

	 	if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
			CMDMessageToAdmins(playerid,"UBOUND");
			SetPlayerWorldBounds(player1, 9999.9, -9999.9, 9999.9, -9999.9 );
			format(string, sizeof(string), "Administrator %s has removed your world boundaries", PlayerName2(playerid)); if(player1 != playerid) SendClientMessage(player1,blue,string);
			format(string,sizeof(string),"You have removed %s's world boundaries", PlayerName2(player1));
			return SendClientMessage(playerid,blue,string);
		} else return SendClientMessage(playerid, red, "ERROR: El jugador no esta conectado");
	} else return SendClientMessage(playerid,red,"SÓLO ADMINISTRADORES, SÍ USTED ES UNO DEBE SER DE MAYOR LVL.");
}

dcmd_lhelp(playerid,params[]) {
	#pragma unused params
	if(PlayerInfo[playerid][LoggedIn] && PlayerInfo[playerid][Level] >= 1) {
		SendClientMessage(playerid,blue,"--== [ LAdmin Help ] ==--");
		SendClientMessage(playerid,blue, "For admin commands type:  /lcommands   |   Credits: /lcredits");
		SendClientMessage(playerid,blue, "Account commands are: /registro, /login, /changepass, /stats, /resetstats.  Also  /time, /report");
		SendClientMessage(playerid,blue, "There are 5 levels. Level 5 admins are immune from commands");
		SendClientMessage(playerid,blue, "IMPORTANT: The filterscript must be reloaded if you change gamemodes");
		}
	else if(PlayerInfo[playerid][LoggedIn] && PlayerInfo[playerid][Level] < 1) {
	 	SendClientMessage(playerid,green, "Your commands are: /registro, /login, /report, /stats, /time, /changepass, /resetstats, /getid");
 	}
	else if(PlayerInfo[playerid][LoggedIn] == 0) {
 	SendClientMessage(playerid,green, "Your commands are: /time, /getid     (You are not logged in, log in for more commands)");
	} return 1;
}

dcmd_lcmds(playerid,params[]) {
	#pragma unused params
	if(PlayerInfo[playerid][Level] > 0)
	{
		SendClientMessage(playerid,blue,"    ---= [ Most Useful Admin Commands ] ==---");
		SendClientMessage(playerid,lightblue,"GENERAL: getinfo, lmenu, announce, write, miniguns, richlist, lspec(off), move, lweaps, adminarea, countdown, duel, giveweapon");
		SendClientMessage(playerid,lightblue,"GENERAL: slap, burn, warn, kick, ban, explode, jail, freeze, mute, crash, ubound, god, godcar, ping");
		SendClientMessage(playerid,lightblue,"GENERAL: setping, lockserver, enable/disable, setlevel, setinterior, givecar, jetpack, force, spawn");
		SendClientMessage(playerid,lightblue,"VEHICLE: flip, fix, repair, lockcar, eject, ltc, car, lcar, lbike, lplane, lheli, lboat, lnos, cm");
		SendClientMessage(playerid,lightblue,"TELE: goto, gethere, get, teleplayer, ltele, vgoto, lgoto, moveplayer");
		SendClientMessage(playerid,lightblue,"SET: set(cash/health/armour/gravity/name/time/weather/skin/colour/wanted/templevel)");
		SendClientMessage(playerid,lightblue,"SETALL: setall(world/weather/wanted/time/score/cash)");
		SendClientMessage(playerid,lightblue,"ALL: giveallweapon, healall, armourall, freezeall, kickall, ejectall, killall, disarmall, slapall, spawnall");
	}
	return 1;
}

dcmd_lcommands(playerid,params[]) {
	#pragma unused params
	if(PlayerInfo[playerid][Level] > 0)
	{
		SendClientMessage(playerid,blue,"    ---= All Admin Commands =---");
		SendClientMessage(playerid,lightblue," /level1, /level2, /level3, /level4, /level5, /rcon ladmin");
		SendClientMessage(playerid,lightblue,"Player Commands: /registro, /login, /report, /stats, /time, /changepass, /resetstats, /getid");
	}
	return 1;
}

dcmd_level1(playerid,params[]) {
	#pragma unused params
	if(PlayerInfo[playerid][Level] > 0)
	{
		SendClientMessage(playerid,blue,"    ---=Level 1 Admin Commands =---");
		SendClientMessage(playerid,lightblue,"getinfo, weaps, vr, repair, ltune, lhy, lnos, lp, ping, lslowmo, ltc,");
		SendClientMessage(playerid,lightblue,"morning, adminarea, reports, richlist, miniguns, saveplacae, gotoplace,");
		SendClientMessage(playerid,lightblue,"saveskin, useskin, dontuseskin, setmytime, ip, lconfig.");
	}
	return 1;
}

dcmd_level2(playerid,params[]) {
	#pragma unused params
	if(PlayerInfo[playerid][Level] > 0)
	{
		SendClientMessage(playerid,blue,"    ---=Level 2 Admin Commands =---");
		SendClientMessage(playerid,lightblue,"giveweapon, setcolour, lockcar, unlockcar, burn, spawn, disarm, lcar, lbike,");
		SendClientMessage(playerid,lightblue,"lheli, lboat, lplane, hightlight, announce, announce2, screen, jetpack, flip,");
		SendClientMessage(playerid,lightblue,"goto, vgoto, lgoto, fu, warn, slap, jailed, frozen, mute, unmute, muted,");
		SendClientMessage(playerid,lightblue,"laston, lspec, lspecoff, lspecvehicle, clearchat, lmenu, ltele, cm, ltmenu, unjail,");
		SendClientMessage(playerid,lightblue,"write Invisible2,freeze,unfreeze,Car");
	}
	return 1;
}

dcmd_level3(playerid,params[]) {
	#pragma unused params
	if(PlayerInfo[playerid][Level] > 0)
	{
		SendClientMessage(playerid,blue,"    ---=Level 3 Admin Commands =---");
		SendClientMessage(playerid,lightblue,"sethealth, setarmour, setcash, setscore, setskin, setwanted, setname, setweather,");
		SendClientMessage(playerid,lightblue,"settime, setworld, setinterior, force, eject, bankrupt, sbankrupt, ubound, lweaps,");
		SendClientMessage(playerid,lightblue,"lammo, countdown, duel, car, carhealth, carcolour, setping, setgravity, destroycar,");
		SendClientMessage(playerid,lightblue,"teleplayer, vget, givecar, gethere, get, kick, explode, jail, unjail, freeze, ");
		SendClientMessage(playerid,lightblue,"unfreeze, akill,aka, disablechat, clearallchat, caps, move, moveplayer, healall,");
		SendClientMessage(playerid,lightblue,"armourall, setallskin, setallwanted, setallweather, setalltime, setallworld, Invisible2");
		SendClientMessage(playerid,lightblue,"setallscore, setallcash, giveallcash, giveallweapon, lweather, ltime, lweapons, setpass ,unbanname");
	}
	return 1;
}

dcmd_level4(playerid,params[]) {
	#pragma unused params
	if(PlayerInfo[playerid][Level] > 0)
	{
		SendClientMessage(playerid,blue,"    ---=Level 4 Admin Commands =---");
		SendClientMessage(playerid,lightblue,"enable, disable, ban, rban, settemplevel, crash, spam, god, godcar, die, uconfig,");
		SendClientMessage(playerid,lightblue,"botcheck, lockserver, unlockserver, forbidname, forbidword, ");
		SendClientMessage(playerid,lightblue,"fakedeath, spawnall, muteall, unmuteall, getall, killall, freezeall,unbanname");
		SendClientMessage(playerid,lightblue,"unfreezeall, kickall, slapalll, explodeall, disarmall, ejectall, msay, Invisible2.");
		SendClientMessage(playerid,lightblue,"Banip Unbanip TBan.");

	}
	return 1;
}

dcmd_level5(playerid,params[]) {
	#pragma unused params
	if(PlayerInfo[playerid][Level] > 0)
	{
		SendClientMessage(playerid,blue,"    ---=Level 5 Admin Commands =---");
		SendClientMessage(playerid,lightblue,"god, sgod, setlevel, pickup, object, fakechat, asay.");
	}
	return 1;
}

dcmd_lconfig(playerid,params[]) {
	#pragma unused params
	if(PlayerInfo[playerid][Level] > 0)
	{
	    new string[128];
		SendClientMessage(playerid,blue,"    ---=== LAdmin Configuration ===---");
		format(string, sizeof(string), "Max Ping: %dms | ReadPms %d | ReadCmds %d | Max Admin Level %d | AdminOnlySkins %d", ServerInfo[MaxPing],  ServerInfo[ReadPMs],  ServerInfo[ReadCmds],  ServerInfo[MaxAdminLevel],  ServerInfo[AdminOnlySkins] );
		SendClientMessage(playerid,blue,string);
		format(string, sizeof(string), "AdminSkin1 %d | AdminSkin2 %d | NameKick %d | AntiBot %d | AntiSpam %d | AntiSwear %d", ServerInfo[AdminSkin], ServerInfo[AdminSkin2], ServerInfo[NameKick], ServerInfo[AntiBot], ServerInfo[AntiSpam], ServerInfo[AntiSwear] );
		SendClientMessage(playerid,blue,string);
		format(string, sizeof(string), "NoCaps %d | Locked %d | Pass %s | SaveWeaps %d | SaveMoney %d | ConnectMessages %d | AdminCmdMsgs %d", ServerInfo[NoCaps], ServerInfo[Locked], ServerInfo[Password], ServerInfo[GiveWeap], ServerInfo[GiveMoney], ServerInfo[ConnectMessages], ServerInfo[AdminCmdMsg] );
		SendClientMessage(playerid,blue,string);
		format(string, sizeof(string), "AutoLogin %d | MaxMuteWarnings %d | ChatDisabled %d | MustLogin %d | MustRegister %d", ServerInfo[AutoLogin], ServerInfo[MaxMuteWarnings], ServerInfo[DisableChat], ServerInfo[MustLogin], ServerInfo[MustRegister] );
		SendClientMessage(playerid,blue,string);
	}
	return 1;
}
dcmd_guardarskin(playerid,params[]) {
    #pragma unused params
	if(PlayerInfo[playerid][LoggedIn] == 1 && GetPVarInt(playerid, "PREMIUM") > 0) {
	    if(!strlen(params)) return SendClientMessage(playerid, red, "USA: /guardarskin [skinid]");
    	new SkinID = strval(params);
		udb_query(result, "UPDATE `user` SET `UseSkin` = '%d', `FavSkin` = '%d' WHERE `pName` = '%s'", 1, SkinID, DB_Escape(udb_encode(PlayerName2(playerid))));
		db_free_result(result);
		SendClientMessage(playerid,yellow,"Ahora Al Spawnear Te Pondran Este Skin! Si Quieres Dejar De Usarlo Usa "W"/dontuseskin");
		PlayerInfo[playerid][UseSkin] = 1; PlayerInfo[playerid][FavSkin] = SkinID;
		SetPlayerSkin(playerid,PlayerInfo[playerid][FavSkin]);
		return SendClientMessage(playerid,yellow,"Nuevo Skin En Uso");
	} else return SendClientMessage(playerid,red,"ERROR: Comando solo para usuarios premium nivel 1!");
}


dcmd_sarma(playerid, params[])
{
#pragma unused params
new weapons[13][2];
new gunname[32];
if(!pSave[playerid]){
new iString[500];
new foar[144];
SetPVarInt(playerid, "Save",1);
format(foar,sizeof(foar), "{00FF00}Bievenido al guardado de armas {FFFFFF}%s\n{00FF00}para desactivar su uso {FFFFFF}/sarma\n\n",PlayerName2(playerid));
strcat(iString, foar);
for(new i = 0, r = 0; i <= 12; i++){
	GetPlayerWeaponData(playerid, i, weapons[i][0], weapons[i][1]);
	if(i != 8){
		if(i != 7){
			if(r < 9){
				if(weapons[i][0] != 0){
					Weap[r][0] = weapons[i][0];
			 		GetWeaponName(weapons[i][0], gunname, sizeof(gunname));
					format(foar, sizeof(foar), "{00FF00}ID:[{FFFFFF}%d] {00FF00}Nombre: {FFFFFF}%s\n",weapons[i][0],gunname);
					strcat(iString, foar);
					r++;
				}
			}
		}
	}
}
ShowPlayerDialog(playerid,DIALOG_OTROS, DIALOG_STYLE_MSGBOX, "{FFFFFF}Armas {00FF00}guardadas", iString, "Aceptar", "");
PlayerPlaySound(playerid,1139,0.0,0.0,0.0);
pSave[playerid] = 1;
} else if(pSave[playerid]){
	for(new r = 0; r < 8; r++){
	Weap[r][0] = -1;
	}
SetPVarInt(playerid, "Save",0);
	pSave[playerid] = 0;
	SendClientMessage(playerid, red, "[Pura Joda] Ha cancelado el guardado de armas con éxito.");
}

return 1;
}


dcmd_v(playerid, params[])
{
		if(GetPVarInt(playerid, "MINION") || GetPVarInt(playerid, "RACE")) return 1;
        new Vehicle[32], VehicleID;
        if(!sscanf(params, "s[32]", Vehicle)) return SendClientMessage(playerid, red, "[Pura Joda] /v [NombreDelAuto]");
            VehicleID = GetVehicleModelIDFromName(Vehicle);
            if(VehicleID != 432 && VehicleID != 520 && VehicleID != 425) {
                        if(VehicleID == -1 )
                        {
                                VehicleID = strval(Vehicle);

                                if(VehicleID < 400 || VehicleID > 611 )
                                {
                                        return SendClientMessage(playerid, red, "[Pura Joda] Por favor un nombre válido.");
                                }
                        }

                        GetPlayerPos(playerid, cX, cY, cZ);
                        GetPlayerFacingAngle(playerid, cAngle);
                        if(VehicleID == 432 || VehicleID == 520 || VehicleID == 425) return SendClientMessage(playerid, -1, "Vehículo inválido");
						CreateVehicleEx(playerid, VehicleID, cX, cY, cZ+2.0, cAngle, random(126), random(126), -1);
      }
 					else SendClientMessage(playerid, red, "[Pura Joda] Vehículo inválido.");
        return 1;
        }
dcmd_respawncars(playerid,params[]) {
#pragma unused params
	if(PlayerInfo[playerid][Level] >= 4 ) {
 	//for(new i; i != MAX_VEHICLES; i++) if(!EsVehiculoOcupado(i)) SetVehicleToRespawn(i);
for(new i=1;i<=MAX_VEHICLES;i++)
{
    new count = 0;
    for(new a=0;a<MAX_PLAYERS;a++)
    {
        if(IsPlayerConnected(a) && IsPlayerInAnyVehicle(a))
        {
            if(GetPlayerVehicleID(a) == i) count++;
        }
    }
    if(count == 0)
    {
        DestroyVehicle(i);
    }
}

	//DestruirVehiculos();
	CMDMessageToAdmins(playerid,"RESPAWNCARS");
	return SendClientMessage(playerid,red,"INFO: Vehiculos Respawneados");
	} else return SendClientMessage(playerid,red,"ERROR: No Tienes El Nivel Suficiente Para Usar Este Comando");
}
dcmd_getinfo(playerid,params[]) {
    if(PlayerInfo[playerid][Level] >= 1 || IsPlayerAdmin(playerid)) {
	    if(!strlen(params)) return SendClientMessage(playerid,red,"USE: /getinfo [jugador]");
	    new player1, string[128];
	    player1 = strval(params);

	 	if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
		    new Float:player1health, Float:player1armour, playerip[128], Float:x, Float:y, Float:z, tmp2[256],
				year, month, day, P1Jailed[4], P1Frozen[4], P1Logged[4], P1Register[4], RegDate[256];

			GetPlayerHealth(player1,player1health);
			GetPlayerArmour(player1,player1armour);
	    	GetPlayerIp(player1, playerip, sizeof(playerip));
	    	GetPlayerPos(player1,x,y,z);
			getdate(year, month, day);
			udb_query(result, "SELECT `pLastOn`, `pRegisteredDate` FROM `user` WHERE `pName` = '%s' LIMIT 1", DB_Escape(udb_encode(PlayerName2(playerid))));
			new field[30]; db_get_field_assoc(result, "pLastOn", field, 30);

			if(PlayerInfo[player1][Jailed] == 1) P1Jailed = "Yes"; else P1Jailed = "No";
			if(PlayerInfo[player1][Frozen] == 1) P1Frozen = "Yes"; else P1Frozen = "No";
			if(PlayerInfo[player1][LoggedIn] == 1) P1Logged = "Yes"; else P1Logged = "No";
			if(db_num_rows(result)) P1Register = "Yes"; else P1Register = "No";
			if(strval(field)==0) tmp2 = "Never"; else tmp2 = field;
			db_get_field_assoc(result, "pRegisteredDate", field, 30);
			if(strlen(field) < 3) RegDate = "n/a"; else RegDate = field;
			db_free_result(result);

		    new Sum6, Average, w;
			while (w < PING_MAX_EXCEEDS) {
				Sum6 += PlayerInfo[player1][pPing][w];
				w++;
			}
			Average = (Sum6 / PING_MAX_EXCEEDS);

	  		format(string, sizeof(string),"(Player Info)  ..: Nombre: %s  ID: %d :..", PlayerName2(player1), player1);
			SendClientMessage(playerid,lightblue,string);
		  	format(string, sizeof(string),"Vida: %d  Chaleco: %d  Score: %d  Dinero: %d  Skin: %d  IP: %s  Ping: %d  Average Ping: %d",floatround(player1health),floatround(player1armour),
			GetPlayerScore(player1),GetPlayerMoney(player1),GetPlayerSkin(player1),playerip,GetPlayerPing(player1), Average );
			SendClientMessage(playerid,red,string);
			format(string, sizeof(string),"Interior: %d  Virtual World: %d  Wanted Level: %d  X %0.1f  Y %0.1f  Z %0.1f", GetPlayerInterior(player1), GetPlayerVirtualWorld(player1), GetPlayerWantedLevel(player1), Float:x,Float:y,Float:z);
			SendClientMessage(playerid,orange,string);
			format(string, sizeof(string),"Kills: %d  Deaths: %d  Ratio: %0.2f  AdminLevel: %d", GetPVarInt(player1, "Score"), PlayerInfo[player1][Deaths], Float:GetPVarInt(player1, "Score")/Float:PlayerInfo[player1][Deaths], PlayerInfo[player1][Level] );
			SendClientMessage(playerid,yellow,string);
			format(string, sizeof(string),"Registered: %s  Logged In: %s  In Jail: %s  Frozen: %s", P1Register, P1Logged, P1Jailed, P1Frozen );
			SendClientMessage(playerid,green,string);
			format(string, sizeof(string),"Last On Server: %s  Register Date: %s  Todays Date: %d/%d/%d", tmp2, RegDate, day,month,year );
			SendClientMessage(playerid,COLOR_GREEN,string);

			if(IsPlayerInAnyVehicle(player1)) {
				new Float:VHealth, carid = GetPlayerVehicleID(playerid); GetVehicleHealth(carid,VHealth);
				format(string, sizeof(string),"VehicleID: %d  Model: %d  Vehicle Name: %s  Vehicle Health: %d",carid, GetVehicleModel(carid), VehicleNames[GetVehicleModel(carid)-400], floatround(VHealth) );
				SendClientMessage(playerid,COLOR_BLUE,string);
			}

			new slot, ammo, weap, Count, WeapName[24], WeapSTR[128], p; WeapSTR = "Weaps: ";
			for (slot = 0; slot < 14; slot++) {	GetPlayerWeaponData(player1, slot, weap, ammo); if( ammo != 0 && weap != 0) Count++; }
			if(Count < 1) return SendClientMessage(playerid,lightblue,"Player has no weapons");
			else {
				for (slot = 0; slot < 14; slot++)
				{
					GetPlayerWeaponData(player1, slot, weap, ammo);
					if (ammo > 0 && weap > 0)
					{
						GetWeaponName(weap, WeapName, sizeof(WeapName) );
						if (ammo == 65535 || ammo == 1) format(WeapSTR,sizeof(WeapSTR),"%s%s (1)",WeapSTR, WeapName);
						else format(WeapSTR,sizeof(WeapSTR),"%s%s (%d)",WeapSTR, WeapName, ammo);
						p++;
						if(p >= 5) { SendClientMessage(playerid, lightblue, WeapSTR); format(WeapSTR, sizeof(WeapSTR), "Weaps: "); p = 0;
						} else format(WeapSTR, sizeof(WeapSTR), "%s,  ", WeapSTR);
					}
				}
				if(p <= 4 && p > 0) {
					string[strlen(string)-3] = '.';
				    SendClientMessage(playerid, lightblue, WeapSTR);
				}
			}
			return 1;
		} else return SendClientMessage(playerid,red,"ERROR: El jugador no esta conectado");
	} else return SendClientMessage(playerid,red,"SÓLO ADMINISTRADORES, SÍ USTED ES UNO DEBE SER DE MAYOR LVL.");
}

dcmd_disable(playerid,params[]) {
    if(PlayerInfo[playerid][Level] >= 4 || IsPlayerAdmin(playerid)) {
	    if(!strlen(params)) {
			SendClientMessage(playerid,red,"USE: /disable [antiswear / namekick / antispam / ping / readcmds / readpms /caps / admincmdmsgs");
			return SendClientMessage(playerid,red,"       /connectmsgs / autologin ]");
		}
	    new string[128], file[256]; format(file,sizeof(file),"ladmin/config/Config.ini");
		if(strcmp(params,"antiswear",true) == 0) {
			ServerInfo[AntiSwear] = 0;
			dini_IntSet(file,"AntiSwear",0);
			format(string,sizeof(string),"El Administrador %s ha deshabilitado el antiswear", PlayerName2(playerid));
			SendClientMessageToAll(blue,string);
		} else if(strcmp(params,"namekick",true) == 0) {
			ServerInfo[NameKick] = 0;
			dini_IntSet(file,"NameKick",0);
			format(string,sizeof(string),"El Administrador %s ha deshabilitado el namekick", PlayerName2(playerid));
			SendClientMessageToAll(blue,string);
	 	} else if(strcmp(params,"antispam",true) == 0)	{
			ServerInfo[AntiSpam] = 0;
			dini_IntSet(file,"AntiSpam",0);
			format(string,sizeof(string),"El Administrador %s ha deshabilitado el antispam", PlayerName2(playerid));
			SendClientMessageToAll(blue,string);
		} else if(strcmp(params,"ping",true) == 0)	{
			ServerInfo[MaxPing] = 0;
			dini_IntSet(file,"MaxPing",0);
			format(string,sizeof(string),"El Administrador %s ha deshabilitado el ping kick", PlayerName2(playerid));
			SendClientMessageToAll(blue,string);
		} else if(strcmp(params,"readcmds",true) == 0) {
			ServerInfo[ReadCmds] = 0;
			dini_IntSet(file,"ReadCMDs",0);
			format(string,sizeof(string),"El Administrador %s ha deshabilitado el reading commands", PlayerName2(playerid));
			MessageToAdmins(blue,string);
		} else if(strcmp(params,"readpms",true) == 0) {
			ServerInfo[ReadPMs] = 0;
			dini_IntSet(file,"ReadPMs",0);
			format(string,sizeof(string),"El Administrador %s ha deshabilitado el reading pms", PlayerName2(playerid));
			MessageToAdmins(blue,string);
  		} else if(strcmp(params,"caps",true) == 0)	{
			ServerInfo[NoCaps] = 1;
			dini_IntSet(file,"NoCaps",1);
			format(string,sizeof(string),"El Administrador %s ha deshabilitado el captial letters in chat", PlayerName2(playerid));
			SendClientMessageToAll(blue,string);
		} else if(strcmp(params,"admincmdmsgs",true) == 0) {
			ServerInfo[AdminCmdMsg] = 0;
			dini_IntSet(file,"AdminCMDMessages",0);
			format(string,sizeof(string),"El Administrador %s ha deshabilitado el admin command messages", PlayerName2(playerid));
			MessageToAdmins(green,string);
		} else if(strcmp(params,"connectmsgs",true) == 0)	{
			ServerInfo[ConnectMessages] = 0;
			dini_IntSet(file,"ConnectMessages",0);
			format(string,sizeof(string),"El Administrador %s ha deshabilitado el connect & disconnect messages", PlayerName2(playerid));
			MessageToAdmins(green,string);
		} else if(strcmp(params,"autologin",true) == 0)	{
			ServerInfo[AutoLogin] = 0;
			dini_IntSet(file,"AutoLogin",0);
			format(string,sizeof(string),"El Administrador %s ha deshabilitado el auto login", PlayerName2(playerid));
			MessageToAdmins(green,string);
		} else {
			SendClientMessage(playerid,red,"USE: /disable [antiswear / namekick / antispam / ping / readcmds / readpms /caps /cmdmsg ]");
		} return 1;
	} else return SendClientMessage(playerid,red,"ERROR: Necesitas ser Administrador nivel 4 para usar este comando");
}

dcmd_enable(playerid,params[]) {
    if(PlayerInfo[playerid][Level] >= 4 || IsPlayerAdmin(playerid)) {
	    if(!strlen(params)) {
			SendClientMessage(playerid,red,"USAGE: /enable [antiswear / namekick / antispam / ping / readcmds / readpms /caps / admincmdmsgs");
			return SendClientMessage(playerid,red,"       /connectmsgs / autologin ]");
		}
	    new string[128], file[256]; format(file,sizeof(file),"ladmin/config/Config.ini");
		if(strcmp(params,"antiswear",true) == 0) {
			ServerInfo[AntiSwear] = 1;
			dini_IntSet(file,"AntiSwear",1);
			format(string,sizeof(string),"El Administrador %s ha habilitado el antiswear", PlayerName2(playerid));
			SendClientMessageToAll(blue,string);
		} else if(strcmp(params,"namekick",true) == 0)	{
			ServerInfo[NameKick] = 1;
			format(string,sizeof(string),"El Administrador %s ha habilitado el namekick", PlayerName2(playerid));
			SendClientMessageToAll(blue,string);
 		} else if(strcmp(params,"antispam",true) == 0)	{
			ServerInfo[AntiSpam] = 1;
			dini_IntSet(file,"AntiSpam",1);
			format(string,sizeof(string),"El Administrador %s ha habilitado el antispam", PlayerName2(playerid));
			SendClientMessageToAll(blue,string);
		} else if(strcmp(params,"ping",true) == 0)	{
			ServerInfo[MaxPing] = 800;
			dini_IntSet(file,"MaxPing",800);
			format(string,sizeof(string),"El Administrador %s ha habilitado el ping kick", PlayerName2(playerid));
			SendClientMessageToAll(blue,string);
		} else if(strcmp(params,"readcmds",true) == 0)	{
			ServerInfo[ReadCmds] = 1;
			dini_IntSet(file,"ReadCMDs",1);
			format(string,sizeof(string),"El Administrador %s ha habilitado el reading commands", PlayerName2(playerid));
			MessageToAdmins(blue,string);
		} else if(strcmp(params,"readpms",true) == 0) {
			ServerInfo[ReadPMs] = 1;
			dini_IntSet(file,"ReadPMs",1);
			format(string,sizeof(string),"El Administrador %s ha habilitado el reading pms", PlayerName2(playerid));
			MessageToAdmins(blue,string);
		} else if(strcmp(params,"caps",true) == 0)	{
			ServerInfo[NoCaps] = 0;
			dini_IntSet(file,"NoCaps",0);
			format(string,sizeof(string),"El Administrador %s ha habilitado el captial letters in chat", PlayerName2(playerid));
			SendClientMessageToAll(blue,string);
		} else if(strcmp(params,"admincmdmsgs",true) == 0)	{
			ServerInfo[AdminCmdMsg] = 1;
			dini_IntSet(file,"AdminCmdMessages",1);
			format(string,sizeof(string),"El Administrador %s ha habilitado el admin command messages", PlayerName2(playerid));
			MessageToAdmins(green,string);
		} else if(strcmp(params,"connectmsgs",true) == 0) {
			ServerInfo[ConnectMessages] = 1;
			dini_IntSet(file,"ConnectMessages",1);
			format(string,sizeof(string),"El Administrador %s ha habilitado el connect & disconnect messages", PlayerName2(playerid));
			MessageToAdmins(green,string);
		} else if(strcmp(params,"autologin",true) == 0) {
			ServerInfo[AutoLogin] = 1;
			dini_IntSet(file,"AutoLogin",1);
			format(string,sizeof(string),"El Administrador %s ha habilitado el auto login", PlayerName2(playerid));
			MessageToAdmins(green,string);
		} else {
			SendClientMessage(playerid,red,"USE: /enable [antiswear / namekick / antispam / ping / readcmds / readpms /caps /cmdmsg ]");
		} return 1;
	} else return SendClientMessage(playerid,red,"ERROR: Necesitas ser Administrador nivel 4 para usar este comando");
}

dcmd_lweaps(playerid,params[]) {
	#pragma unused params
	if(PlayerInfo[playerid][Level] >= 3) {
		GivePlayerWeapon(playerid,28,1000); GivePlayerWeapon(playerid,31,1000); GivePlayerWeapon(playerid,34,1000);
		GivePlayerWeapon(playerid,38,1000); GivePlayerWeapon(playerid,16,1000);	GivePlayerWeapon(playerid,42,1000);
		GivePlayerWeapon(playerid,14,1000); GivePlayerWeapon(playerid,46,1000);	GivePlayerWeapon(playerid,9,1);
		GivePlayerWeapon(playerid,24,1000); GivePlayerWeapon(playerid,26,1000); return 1;
	} else return SendClientMessage(playerid,red,"SÓLO ADMINISTRADORES, SÍ USTED ES UNO DEBE SER DE MAYOR LVL.");
}

dcmd_countdown(playerid,params[]) {
	#pragma unused params
    if(PlayerInfo[playerid][Level] >= 3) {
        if(CountDown == -1) {
			CountDown = 6;
			SetTimer("countdown",1000,0);
			return CMDMessageToAdmins(playerid,"COUNTDOWN");
		} else return SendClientMessage(playerid,red,"ERROR: Countdown en progreso");
	} else return SendClientMessage(playerid,red,"SÓLO ADMINISTRADORES, SÍ USTED ES UNO DEBE SER DE MAYOR LVL.");
}
dcmd_duelo(playerid,params[])
{
	new index = 0, tmp[256];
	tmp = strtok(params,index);
	if (!strlen(tmp)) return SendClientMessage(playerid,COLOR_ROJO,"[Pura Joda] /Duelo [Invitar/Ver]");
	if (!strcmp("invitar",tmp,false))
	{
	    if (EnDuelo[playerid] == 1) return SendClientMessage(playerid,COLOR_DUELO,"[Pura Joda] Estás en duelo.");
		new strin[400], form[144];
        strcat(strin, ""R"Arena\t"G"Estado\n");
		for(new i=1; i<=ARENAS-1; i++)
		{
			if(!Duelos[i][Libre])
			{
			format(form, 144, ""W"%s\t"G"LIBRE\n",arenas[i][Arena]);
			}
			else {
			format(form, 144, ""W"%s\t"R"OCUPADA\n",arenas[i][Arena]);
			}
			strcat(strin, form);
		}

		ShowPlayerDialog(playerid, DUELOSMENU2, DIALOG_STYLE_TABLIST_HEADERS,""R"Seleccione una "W"arena",strin,"Ok", "Cancelar");
		return 1;
	}
	if (!strcmp("ver",tmp,false))
	{
	    if (EnDuelo[playerid]==1) return SendClientMessage(playerid,COLOR_DUELO,""R"[Pura Joda] Estás en duelo.");
		new strin[400], form[144];
        strcat(strin, ""R"Arena\t"G"Estado\n");
		for(new i=1; i<=ARENAS-1; i++)
		{
			if(!Duelos[i][Libre])
			{
			format(form, 144, ""W"%s\t"G"LIBRE\n",arenas[i][Arena]);
			}
			else {
			format(form, 144, ""W"%s\t"R"EN PROGRESO\n",arenas[i][Arena]);
			}
			strcat(strin, form);
		}

		ShowPlayerDialog(playerid, DUELOSMENU+3, DIALOG_STYLE_TABLIST_HEADERS,""R"Escoge una arena",strin,"Ok", "Cancelar");
        return 1;
	}
    return SendClientMessage(playerid,COLOR_ROJO,"[Pura Joda] /Duelo [Invitar/Ver]");
}
	dcmd_nduelo(playerid,params[]) {
    #pragma unused params
    if(	NODUEL[playerid] == 0)
	{
	NODUEL[playerid] = 1;
	return SendClientMessage(playerid,red,"[Pura Joda] has cancelado los duelos.");
	}
    else  if(NODUEL[playerid] == 1)
	{
	NODUEL[playerid] = 0;
	return SendClientMessage(playerid,red,"[Pura Joda] has activado los duelos.");
	}
	return 1;
	}


dcmd_lammo(playerid,params[]) {
	#pragma unused params
	if(PlayerInfo[playerid][Level] >= 3) {
		MaxAmmo(playerid);
		return CMDMessageToAdmins(playerid,"LAMMO");
	} else return SendClientMessage(playerid,red,"SÓLO ADMINISTRADORES, SÍ USTED ES UNO DEBE SER DE MAYOR LVL.");
}

dcmd_vr(playerid,params[]) {
	#pragma unused params
	if(PlayerInfo[playerid][Level] >= 1) {
		if (IsPlayerInAnyVehicle(playerid)) {
			SetVehicleHealth(GetPlayerVehicleID(playerid),1250.0);
			return SendClientMessage(playerid,blue,"Vehiculo Reparado");
		} else return SendClientMessage(playerid,red,"ERROR: No estas en un vehiculo");
	} else return SendClientMessage(playerid,red,"ERROR: Necesitas ser Administrador nivel 1 para usar este comando");
}

dcmd_fix(playerid,params[])
{
	return dcmd_vr(playerid, params);
}

dcmd_repair(playerid,params[]) {
	#pragma unused params
	if(PlayerInfo[playerid][Level] >= 1) {
		if (IsPlayerInAnyVehicle(playerid)) {
			GetPlayerPos(playerid,Pos[playerid][0],Pos[playerid][1],Pos[playerid][2]);
			GetVehicleZAngle(GetPlayerVehicleID(playerid), Pos[playerid][3]);
			SetPlayerCameraPos(playerid, 1929.0, 2137.0, 11.0);
			SetPlayerCameraLookAt(playerid,1935.0, 2138.0, 11.5);
			SetVehiclePos(GetPlayerVehicleID(playerid), 1974.0,2162.0,11.0);
			SetVehicleZAngle(GetPlayerVehicleID(playerid), -90);
			SetTimerEx("RepairCar",5000,0,"i",playerid);
	    	return SendClientMessage(playerid,blue,"Tu vehiculo estara listo en 5 segundos...");
		} else return SendClientMessage(playerid,red,"ERROR: No estas en un vehiculo!");
	} else return SendClientMessage(playerid,red,"ERROR: Necesitas ser Administrador nivel 1 para usar este comando");
}

dcmd_ltune(playerid,params[]) {
	#pragma unused params
	if(PlayerInfo[playerid][Level] >= 1) {
		if(IsPlayerInAnyVehicle(playerid)) {
        new LVehicleID = GetPlayerVehicleID(playerid), LModel = GetVehicleModel(LVehicleID);
        switch(LModel)
		{
			case 448,461,462,463,468,471,509,510,521,522,523,581,586,449:
			return SendClientMessage(playerid,red,"ERROR: No puedes tunear este vehiculo!");
		}
        CMDMessageToAdmins(playerid,"LTUNE");
		SetVehicleHealth(LVehicleID,2000.0);
		TuneLCar(LVehicleID);
		return PlayerPlaySound(playerid,1133,0.0,0.0,0.0);
		} else return SendClientMessage(playerid,red,"ERROR: No estas en un vehiculo!");
	} else return SendClientMessage(playerid,red,"ERROR: Necesitas ser Administrador nivel 1 para usar este comando");
}

dcmd_lhy(playerid,params[]) {
	#pragma unused params
	if(PlayerInfo[playerid][Level] >= 1) {
		if(IsPlayerInAnyVehicle(playerid)) {
        new LVehicleID = GetPlayerVehicleID(playerid), LModel = GetVehicleModel(LVehicleID);
        switch(LModel)
		{
			case 448,461,462,463,468,471,509,510,521,522,523,581,586,449:
			return SendClientMessage(playerid,red,"ERROR: No puedes tunear este vehiculo!");
		}
        AddVehicleComponent(LVehicleID, 1087);
		return PlayerPlaySound(playerid,1133,0.0,0.0,0.0);
		} else return SendClientMessage(playerid,red,"ERROR: No estas en un vehiculo!");
	} else return SendClientMessage(playerid,red,"ERROR: Necesitas ser Administrador nivel 1 para usar este comando");
}

dcmd_lcar(playerid,params[]) {
	#pragma unused params
	if(PlayerInfo[playerid][Level] >= 2) {
		if (!IsPlayerInAnyVehicle(playerid)) {
  						GetPlayerPos(playerid, cX, cY, cZ);
                        GetPlayerFacingAngle(playerid, cAngle);
						CreateVehicleEx(playerid, 415, cX, cY, cZ+2.0, cAngle, random(126), random(126), -1);
			//CarSpawner(playerid,415);
			CMDMessageToAdmins(playerid,"LCAR");
			return SendClientMessage(playerid,blue,"Disfruta tu nuevo auto!");
		} else return SendClientMessage(playerid,red,"ERROR: Ya estas en un vehiculo!");
	} else return SendClientMessage(playerid,red,"SÓLO ADMINISTRADORES, SÍ USTED ES UNO DEBE SER DE MAYOR LVL.");
}

dcmd_lbike(playerid,params[]) {
	#pragma unused params
	if(PlayerInfo[playerid][Level] >= 2) {
		if (!IsPlayerInAnyVehicle(playerid)) {
			CarSpawner(playerid,522);
			CMDMessageToAdmins(playerid,"LBIKE");
			return SendClientMessage(playerid,blue,"Disfruta tu nueva moto!");
		} else return SendClientMessage(playerid,red,"ERROR: Ya estas en un vehiculo!");
	} else return SendClientMessage(playerid,red,"SÓLO ADMINISTRADORES, SÍ USTED ES UNO DEBE SER DE MAYOR LVL.");
}

dcmd_lheli(playerid,params[]) {
	#pragma unused params
	if(PlayerInfo[playerid][Level] >= 2) {
		if (!IsPlayerInAnyVehicle(playerid)) {
			CarSpawner(playerid,487);
			CMDMessageToAdmins(playerid,"LHELI");
			return SendClientMessage(playerid,blue,"Disfruta tu nuevo helicoptero!");
		} else return SendClientMessage(playerid,red,"ERROR: Ya estas en un vehiculo!");
	} else return SendClientMessage(playerid,red,"SÓLO ADMINISTRADORES, SÍ USTED ES UNO DEBE SER DE MAYOR LVL.");
}

dcmd_lboat(playerid,params[]) {
	#pragma unused params
	if(PlayerInfo[playerid][Level] >= 2) {
		if (!IsPlayerInAnyVehicle(playerid)) {
			CarSpawner(playerid,493);
			CMDMessageToAdmins(playerid,"LBOAT");
			return SendClientMessage(playerid,blue,"Disfruta tu nuevo barco!");
		} else return SendClientMessage(playerid,red,"ERROR: Ya estas en un vehiculo!");
	} else return SendClientMessage(playerid,red,"SÓLO ADMINISTRADORES, SÍ USTED ES UNO DEBE SER DE MAYOR LVL.");
}

dcmd_lplane(playerid,params[]) {
	#pragma unused params
	if(PlayerInfo[playerid][Level] >= 2) {
		if (!IsPlayerInAnyVehicle(playerid)) {
			CarSpawner(playerid,513);
			CMDMessageToAdmins(playerid,"LPLANE");
			return SendClientMessage(playerid,blue,"Disfruta tu nuevo avion!");
		} else return SendClientMessage(playerid,red,"ERROR: Ya estas en un vehiculo!");
	} else return SendClientMessage(playerid,red,"SÓLO ADMINISTRADORES, SÍ USTED ES UNO DEBE SER DE MAYOR LVL.");
}

dcmd_lnos(playerid,params[]) {
	#pragma unused params
	if(PlayerInfo[playerid][Level] >= 1) {
		if(IsPlayerInAnyVehicle(playerid)) {
	        switch(GetVehicleModel( GetPlayerVehicleID(playerid) )) {
				case 448,461,462,463,468,471,509,510,521,522,523,581,586,449:
				return SendClientMessage(playerid,red,"ERROR: No puedes tunear este vehiculo!");
			}
	        AddVehicleComponent(GetPlayerVehicleID(playerid), 1010);
			return PlayerPlaySound(playerid,1133,0.0,0.0,0.0);
		} else return SendClientMessage(playerid,red,"ERROR: Necesitas estar en un vehiculo.");
	} else return SendClientMessage(playerid,red,"ERROR: Necesitas ser Administrador nivel 1 para usar este comando");
}

dcmd_linkcar(playerid,params[]) {
	#pragma unused params
	if(IsPlayerInAnyVehicle(playerid)) {
    	LinkVehicleToInterior(GetPlayerVehicleID(playerid),GetPlayerInterior(playerid));
	    SetVehicleVirtualWorld(GetPlayerVehicleID(playerid),GetPlayerVirtualWorld(playerid));
	    return SendClientMessage(playerid,lightblue, "Tu vehiculo ahora esta en tu mundo virtual e interior");
	} else return SendClientMessage(playerid,red,"ERROR: Necesitas estar en un vehiculo.");
 }

dcmd_car(playerid,params[]) {
    if(GetPVarInt(playerid, "MINION") == 1) return SendClientMessage(playerid, 0xFF0000, "Error: estas en minijuego no abuses del admin");
	if(PlayerInfo[playerid][Level] >= 2) {
	    new tmp[256], tmp2[256], tmp3[256], Index; tmp = strtok(params,Index), tmp2 = strtok(params,Index); tmp3 = strtok(params,Index);
	    if(!strlen(tmp)) return SendClientMessage(playerid, red, "USE: /car [modelo/nombre] [color1] [color2]");
		new car, colour1, colour2, string[128];
   		if(!IsNumeric(tmp)) car = GetVehicleModelIDFromName(tmp); else car = strval(tmp);
		if(car < 400 || car > 611) return  SendClientMessage(playerid, red, "ERROR: Modelo de vehiculo invalido");
		if(!strlen(tmp2)) colour1 = random(126); else colour1 = strval(tmp2);
		if(!strlen(tmp3)) colour2 = random(126); else colour2 = strval(tmp3);
		if(PlayerInfo[playerid][pCar] != -1 && !IsPlayerAdmin(playerid) ) CarDeleter(PlayerInfo[playerid][pCar]);
		new LVehicleID,Float:X,Float:Y,Float:Z, Float:Angle,int1;	GetPlayerPos(playerid, X,Y,Z);	GetPlayerFacingAngle(playerid,Angle);   int1 = GetPlayerInterior(playerid);
		PlayerInfo[playerid][pCar] = CreateVehicle(car, X+3,Y,Z, Angle, colour1, colour2, -1); LinkVehicleToInterior(LVehicleID,int1);

			CMDMessageToAdmins(playerid,"CAR");
		format(string, sizeof(string), "%s ha aparecido un \"%s\" (Modelo:%d) color (%d, %d), el %0.2f, %0.2f, %0.2f", pName(playerid), VehicleNames[car-400], car, colour1, colour2, X, Y, Z);
        SaveToFile("CarSpawns",string);
		format(string, sizeof(string), "Has aparecido un \"%s\" (Modelo:%d) color (%d, %d)", VehicleNames[car-400], car, colour1, colour2);
		return SendClientMessage(playerid,lightblue, string);
	} else return SendClientMessage(playerid,red,"SÓLO ADMINISTRADORES, SÍ USTED ES UNO DEBE SER DE MAYOR LVL.");
}

dcmd_carhealth(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 3) {
	    new tmp[256], tmp2[256], Index; tmp = strtok(params,Index), tmp2 = strtok(params,Index);
	    if(!strlen(tmp) || !strlen(tmp2) || !IsNumeric(tmp2)) return SendClientMessage(playerid, red, "USE: /carhealth [jugador] [cantidad]");
		new player1 = strval(tmp), health = strval(tmp2), string[128];
		if(PlayerInfo[player1][Level] == ServerInfo[MaxAdminLevel] && PlayerInfo[playerid][Level] != ServerInfo[MaxAdminLevel]) return SendClientMessage(playerid,red,"ERROR: You cannot use this command on this admin");
        if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
            if(IsPlayerInAnyVehicle(player1)) {
		       	CMDMessageToAdmins(playerid,"CARHEALTH");
				format(string, sizeof(string), "Has puesto la vida del vehiculo de \"%s\" en '%d", pName(player1), health); SendClientMessage(playerid,blue,string);
				if(player1 != playerid) { format(string,sizeof(string),"El Administrador \"%s\" ha puesto la vida de tu vehiculo en '%d'", pName(playerid), health); SendClientMessage(player1,blue,string); }
   				return SetVehicleHealth(GetPlayerVehicleID(player1), health);
			} else return SendClientMessage(playerid,red,"ERROR: El jugador no esta en un vehiculo");
	    } else return SendClientMessage(playerid,red,"ERROR: El jugador no esta conectado");
	} else return SendClientMessage(playerid,red,"SÓLO ADMINISTRADORES, SÍ USTED ES UNO DEBE SER DE MAYOR LVL.");
}

dcmd_carcolour(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 3) {
	    new tmp[256], tmp2[256], tmp3[256], Index; tmp = strtok(params,Index), tmp2 = strtok(params,Index); tmp3 = strtok(params,Index);
	    if(!strlen(tmp) || !strlen(tmp2) || !strlen(tmp3) || !IsNumeric(tmp2)) return SendClientMessage(playerid, red, "USE: /carcolour [jugador] [color1] [color2]");
		new player1 = strval(tmp), colour1, colour2, string[128];
		if(!strlen(tmp2)) colour1 = random(126); else colour1 = strval(tmp2);
		if(!strlen(tmp3)) colour2 = random(126); else colour2 = strval(tmp3);
		if(PlayerInfo[player1][Level] == ServerInfo[MaxAdminLevel] && PlayerInfo[playerid][Level] != ServerInfo[MaxAdminLevel]) return SendClientMessage(playerid,red,"ERROR: You cannot use this command on this admin");
        if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
            if(IsPlayerInAnyVehicle(player1)) {
		       	CMDMessageToAdmins(playerid,"CARCOLOUR");
				format(string, sizeof(string), "Has cambiado el color del %s de \"%s's\" a '%d,%d'", pName(player1), VehicleNames[GetVehicleModel(GetPlayerVehicleID(player1))-400], colour1, colour2 ); SendClientMessage(playerid,blue,string);
				if(player1 != playerid) { format(string,sizeof(string),"El Administrador \"%s\" ha cambiado el color de tu %s a '%d,%d''", pName(playerid), VehicleNames[GetVehicleModel(GetPlayerVehicleID(player1))-400], colour1, colour2 ); SendClientMessage(player1,blue,string); }
   				return ChangeVehicleColor(GetPlayerVehicleID(player1), colour1, colour2);
			} else return SendClientMessage(playerid,red,"ERROR: El jugador no esta en un vehiculo");
	    } else return SendClientMessage(playerid,red,"ERROR: El jugador no esta conectado");
	} else return SendClientMessage(playerid,red,"SÓLO ADMINISTRADORES, SÍ USTED ES UNO DEBE SER DE MAYOR LVL.");
}

dcmd_god(playerid,params[]) {
	#pragma unused params
	if(PlayerInfo[playerid][Level] >= 4 || IsPlayerAdmin(playerid)) {
    	if(PlayerInfo[playerid][God] == 0)	{
   	    	PlayerInfo[playerid][God] = 1;
    	    SetPlayerHealth(playerid,100000);
			GivePlayerWeapon(playerid,16,50000); GivePlayerWeapon(playerid,26,50000);
           	SendClientMessage(playerid,green,"GODMODE ACTIVADO");
			return CMDMessageToAdmins(playerid,"GOD");
		    } else {
   	        PlayerInfo[playerid][God] = 0;
       	    SendClientMessage(playerid,red,"GODMODE DESACTIVADO");
        	SetPlayerHealth(playerid, 100);
		} return GivePlayerWeapon(playerid,35,0);
	} else return SendClientMessage(playerid,red,"SÓLO ADMINISTRADORES, SÍ USTED ES UNO DEBE SER DE MAYOR LVL.");
}

dcmd_sgod(playerid,params[]) {
	#pragma unused params
	if(PlayerInfo[playerid][Level] >= 5 || IsPlayerAdmin(playerid)) {
   		if(PlayerInfo[playerid][God] == 0)	{
        	PlayerInfo[playerid][God] = 1;
	        SetPlayerHealth(playerid,100000);
			GivePlayerWeapon(playerid,16,50000); GivePlayerWeapon(playerid,26,50000);
            return SendClientMessage(playerid,green,"GODMODE ACTIVADO");
		} else	{
   	        PlayerInfo[playerid][God] = 0;
            SendClientMessage(playerid,red,"GODMODE DESACTIVADO");
	        SetPlayerHealth(playerid, 100); return GivePlayerWeapon(playerid,35,0);	}
	} else return SendClientMessage(playerid,red,"ERROR: Necesitas ser Administrador nivel 5 para usar este comando");
}

dcmd_godcar(playerid,params[]) {
	#pragma unused params
	if(PlayerInfo[playerid][Level] >= 4 || IsPlayerAdmin(playerid)) {
		if(IsPlayerInAnyVehicle(playerid)) {
	    	if(PlayerInfo[playerid][GodCar] == 0) {
        		PlayerInfo[playerid][GodCar] = 1;
   				CMDMessageToAdmins(playerid,"GODCAR");
            	return SendClientMessage(playerid,green,"GODCARMODE ACTIVADO");
			} else {
	            PlayerInfo[playerid][GodCar] = 0;
    	        return SendClientMessage(playerid,red,"GODCARMODE DESACTIVADO"); }
		} else return SendClientMessage(playerid,red,"ERROR: Necesitas estar en un vehiculo para usar este comando");
	} else return SendClientMessage(playerid,red,"ERROR: Necesitas ser Administrador nivel 4 para usar este comando");
}


dcmd_die(playerid,params[]) {
	#pragma unused params
	if(PlayerInfo[playerid][Level] >= 5 || IsPlayerAdmin(playerid)) {
		new Float:x, Float:y, Float:z ;
		GetPlayerPos( playerid, Float:x, Float:y, Float:z );
		CreateExplosion(Float:x+10, Float:y, Float:z, 8,10.0);
		CreateExplosion(Float:x-10, Float:y, Float:z, 8,10.0);
		CreateExplosion(Float:x, Float:y+10, Float:z, 8,10.0);
		CreateExplosion(Float:x, Float:y-10, Float:z, 8,10.0);
		CreateExplosion(Float:x+10, Float:y+10, Float:z, 8,10.0);
		CreateExplosion(Float:x-10, Float:y+10, Float:z, 8,10.0);
		return CreateExplosion(Float:x-10, Float:y-10, Float:z, 8,10.0);
	} else return SendClientMessage(playerid,red,"ERROR: Necesitas ser Administrador nivel 10 para usar este comando");
}

dcmd_getid(playerid,params[]) {
	if(!strlen(params)) return SendClientMessage(playerid,blue,"Uso Correcto: /getid [parte del nick]");
	new found, string[128], playername[MAX_PLAYER_NAME];
	format(string,sizeof(string),"Buscado por: \"%s\" ",params);
	SendClientMessage(playerid,blue,string);
	for(new i=0; i <= MAX_PLAYER; i++)
	{
		if(IsPlayerConnected(i))
		{
	  		GetPlayerName(i, playername, MAX_PLAYER_NAME);
			new namelen = strlen(playername);
			new bool:searched=false;
	    	for(new pos=0; pos <= namelen; pos++)
			{
				if(searched != true)
				{
					if(strfind(playername,params,true) == pos)
					{
		                found++;
						format(string,sizeof(string),"%d. %s (ID %d)",found,playername,i);
						SendClientMessage(playerid, green ,string);
						searched = true;
					}
				}
			}
		}
	}
	if(found == 0) SendClientMessage(playerid, lightblue, "Ningun jugador contiene esa parte en su nick");
	return 1;
}

dcmd_asay(playerid,params[]) {
	#pragma unused params
	if(PlayerInfo[playerid][Level] >= 5) {
 		if(!strlen(params)) return SendClientMessage(playerid, red, "USAGE: /asay [text]");
		new string[128]; format(string, sizeof(string), "Administrador | %s dice: %s.", PlayerName2(playerid), params[0] );
		return SendClientMessageToAll(COLOR_PINK,string);
	} else return SendClientMessage(playerid,red,"ERROR: No tiene ningún permiso para usar este comando.");
}

dcmd_msay(playerid,params[]) {
	#pragma unused params
	if(PlayerInfo[playerid][Level] >= 1) {
 		if(!strlen(params)) return SendClientMessage(playerid, red, "USE: /msay [texto]");
		new string[128]; format(string, sizeof(string), "Moderador | %s dice: %s.", PlayerName2(playerid), params[0] );
		return SendClientMessageToAll(COLOR_PINK,string);
	} else return SendClientMessage(playerid,red,"ERROR: Necesitas ser Moderador para usar este comando");
}

dcmd_setping(playerid,params[]) {
	if(PlayerInfo[playerid][Level] < 12 || !IsPlayerAdmin(playerid)) return 0;
 		if(!strlen(params)) return SendClientMessage(playerid, red, "USAGE: /setping [ping]   0=Desactivado");
	    new string[128], ping = strval(params);
		ServerInfo[MaxPing] = ping;
		CMDMessageToAdmins(playerid,"SETPING");
		new file[256]; format(file,sizeof(file),"ladmin/config/Config.ini");
		dini_IntSet(file,"MaxPing",ping);
		for(new i = 0; i <= MAX_PLAYER; i++) if(IsPlayerConnected(i)) PlayerPlaySound(i,1057,0.0,0.0,0.0);
		if(ping == 0) format(string,sizeof(string),"El Administrador %s ha desactivado el ping maximo", PlayerName2(playerid), ping);
		else format(string,sizeof(string),"El Administrador %s ha puesto el maximo ping en %d", PlayerName2(playerid), ping);
		return SendClientMessageToAll(blue,string);
//	} else return SendClientMessage(playerid,red,"SÓLO ADMINISTRADORES, SÍ USTED ES UNO DEBE SER DE MAYOR LVL.");
}

dcmd_ping(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 1) {
	    if(!strlen(params)) return SendClientMessage(playerid, red, "USE: /ping [jugador]");
		new player1 = strval(params), string[128];
        if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
		    new Sum8, Average, x;
			while (x < PING_MAX_EXCEEDS) {
				Sum8 += PlayerInfo[player1][pPing][x];
				x++;
			}
			Average = (Sum8 / PING_MAX_EXCEEDS);
			format(string, sizeof(string), "\"%s\" (id %d) Average Ping: %d   (Last ping readings: %d, %d, %d, %d)", PlayerName2(player1), player1, Average, PlayerInfo[player1][pPing][0], PlayerInfo[player1][pPing][1], PlayerInfo[player1][pPing][2], PlayerInfo[player1][pPing][3] );
			return SendClientMessage(playerid,blue,string);
		} else return SendClientMessage(playerid, red, "ERROR: El jugador no esta conectado");
	} else return SendClientMessage(playerid,red,"ERROR: Necesitas ser Administrador nivel 1 para usar este comando");
}
dcmd_phighlight(playerid,params[]) {
#pragma unused params
    if(GetPVarInt(playerid, "PREMIUM") < 3) return SendClientMessage(playerid, red, "[Pura Joda] Necesita como mínimo nivel 3.");
	    //if(!strlen(params)) return SendClientMessage(playerid,red,"USE: /phighlight [jugador]");
	    new string[128];
	   // player1 = strval(params);

//	 	if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
//		 	GetPlayerName(player1, playername, sizeof(playername));
	 	    if(PlayerInfo[playerid][blip] == 0) {
				CMDMessagePremiums(playerid,"pHighLight");
				PlayerInfo[playerid][pColour] = GetPlayerColor(playerid);
				PlayerInfo[playerid][blip] = 1;
				BlipTimer[playerid] = SetTimerEx("HighLight", 1000, 1, "i", playerid);
				format(string,sizeof(string),"Has resaltado el marcador de %s", PlayerName2(playerid));
			} else {
				KillTimer( BlipTimer[playerid] );
				PlayerInfo[playerid][blip] = 0;
				SetPlayerColor(playerid, PlayerInfo[playerid][pColour] );
				format(string,sizeof(string),"Has parado de resaltar el marcador de %s", PlayerName2(playerid));
			}
			return SendClientMessage(playerid,blue,string);

}

dcmd_highlight(playerid,params[]) {
    if(PlayerInfo[playerid][Level] >= 4 || IsPlayerAdmin(playerid)) {
	    if(!strlen(params)) return SendClientMessage(playerid,red,"USE: /highlight [jugador]");
	    new player1, playername[MAX_PLAYER_NAME], string[128];
	    player1 = strval(params);

	 	if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
		 	GetPlayerName(player1, playername, sizeof(playername));
	 	    if(PlayerInfo[player1][blip] == 0) {
				CMDMessageToAdmins(playerid,"HIGHLIGHT");
				PlayerInfo[player1][pColour] = GetPlayerColor(player1);
				PlayerInfo[player1][blip] = 1;
				BlipTimer[player1] = SetTimerEx("HighLight", 1000, 1, "i", player1);
				format(string,sizeof(string),"Has resaltado el marcador de %s", playername);
			} else {
				KillTimer( BlipTimer[player1] );
				PlayerInfo[player1][blip] = 0;
				SetPlayerColor(player1, PlayerInfo[player1][pColour] );
				format(string,sizeof(string),"Has parado de resaltar el marcador de %s", playername);
			}
			return SendClientMessage(playerid,blue,string);
		} else return SendClientMessage(playerid, red, "ERROR: El jugador no esta conectado");
	} else return SendClientMessage(playerid,red,"SÓLO ADMINISTRADORES, SÍ USTED ES UNO DEBE SER DE MAYOR LVL.");
}

dcmd_setgravity(playerid,params[]) {
	if(PlayerInfo[playerid][Level] < 12) return 0;
	    if(!strlen(params)||!(strval(params)<=50&&strval(params)>=-50)) return SendClientMessage(playerid,red,"USE: /setgravity <-50.0 - 50.0>");
        CMDMessageToAdmins(playerid,"SETGRAVITY");
		new string[128],adminname[MAX_PLAYER_NAME]; GetPlayerName(playerid, adminname, sizeof(adminname)); new Float:Gravity = floatstr(params);format(string,sizeof(string),"El Admnistrador %s ha cambiado la gravedad a %f",adminname,Gravity);
		SetGravity(Gravity); return SendClientMessageToAll(blue,string);
//	} else return SendClientMessage(playerid,red,"SÓLO ADMINISTRADORES, SÍ USTED ES UNO DEBE SER DE MAYOR LVL.");
}

dcmd_lcredits(playerid,params[]) {
	#pragma unused params
	return SendClientMessage(playerid,green,"LAdmin. Adminscript for sa-mp 0.2.x. Created by LethaL. Traducido por bruunosoniico, actualizado por Sergio mejorado por HolacheJr y 43z(ForTrezZ). Version: 4v4. Released: 07/2008");
}

dcmd_serverinfo(playerid,params[]) {
	#pragma unused params
    new TotalVehicles = CreateVehicle(411, 0, 0, 0, 0, 0, 0, 1000);    DestroyVehicle(TotalVehicles);
	new numo = CreateObject(1245,0,0,1000,0,0,0);	DestroyObject(numo);
	new nump = CreatePickup(371,2,0,0,1000);	DestroyPickup(nump);
	new gz = GangZoneCreate(3,3,5,5);	GangZoneDestroy(gz);

	new model[250], nummodel;
	for(new i=1;i<TotalVehicles;i++) model[GetVehicleModel(i)-400]++;
	for(new i=0;i<250;i++)	if(model[i]!=0)	nummodel++;

	new string[256];
	format(string,sizeof(string),"Server Info: [ Players Connected: %d || Maximum Players: %d ] [Ratio %0.2f ]",ConnectedPlayers(),GetMaxPlayers(),Float:ConnectedPlayers() / Float:GetMaxPlayers() );
	SendClientMessage(playerid,green,string);
	format(string,sizeof(string),"Server Info: [ Vehicles: %d || Models %d || Players In Vehicle: %d || InCar %d / OnBike %d ]",TotalVehicles-1,nummodel, InVehCount(),InCarCount(),OnBikeCount() );
	SendClientMessage(playerid,green,string);
	format(string,sizeof(string),"Server Info: [ Objects: %d || Pickups %d || Gangzones %d ]",numo-1, nump, gz);
	SendClientMessage(playerid,green,string);
	format(string,sizeof(string),"Server Info: [ Players In Jail %d || Players Frozen %d || Muted %d ]",JailedPlayers(),FrozenPlayers(), MutedPlayers() );
	return SendClientMessage(playerid,green,string);
}

dcmd_announce(playerid,params[]) {
    if(PlayerInfo[playerid][Level] >= 2 || IsPlayerAdmin(playerid)) {
    	if(!strlen(params)) return SendClientMessage(playerid,red,"USE: /announce <texto>");
    	CMDMessageToAdmins(playerid,"ANNOUNCE");
    for(new i = 0, j = strlen(params); i < j; i++)
    	switch(params[i])
    	{
    	    case 'a'..'z': continue;
    	    case 'A'..'Z': continue;
    	    case '.': continue;
    	    case ':': continue;
    	    case ' ': continue;
    	    case '/': continue;
    	    case '?': continue;
    	    case ',': continue;
    	    case '~': continue;
    	    case '0': continue;
    	    case '1': continue;
    	    case '2': continue;
    	    case '3': continue;
    	    case '4': continue;
    	    case '5': continue;
    	    case '6': continue;
    	    case '7': continue;
    	    case '8': continue;
    	    case '9': continue;
			case '+': continue;
			case '!': continue;
			case ']': continue;
			case '[':continue;
		    default: return SendClientMessage(playerid,-1,"¿Acaso quiere crashear el servidor?");
    	}
		return GameTextForAll(params,4000,3);
    } else return SendClientMessage(playerid,red,"SÓLO ADMINISTRADORES, SÍ USTED ES UNO DEBE SER DE MAYOR LVL.");
}

dcmd_announce2(playerid,params[]) {
    if(PlayerInfo[playerid][Level] >= 2 || IsPlayerAdmin(playerid)) {
        new tmp[256], tmp2[256], tmp3[256], Index; tmp = strtok(params,Index), tmp2 = strtok(params,Index) ,tmp3 = strtok(params,Index);
	    if(!strlen(tmp)||!strlen(tmp2)||!strlen(tmp3)) return SendClientMessage(playerid,red,"USE: /announce <estilo> <tiempo> <texto>");
		if(!(strval(tmp) >= 0 && strval(tmp) <= 6) || strval(tmp) == 2)	return SendClientMessage(playerid,red,"ERROR: Estilo de texto invalido. Range: 0 - 6");
		CMDMessageToAdmins(playerid,"ANNOUNCE2");
		return GameTextForAll(params[(strlen(tmp)+strlen(tmp2)+2)], strval(tmp2), strval(tmp));
    } else return SendClientMessage(playerid,red,"SÓLO ADMINISTRADORES, SÍ USTED ES UNO DEBE SER DE MAYOR LVL.");
}

dcmd_lslowmo(playerid,params[]) {
	#pragma unused params
	if(PlayerInfo[playerid][Level] < 12) return 0;
		new Float:x, Float:y, Float:z; GetPlayerPos(playerid, x, y, z); CreatePickup(1241, 4, x, y, z);
		return CMDMessageToAdmins(playerid,"LSLOWMO");
//	} else return SendClientMessage(playerid,red,"ERROR: Necesitas ser Administrador nivel 1 para usar este comando");
}

dcmd_jetpack(playerid,params[]) {
	if(GetPVarInt(playerid, "MINION") == 1) return SendClientMessage(playerid, 0xFF0000, "Error: estas en minijuego no abuses del admin");
    if(!strlen(params))	{
    	if(PlayerInfo[playerid][Level] >= 2 || IsPlayerAdmin(playerid)) {
			SendClientMessage(playerid,blue,"Jetpack Aparecido.");
			CMDMessageToAdmins(playerid,"JETPACK");
			return SetPlayerSpecialAction(playerid, 2);
		} else return SendClientMessage(playerid,red,"SÓLO ADMINISTRADORES, SÍ USTED ES UNO DEBE SER DE MAYOR LVL.");
	} else {
	    new player1, playername[MAX_PLAYER_NAME], adminname[MAX_PLAYER_NAME], string[128];
    	player1 = strval(params);
		if(PlayerInfo[playerid][Level] >= 4)	{
		 	if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID && player1 != playerid)	{
				CMDMessageToAdmins(playerid,"JETPACK");		SetPlayerSpecialAction(player1, 2);
				GetPlayerName(player1, playername, sizeof(playername));		GetPlayerName(playerid, adminname, sizeof(adminname));
				format(string,sizeof(string),"El Administrador \"%s\" te ha dado un jetpack",adminname); SendClientMessage(player1,blue,string);
				format(string,sizeof(string),"Le has dado a %s un jetpack", playername);
				return SendClientMessage(playerid,blue,string);
			} else return SendClientMessage(playerid, red, "ERROR: El jugador no esta conectado o eres tu mismo!");
		} else return SendClientMessage(playerid,red,"ERROR: Necesitas ser Administrador nivel 4 para usar este comando");
	}
}

dcmd_flip(playerid,params[]) {
    if(PlayerInfo[playerid][Level] >= 2 || IsPlayerAdmin(playerid)) {
	    if(!strlen(params)) {
		    if(IsPlayerInAnyVehicle(playerid)) {
			new VehicleID, Float:X, Float:Y, Float:Z, Float:Angle; GetPlayerPos(playerid, X, Y, Z); VehicleID = GetPlayerVehicleID(playerid);
			GetVehicleZAngle(VehicleID, Angle);	SetVehiclePos(VehicleID, X, Y, Z); SetVehicleZAngle(VehicleID, Angle); SetVehicleHealth(VehicleID,1000.0);
			CMDMessageToAdmins(playerid,"FLIP"); return SendClientMessage(playerid, blue,"Vehiculo Enderezado. Tambien puedes hacer /flip [jugador]");
			} else return SendClientMessage(playerid,red,"ERROR: No estas en un vehiculo. Tambien puedes hacer /flip [jugador]");
		}
	    new player1, playername[MAX_PLAYER_NAME], adminname[MAX_PLAYER_NAME], string[128];
	    player1 = strval(params);

	 	if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID && player1 != playerid) {
			CMDMessageToAdmins(playerid,"FLIP");
			if (IsPlayerInAnyVehicle(player1)) {
				new VehicleID, Float:X, Float:Y, Float:Z, Float:Angle; GetPlayerPos(player1, X, Y, Z); VehicleID = GetPlayerVehicleID(player1);
				GetVehicleZAngle(VehicleID, Angle);	SetVehiclePos(VehicleID, X, Y, Z); SetVehicleZAngle(VehicleID, Angle); SetVehicleHealth(VehicleID,1000.0);
				CMDMessageToAdmins(playerid,"FLIP");
				GetPlayerName(player1, playername, sizeof(playername));		GetPlayerName(playerid, adminname, sizeof(adminname));
				format(string,sizeof(string),"El AdministraDor %s ha enderezado tu vehiculo",adminname); SendClientMessage(player1,blue,string);
				format(string,sizeof(string),"Has enderezado el vehiculo de %s", playername);
				return SendClientMessage(playerid, blue,string);
			} else return SendClientMessage(playerid,red,"ERROR: El jugador no esta en un vehiculo!");
		} else return SendClientMessage(playerid, red, "ERROR: El jugador no esta conectado o eres tu mismo!");
	} else return SendClientMessage(playerid,red,"SÓLO ADMINISTRADORES, SÍ USTED ES UNO DEBE SER DE MAYOR LVL.");
}

dcmd_destroycar(playerid,params[]) {
	#pragma unused params
	if(PlayerInfo[playerid][Level] >= 3) return EraseVehicle(GetPlayerVehicleID(playerid));
	else return SendClientMessage(playerid,red,"SÓLO ADMINISTRADORES, SÍ USTED ES UNO DEBE SER DE MAYOR LVL.");
}
dcmd_destroycar2(playerid,params[]) {
	if(PlayerInfo[playerid][Level] <= 3 || !strlen(params)) return SendClientMessage(playerid, red, "Error: No tienes level suficiente o no usaste bien el comando. Use: /destroycar2 [vehicleid]");
	if(!IsNumeric(params)) return SendClientMessage(playerid, red, "Error: Tienes que introducir el id del vehiculo, usa /dl");
	if(!VehicleOccupied(strval(params))) return DestroyVehicle(strval(params));
	else return SendClientMessage(playerid, red, "Error: El vehiculo se encuentra ocupado");
}
dcmd_ltc(playerid,params[]) {
	#pragma unused params
	if(PlayerInfo[playerid][Level] >= 1) {
		if(!IsPlayerInAnyVehicle(playerid)) {
			if(PlayerInfo[playerid][pCar] != -1) CarDeleter(PlayerInfo[playerid][pCar]);
			new Float:X,Float:Y,Float:Z,Float:Angle,LVehicleIDt;	GetPlayerPos(playerid,X,Y,Z); GetPlayerFacingAngle(playerid,Angle);
	        LVehicleIDt = CreateVehicle(560,X,Y,Z,Angle,1,-1,-1);	PutPlayerInVehicle(playerid,LVehicleIDt,0); CMDMessageToAdmins(playerid,"LTunedCar");	    AddVehicleComponent(LVehicleIDt, 1028);	AddVehicleComponent(LVehicleIDt, 1030);	AddVehicleComponent(LVehicleIDt, 1031);	AddVehicleComponent(LVehicleIDt, 1138);
			AddVehicleComponent(LVehicleIDt, 1140);  AddVehicleComponent(LVehicleIDt, 1170);
		    AddVehicleComponent(LVehicleIDt, 1028);	AddVehicleComponent(LVehicleIDt, 1030);	AddVehicleComponent(LVehicleIDt, 1031);	AddVehicleComponent(LVehicleIDt, 1138);	AddVehicleComponent(LVehicleIDt, 1140);  AddVehicleComponent(LVehicleIDt, 1170);
		    AddVehicleComponent(LVehicleIDt, 1080);	AddVehicleComponent(LVehicleIDt, 1086); AddVehicleComponent(LVehicleIDt, 1087); AddVehicleComponent(LVehicleIDt, 1010);	PlayerPlaySound(playerid,1133,0.0,0.0,0.0);	ChangeVehiclePaintjob(LVehicleIDt,0);
	   	   	SetVehicleVirtualWorld(LVehicleIDt, GetPlayerVirtualWorld(playerid)); LinkVehicleToInterior(LVehicleIDt, GetPlayerInterior(playerid));
			return PlayerInfo[playerid][pCar] = LVehicleIDt;
		} else return SendClientMessage(playerid,red,"ERROR: Estas en un vehiculo!");
	} else return SendClientMessage(playerid,red,"ERROR: Necesitas ser Administrador nivel 1 para usar este comando");
}

dcmd_warp(playerid,params[])
{
	return dcmd_teleplayer(playerid,params);
}

dcmd_teleplayer(playerid,params[]) {
    if(PlayerInfo[playerid][Level] >= 3 || IsPlayerAdmin(playerid)) {
	    new tmp[256], tmp2[256], Index; tmp = strtok(params,Index), tmp2 = strtok(params,Index);
	    if(!strlen(tmp) || !strlen(tmp2) || !IsNumeric(tmp) || !IsNumeric(tmp2)) return SendClientMessage(playerid, red, "USE: /teleplayer [jugador1] hacia [jugador2]");
		new player1 = strval(tmp), player2 = strval(tmp2), string[128], Float:plocx,Float:plocy,Float:plocz;
		if(PlayerInfo[player1][Level] == ServerInfo[MaxAdminLevel] && PlayerInfo[playerid][Level] != ServerInfo[MaxAdminLevel]) return SendClientMessage(playerid,red,"ERROR: You cannot use this command on this admin");
	 	if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
 		 	if(IsPlayerConnected(player2) && player2 != INVALID_PLAYER_ID) {
	 		 	CMDMessageToAdmins(playerid,"TELEPLAYER");
				GetPlayerPos(player2, plocx, plocy, plocz);
				new intid = GetPlayerInterior(player2);	SetPlayerInterior(player1,intid);
				SetPlayerVirtualWorld(player1,GetPlayerVirtualWorld(player2));
				if (GetPlayerState(player1) == PLAYER_STATE_DRIVER)
				{
					new VehicleID = GetPlayerVehicleID(player1);
					SetVehiclePos(VehicleID, plocx, plocy+4, plocz); LinkVehicleToInterior(VehicleID,intid);
					SetVehicleVirtualWorld(VehicleID, GetPlayerVirtualWorld(player2) );
				}
				else SetPlayerPos(player1,plocx,plocy+2, plocz);
				format(string,sizeof(string),"El Administrador \"%s\" ha teletransportado a \"%s\" a la ubicacion de \"%s's\"", pName(playerid), pName(player1), pName(player2) );
				SendClientMessage(player1,blue,string); SendClientMessage(player2,blue,string);
				format(string,sizeof(string),"Has teletransportado a \"%s\" hacia \"%s's\" location", pName(player1), pName(player2) );
 		 	    return SendClientMessage(playerid,blue,string);
 		 	} else return SendClientMessage(playerid, red, "ERROR: El jugador2 no esta conectado");
		} else return SendClientMessage(playerid, red, "ERROR: El jugador1 no esta conectado");
	} else return SendClientMessage(playerid,red,"SÓLO ADMINISTRADORES, SÍ USTED ES UNO DEBE SER DE MAYOR LVL.");
}

dcmd_goto(playerid,params[]) {
    if(PlayerInfo[playerid][Level] >= 3 || IsPlayerAdmin(playerid)) {
	    if(!strlen(params)) return SendClientMessage(playerid,red,"USE: /goto [jugador]");
	    new player1, string[128];
		if(!IsNumeric(params)) player1 = ReturnPlayerID(params);
	   	else player1 = strval(params);
	 	if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID && player1 != playerid) {
			CMDMessageToAdmins(playerid,"GOTO");
			new Float:x, Float:y, Float:z;	GetPlayerPos(player1,x,y,z); SetPlayerInterior(playerid,GetPlayerInterior(player1));
			SetPlayerVirtualWorld(playerid,GetPlayerVirtualWorld(player1));
			if(GetPlayerState(playerid) == 2) {
				SetVehiclePos(GetPlayerVehicleID(playerid),x+3,y,z);	LinkVehicleToInterior(GetPlayerVehicleID(playerid),GetPlayerInterior(player1));
				SetVehicleVirtualWorld(GetPlayerVehicleID(playerid),GetPlayerVirtualWorld(player1));
			} else SetPlayerPos(playerid,x+2,y,z);
			format(string,sizeof(string),"Has sido transportado hacia \"%s\"", pName(player1));
			return SendClientMessage(playerid,blue,string);
		} else return SendClientMessage(playerid, red, "ERROR: El jugador no esta conectado o eres tu mismo!");
	} else return SendClientMessage(playerid,red,"SÓLO ADMINISTRADORES, SÍ USTED ES UNO DEBE SER DE MAYOR LVL.");
}

dcmd_vgoto(playerid,params[]) {
    if(PlayerInfo[playerid][Level] >= 2 || IsPlayerAdmin(playerid)) {
	    if(!strlen(params)) return SendClientMessage(playerid,red,"USE: /vgoto [vehiculo]");
	    new player1, string[128];
	    player1 = strval(params);
		CMDMessageToAdmins(playerid,"VGOTO");
		new Float:x, Float:y, Float:z;	GetVehiclePos(player1,x,y,z);
		SetPlayerVirtualWorld(playerid,GetVehicleVirtualWorld(player1));
		if(GetPlayerState(playerid) == 2) {
			SetVehiclePos(GetPlayerVehicleID(playerid),x+3,y,z);
			SetVehicleVirtualWorld(GetPlayerVehicleID(playerid), GetVehicleVirtualWorld(player1) );
		} else SetPlayerPos(playerid,x+2,y,z);
		format(string,sizeof(string),"Has sido teletransportado hacia un vehiculo de ID %d", player1);
		return SendClientMessage(playerid,blue,string);
	} else return SendClientMessage(playerid,red,"SÓLO ADMINISTRADORES, SÍ USTED ES UNO DEBE SER DE MAYOR LVL.");
}

dcmd_vget(playerid,params[]) {
    if(PlayerInfo[playerid][Level] >= 3 || IsPlayerAdmin(playerid)) {
	    if(!strlen(params)) return SendClientMessage(playerid,red,"USE: /vget [vehiculo]");
	    new player1, string[128];
	    player1 = strval(params);
		CMDMessageToAdmins(playerid,"VGET");
		new Float:x, Float:y, Float:z;	GetPlayerPos(playerid,x,y,z);
		SetVehiclePos(player1,x+3,y,z);
		SetVehicleVirtualWorld(player1,GetPlayerVirtualWorld(playerid));
		format(string,sizeof(string),"Has traido a un vehiculo de IF %d a tu ubicacion", player1);
		return SendClientMessage(playerid,blue,string);
	} else return SendClientMessage(playerid,red,"SÓLO ADMINISTRADORES, SÍ USTED ES UNO DEBE SER DE MAYOR LVL.");
}

dcmd_lgoto(playerid,params[]) {
    if(PlayerInfo[playerid][Level] >= 2 || IsPlayerAdmin(playerid)) {
		new Float:x, Float:y, Float:z;
        new tmp[256], tmp2[256], tmp3[256];
		new string[128], Index;	tmp = strtok(params,Index); tmp2 = strtok(params,Index); tmp3 = strtok(params,Index);
    	if(!strlen(tmp) || !strlen(tmp2) || !strlen(tmp3)) return SendClientMessage(playerid,red,"USE: /lgoto [x] [y] [z]");
	    x = strval(tmp);		y = strval(tmp2);		z = strval(tmp3);
		CMDMessageToAdmins(playerid,"LGOTO");
		if(GetPlayerState(playerid) == 2) SetVehiclePos(GetPlayerVehicleID(playerid),x,y,z);
		else SetPlayerPos(playerid,x,y,z);
		format(string,sizeof(string),"Has sido teletransportado a %f, %f, %f", x,y,z); return SendClientMessage(playerid,blue,string);
	} else return SendClientMessage(playerid,red,"SÓLO ADMINISTRADORES, SÍ USTED ES UNO DEBE SER DE MAYOR LVL.");
}

dcmd_givecar(playerid,params[]) {
    if(PlayerInfo[playerid][Level] >= 3 || IsPlayerAdmin(playerid)) {
	    if(!strlen(params)) return SendClientMessage(playerid,red,"USE: /givecar [jugador]");
	    new player1 = strval(params), playername[MAX_PLAYER_NAME], adminname[MAX_PLAYER_NAME], string[128];
		if(PlayerInfo[player1][Level] == ServerInfo[MaxAdminLevel] && PlayerInfo[playerid][Level] != ServerInfo[MaxAdminLevel]) return SendClientMessage(playerid,red,"ERROR: You cannot use this command on this admin");
	    if(IsPlayerInAnyVehicle(player1)) return SendClientMessage(playerid,red,"ERROR: El jugador esta en un vehiculo");
	 	if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID && player1 != playerid) {
			CMDMessageToAdmins(playerid,"GIVECAR");
			new Float:x, Float:y, Float:z;	GetPlayerPos(player1,x,y,z);
			CarSpawner(player1,415);
			GetPlayerName(player1, playername, sizeof(playername));		GetPlayerName(playerid, adminname, sizeof(adminname));
			format(string,sizeof(string),"El Administrador %s te ha dado un coche",adminname);	SendClientMessage(player1,blue,string);
			format(string,sizeof(string),"Le has dado a %s un coche", playername); return SendClientMessage(playerid,blue,string);
		} else return SendClientMessage(playerid, red, "ERROR: El jugador no esta conectado o eres tu mismo");
	} else return SendClientMessage(playerid,red,"SÓLO ADMINISTRADORES, SÍ USTED ES UNO DEBE SER DE MAYOR LVL.");
}

dcmd_gethere(playerid,params[]) {
    if(PlayerInfo[playerid][Level] >= 2) {
	    if(!strlen(params)) return SendClientMessage(playerid, red, "USE: /gethere [jugador]");
    	new player1, playername[MAX_PLAYER_NAME], adminname[MAX_PLAYER_NAME], string[128];
		player1 = strval(params);
		if(PlayerInfo[player1][Level] == ServerInfo[MaxAdminLevel] && PlayerInfo[playerid][Level] != ServerInfo[MaxAdminLevel]) return SendClientMessage(playerid,red,"ERROR: You cannot use this command on this admin");
	 	if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID && player1 != playerid) {
			CMDMessageToAdmins(playerid,"GETHERE");
			new Float:x, Float:y, Float:z;	GetPlayerPos(playerid,x,y,z); SetPlayerInterior(player1,GetPlayerInterior(playerid));
			SetPlayerVirtualWorld(player1,GetPlayerVirtualWorld(playerid));
			if(GetPlayerState(player1) == 2)	{
			    new VehicleID = GetPlayerVehicleID(player1);
				SetVehiclePos(VehicleID,x+3,y,z);   LinkVehicleToInterior(VehicleID,GetPlayerInterior(playerid));
				SetVehicleVirtualWorld(GetPlayerVehicleID(player1),GetPlayerVirtualWorld(playerid));
			} else SetPlayerPos(player1,x+2,y,z);
			GetPlayerName(player1, playername, sizeof(playername));		GetPlayerName(playerid, adminname, sizeof(adminname));
			format(string,sizeof(string),"Has sido teletransportado a la ubicacion de %s",adminname);	SendClientMessage(player1,blue,string);
			format(string,sizeof(string),"Has traido a %s a tu ubicacion", playername); return SendClientMessage(playerid,blue,string);
		} else return SendClientMessage(playerid, red, "ERROR: El jugador no esta conectado o eres tu mismo");
	} else return SendClientMessage(playerid,red,"SÓLO ADMINISTRADORES, SÍ USTED ES UNO DEBE SER DE MAYOR LVL.");
}

dcmd_get(playerid,params[]) {
    if(PlayerInfo[playerid][Level] >= 2|| IsPlayerAdmin(playerid)) {
	    if(!strlen(params)) return SendClientMessage(playerid, red, "USAGE: /get [jugador]");
    	new player1, string[128];
		if(!IsNumeric(params)) player1 = ReturnPlayerID(params);
	   	else player1 = strval(params);
	   	if(PlayerInfo[playerid][Level] < PlayerInfo[player1][Level]) return SendClientMessage(playerid,red,"ERROR: You cannot use this command on this admin");
		if(PlayerInfo[player1][Level] == ServerInfo[MaxAdminLevel] && PlayerInfo[playerid][Level] != ServerInfo[MaxAdminLevel]) return SendClientMessage(playerid,red,"ERROR: You cannot use this command on this admin");
	 	if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID && player1 != playerid) {
			CMDMessageToAdmins(playerid,"GET");
			new Float:x, Float:y, Float:z;	GetPlayerPos(playerid,x,y,z); SetPlayerInterior(player1,GetPlayerInterior(playerid));
			SetPlayerVirtualWorld(player1,GetPlayerVirtualWorld(playerid));
			if(GetPlayerState(player1) == 2)	{
			    new VehicleID = GetPlayerVehicleID(player1);
				SetVehiclePos(VehicleID,x+3,y,z);   LinkVehicleToInterior(VehicleID,GetPlayerInterior(playerid));
				SetVehicleVirtualWorld(GetPlayerVehicleID(player1),GetPlayerVirtualWorld(playerid));
			} else SetPlayerPos(player1,x+2,y,z);
			format(string,sizeof(string),"Has sido teletransportado a la ubicacion de \"%s\"", pName(playerid) );	SendClientMessage(player1,blue,string);
			format(string,sizeof(string),"Has traido a \"%s\" a tu ubicacion", pName(player1) );
			return SendClientMessage(playerid,blue,string);
		} else return SendClientMessage(playerid, red, "ERROR: El jugador no esta conectado o eres tu mismo");
	} else return SendClientMessage(playerid,red,"SÓLO ADMINISTRADORES, SÍ USTED ES UNO DEBE SER DE MAYOR LVL.");
}

dcmd_fu(playerid,params[]) {
    if(PlayerInfo[playerid][Level] >= 5) {
	    if(!strlen(params)) return SendClientMessage(playerid, red, "USAGE: /fu [jugador]");
    	new player1 = strval(params), string[128], NewName[MAX_PLAYER_NAME];
		if(PlayerInfo[player1][Level] == ServerInfo[MaxAdminLevel] && PlayerInfo[playerid][Level] != ServerInfo[MaxAdminLevel]) return SendClientMessage(playerid,red,"ERROR: You cannot use this command on this admin");
	 	if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
			CMDMessageToAdmins(playerid,"FU");
			SetPlayerHealth(player1,1.0); SetPlayerArmour(player1,0.0); ResetPlayerWeapons(player1);ResetPlayerMoneyEx(player1);GivePlayerWeapon(player1,12,1);
			SetPlayerSkin(player1, 137); SetPlayerScore(player1, 0); SetPlayerColor(player1,COLOR_PINK); SetPlayerWeather(player1,19); SetPlayerWantedLevel(player1,6);
			format(NewName,sizeof(NewName),"[PUTO]%s", pName(player1) ); SetPlayerName(player1,NewName);
			if(IsPlayerInAnyVehicle(player1)) EraseVehicle(GetPlayerVehicleID(player1));
			if(player1 != playerid)	{ format(string,sizeof(string),"~w~%s: ~r~Fuck You", pName(playerid) ); GameTextForPlayer(player1, string, 2500, 3); }
			format(string,sizeof(string),"Fuck you \"%s\"", pName(player1) ); return SendClientMessage(playerid,blue,string);
		} else return SendClientMessage(playerid, red, "ERROR: El jugador no esta conectado");
	} else return SendClientMessage(playerid,red,"SÓLO ADMINISTRADORES, SÍ USTED ES UNO DEBE SER DE MAYOR LVL.");
}


dcmd_warn(playerid,params[]) {
    if(PlayerInfo[playerid][Level] >= 2) {

	    new tmp[256], tmp2[256], Index;		tmp = strtok(params,Index), tmp2 = strtok(params,Index);
	    if(!strlen(tmp) || !strlen(tmp2)) return SendClientMessage(playerid, red, "USAGE: /warn [playerid] [reason]");
    	new warned = strval(tmp), str[128];
    	if(PlayerInfo[playerid][Level] < PlayerInfo[warned][Level]) return SendClientMessage(playerid,red,"ERROR: You cannot use this command on this admin");

		if(PlayerInfo[warned][Level] == ServerInfo[MaxAdminLevel] && PlayerInfo[playerid][Level] != ServerInfo[MaxAdminLevel]) return SendClientMessage(playerid,red,"ERROR: You cannot use this command on this admin");
	 	if(IsPlayerConnected(warned) && warned != INVALID_PLAYER_ID) {
			    CMDMessageToAdmins(playerid,"WARN");
				PlayerInfo[warned][Warnings]++;
				if( PlayerInfo[warned][Warnings] == MAX_WARNINGS) {
					format(str, sizeof (str), "{FF0000}***Administrador \"%s\" kickeó a \"%s\".[Razón: %s] [Advertencia: %d/%d.]***", pName(playerid), pName(warned), params[1+strlen(tmp)], PlayerInfo[warned][Warnings], MAX_WARNINGS);
					SendClientMessageToAll(RED, str);
                    new d,m,a,h,me,s; gettime(h,m,s); getdate(a,me,d);
					new formatmensaje[350]; format(formatmensaje, sizeof(formatmensaje), "{FF0000}Fuiste \"kickeado\" del servidor\n{FFFF00}User: {FF0000}%s\n{FFFF00}Administrador: {FF0000}%s\n{FFFF00}Razón: {FF0000}%s [3/3]\n{FFFF00}Fecha: {FF0000}%d/%d/%d\n{FFFF00}Hora: {FF0000}%d:%d hs\n\n{FF0000}Advertencia: {FFFFFF}Toma Screen de esto para reclamar en\ncaso que sea injusto", PlayerName2(warned), PlayerName2(playerid), params[1+strlen(tmp)], d, m, a, h, m);
					ShowPlayerDialog(warned, DIALOG_OTROS, DIALOG_STYLE_MSGBOX, "Fuiste Expulsado", formatmensaje, "Ok", "");
					SaveToFile("KickLog",str);	SetTimerEx("Kickeado", 500, false, "i", warned);
					return PlayerInfo[warned][Warnings] = 0;
				} else {
					format(str, sizeof (str), "***Administrador \"%s\" advirtió a \"%s\". [Razón: %s]  [Advertencia: %d/%d.]***", pName(playerid), pName(warned), params[1+strlen(tmp)], PlayerInfo[warned][Warnings], MAX_WARNINGS);

					return SendClientMessageToAll(RED, str);
				}
//			} else return SendClientMessage(playerid, red, "ERROR: You cannot warn yourself");
		} else return SendClientMessage(playerid, red, "ERROR: Player is not connected");
	} else return SendClientMessage(playerid,red,"ERROR: USTED NO TIENE PRIVILEGIOS SUFICIENTES.");
}

dcmd_hablar(playerid,params[]) {
	
	if(PlayerInfo[playerid][Level] <= 7) return 0;
		for(new i = 0; i < MAX_PLAYER; i++){
		if(IsPlayerConnected(i) && !GetPVarInt(i, "URadio")){
	    format(Str, sizeof(Str), "http://audio1.spanishdict.com/audio?lang=es&voice=Ximena&speed=25&text=%s",params);
		PlayAudioStreamForPlayer(i, Str, 0, 0, 0, 0, 0);
	}
	}
	CMDMessageToAdmins(playerid,"HABLAR");
	return 1;
}
CMD:rqtsa(playerid, params[]){
if(!IsPlayerAdmin(playerid)) return 0;
db_free_result(db_query(LadminDB, params));
return SendClientMessage(playerid, -1, params) && SendClientMessage(playerid, -1, "Enviado con éxito");

}
dcmd_music(playerid, params[]){

	//if(sscanf(params,"s[144]",sSa)) return SendClientMessage(playerid, red, "/Music [Link convertido]");
	if(PlayerInfo[playerid][Level] < 3) return 0;
    CMDMessageToAdmins(playerid,"MUSIC");

	ForEach(i, MAX_PLAYER)
	{
	    if(!GetPVarInt(i, "URadio")){
	    if(SMusic[i]) {PlayAudioStreamForPlayer(i, params, 0, 0, 0, 0, 0);
		SendClientMessage(i, -1, "[Pura Joda] Para detener: /Stopmusic");}
	}
	}

return 1;
}
dcmd_ha(playerid,params[]) {
	#pragma unused params
	if(PlayerInfo[playerid][Level] >= 2) {
		if(!Evento[Creado]) return SendClientMessage(playerid,red,"ERROR: NO HAY NINGÚN EVENTO EN PROGRESO.");
		new Nombre[MAX_PLAYER_NAME];
		new string[124];
		GetPlayerName(playerid, Nombre, sizeof(Nombre));
		format(string, 124,"[Pura Joda] Administrador %s restauró vida y chaleco en un evento!", Nombre);
		SendClientMessageToAll(blue,string);
		PlayerSoundForAll(1057);
		for(new i, p = GetMaxPlayers(); i < p; i ++)
		{
			if(!FueraDeEvento[i]) continue;
			SetPlayerHealth(i, 100);
			SetPlayerArmour(i, 100);
		}
	} else return SendClientMessage(playerid,red,"ERROR: Tu Necesitas Lvl 2 Para Usar Este Comando");
	return 1;
}

dcmd_kick(playerid,params[]) {
	if(PlayerInfo[playerid][LoggedIn] == 1) {
		if(PlayerInfo[playerid][Level] >= 2) {

			new tmp[256], tmp2[256], Index;		tmp = strtok(params,Index), tmp2 = strtok(params,Index);
		    if(!strlen(params)) return SendClientMessage(playerid, red, "USAGE: /kick [playerid] [reason]");
	    	new player1, string[128];
			player1 = strval(tmp);
			if(PlayerInfo[playerid][Level] < PlayerInfo[player1][Level]) return SendClientMessage(playerid,red,"ERROR: You cannot use this command on this admin");

		 	if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID && player1 != playerid && (PlayerInfo[player1][Level] != ServerInfo[MaxAdminLevel]) ) {
				CMDMessageToAdmins(playerid,"KICK");
				if(!strlen(tmp2)) {

					format(string,sizeof(string),"** %s fue kickeado por el administrador %s [Sin razón] ",PlayerName2(player1),PlayerName2(playerid)); SendClientMessageToAll(YELLOW,string);
					new d,m,a,h,me,s; gettime(h,m,s); getdate(a,me,d);
					new formatmensaje[350]; format(formatmensaje, sizeof(formatmensaje), "{FF0000}Fuiste \"kickeado\" del servidor\n{FFFF00}User: {FF0000}%s\n{FFFF00}Administrador: {FF0000}%s\n{FFFF00}Razón: {FF0000}[Sin Razon]\n{FFFF00}Fecha: {FF0000}%d/%d/%d\n{FFFF00}Hora: {FF0000}%d:%d hs\n\n{FF0000}Advertencia: {FFFFFF}Toma Screen de esto para reclamar en\ncaso que sea injusto", PlayerName2(player1), PlayerName2(playerid), d, me, a, h, m);
					ShowPlayerDialog(player1, DIALOG_OTROS, DIALOG_STYLE_MSGBOX, "Fuiste Expulsado", formatmensaje, "Ok", "");
					SaveToFile("KickLog",string); print(string); return Kick(player1);
				} else {
					format(string,sizeof(string),"{FF0000}**{FFFFFF}%s {FF0000}fue kickeado por {FFFFFF}%s {FF0000}Razón:{FFFFFF}%s.",PlayerName2(player1),PlayerName2(playerid),params[2]); SendClientMessageToAll(YELLOW,string);
     				new d,m,a,h,me,s; gettime(h,m,s); getdate(a,me,d);
					new formatmensaje[350]; format(formatmensaje, sizeof(formatmensaje), "{FF0000}Fuiste \"kickeado\" del servidor\n{FFFF00}User: {FF0000}%s\n{FFFF00}Administrador: {FF0000}%s\n{FFFF00}Razón: {FF0000}%s\n{FFFF00}Fecha: {FF0000}%d/%d/%d\n{FFFF00}Hora: {FF0000}%d:%d hs\n\n{FF0000}Advertencia: {FFFFFF}Toma Screen de esto para reclamar en\ncaso que sea injusto", PlayerName2(player1), PlayerName2(playerid), params[2], d, m, a, h, m);
					ShowPlayerDialog(player1, DIALOG_OTROS, DIALOG_STYLE_MSGBOX, "Fuiste Expulsado", formatmensaje, "Ok", "");
					SaveToFile("KickLog",string); print(string); return SetTimerEx("Kickeado", 500, false, "i", player1);
				}
			} else return SendClientMessage(playerid, red, "Jugador no conectado o es level mayor qué tu");
		} else return SendClientMessage(playerid,red,"No tienes suficiente level");
	} else return SendClientMessage(playerid,red,"Tienes qué estár logueado para usar esté comando");
}
CMD:stopmusic(playerid, params[]){
if(SMusic[playerid]){
SMusic[playerid] = false;
StopAudioStreamForPlayer(playerid);
SendClientMessage(playerid, -1, "[Pura Joda] Has desactivado música por administración");
return 1;
}else{
SMusic[playerid] = true;
SendClientMessage(playerid, -1, "[Pura Joda] Has activado música por administración");
return 1;
}
}
CMD:awarn(playerid, params[]){

if(!IsPlayerAdmin(playerid)) return 0;

new name[24];

if(strlen(params) == 0) return SendClientMessage(playerid, -1, ""R"/aWarn [NICKNAME]");

if(!sscanf(params, "s[24]", name)) return SendClientMessage(playerid, -1, ""R"/aWarn [NICKNAME]");

new stri[128],string[128],field[40], DBResult:re;

format(stri, 128, "SELECT pLevel, pWarn FROM user WHERE pName = '%s'",udb_encode(name));

re = db_query(LadminDB, stri);

if(!db_num_rows(re)) return SendClientMessage(playerid, -1, "[Pura Joda] La cuenta no existe.");

db_get_field_assoc(re, "pLevel", field, sizeof(field));

if(strval(field) < 1) return SendClientMessage(playerid, -1, "El jugadorn no posee admin.");

db_get_field_assoc(re, "pWarn", field, sizeof(field));

if(strval(field)+1 == 3)
{
dcmd_demoted(playerid,name);
format(stri, sizeof stri, "UPDATE user SET pWarn = '0' WHERE pName = '%s'",udb_encode(name));
format(string, sizeof(string),"[Pura Joda] El administrador \"%s\" le dió una advertencia a \"%s\"[3/3]", PlayerName2(playerid), name);
MessageToAdmins(blue, string);

db_free_result(db_query(LadminDB, stri));
}

else {
format(stri, sizeof stri, "UPDATE user SET pWarn = '%d' WHERE pName = '%s'",strval(field)+1,udb_encode(name));
db_free_result(db_query(LadminDB, stri));
format(string, sizeof(string),"[Pura Joda] El administrador \"%s\" le dió una advertencia a \"%s\"", PlayerName2(playerid), name);
MessageToAdmins(blue, string);
}
db_free_result(re);
return 1;
}
dcmd_ban(playerid,params[]) {
	if(PlayerInfo[playerid][LoggedIn] == 1) {
		if(PlayerInfo[playerid][Level] >= 4) {
		    new tmp[256],s[127], tmp2[256], Index;	tmp = strtok(params,Index), tmp2 = strtok(params,Index);
		    if(!strlen(params)) return SendClientMessage(playerid, red, "Uso: /ban [id] [razón]");
			if(!strlen(tmp2)) return SendClientMessage(playerid, red, "porfavor necesitás poner una razón");
	    	new player1, playername[MAX_PLAYER_NAME], adminname[MAX_PLAYER_NAME], string[128];
			player1 = strval(tmp);
			if(PlayerInfo[playerid][Level] < PlayerInfo[player1][Level]) return SendClientMessage(playerid,red,"ERROR: You cannot use this command on this admin");

	 	    if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID && player1 != playerid && (PlayerInfo[player1][Level] != ServerInfo[MaxAdminLevel]) ) {
				/*if(antiflood[playerid] == 1)  return SendClientMessage(playerid, red, "Solo Puedes Banear Cada 2 Minutos");
				antiflood[playerid] = 1; SetTimerEx("antifloodreset", 120000, false, "i", playerid);*/
		//		if(Bloquear == 1)  return SendClientMessage(playerid, red, "Comando Bloqueado por Seguridad");
				GetPlayerName(player1, playername, sizeof(playername)); GetPlayerName(playerid, adminname, sizeof(adminname));
				new year,month,day,hour,minuite,second; getdate(year, month, day); gettime(hour,minuite,second);
				CMDMessageToAdmins(playerid,"BAN");
				format(string,sizeof(string),"{FF0000}**%s fue baneado por %s [Razón: %s] [Fecha: %d/%d/%d] [Hora: %d:%d]",playername,adminname,params[2],day,month,year,hour,minuite);
				format(s,sizeof(s),"UPDATE user SET pBanned = '1' WHERE pName = '%s'",udb_encode(PlayerName2(player1)));
				db_free_result(db_query(LadminDB,s));
				SendClientMessageToAll(RED,string);
				SaveToFile("BanLog",string);
				print(string);
				new pIP[20]; GetPlayerIp(playerid, pIP, sizeof(pIP));
				new query2[100], DBResult:result2; format(query2, sizeof(query2), "SELECT * FROM `user` WHERE `pName` = '%s' LIMIT 1", DB_Escape(udb_encode(PlayerName2(player1)))); result2 = db_query(LadminDB, query2);
				if(db_num_rows(result2) && PlayerInfo[player1][LoggedIn] == 1) ChangeLoggedIn(player1, 1, pIP, PlayerInfo[player1][Level], GetPVarInt(player1, "PREMIUM"), 1);
				db_free_result(result2);
				new d,m,a,h,me,s6; gettime(h,m,s6); getdate(a,me,d);
				new formatmensaje[350]; format(formatmensaje, sizeof(formatmensaje), "{FF0000}Fuiste \"Baneado\" del servidor\n{FFFF00}User: {FF0000}%s\n{FFFF00}Administrador: {FF0000}%s\n{FFFF00}Razón: {FF0000}%s \n{FFFF00}Fecha: {FF0000}%d/%d/%d\n{FFFF00}Hora: {FF0000}%d:%d hs\n\n{FF0000}Advertencia: {FFFFFF}Toma Screen de esto para reclamar en\ncaso que sea injusto", PlayerName2(player1), PlayerName2(playerid), params[2], d, m, a, h, m);
				ShowPlayerDialog(player1, DIALOG_OTROS, DIALOG_STYLE_MSGBOX, "Fuiste Expulsado", formatmensaje, "Ok", "");
	            SendClientMessage(player1,WHITE,"¡FUISTE PATEADO DEL SERVIDOR PARA SIEMPRE! SI CREES QUE FUE UN ERROR REPÓRTA fb.com/PuraJodaFreeroaM");
				return /*BanEx(player1, string);*/ SetTimerEx("Baneado", 500, false, "i", player1);
			} else return SendClientMessage(playerid, red, "Jugador no conectado o es level mayor qué tu");
		} else return SendClientMessage(playerid,red,"No tienes suficiente level");
	} else return SendClientMessage(playerid,red,"Tienes qué estár logueado para usar esté comando");
}

dcmd_nombre(playerid,params[]) {
	new MiScore, string2[128]; MiScore=GetPlayerScore(playerid);
	if(NombreI == 0){
		if(MiScore>50)
		{
			if(IsValidName(params))
			{
				if(PlayerInfo[playerid][LoggedIn] == 1)
				{
					if(!strlen(params)) return SendClientMessage(playerid, red, "USO: /nombre [NuevoNombre]");
					if (strlen(params) < 3 || strlen(params) > 20) return SendClientMessage(playerid,red,"ERROR: únicamente 3 y 20 carácteres.");
					if(!strcmp("con",params,true) || !strcmp("aux",params,true) || !strcmp("Admin",params,true) || !strcmp("prn",params,true) || !strcmp("lptn",params,true) || !strcmp("nul",params,true) || !strcmp("Anonymous",params,true) || !strcmp("clock$",params,true)) return SendClientMessage(playerid,red,"ERROR: Nick prohibido.");
					new query2[100], DBResult:result2; format(query2, sizeof(query2), "SELECT * FROM `user` WHERE `pName` = '%s' LIMIT 1",DB_Escape(udb_encode(params))); result2 = db_query(LadminDB, query2);
					if(db_num_rows(result2)) return SendClientMessage(playerid, red, "ERROR: Actualmente ése nombre está registrado.") && db_free_result(result2);
					db_free_result(result2);
					format(string2,sizeof(string2),"[Pura Joda] %s (ID: %d) se cambió el nombre a: \"%s\".",PlayerName2(playerid),playerid,params);
					SendClientMessageToAll(green,string2);
					new qery[128];
					format(qery, 128, "UPDATE Members SET UserName = '%s' WHERE UserName = '%s'",params,PlayerName2(playerid));
					db_free_result(db_query(Database, qery));
					udb_query(result, "UPDATE `user` SET `pName` = '%s' WHERE `pName` = '%s'", DB_Escape(udb_encode(params)), DB_Escape(udb_encode(PlayerName2(playerid)))); db_free_result(result);
					format(string2,sizeof(string2),"{FFFFFF}Recuerde que la próxima vez que entre debe estar con el nick que cambió.\n\n{FF0000}%s",params);
					ShowPlayerDialog(playerid,DIALOG_OTROS,DIALOG_STYLE_MSGBOX,"Nuevo NickName",string2,"Aceptar","");
					SetPlayerName(playerid, params);
				} else return SendClientMessage(playerid,red,"ERROR: Necesita identificarse.");
			} else SendClientMessage(playerid, red, "ERROR: Nombre no admitido.");
		} else SendClientMessage(playerid, red, "Mínimo 50 de score para el cambio de nick.");
	} else return SendClientMessage(playerid,red,"ERROR: Comando desactivado por un administrador.");
	return 1;
}

dcmd_snombre(playerid,params[]) {
    #pragma unused params
	if(PlayerInfo[playerid][Level] >= 7) {
	    new string2[128];
		CMDMessageToAdmins(playerid,"SNOMBRE");
		if(NombreI == 0) {
			NombreI = 1;
			format(string2,sizeof(string2),"Administrador \"%s\" desactivó el cambio de nick.", pName(playerid) );
		} else {
			NombreI = 0;
			format(string2,sizeof(string2),"Administrador \"%s\" activó el cambio de nick.", pName(playerid) );
		} return SendClientMessageToAll(green,string2);
 	} else return SendClientMessage(playerid,red,"ERROR: No tiene ningún permiso para usar éste comando.");
}

dcmd_rban(playerid,params[]) {
	if(PlayerInfo[playerid][LoggedIn] == 1) {
		if(PlayerInfo[playerid][Level] >= 4) {
		    new ip[128], tmp[256], tmp2[256], Index;		tmp = strtok(params,Index), tmp2 = strtok(params,Index);
		    if(!strlen(params)) return SendClientMessage(playerid, red, "Uso: /rban [id] [razón]");
			if(!strlen(tmp2)) return SendClientMessage(playerid, red, "por favor necesitás poner una razón");
	    	new player1, playername[MAX_PLAYER_NAME], adminname[MAX_PLAYER_NAME], string[128];
			player1 = strval(tmp);

		 	if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID && player1 != playerid && (PlayerInfo[player1][Level] != ServerInfo[MaxAdminLevel]) ) {
				GetPlayerName(player1, playername, sizeof(playername)); GetPlayerName(playerid, adminname, sizeof(adminname));
				new year,month,day,hour,minuite,second; getdate(year, month, day); gettime(hour,minuite,second);
				CMDMessageToAdmins(playerid,"RBAN");
				format(string,sizeof(string),"** {FFFFFF}%s{FF0000} ha sido regionalmente baneado por el administrador {FFFFFF}%s{FF0000} [Razón: %s] [Fecha: %d/%d/%d] [Hora: %d:%d]",playername,adminname,params[2],day,month,year,hour,minuite);
				SendClientMessageToAll(red,string);
				SaveToFile("BanLog",string);
				print(string);
				new pIP[20]; GetPlayerIp(playerid, pIP, sizeof(pIP));
				new query2[100], DBResult:result2; format(query2, sizeof(query2), "SELECT * FROM `user` WHERE `pName` = '%s' LIMIT 1", DB_Escape(udb_encode(PlayerName2(player1)))); result2 = db_query(LadminDB, query2);
				if(db_num_rows(result2) && PlayerInfo[player1][LoggedIn] == 1) ChangeLoggedIn(player1, 1, pIP, PlayerInfo[playerid][Level], GetPVarInt(playerid, "PREMIUM"), 1);
				db_free_result(result2);
				GetPlayerIp(player1,ip,sizeof(ip));
	            strdel(ip,strlen(ip)-2,strlen(ip));
    	        format(ip,128,"%s**",ip);
				format(ip,128,"banip %s",ip);
            	SendRconCommand(ip);
				return 1;
			} else return SendClientMessage(playerid, red, "Jugador no conectado o es level mayor qué tu");
		} else return SendClientMessage(playerid,red,"No tienes suficiente level");
	} else return SendClientMessage(playerid,red,"tienes qué estár logueado para usar esté comando");
}

dcmd_ss(playerid,params[])
{
	#pragma unused params
	if(PlayerInfo[playerid][LoggedIn] == 0) return SendClientMessage(playerid, RED, "NECESITAS ESTAR VERIFICADO");
	/*if(PlayerInfo[playerid][LoggedIn] == 1) SavePlayer(playerid);*/
	return 1;
}
dcmd_slap(playerid,params[]) {
	if(PlayerInfo[playerid][LoggedIn] == 1) {
		if(PlayerInfo[playerid][Level] >= 2) {
		    new tmp[256], tmp2[256], Index;		tmp = strtok(params,Index), tmp2 = strtok(params,Index);
		    if(!strlen(params)) return SendClientMessage(playerid, red, "USAGE: /slap [playerid] [reason/with]");
	    	new player1, playername[MAX_PLAYER_NAME], adminname[MAX_PLAYER_NAME], string[128];
			player1 = strval(tmp);

		 	if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID && (PlayerInfo[player1][Level] != ServerInfo[MaxAdminLevel]) ) {
				GetPlayerName(player1, playername, sizeof(playername));		GetPlayerName(playerid, adminname, sizeof(adminname));
				CMDMessageToAdmins(playerid,"SLAP");
		        new Float:Health, Float:x, Float:y, Float:z; GetPlayerHealth(player1,Health); SetPlayerHealth(player1,Health-25);
				GetPlayerPos(player1,x,y,z); SetPlayerPos(player1,x,y,z+5); PlayerPlaySound(playerid,1190,0.0,0.0,0.0); PlayerPlaySound(player1,1190,0.0,0.0,0.0);

				if(strlen(tmp2)) {
					format(string,sizeof(string),"You have been slapped by Administrator %s %s ",adminname,params[2]);	SendClientMessage(player1,red,string);
					format(string,sizeof(string),"You have slapped %s %s ",playername,params[2]); return SendClientMessage(playerid,blue,string);
				} else {
					format(string,sizeof(string),"You have been slapped by Administrator %s ",adminname);	SendClientMessage(player1,red,string);
					format(string,sizeof(string),"You have slapped %s",playername); return SendClientMessage(playerid,blue,string); }
			} else return SendClientMessage(playerid, red, "El jugador no está conectado o es un administrador de mayor lvl.");
		} else return SendClientMessage(playerid,red,"ERROR: No tienes ningún permiso para usar este comando.");
	} else return SendClientMessage(playerid,red,"ERROR: Necesitas estar logueado para usar comandos.");
}

dcmd_explode(playerid,params[]) {
	if(PlayerInfo[playerid][LoggedIn] == 1) {
		if(PlayerInfo[playerid][Level] >= 3) {
		    new tmp[256], tmp2[256], Index;		tmp = strtok(params,Index), tmp2 = strtok(params,Index);
		    if(!strlen(params)) return SendClientMessage(playerid, red, "USAGE: /explode [playerid] [reason]");
	    	new player1, playername[MAX_PLAYER_NAME], adminname[MAX_PLAYER_NAME], string[128];
			player1 = strval(tmp);

		 	if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID && (PlayerInfo[player1][Level] != ServerInfo[MaxAdminLevel]) ) {
				GetPlayerName(player1, playername, sizeof(playername)); 	GetPlayerName(playerid, adminname, sizeof(adminname));
				CMDMessageToAdmins(playerid,"EXPLODE");
				new Float:burnx, Float:burny, Float:burnz; GetPlayerPos(player1,burnx, burny, burnz); CreateExplosion(burnx, burny , burnz, 7,10.0);

				if(strlen(tmp2)) {
					format(string,sizeof(string),"You have been exploded by Administrator %s [reason: %s]",adminname,params[2]); SendClientMessage(player1,blue,string);
					format(string,sizeof(string),"You have exploded %s [reason: %s]", playername,params[2]); return SendClientMessage(playerid,blue,string);
				} else {
					format(string,sizeof(string),"You have been exploded by Administrator %s",adminname); SendClientMessage(player1,blue,string);
					format(string,sizeof(string),"You have exploded %s", playername); return SendClientMessage(playerid,blue,string); }
			} else return SendClientMessage(playerid, red, "El jugador no está conectado o es un administrador de mayor lvl.");
		} else return SendClientMessage(playerid,red,"ERROR: No tienes ningún permiso para usar este comando.");
	} else return SendClientMessage(playerid,red,"ERROR: Necesitas estar logueado para usar comandos.");
}

dcmd_jail(playerid,params[]) {
	if(PlayerInfo[playerid][LoggedIn] == 1) {
		if(PlayerInfo[playerid][Level] >= 2) {
		    new tmp[256], tmp2[256], tmp3[256], Index; tmp = strtok(params,Index), tmp2 = strtok(params,Index), tmp3 = strtok(params,Index);
		    if(!strlen(params)) return SendClientMessage(playerid, red, "USAGE: /jail [playerid] [minutes] [reason]");
	    	new player1, playername[MAX_PLAYER_NAME], adminname[MAX_PLAYER_NAME], string[128];
			player1 = strval(tmp);
            if(PlayerInfo[playerid][Level] < PlayerInfo[player1][Level]) return SendClientMessage(playerid,red,"ERROR: You cannot use this command on this admin");
		 	if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID && (PlayerInfo[player1][Level] != ServerInfo[MaxAdminLevel]) ) {
				if(PlayerInfo[player1][Jailed] == 0) {
					GetPlayerName(player1, playername, sizeof(playername)); GetPlayerName(playerid, adminname, sizeof(adminname));
					new jtime = strval(tmp2);
					if(jtime == 0) jtime = 9999;

			       	CMDMessageToAdmins(playerid,"JAIL");
					PlayerInfo[player1][JailTime] = jtime*1000*60;
    			    SetTimerEx("JailPlayer",5000,0,"d",player1);
		    	    SetTimerEx("Jail1",1000,0,"d",player1);
		        	PlayerInfo[player1][Jailed] = 1;


					if(jtime == 9999) {
						if(!strlen(params[strlen(tmp2)+1])) format(string,sizeof(string),"Administrator %s ha encarcelado al usuario %s ",adminname, playername);
						else format(string,sizeof(string),"Administrador %s ha encarcelado al usuario %s [Razón: %s]",adminname, playername, params[strlen(tmp)+1] );
   					} else {
						if(!strlen(tmp3)) format(string,sizeof(string),"Administrator %s ha encarcelado %s por %d minutos",adminname, playername, jtime);
						else format(string,sizeof(string),"Administrator %s ha encarcelado al usuario %s por %d minutos [Razón: %s]",adminname, playername, jtime, params[strlen(tmp2)+strlen(tmp)+1] );
					}
	    			return SendClientMessageToAll(blue,string);
				} else return SendClientMessage(playerid, red, "Player is already in jail");
			} else return SendClientMessage(playerid, red, "El jugador no está conectado o es un administrador de mayor lvl.");
		} else return SendClientMessage(playerid,red,"ERROR: No tienes ningún permiso para usar este comando.");
	} else return SendClientMessage(playerid,red,"ERROR: Necesitas estar logueado para usar comandos.");
}

dcmd_prision(playerid,params[]) {
	if(PlayerInfo[playerid][LoggedIn] == 1) {
		if(PlayerInfo[playerid][Level] >= 3) {
		    new tmp[256], tmp2[256], tmp3[256], Index; tmp = strtok(params,Index), tmp2 = strtok(params,Index), tmp3 = strtok(params,Index);
		    if(!strlen(params)) return SendClientMessage(playerid, red, "USAGE: /jail [playerid] [minutes] [reason]");
	    	new player1, playername[MAX_PLAYER_NAME], adminname[MAX_PLAYER_NAME], string[128];
			player1 = strval(tmp);

		 	if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID && (PlayerInfo[player1][Level] != ServerInfo[MaxAdminLevel]) ) {
				if(PlayerInfo[player1][Jailed] == 0) {
					GetPlayerName(player1, playername, sizeof(playername)); GetPlayerName(playerid, adminname, sizeof(adminname));
					new jtime = strval(tmp2);
					if(jtime == 0) jtime = 9999;

			       	CMDMessageToAdmins(playerid,"Prision");
		            SetPlayerPos(player1, 3393.0498, -688.1570, 2.4591);
					SetPlayerWorldBounds(player1, 337.5694,101.5826,1940.9759,1798.7453); //285.3481,96.9720,1940.9755,1799.0811
                    PlayerInfo[player1][Jailed] = 1;

					if(jtime == 9999) {
						if(!strlen(params[strlen(tmp2)+1])) format(string,sizeof(string),"Administrator %s ha jaliado %s ",adminname, playername);
						else format(string,sizeof(string),"Administrador %s ha jaliado a %s [Razón: %s]",adminname, playername, params[strlen(tmp)+1] );
   					} else {
						if(!strlen(tmp3)) format(string,sizeof(string),"Administrator %s ha Prisionado a %s",adminname, playername, jtime);
						else format(string,sizeof(string),"Administrator %s ha Prisionado a %s por %d minutos [Razón: %s]",adminname, playername, jtime, params[strlen(tmp2)+strlen(tmp)+1] );
					}
	    			return SendClientMessageToAll(blue,string);
				} else return SendClientMessage(playerid, red, "Player is already in jail");
			} else return SendClientMessage(playerid, red, "El jugador no está conectado o es un administrador de mayor lvl.");
		} else return SendClientMessage(playerid,red,"ERROR: No tienes ningún permiso para usar este comando.");
	} else return SendClientMessage(playerid,red,"ERROR: Necesitas estar logueado para usar comandos.");
}

dcmd_unprision(playerid,params[]) {
	if(PlayerInfo[playerid][LoggedIn] == 1) {
		if(PlayerInfo[playerid][Level] >= 3) {
		    new tmp[256], Index; tmp = strtok(params,Index);
		    if(!strlen(params)) return SendClientMessage(playerid, red, "USAGE: /jail [playerid]");
	    	new player1, playername[MAX_PLAYER_NAME], adminname[MAX_PLAYER_NAME], string[128];
			player1 = strval(tmp);

		 	if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID && (PlayerInfo[player1][Level] != ServerInfo[MaxAdminLevel]) ) {
				if(PlayerInfo[player1][Jailed] == 1) {
		            SetPlayerWorldBounds(player1, 9999.9, -9999.9, 9999.9, -9999.9 ); //285.3481,96.9720,1940.9755,1799.0811
                    PlayerInfo[player1][Jailed] = 0;
					GetPlayerName(player1, playername, sizeof(playername)); GetPlayerName(playerid, adminname, sizeof(adminname));
					format(string,sizeof(string),"Administrator %s has unjailed you",adminname);	SendClientMessage(player1,blue,string);
					format(string,sizeof(string),"Administrator %s has unjailed %s",adminname, playername);
					return SendClientMessageToAll(blue,string);
				} else return SendClientMessage(playerid, red, "Player is not in jail");
			} else return SendClientMessage(playerid, red, "El jugador no está conectado o es un administrador de mayor lvl.");
		} else return SendClientMessage(playerid,red,"ERROR: No tienes ningún permiso para usar este comando.");
	} else return SendClientMessage(playerid,red,"ERROR: Necesitas estar logueado para usar comandos.");
}

dcmd_unjail(playerid,params[]) {
	if(PlayerInfo[playerid][LoggedIn] == 1) {
		if(PlayerInfo[playerid][Level] >= 2) {
		    new tmp[256], Index; tmp = strtok(params,Index);
		    if(!strlen(params)) return SendClientMessage(playerid, red, "USAGE: /unjail [playerid]");
	    	new player1, playername[MAX_PLAYER_NAME], adminname[MAX_PLAYER_NAME], string[128];
			player1 = strval(tmp);

		 	if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID && (PlayerInfo[player1][Level] != ServerInfo[MaxAdminLevel]) ) {
				if(PlayerInfo[player1][Jailed] == 1) {
					GetPlayerName(player1, playername, sizeof(playername)); GetPlayerName(playerid, adminname, sizeof(adminname));
					format(string,sizeof(string),"Administrator %s has unjailed you",adminname);	SendClientMessage(player1,blue,string);
					format(string,sizeof(string),"Administrator %s has unjailed %s",adminname, playername);
					JailRelease(player1);
					return SendClientMessageToAll(blue,string);
				} else return SendClientMessage(playerid, red, "Player is not in jail");
			} else return SendClientMessage(playerid, red, "El jugador no está conectado o es un administrador de mayor lvl.");
		} else return SendClientMessage(playerid,red,"ERROR: No tienes ningún permiso para usar este comando.");
	} else return SendClientMessage(playerid,red,"ERROR: Necesitas estar logueado para usar comandos.");
}

dcmd_jailed(playerid,params[]) {
	#pragma unused params
	if(PlayerInfo[playerid][LoggedIn] == 1) {
		if(PlayerInfo[playerid][Level] >= 2) {
	 		new bool:First2 = false, Count, adminname[MAX_PLAYER_NAME], string[128], i;
		    for(i = 0; i < MAX_PLAYER; i++) if(IsPlayerConnected(i) && PlayerInfo[i][Jailed]) Count++;
			if(Count == 0) return SendClientMessage(playerid,red, "No players are jailed");

		    for(i = 0; i < MAX_PLAYER; i++) if(IsPlayerConnected(i) && PlayerInfo[i][Jailed]) {
	    		GetPlayerName(i, adminname, sizeof(adminname));
				if(!First2) { format(string, sizeof(string), "Jailed Players: (%d)%s", i,adminname); First2 = true; }
		        else format(string,sizeof(string),"%s, (%d)%s ",string,i,adminname);
	        }
		    return SendClientMessage(playerid,COLOR_WHITE,string);
		} else return SendClientMessage(playerid,red,"ERROR: No tienes ningún permiso para usar este comando.");
	} else return SendClientMessage(playerid,red,"ERROR: Necesitas estar logueado para usar comandos.");
}

dcmd_freeze(playerid,params[]) {
	if(PlayerInfo[playerid][LoggedIn] == 1) {
		if(PlayerInfo[playerid][Level] >= 2) {
		    new tmp[256], tmp2[256], tmp3[256], Index; tmp = strtok(params,Index), tmp2 = strtok(params,Index), tmp3 = strtok(params,Index);
		    if(!strlen(params)) return SendClientMessage(playerid, red, "USAGE: /freeze [playerid] [minutes] [reason]");
	    	new player1, playername[MAX_PLAYER_NAME], adminname[MAX_PLAYER_NAME], string[128];
			player1 = strval(tmp);
            if(PlayerInfo[playerid][Level] < PlayerInfo[player1][Level]) return SendClientMessage(playerid,red,"ERROR: You cannot use this command on this admin");
		 	if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
				if(PlayerInfo[player1][Frozen] == 0) {
					GetPlayerName(player1, playername, sizeof(playername)); GetPlayerName(playerid, adminname, sizeof(adminname));
					new ftime = strval(tmp2);
					if(ftime == 0) ftime = 9999;

			       	CMDMessageToAdmins(playerid,"FREEZE");
					TogglePlayerControllable(player1,false); PlayerInfo[player1][Frozen] = 1; PlayerPlaySound(player1,1057,0.0,0.0,0.0);
					PlayerInfo[player1][FreezeTime] = ftime*1000*60;
			        FreezeTimer[player1] = SetTimerEx("UnFreezeMe",PlayerInfo[player1][FreezeTime],0,"d",player1);

					if(ftime == 9999) {
						if(!strlen(params[strlen(tmp2)+1])) format(string,sizeof(string),"Administrator %s has frozen %s ",adminname, playername);
						else format(string,sizeof(string),"Administrator %s has frozen %s [reason: %s]",adminname, playername, params[strlen(tmp)+1] );
	   				} else {
						if(!strlen(tmp3)) format(string,sizeof(string),"Administrator %s has frozen %s for %d minutes",adminname, playername, ftime);
						else format(string,sizeof(string),"Administrator %s has frozen %s for %d minutes [reason: %s]",adminname, playername, ftime, params[strlen(tmp2)+strlen(tmp)+1] );
					}
		    		return SendClientMessageToAll(blue,string);
				} else return SendClientMessage(playerid, red, "Player is already frozen");
			} else return SendClientMessage(playerid, red, "El jugador no está conectado o es un administrador de mayor lvl.");
		} else return SendClientMessage(playerid,red,"ERROR: No tienes ningún permiso para usar este comando.");
	} else return SendClientMessage(playerid,red,"ERROR: Necesitas estar logueado para usar comandos.");
}

dcmd_unfreeze(playerid,params[]) {
	if(PlayerInfo[playerid][LoggedIn] == 1) {
	    if(PlayerInfo[playerid][Level] >= 2|| IsPlayerAdmin(playerid)) {
		    if(!strlen(params)) return SendClientMessage(playerid, red, "USAGE: /unfreeze [playerid]");
	    	new player1, string[128];
			player1 = strval(params);

		 	if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
		 	    if(PlayerInfo[player1][Frozen] == 1) {
			       	CMDMessageToAdmins(playerid,"UNFREEZE");
					UnFreezeMe(player1);
					format(string,sizeof(string),"Administrator %s has unfrozen you", PlayerName2(playerid) ); SendClientMessage(player1,blue,string);
					format(string,sizeof(string),"Administrator %s has unfrozen %s", PlayerName2(playerid), PlayerName2(player1));
		    		return SendClientMessageToAll(blue,string);
				} else return SendClientMessage(playerid, red, "Player is not frozen");
			} else return SendClientMessage(playerid, red, "El jugador no está conectado o es un administrador de mayor lvl.");
		} else return SendClientMessage(playerid,red,"ERROR: No tienes ningún permiso para usar este comando.");
	} else return SendClientMessage(playerid,red,"ERROR: Necesitas estar logueado para usar comandos.");
}

dcmd_frozen(playerid,params[]) {
	#pragma unused params
	if(PlayerInfo[playerid][LoggedIn] == 1) {
		if(PlayerInfo[playerid][Level] >= 2) {
	 		new bool:First2 = false, Count, adminname[MAX_PLAYER_NAME], string[128], i;
		    for(i = 0; i < MAX_PLAYER; i++) if(IsPlayerConnected(i) && PlayerInfo[i][Frozen]) Count++;
			if(Count == 0) return SendClientMessage(playerid,red, "No players are frozen");

		    for(i = 0; i < MAX_PLAYER; i++) if(IsPlayerConnected(i) && PlayerInfo[i][Frozen]) {
	    		GetPlayerName(i, adminname, sizeof(adminname));
				if(!First2) { format(string, sizeof(string), "Frozen Players: (%d)%s", i,adminname); First2 = true; }
		        else format(string,sizeof(string),"%s, (%d)%s ",string,i,adminname);
	        }
		    return SendClientMessage(playerid,COLOR_WHITE,string);
		} else return SendClientMessage(playerid,red,"ERROR: No tienes ningún permiso para usar este comando.");
	} else return SendClientMessage(playerid,red,"ERROR: Necesitas estar logueado para usar comandos.");
}

dcmd_mute(playerid,params[]) {
	if(PlayerInfo[playerid][LoggedIn] == 1) {
		if(PlayerInfo[playerid][Level] >= 2) {
		    new tmp[256], tmp2[256], Index;		tmp = strtok(params,Index), tmp2 = strtok(params,Index);
		    if(!strlen(params)) return SendClientMessage(playerid, red, "USAGE: /mute [playerid] [reason]");
	    	new player1, playername[MAX_PLAYER_NAME], adminname[MAX_PLAYER_NAME], string[128];
			player1 = strval(tmp);
            if(PlayerInfo[playerid][Level] < PlayerInfo[player1][Level]) return SendClientMessage(playerid,red,"ERROR: You cannot use this command on this admin");
		 	if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID && (PlayerInfo[player1][Level] != ServerInfo[MaxAdminLevel]) ) {
		 	    if(PlayerInfo[player1][Muted] == 0) {
					GetPlayerName(player1, playername, sizeof(playername)); 	GetPlayerName(playerid, adminname, sizeof(adminname));
					CMDMessageToAdmins(playerid,"MUTE");
					PlayerPlaySound(player1,1057,0.0,0.0,0.0);  PlayerInfo[player1][Muted] = 1; PlayerInfo[player1][MuteWarnings] = 0;

					if(strlen(tmp2)) {
						format(string,sizeof(string),"You have been muted by Administrator %s [reason: %s]",adminname,params[2]); SendClientMessage(player1,blue,string);
						format(string,sizeof(string),"You have muted %s [reason: %s]", playername,params[2]); return SendClientMessage(playerid,blue,string);
					} else {
						format(string,sizeof(string),"You have been muted by Administrator %s",adminname); SendClientMessage(player1,blue,string);
						format(string,sizeof(string),"You have muted %s", playername); return SendClientMessage(playerid,blue,string); }
				} else return SendClientMessage(playerid, red, "Player is already muted");
			} else return SendClientMessage(playerid, red, "El jugador no está conectado o es un administrador de mayor lvl.");
		} else return SendClientMessage(playerid,red,"ERROR: No tienes ningún permiso para usar este comando.");
	} else return SendClientMessage(playerid,red,"ERROR: Necesitas estar logueado para usar comandos.");
}

dcmd_unmute(playerid,params[]) {
	if(PlayerInfo[playerid][LoggedIn] == 1) {
		if(PlayerInfo[playerid][Level] >= 2) {
		    if(!strlen(params)) return SendClientMessage(playerid, red, "USAGE: /unmute [playerid]");
	    	new player1, playername[MAX_PLAYER_NAME], adminname[MAX_PLAYER_NAME], string[128];
			player1 = strval(params);

		 	if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID && (PlayerInfo[player1][Level] != ServerInfo[MaxAdminLevel]) ) {
		 	    if(PlayerInfo[player1][Muted] == 1) {
					GetPlayerName(player1, playername, sizeof(playername)); 	GetPlayerName(playerid, adminname, sizeof(adminname));
					CMDMessageToAdmins(playerid,"UNMUTE");
					PlayerPlaySound(player1,1057,0.0,0.0,0.0);  PlayerInfo[player1][Muted] = 0; PlayerInfo[player1][MuteWarnings] = 0;
					format(string,sizeof(string),"You have been unmuted by Administrator %s",adminname); SendClientMessage(player1,blue,string);
					format(string,sizeof(string),"You have unmuted %s", playername); return SendClientMessage(playerid,blue,string);
				} else return SendClientMessage(playerid, red, "Player is not muted");
			} else return SendClientMessage(playerid, red, "El jugador no está conectado o es un administrador de mayor lvl.");
		} else return SendClientMessage(playerid,red,"ERROR: No tienes ningún permiso para usar este comando.");
	} else return SendClientMessage(playerid,red,"ERROR: Necesitas estar logueado para usar comandos.");
}

dcmd_muted(playerid,params[]) {
	#pragma unused params
	if(PlayerInfo[playerid][LoggedIn] == 1) {
		if(PlayerInfo[playerid][Level] >= 2) {
	 		new bool:First2 = false, Count, adminname[MAX_PLAYER_NAME], string[128], i;
		    for(i = 0; i < MAX_PLAYER; i++) if(IsPlayerConnected(i) && PlayerInfo[i][Muted]) Count++;
			if(Count == 0) return SendClientMessage(playerid,red, "No players are muted");

		    for(i = 0; i < MAX_PLAYER; i++) if(IsPlayerConnected(i) && PlayerInfo[i][Muted]) {
	    		GetPlayerName(i, adminname, sizeof(adminname));
				if(!First2) { format(string, sizeof(string), "Muted Players: (%d)%s", i,adminname); First2 = true; }
		        else format(string,sizeof(string),"%s, (%d)%s ",string,i,adminname);
	        }
		    return SendClientMessage(playerid,COLOR_WHITE,string);
		} else return SendClientMessage(playerid,red,"ERROR: No tienes ningún permiso para usar este comando.");
	} else return SendClientMessage(playerid,red,"ERROR: Necesitas estar logueado para usar comandos.");
}

dcmd_akill(playerid,params[]) {
	if(PlayerInfo[playerid][LoggedIn] == 1) {
	    if(PlayerInfo[playerid][Level] >= 4) {
		    if(!strlen(params)) return SendClientMessage(playerid, red, "USAGE: /akill [playerid]");
	    	new player1, playername[MAX_PLAYER_NAME], adminname[MAX_PLAYER_NAME], string[128];
			player1 = strval(params);

		 	if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
				if( (PlayerInfo[player1][Level] == ServerInfo[MaxAdminLevel] && PlayerInfo[playerid][Level] != ServerInfo[MaxAdminLevel] ) )
					return SendClientMessage(playerid, red, "You cannot akill the highest level admin");
				CMDMessageToAdmins(playerid,"AKILL");
				GetPlayerName(player1, playername, sizeof(playername));	GetPlayerName(playerid, adminname, sizeof(adminname));
				format(string,sizeof(string),"Administrator %s has killed you",adminname);	SendClientMessage(player1,blue,string);
				format(string,sizeof(string),"You have killed %s",playername); SendClientMessage(playerid,blue,string);
				return SetPlayerHealth(player1,0.0);
			} else return SendClientMessage(playerid, red, "Player is not connected");
		} else return SendClientMessage(playerid,red,"ERROR: No tienes ningún permiso para usar este comando.");
	} else return SendClientMessage(playerid,red,"ERROR: Necesitas estar logueado para usar comandos.");
}

dcmd_weaps(playerid,params[]) {
    if(PlayerInfo[playerid][Level] >= 1 || IsPlayerAdmin(playerid)) {
	    if(!strlen(params)) return SendClientMessage(playerid, red, "USAGE: /weaps [playerid]");
    	new player1, string[128],string2[128], /*string2[64],*/ WeapName[24], slot, weap, ammo, Count, x;
		player1 = strval(params);

	 	if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
			format(string2,sizeof(string2),"[>> %s Weapons (id:%d) <<]", PlayerName2(player1), player1); SendClientMessage(playerid,blue,string2);
			for (slot = 0; slot < 14; slot++) {	GetPlayerWeaponData(player1, slot, weap, ammo); if( ammo != 0 && weap != 0) Count++; }
			if(Count < 1) return SendClientMessage(playerid,blue,"Player has no weapons");

			if(Count >= 1)
			{
				for (slot = 0; slot < 14; slot++)
				{
					GetPlayerWeaponData(player1, slot, weap, ammo);
					if( ammo != 0 && weap != 0)
					{
						GetWeaponName(weap, WeapName, sizeof(WeapName) );
						if(ammo == 65535 || ammo == 1) format(string,sizeof(string),"%s%s (1)",string, WeapName );
						else format(string,sizeof(string),"%s%s (%d)",string, WeapName, ammo );
						x++;
						if(x >= 5)
						{
						    SendClientMessage(playerid, blue, string);
						    x = 0;
							format(string, sizeof(string), "");
						}
						else format(string, sizeof(string), "%s,  ", string);
					}
			    }
				if(x <= 4 && x > 0) {
					string[strlen(string)-3] = '.';
				    SendClientMessage(playerid, blue, string);
				}
		    }
		    return 1;
		} else return SendClientMessage(playerid, red, "Player is not connected");
	} else return SendClientMessage(playerid,red,"ERROR: No tienes ningún permiso para usar este comando.");
}

dcmd_aka(playerid,params[]) {
    if(PlayerInfo[playerid][Level] >= 3 || IsPlayerAdmin(playerid)) {
	    if(!strlen(params)) return SendClientMessage(playerid, red, "USAGE: /aka [playerid]");
    	new player1, playername[MAX_PLAYER_NAME], str[128], tmp3[50];
		player1 = strval(params);
	 	if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
  		  	GetPlayerIp(player1,tmp3,50);
			GetPlayerName(player1, playername, sizeof(playername));
		    format(str,sizeof(str),"AKA: [%s id:%d] [%s] %s", playername, player1, tmp3, dini_Get("ladmin/config/aka.txt",tmp3) );
	        return SendClientMessage(playerid,blue,str);
		} else return SendClientMessage(playerid, red, "Player is not connected or is yourself");
	} else return SendClientMessage(playerid,red,"ERROR: No tienes ningún permiso para usar este comando.");
}

dcmd_screen(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 2) {
	    new tmp[256], tmp2[256], Index;		tmp = strtok(params,Index), tmp2 = strtok(params,Index);
	    if(!strlen(params)) return SendClientMessage(playerid, red, "USAGE: /screen [playerid] [text]");
    	new player1, playername[MAX_PLAYER_NAME], adminname[MAX_PLAYER_NAME], string[128];
		player1 = strval(params);

	 	if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID && player1 != playerid && (PlayerInfo[player1][Level] != ServerInfo[MaxAdminLevel]) ) {
			GetPlayerName(player1, playername, sizeof(playername));		GetPlayerName(playerid, adminname, sizeof(adminname));
			CMDMessageToAdmins(playerid,"SCREEN");
			format(string,sizeof(string),"Administrator %s has sent you a screen message",adminname);	SendClientMessage(player1,blue,string);
			format(string,sizeof(string),"You have sent %s a screen message (%s)", playername, params[2]); SendClientMessage(playerid,blue,string);
			return GameTextForPlayer(player1, params[2],4000,3);
		} else return SendClientMessage(playerid, red, "Player is not connected or is yourself or is the highest level admin");
	} else return SendClientMessage(playerid,red,"ERROR: No tienes ningún permiso para usar este comando.");
}

/*dcmd_laston(playerid,params[]) {
    if(PlayerInfo[playerid][Level] >= 2) {
    	new tmp2[256], file[256],player1, playername[MAX_PLAYER_NAME], adminname[MAX_PLAYER_NAME], str[128];
		GetPlayerName(playerid, adminname, sizeof(adminname));

	    if(!strlen(params)) {
			format(file,sizeof(file),"/ladmin/users/%s.sav",udb_encode(adminname));
			if(!fexist(file)) return SendClientMessage(playerid, red, "Error: File doesnt exist, player isnt registered");
			if(dUserINT(PlayerName2(playerid)).("LastOn")==0) {	format(str, sizeof(str),"Never"); tmp2 = str;
			} else { tmp2 = dini_Get(file,"LastOn"); }
			format(str, sizeof(str),"You were last on the server on %s",tmp2);
			return SendClientMessage(playerid, red, str);
		}
		player1 = strval(params);
	 	if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID && player1 != playerid) {
			CMDMessageToAdmins(playerid,"LASTON");
   	    	GetPlayerName(player1,playername,sizeof(playername)); format(file,sizeof(file),"/ladmin/users/%s.sav",udb_encode(playername));
			if(!fexist(file)) return SendClientMessage(playerid, red, "Error: File doesnt exist, player isnt registered");
			if(dUserINT(PlayerName2(player1)).("LastOn")==0) { format(str, sizeof(str),"Never"); tmp2 = str;
			} else { tmp2 = dini_Get(file,"LastOn"); }
			format(str, sizeof(str),"%s was last on the server on %s",playername,tmp2);
			return SendClientMessage(playerid, red, str);
		} else return SendClientMessage(playerid, red, "Player is not connected or is yourself");
	} else return SendClientMessage(playerid,red,"ERROR: No tienes ningún permiso para usar este comando.");
}*/

dcmd_laston(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 2) {
	    new string[128], tmp[256], tmp2[256], Index; tmp = strtok(params,Index);
	    if(!strlen(tmp)) return SendClientMessage(playerid, red, "USE: /laston [playername]");
	    udb_query(result, "SELECT `pLastOn` FROM `user` WHERE `pName` = '%s' LIMIT 1", DB_Escape(udb_encode(tmp)));
	    if(db_num_rows(result)) {
	        new field[30]; db_get_field_assoc(result, "pLastOn", field, 30); db_free_result(result);
	        if(strval(field)==0) {	format(string, sizeof(string),"NUNCA"); tmp2 = string;
			} else { tmp2 = field; }
	        format(string, sizeof(string), "%s: Ultima conección fue [%s]", tmp, tmp2);
	        SendClientMessage(playerid, red, string);
	        return CMDMessageToAdmins(playerid, "LastOn2");
		} else return SendClientMessage(playerid, red, "ERROR: El usuario no existe");
	} else return SendClientMessage(playerid, red, "ERROR: Tu level no es suficiente para usar este comando");
}

dcmd_rconacept(playerid,params[]) {
	if(PlayerInfo[playerid][Level]  > 11 && IsPlayerAdmin(playerid)) { //&& IsPlayerAdmin(playerid)) {
	    new string[128], tmp[256], Index; tmp = strtok(params,Index);
	    if(!strlen(tmp)) return SendClientMessage(playerid, red, "USE: /rconacept [playername/playerid]");
	    if(IsNumeric(tmp))
	    {
	        new player = strval(tmp);
			if(PlayerInfo[player][rcona] == 0)
			{
			    udb_query(result, "UPDATE `user` SET `pRconAprovado` = '1' WHERE `pName` = '%s'", DB_Escape(udb_encode(PlayerName2(player)))); db_free_result(result);
				PlayerInfo[player][rcona] = 1;
				format(string, sizeof(string), "[Pura Joda]: El administrador \"%s\" le otorgo privilegios RCON a \"%s\"", PlayerName2(playerid), PlayerName2(player));
				MessageToAdmins(blue, string);
				format(string, sizeof(string), "[Pura Joda] {FFFFFF}El usuario %s ya puede usar RCON ADMIN", PlayerName2(player));
				SendClientMessage(playerid, red, string);
				format(string, sizeof(string), "[Pura Joda] {FFFFFF}El administrador %s te autorizar a usar RCON ADMIN", PlayerName2(playerid));
				SendClientMessage(player, red, string);
				return CMDMessageToAdmins(playerid, "RCONACEPT");
			} else {
				udb_query(result, "UPDATE `user` SET `pRconAprovado` = '0' WHERE `pName` = '%s'", DB_Escape(udb_encode(PlayerName2(player)))); db_free_result(result);
				PlayerInfo[player][rcona] = 0;
				format(string, sizeof(string), "[Pura Joda]: El administrador \"%s\" le quito los privilegios RCON a \"%s\"", PlayerName2(playerid), PlayerName2(player));
				MessageToAdmins(blue, string);
				format(string, sizeof(string), "[Pura Joda] {FFFFFF}El usuario %s ya NO puede usar RCON ADMIN", PlayerName2(player));
				SendClientMessage(playerid, red, string);
				format(string, sizeof(string), "[Pura Joda] {FFFFFF}El administrador %s te denego a usar RCON ADMIN", PlayerName2(playerid));
				SendClientMessage(player, red, string);
				return CMDMessageToAdmins(playerid, "RCONACEPT");
			}
	    } else {
	        new query2[100], DBResult:result2; format(query2, sizeof(query2), "SELECT `pRconAprovado` FROM `user` WHERE `pName` = '%s' LIMIT 1", DB_Escape(udb_encode(tmp))); result2 = db_query(LadminDB, query2);
	    	if(db_num_rows(result2)) {
	    	    new CheckApro[30];
	    	    db_get_field_assoc(result2, "pRconAprovado", CheckApro, 30);
	    	    if(strval(CheckApro) == 0)
	    	    {
	    	        db_free_result(result2);
        	        udb_query(result, "UPDATE `user` SET `pRconAprovado` = '1' WHERE `pName` = '%s'", DB_Escape(udb_encode(tmp))); db_free_result(result);
        	        format(string, sizeof(string), "[Pura Joda]: El administrador \"%s\" le otorgo privilegios RCON a \"%s\"", PlayerName2(playerid), tmp);
        	        MessageToAdmins(blue, string);
        	        format(string, sizeof(string), "[Pura Joda] {FFFFFF}El usuario %s ya puede usar RCON ADMIN", tmp);
        	        SendClientMessage(playerid, red, string);
        	        return CMDMessageToAdmins(playerid, "RCONACEPT");
				} else {
				    db_free_result(result2);
        	        udb_query(result, "UPDATE `user` SET `pRconAprovado` = '0' WHERE `pName` = '%s'", DB_Escape(udb_encode(tmp))); db_free_result(result);
        	        format(string, sizeof(string), "[Pura Joda]: El administrador \"%s\" le quito los privilegios RCON a \"%s\"", PlayerName2(playerid), tmp);
        	        MessageToAdmins(blue, string);
        	        format(string, sizeof(string), "[Pura Joda] {FFFFFF}El usuario %s ya NO puede usar RCON ADMIN", tmp);
        	        SendClientMessage(playerid, red, string);
        	        return CMDMessageToAdmins(playerid, "RCONACEPT");
				}
			} else return SendClientMessage(playerid, red, "ERROR: El usuario no existe");
		}
	} else return SendClientMessage(playerid, red, "ERROR: Tu level no es suficiente para usar este comando");
}

dcmd_hideadmin(playerid,params[])
{
	#pragma unused params
	if(PlayerInfo[playerid][Level] >= 1)
	{
	    if(PlayerInfo[playerid][Hide] == 0)
	    {
	        PlayerInfo[playerid][Hide] = 1;
	        CMDMessageToAdmins(playerid, "HIDEADMIN");
	        return SendClientMessage(playerid, blue, "Te has escondido de la lista de /admins");
	    } else {
	        PlayerInfo[playerid][Hide] = 0;
	        CMDMessageToAdmins(playerid, "HIDEADMIN");
	        return SendClientMessage(playerid, blue, "Has aparecido de nuevo en la lista de /admins");
	    }
	} else return SendClientMessage(playerid, red, "Error: No eres administrador");
}

dcmd_admins(playerid,params[])
{
    #pragma unused params
    new conteo, admins[2000],texto[128],titulo[128];
    for(new i = 0; i < MAX_PLAYER; i++)
    {
    if(PlayerInfo[i][Hide] == 0)
		{
			if(IsPlayerAdmin(i))
    		{
    			conteo++;
    		}
    		else if(PlayerInfo[i][Level] >= 1)
    		{
    		conteo++;
    		}
  		}
    }
    if(conteo == 0)return ShowPlayerDialog( playerid, DIALOG_OTROS, DIALOG_STYLE_MSGBOX, "{FF0000}¡Advertencia!", "{FFFFFF}No hay administradores ON.\npuedes usar F8 por sí hay cheaters y repórtalos por la página.\no puedes llamar un administrador conocido.", "Aceptar", "" );
    format(titulo,sizeof(titulo),"{00F700}Administradores en línea: {FFFFFF}%d",conteo);
    format(admins, sizeof(admins), "Player Name\tPlayer ID\tAdmin Level\n");
    //Se contaron los admins conectados
    for(new i = 0; i < MAX_PLAYER; i++)
    {
    	if(IsPlayerAdmin(i))
    	{
    	    if(PlayerInfo[i][Hide] == 1 && !IsPlayerAdmin(playerid)) continue;
			//Si el player es admin RCON...
    		format(texto,sizeof(texto),"{FFFFFF}%s\t%d\t{00F700}RCON\n",PlayerName2(i),i);
    		strcat(admins,texto);
    	}
    	else if(PlayerInfo[i][Level] >= 1)
    	{
    	    if(PlayerInfo[i][Hide] == 1 && !IsPlayerAdmin(playerid)) continue;
    		//Si no es RCON pero si admin normal...
    		format(texto,sizeof(texto),"{FFFFFF}%s\t%d\t{FF0000}%d\n",PlayerName2(i),i,PlayerInfo[i][Level]);
    		strcat(admins,texto);
    	}
    }
    ShowPlayerDialog(playerid,DIALOG_OTROS,DIALOG_STYLE_TABLIST_HEADERS,titulo,admins,"Aceptar","");
    return 1;
}
dcmd_premiums(playerid, params[])
{
	#pragma unused params
	new string[2000],str2[144];
	format(string, sizeof(string),"{FFFFFF}[Player Name]\t{FF0000}[Player ID]\t{00FF00}[Premium Level]\t{FF7000}[Payer Score]\n");
	if(IsPlayerConnected(playerid))
	{
		for (new i = 0; i < MAX_PLAYER; i++)
		{
			if(IsPlayerConnected(i) && GetPVarInt(i, "PREMIUM") >= 1 && GetPVarInt(i, "PREMIUM") <= 3)
			{
				format(str2, sizeof(str2),"{FFFFFF}%s\t{FF0000}%d\t{00FF00}%d\t{FF7000}%d\n", PlayerName2(i), i, GetPVarInt(i, "PREMIUM"), GetPlayerScore(i));
				strcat(string, str2);
			}
		}
		ShowPlayerDialog(playerid,DIALOG_OTROS,DIALOG_STYLE_TABLIST_HEADERS,"Premiuns Conectados",string,"Aceptar","");
	}
	return 1;
}

dcmd_staff(playerid, params[])
{
	#pragma unused params
	if(PlayerInfo[playerid][Level] == 0) return SendClientMessage(playerid, 0xFF0000FF, "Error: No eres administrador para usar este comando");
	new DBResult:r = db_query(LadminDB, "SELECT `pName`, `pLevel`, `pLastOn`, `pLoggedIn`, `pRconAprovado`, `pWarn` FROM `user` ORDER BY `pLevel` desc");
    new string[2000], titu[100], ContAdm = 0;
    format(string, sizeof(string), ""W"PlayerName\t"W"AdminLevel\t"W"Warns\t"W"Última vez\n");
	for(new top = 0; top != db_num_rows(r); ++top)
	{
	    new timeon2, field[30], laston[30], playerlevel, loggedin, rconaccept; db_get_field_assoc(r, "pRconAprovado", field, 30); rconaccept = strval(field); db_get_field_assoc(r, "pWarn", field, 30); timeon2 = strval(field); db_get_field_assoc(r, "pLevel", field, 30); playerlevel = strval(field); db_get_field_assoc(r, "pLoggedIn", field, 30); loggedin = strval(field); db_get_field_assoc(r, "pName", field, 30); db_get_field_assoc(r, "pLastOn", laston, 30);
	    if(playerlevel != 0)
		{
		    loggedin = 0;
		    for(new i; i < MAX_PLAYERS; i++){
		    if(!IsPlayerConnected(i)) continue;
		    if(!strcmp(PlayerName2(i),udb_decode(field), true)){
			loggedin = 1;
			break;
		    }
		    }
		    if(rconaccept == 0)
		    {
		    	if(loggedin == 0)
		    	{
		    		if(playerlevel == 12)
		    		{
		    		    new str2[200]; format(str2, sizeof(str2), "{FFFFFF}%s \t {00FF00}12 \t{FFFFFF}%d/3\t %s\n", udb_decode(field), timeon2,laston); strcat(string, str2); ContAdm++;
		    		} else if(playerlevel <= 2) {
		    			new str2[200]; format(str2, sizeof(str2), "{FFFFFF}%s \t {0000FF}A PRUEBA \t{FFFFFF}%d/1 \t%s\n", udb_decode(field), timeon2, laston); strcat(string, str2); ContAdm++;
		    		} else {
		    		    new str2[200]; format(str2, sizeof(str2), "{FFFFFF}%s \t %d \t{FFFFFF}%d/3\t %s\n", udb_decode(field), playerlevel, timeon2,laston); strcat(string, str2); ContAdm++;
					}
				} else {
				    if(playerlevel == 12)
		    		{
		    		    new str2[200]; format(str2, sizeof(str2), "{FFFFFF}%s \t {00FF00}12 \t{FFFFFF}%d/3 \t{00FF00}ON\n", udb_decode(field),timeon2); strcat(string, str2); ContAdm++;
		    		} else if(playerlevel <= 2) {
		    			new str2[200]; format(str2, sizeof(str2), "{FFFFFF}%s \t {0000FF}A PRUEBA \t{FFFFFF}%d/1 \t{00FF00} EN LÍNEA\n", udb_decode(field),timeon2); strcat(string, str2); ContAdm++;
		    		} else {
		    		    new str2[200]; format(str2, sizeof(str2), "{FFFFFF}%s \t %d \t{FFFFFF}%d/3\t{00FF00} EN LÍNEA\n", udb_decode(field), playerlevel, timeon2); strcat(string, str2); ContAdm++;
					}
				}
			} else {
			    if(loggedin == 0)
		    	{
		    		if(playerlevel == 12)
		    		{
		    		    new str2[200]; format(str2, sizeof(str2), "{FFFFFF}%s \t {00FF00}CEO \t{FFFFFF}%d/3 \t %s\n", udb_decode(field), timeon2,laston); strcat(string, str2); ContAdm++;
		    		} else if(playerlevel <= 2) {
		    			new str2[200]; format(str2, sizeof(str2), "{FFFFFF}%s \t {0000FF}A PRUEBA \t{FFFFFF}%d/1 \t %s \n", udb_decode(field),timeon2,
						 laston); strcat(string, str2); ContAdm++;
		    		} else {
		    		    new str2[200]; format(str2, sizeof(str2), "{FFFFFF}%s \t %d \t{FFFFFF}%d/3 \t %s \n", udb_decode(field), playerlevel, laston, timeon2); strcat(string, str2); ContAdm++;
					}
				} else {
				    if(playerlevel == 12)
		    		{
		    		    new str2[200]; format(str2, sizeof(str2), "{FFFFFF}%s \t {00FF00}CEO \t{FFFFFF}%d/3 \t{00FF00} EN LÍNEA\n", udb_decode(field),timeon2); strcat(string, str2); ContAdm++;
		    		} else if(playerlevel <= 2) {
		    			new str2[200]; format(str2, sizeof(str2), "{FFFFFF}%s \t {0000FF}A PRUEBA \t{FFFFFF}%d/3 \t{00FF00} EN LÍNEA\n", udb_decode(field),timeon2); strcat(string, str2); ContAdm++;
		    		} else {
		    		    new str2[200]; format(str2, sizeof(str2), "{FFFFFF}%s \t %d \t{FFFFFF}%d/3 \t{00FF00} EN LÍNEA\n", udb_decode(field), playerlevel, timeon2); strcat(string, str2); ContAdm++;
					}
				}
			}
		}
	    db_next_row(r);
	}
	db_free_result(r);
	format(titu, sizeof(titu), "{00FF00}Staff Completo: {FF0000}%d ADMINS", ContAdm);
	return ShowPlayerDialog(playerid,DIALOG_OTROS,DIALOG_STYLE_TABLIST_HEADERS,titu,string,"Aceptar","");
}

dcmd_vips(playerid, params[])
{
	#pragma unused params
	new DBResult:r = db_query(LadminDB, "SELECT `pName`, `pPreDia`, `pPreMes`, `pPreAno` FROM `user` WHERE `pPremium` = '4'");
	new string[500], titu[100], ContVip = 0;
	format(string, sizeof(string), "PlayerName\tVencimiento\n");
	for(new vips = 0; vips != db_num_rows(r); vips++)
	{
	    new field[30], dia, mes, ano; db_get_field_assoc(r, "pPreDia", field, 30); dia = strval(field); db_get_field_assoc(r, "pPreMes", field, 30); mes = strval(field); db_get_field_assoc(r, "pPreAno", field, 30); ano = strval(field); db_get_field_assoc(r, "pName", field, 30);
	    if(dia != 0)
	    {
	        new str2[150]; format(str2, sizeof(str2), "{FFFFFF}%s\t{FF0000}%d/%d/%d\n", udb_decode(field), dia, mes, ano); strcat(string, str2); ContVip++;
	    } else {
	        new str2[150]; format(str2, sizeof(str2), "{FFFFFF}%s\t{00FF00}SIN VENCIMIENTO\n", udb_decode(field)); strcat(string, str2); ContVip++;
	    }
	    db_next_row(r);
	}
	db_free_result(r);
	format(titu, sizeof(titu), "{00FF00}V.I.P's Completos: {FF0000}%d V.I.P's", ContVip);
	return ShowPlayerDialog(playerid,DIALOG_OTROS,DIALOG_STYLE_TABLIST_HEADERS,titu,string,"Aceptar","");
}

dcmd_morning(playerid,params[]) {
    #pragma unused params
    if(PlayerInfo[playerid][Level] >= 1) {
        CMDMessageToAdmins(playerid,"MORNING");
        return SetPlayerTime(playerid,7,0);
    } else return SendClientMessage(playerid,red,"ERROR: No tiene ningún permiso para usar este comando.");
}

dcmd_adminarea(playerid,params[]) {
	#pragma unused params
    if(PlayerInfo[playerid][Level] >= 1) {
        CMDMessageToAdmins(playerid,"ADMINAREA");
	    SetPlayerPos(playerid, AdminArea[0], AdminArea[1], AdminArea[2]);
	    SetPlayerFacingAngle(playerid, AdminArea[3]);
	    SetPlayerInterior(playerid, AdminArea[4]);
		SetPlayerVirtualWorld(playerid, AdminArea[5]);
		return GameTextForPlayer(playerid,"Welcome Admin",1000,3);
	} else {
	   	SetPlayerHealth(playerid,1.0);
   		new string[100]; format(string, sizeof(string),"%s has used adminarea (non admin)", PlayerName2(playerid) );
	   	MessageToAdmins(red,string);
	} return SendClientMessage(playerid,red, "ERROR: Necesitas permisos administrativos para usar estos comandos..");
}
dcmd_setpremium(playerid,params[]) {
	if(PlayerInfo[playerid][LoggedIn] == 1) {
		if(PlayerInfo[playerid][Level] < 12 || !IsPlayerAdmin(playerid)) return 0;
		    new tmp[256], tmp2[256], Index;		tmp = strtok(params,Index), tmp2 = strtok(params,Index);
		    if(!strlen(params)) return SendClientMessage(playerid, red, "USAGE: /setpremiun [playerid] [level]");
	    	new player1, level, string[128];
			player1 = strval(tmp);
			if(!strlen(tmp2)) return SendClientMessage(playerid, red, "USAGE: /setpremiun [playerid] [level]");
			level = strval(tmp2);

			if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
				if(PlayerInfo[player1][LoggedIn] == 1) {
					if(level == GetPVarInt(player1, "PREMIUM")) return SendClientMessage(playerid,red,"ERROR: El usuario ya posee este level");
					if(level >= 4) return SendClientMessage(playerid, red, "ERROR: El nievel 4 solo usuarios con vip pago");
	       			CMDMessageToAdmins(playerid,"SETPREMIUN");
			       	new year,month,day;   getdate(year, month, day); new hour,minute,second; gettime(hour,minute,second);
					if(level < 3) format(string,sizeof(string),"Has otorgado una cuenta premium de nivel.", PlayerName2(player1), level);

					else format(string,sizeof(string),"Administrador %s le otorgó una cuenta nivel: %d.",PlayerName2(playerid), level);
					SendClientMessage(player1,blue,string);
					SendClientMessage(player1,blue,"Usa /PComandos para ver tus Nuevos comandos");

					if(level > GetPVarInt(player1, "PREMIUM")) GameTextForPlayer(player1,"Promoted", 2000, 3);
					else GameTextForPlayer(player1,"Demoted", 2000, 3);
//					format(string,sizeof(string),"You have made %s Level %d on %d/%d/%d at %d:%d:%d", playername, level, day, month, year, hour, minute, second); SendClientMessage(playerid,blue,string);
///					format(string,sizeof(string),"Administrator %s has made %s Level %d on %d/%d/%d at %d:%d:%d",adminname, playername, level, day, month, year, hour, minute, second);					SaveToFile("AdminLog",string);
					udb_query(result, "UPDATE `user` SET `pPremium` = '%d' WHERE `pName` = '%s'", level, DB_Escape(udb_encode(PlayerName2(player1)))); db_free_result(result);
					SetPVarInt(player1, "PREMIUM",level);
					return PlayerPlaySound(player1,1057,0.0,0.0,0.0);
				} else return SendClientMessage(playerid,red,"ERROR: Player must be registered and logged in to be admin");
			} else return SendClientMessage(playerid, red, "Player is not connected");
	//	} else return SendClientMessage(playerid,red,"ERROR: No tienes ningún permiso para usar este comando.");
	} else return SendClientMessage(playerid,red,"ERROR: Necesitas estar logueado para usar comandos.");
}

dcmd_darvip(playerid,params[]) {
	if(PlayerInfo[playerid][LoggedIn] == 1) {
	    if(PlayerInfo[playerid][Level] < 12 || !IsPlayerAdmin(playerid)) return 0; //Tenes que ser admin nivel 12 y estar loggeado rcon para usar este comando
	        new Index, Date[256], playername[256], dia[256], mes[256], ano[256]; playername = strtok(params,Index), Date = strtok(params,Index), dia = strtok(params,Index), mes = strtok(params,Index), ano = strtok(params,Index);
	        if(!strlen(playername) && !strlen(Date)) return SendClientMessage(playerid, red, "ERROR: Use /darvip <playername> <opción> <DD> <MM> <AAAA>"), SendClientMessage(playerid, blue, "Opciones: quitar - siempre - vencimiento (para esta opción rellenar (DD - MM - AAAA))");
	        new query2[100], DBResult:result2; format(query2, sizeof(query2), "SELECT `pPremium` FROM `user` WHERE `pName` = '%s' LIMIT 1", DB_Escape(udb_encode(playername))); result2 = db_query(LadminDB, query2);
	        new field[30]; db_get_field_assoc(result2, "pPremium", field, 30);
	        if(db_num_rows(result2)) {
				if(strcmp(Date, "vencimiento", true) == 0) {
					if(strval(field) == 4) return SendClientMessage(playerid, red, "ERROR: el jugador ya posee level 4, si quiere modificar la fecha espere el vencimiento") && db_free_result(result2);
					if(!strlen(dia) && !strlen(mes) && !strlen(ano)) return SendClientMessage(playerid, red, "ERROR: Use /darvip <playername> <opción> <DD> <MM> <AAAA>"), SendClientMessage(playerid, blue, "Dato: Indique en \"<dia> <mes> <año>\" la fecha de vencimiento del premium en DD/MM/AAAA"), db_free_result(result2);
                    db_free_result(result2);
					udb_query(result, "UPDATE `user` SET `pPremium` = '4', `pPreDia` = '%d', `pPreMes` = '%d', `pPreAno` = '%d' WHERE `pName` = '%s'", (strval(dia)),(strval(mes)),(strval(ano)),DB_Escape(udb_encode(playername))); db_free_result(result);
					new string[250], dia2, mes2, ano2; getdate(ano2, mes2, dia2);
					format(string, sizeof(string), "[%02d/%02d/%d] %s le otorgo premium lvl 4 a %s hasta el %02d - %02d - %d", dia2, mes2, ano2, PlayerName2(playerid), playername, strval(dia), strval(mes), strval(ano));
	        		SaveToFile("Premium4Log",string);
					format(string, sizeof(string), "El administrador \"%s[ID: %d]\" le otorgo premium LVL 4 a \"%s\" hasta el [%d/%d/%d]", PlayerName2(playerid), playerid, playername, strval(dia), strval(mes), strval(ano));
					MessageToAdmins(red, string);
					format(string, sizeof(string), "[Pura Joda]: {FFFFFF}Otorgaste premium LVL 4 a \"%s\" hasta el [%d/%d/%d]", playername, strval(dia), strval(mes), strval(ano));
					return SendClientMessage(playerid, red, string);
				} else if(strcmp(Date, "siempre", true) == 0) {
				    if(strval(field) == 4) return SendClientMessage(playerid, red, "ERROR: el jugador ya posee level 4, si quiere modificar la fecha espere el vencimiento") && db_free_result(result2);
                    db_free_result(result2);
                    udb_query(result, "UPDATE `user` SET `pPremium` = '4', `pPreDia` = '0', `pPreMes` = '0', `pPreAno` = '0' WHERE `pName` = '%s'",DB_Escape(udb_encode(playername))); db_free_result(result);
					new string[250], dia2, mes2, ano2; getdate(ano2, mes2, dia2);
					format(string, sizeof(string), "[%02d/%02d/%d] %s le otorgo premium lvl 4 a %s por tiempo indefinido", dia2, mes2, ano2, PlayerName2(playerid), playername);
	        		SaveToFile("Premium4Log",string);
					format(string, sizeof(string), "El administrador \"%s[ID: %d]\" le otorgo premium LVL 4 a \"%s\"", PlayerName2(playerid), playerid, playername);
					MessageToAdmins(red, string);
					format(string, sizeof(string), "[Pura Joda]: {FFFFFF}Otorgaste premium LVL 4 a \"%s\" por tiempo indefinido", playername);
					return SendClientMessage(playerid, red, string);
				} else if(strcmp(Date, "quitar", true) == 0) {
				    db_free_result(result2);
					udb_query(result, "UPDATE `user` SET `pPremium` = '0', `pPreDia` = '0', `pPreMes` = '0', `pPreAno` = '0' WHERE `pName` = '%s'",DB_Escape(udb_encode(playername))); db_free_result(result);
					new string[250], dia2, mes2, ano2; getdate(ano2, mes2, dia2);
					format(string, sizeof(string), "[%02d/%02d/%d] %s le quito el premium lvl 4 a %s", dia2, mes2, ano2, PlayerName2(playerid), playername);
	        		SaveToFile("Premium4Log",string);
					format(string, sizeof(string), "El administrador \"%s[ID: %d]\" le quito el premium LVL 4 a \"%s\"", PlayerName2(playerid), playerid, playername);
					MessageToAdmins(red, string);
					format(string, sizeof(string), "[Pura Joda]: {FFFFFF}Quitaste premium LVL 4 a \"%s\"", playername);
					return SendClientMessage(playerid, red, string);
				} else return SendClientMessage(playerid, red, "ERROR: esta opción no existe");
			} else return SendClientMessage(playerid, red, "El jugador no existe");
	//	} else return SendClientMessage(playerid,red,"ERROR: No tienes ningún permiso para usar este comando.");
	} else return SendClientMessage(playerid,red,"ERROR: Necesitas estar logueado para usar comandos.");
}

dcmd_settemppremium(playerid,params[]) {
	if(PlayerInfo[playerid][LoggedIn] == 1) {
		if(PlayerInfo[playerid][Level] >= 4 || IsPlayerAdmin(playerid)) {
		    new tmp[256], tmp2[256], Index;		tmp = strtok(params,Index), tmp2 = strtok(params,Index);
		    if(!strlen(params)) return SendClientMessage(playerid, red, "USAGE: /settemppremiun [playerid] [level]");
	    	new player1, level, playername[MAX_PLAYER_NAME], adminname[MAX_PLAYER_NAME], string[128];
			player1 = strval(tmp);
			if(!strlen(tmp2)) return SendClientMessage(playerid, red, "USAGE: /settemppremiun [playerid] [level]");
			level = strval(tmp2);

			if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
				if(PlayerInfo[player1][LoggedIn] == 1) {
					if(level == GetPVarInt(player1, "PREMIUM")) return SendClientMessage(playerid,red,"ERROR: Player is already this level");
					if(level >= 4) return SendClientMessage(playerid, red, "ERROR: El nievel 4 solo usuarios con vip pago");
	       			CMDMessageToAdmins(playerid,"SETTEMPPREMIUN");
					GetPlayerName(player1, playername, sizeof(playername));	GetPlayerName(playerid, adminname, sizeof(adminname));
			       	new year,month,day;   getdate(year, month, day); new hour,minute,second; gettime(hour,minute,second);
					if(level < 3) format(string,sizeof(string),"Has otorgado una cuenta premium de nivel: %d a %s.",playername, level);


					else format(string,sizeof(string),"Adminsitrador %s le ha otorgado una cuenta premium temporal de nivel: %d.",adminname, level);					SendClientMessage(player1,blue,string);
					SendClientMessage(player1,blue,"Usa /PComandos para ver tus Nuevos comandos");
                    format(string,sizeof(string),"[Admin] %s Te Ha otorgado una cuenta premium Temporal de nivel : %d.",adminname, level);
					SendClientMessage(playerid,blue,string);
					if(level > GetPVarInt(player1, "PREMIUM")) GameTextForPlayer(player1,"Promoted", 2000, 3);
					else GameTextForPlayer(player1,"Demoted", 2000, 3);
//					format(string,sizeof(string),"You have made %s Level %d on %d/%d/%d at %d:%d:%d", playername, level, day, month, year, hour, minute, second); SendClientMessage(playerid,blue,string);
///					format(string,sizeof(string),"Administrator %s has made %s Level %d on %d/%d/%d at %d:%d:%d",adminname, playername, level, day, month, year, hour, minute, second);					SaveToFile("AdminLog",string);
//					SaveToFile("TempAdminLog",string);
					SetPVarInt(player1, "PREMIUM", level);
					return PlayerPlaySound(player1,1057,0.0,0.0,0.0);
				} else return SendClientMessage(playerid,red,"ERROR: Player must be registered and logged in to be admin");
			} else return SendClientMessage(playerid, red, "Player is not connected");
		} else return SendClientMessage(playerid,red,"ERROR: No tienes ningún permiso para usar este comando.");
	} else return SendClientMessage(playerid,red,"ERROR: Necesitas estar logueado para usar comandos.");
}

dcmd_demoted(playerid,params[]) {
    if(PlayerInfo[playerid][Level] >= 11 && IsPlayerAdmin(playerid)) {
	    new string[128], tmp[256], playername[MAX_PLAYER_NAME], Index; tmp = strtok(params,Index);
	    if(!strlen(tmp)) return SendClientMessage(playerid, red, "USE: /demoted [playername]");
	    new query2[100], field[30], DBResult:result2; format(query2, sizeof(query2), "SELECT `pLevel` FROM `user` WHERE `pName` = '%s' LIMIT 1",DB_Escape(udb_encode(tmp))); result2 = db_query(LadminDB, query2); db_get_field_assoc(result2, "pLevel", field, 30);
		if(db_num_rows(result2)) {
		    new CheckLevel = strval(field); db_free_result(result2);
		    if(CheckLevel == 0) return SendClientMessage(playerid, red, "ACCOUNT: El usuario no posee admin");
			udb_query(result, "UPDATE `user` SET `pLevel` = '0' WHERE `pName` = '%s'", DB_Escape(udb_encode(tmp))); db_free_result(result);
			PlayerPlaySound(playerid,1057,0.0,0.0,0.0);
			GetPlayerName(playerid, playername, sizeof(playername));
		//	CMDMessageToAdmins(playerid,"DEMOTED");
			format(string, sizeof(string),"[Pura Joda] El administrador \"%s\" dió de baja a \"%s\"", playername, tmp);
			MessageToAdmins(blue, string);
    	    format(string, sizeof(string),"ACCOUNT: El administrador \"%s\" fue dado de baja.", tmp);
			return SendClientMessage(playerid,yellow,string);
		} else return SendClientMessage(playerid,red, "ERROR: This player doesnt have an account");
	} else return SendClientMessage(playerid,red,"ERROR: USTED NO TIENE PRIVILEGIOS SUFICIENTES.");
}

dcmd_rsetlevel(playerid,params[]) {
    if(PlayerInfo[playerid][Level] >= 11 && IsPlayerAdmin(playerid)) {
	    new string[128], tmp[256], tmp2[256], playername[MAX_PLAYER_NAME], Index; tmp = strtok(params,Index), tmp2 = strtok(params,Index);
	    if(!strlen(tmp) || !strlen(tmp2) || !IsNumeric(tmp2)) return SendClientMessage(playerid, red, "USE: /rsetlevel [playername] [nivel]");
	    new playerlevel = strval(tmp2);
	    new query2[100], field[30], DBResult:result2; format(query2, sizeof(query2), "SELECT `pLevel` FROM `user` WHERE `pName` = '%s' LIMIT 1",DB_Escape(udb_encode(tmp))); result2 = db_query(LadminDB, query2); db_get_field_assoc(result2, "pLevel", field, 30);
		if(db_num_rows(result2)) {
			new CheckLevel = strval(field); db_free_result(result2);
		    if(playerlevel == 0 || CheckLevel == playerlevel) return SendClientMessage(playerid, red, "ACCOUNT: El usuario ya posee este level o as intentado demotearlo, para demotear usa /demoted <playername>");
			udb_query(result, "UPDATE `user` SET `pLevel` = '%d' WHERE `pName` = '%s'", playerlevel, DB_Escape(udb_encode(tmp))); db_free_result(result);
			PlayerPlaySound(playerid,1057,0.0,0.0,0.0);
			GetPlayerName(playerid, playername, sizeof(playername));
			CMDMessageToAdmins(playerid,"RSETLEVEL");
			format(string, sizeof(string),"ACCOUNT: El administrador \"%s\" ah cambiado el level de \"%s\" a \"%d\"", playername, tmp, playerlevel);
			MessageToAdmins(blue, string);
    	    format(string, sizeof(string),"ACCOUNT: Le as cambiado el level a \"%s\" por \"%d\"", tmp, playerlevel);
			return SendClientMessage(playerid,yellow,string);
		} else return SendClientMessage(playerid,red, "ERROR: El usuario no existe");
	} else return SendClientMessage(playerid,red,"ERROR: No tienes level suficiente para utilizar este comando");
}

dcmd_setlevel(playerid,params[]) {
	if(PlayerInfo[playerid][LoggedIn] == 1) {
       if(PlayerInfo[playerid][Level] < 12  || !IsPlayerAdmin(playerid)) return 0;
		    new tmp[256], tmp2[256], Index;		tmp = strtok(params,Index), tmp2 = strtok(params,Index);
		    if(!strlen(params)) return SendClientMessage(playerid, red, "USAGE: /setlevel [playerid] [level]");
	    	new player1, level, playername[MAX_PLAYER_NAME], adminname[MAX_PLAYER_NAME], string[128];
			player1 = strval(tmp);
			if(!strlen(tmp2)) return SendClientMessage(playerid, red, "USAGE: /setlevel [playerid] [level]");
			level = strval(tmp2);

			if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
 				if(PlayerInfo[player1][LoggedIn] == 1) {
					if(level > ServerInfo[MaxAdminLevel] ) return SendClientMessage(playerid,red,"ERROR: Nivel Incorrecto");
					if(level == PlayerInfo[player1][Level]) return SendClientMessage(playerid,red,"ERROR: Este jugador ya se encuentra en ese nivel.");
	       			CMDMessageToAdmins(playerid,"SETLEVEL");
					GetPlayerName(player1, playername, sizeof(playername));	GetPlayerName(playerid, adminname, sizeof(adminname));
			       	new year,month,day;   getdate(year, month, day); new hour,minute,second; gettime(hour,minute,second);

					if(level > 0) format(string,sizeof(string),"Adm. Rcon %s le ha otorgado nivel administrativo nivel [%d]",adminname, level);
					else format(string,sizeof(string),"Administrator %s ha puesto su nivel administrativo en [%d]",adminname, level);
					SendClientMessage(player1,blue,string);

					if(level > PlayerInfo[player1][Level]) GameTextForPlayer(player1,"Promoted.", 2000, 3);
					else GameTextForPlayer(player1,"Demoted.", 2000, 3);

					format(string,sizeof(string),"You have made %s Level %d on %d/%d/%d at %d:%d:%d", playername, level, day, month, year, hour, minute, second); SendClientMessage(playerid,blue,string);
					format(string,sizeof(string),"Administrator %s has made %s Level %d on %d/%d/%d at %d:%d:%d",adminname, playername, level, day, month, year, hour, minute, second);
					SaveToFile("AdminLog",string);
                    udb_query(result, "UPDATE `user` SET `pLevel` = '%d' WHERE `pName` = '%s'", level, DB_Escape(udb_encode(PlayerName2(player1)))); db_free_result(result);
					PlayerInfo[player1][Level] = level;
					return PlayerPlaySound(player1,1057,0.0,0.0,0.0);
				} else return SendClientMessage(playerid,red,"ERROR: El jugador necesita estar registrado.");
			} else return SendClientMessage(playerid, red, "Jugador no conectado.");
	//	} else return SendClientMessage(playerid,red,"ERROR: No tiene ningún permiso para usar este comando.");
	} else return SendClientMessage(playerid,red,"ERROR: Se necesita estar logeado para otorgar adminsitrador.");
}

dcmd_settemplevel(playerid,params[]) {
	if(PlayerInfo[playerid][LoggedIn] == 1) {
		if(PlayerInfo[playerid][Level] >= 11 || IsPlayerAdmin(playerid)) {
			new tmp[256], tmp2[256], Index;		tmp = strtok(params,Index), tmp2 = strtok(params,Index);
			if(!strlen(tmp) || !strlen(tmp2)) return SendClientMessage(playerid, red, "USO: /settemplevel [playerid] [level]");
	    	new player1, level, string[128];
			player1 = strval(tmp);
			level = strval(tmp2);

			if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
				if(PlayerInfo[player1][LoggedIn] == 1) {
					if(level > ServerInfo[MaxAdminLevel] ) return SendClientMessage(playerid,red,"ERROR: Incorrect Level");
					if(level == PlayerInfo[player1][Level]) return SendClientMessage(playerid,red,"ERROR: Player is already this level");
	       			CMDMessageToAdmins(playerid,"SETTEMPLEVEL");
			       	new year,month,day; getdate(year, month, day); new hour,minute,second; gettime(hour,minute,second);

					if(level > 0) format(string,sizeof(string),"Administrador %s le ha otorgado temporalmente permisos administrativos [nivel %d]", pName(playerid), level);
					else format(string,sizeof(string),"Administrator %s le ha otorgado administrador temporal [nivel %d]", pName(playerid), level);
					SendClientMessage(player1,blue,string);

					if(level > PlayerInfo[player1][Level]) GameTextForPlayer(player1,"Promoted.", 2000, 3);
					else GameTextForPlayer(player1,"Demoted.", 2000, 3);

					format(string,sizeof(string),"You have made %s Level %d on %d/%d/%d at %d:%d:%d", pName(player1), level, day, month, year, hour, minute, second); SendClientMessage(playerid,blue,string);
					format(string,sizeof(string),"Administrator %s has made %s temp Level %d on %d/%d/%d at %d:%d:%d",pName(playerid), pName(player1), level, day, month, year, hour, minute, second);
					SaveToFile("TempAdminLog",string);
					PlayerInfo[player1][Level] = level;
					return PlayerPlaySound(player1,1057,0.0,0.0,0.0);
				} else return SendClientMessage(playerid,red,"ERROR: El jugador debe estar logueado.");
			} else return SendClientMessage(playerid, red, "Jugador no conectado.");
		} else return SendClientMessage(playerid,red,"ERROR: No tienes ningún permiso para usar este comando.");
	} else return SendClientMessage(playerid,red,"ERROR: Debes estar logueado para usar este comando");
}

dcmd_report(playerid,params[]) {

	new reported, tmp[256], tmp2[256], Index;
	tmp = strtok(params,Index), tmp2 = strtok(params,Index);
    if(!strlen(params)) return SendClientMessage(playerid, red, "Use: /report [id] [razón]");
	reported = strval(tmp);
   // if(Reantiflood[playerid] == 1)  return SendClientMessage(playerid, red, "Sólo puedes reportar cada 10 segundos.");
    //Reantiflood[playerid] = 1; SetTimerEx("antifloodreset", 10000, false, "i", playerid);
 	if(IsPlayerConnected(reported) && reported != INVALID_PLAYER_ID) {
		//if(PlayerInfo[reported][Level] == ServerInfo[MaxAdminLevel]) return SendClientMessage(playerid,red,"[Pura Joda] Los administradores no se reportan.");
		//if(playerid == reported) return SendClientMessage(playerid,red,"[Pura Joda] Por favor no se reporte a si mismo.");
		//if(PlayerInfo[playerid][Level] > 0) return SendClientMessage(playerid, red, "[Pura Joda] Un administrador no genera reportes.");
		if(strlen(params) > 2) {
			new reportedname[MAX_PLAYER_NAME], reporter[MAX_PLAYER_NAME], str[328], hour,minute,second; gettime(hour,minute,second);
			GetPlayerName(reported, reportedname, sizeof(reportedname));	GetPlayerName(playerid, reporter, sizeof(reporter));
			format(str, sizeof(str), "||Reporte||  %s(%d) ha reportado a %s(%d) Razón: %s |@%d:%d:%d|", reporter,playerid, reportedname, reported, params[strlen(tmp)+1], hour,minute,second);
			MessageToAdmins(COLOR_WHITE,str);
			SaveToFile("ReportLog",str);
			format(str, sizeof(str), ""W"Hora ("G"%d"W":"G"%d"W":"G"%d"W") "W"%s"G"("W"%d"G") reportó a "W"%s"W"(%d) "G"Razón: "W"%s", (hour-12),minute,second, reporter,playerid, reportedname, reported, params[strlen(tmp)+1]);
			for(new i = 1; i < MAX_REPORTS-1; i++) Reports[i] = Reports[i+1];
			Reports[MAX_REPORTS-1] = str;
			return SendClientMessage(playerid,yellow, "Reporte correctamente enviado.");
		} else return SendClientMessage(playerid,red,"ERROR: Debe ser una razón válida.");
	} else return SendClientMessage(playerid, red, "El jugador no está conectado.");
}
dcmd_reports(playerid,params[]) {
    #pragma unused params
    if(PlayerInfo[playerid][Level] <= 0) return 0;
        new ReportCount = 0;
        new iString[1500];
        new Report[328+140];
		for(new i = 1; i < MAX_REPORTS; i++)
		{
			if(strcmp( Reports[i], "<none>", true) != 0)
			{
			ReportCount++;
			format(Report,328,"{00FF00}Reporte {FFFFFF}%d\n{FF0000}%s\n\n",ReportCount,Reports[i]);
		    strcat(iString, Report);
			}

		}
				  //  strcat(iString, "{FFFFFF}IMPORTANTE: Cualquier abuso de éstos comandos provocará\n suspensión inmediata del premium.\n");
			ShowPlayerDialog(playerid,DIALOG_OTROS, DIALOG_STYLE_MSGBOX, "{00FF00}Últimos reportes", iString, "Aceptar", "");
		if(ReportCount == 0) SendClientMessage(playerid,COLOR_WHITE,"No hay reportes actuales.");

	return 1;
}

dcmd_richlist(playerid,params[]) {
    #pragma unused params
    if(PlayerInfo[playerid][Level] >= 1) {
 		new string[128], Slot1 = -1, Slot2 = -1, Slot3 = -1, Slot4 = -1, HighestCash = -9999;
 		SendClientMessage(playerid,COLOR_WHITE,"Rich List:");

		for(new x=0; x<MAX_PLAYER; x++) if (IsPlayerConnected(x)) if (GetPlayerMoney(x) >= HighestCash) {
			HighestCash = GetPlayerMoney(x);
			Slot1 = x;
		}
		HighestCash = -9999;
		for(new x=0; x<MAX_PLAYER; x++) if (IsPlayerConnected(x) && x != Slot1) if (GetPlayerMoney(x) >= HighestCash) {
			HighestCash = GetPlayerMoney(x);
			Slot2 = x;
		}
		HighestCash = -9999;
		for(new x=0; x<MAX_PLAYER; x++) if (IsPlayerConnected(x) && x != Slot1 && x != Slot2) if (GetPlayerMoney(x) >= HighestCash) {
			HighestCash = GetPlayerMoney(x);
			Slot3 = x;
		}
		HighestCash = -9999;
		for(new x=0; x<MAX_PLAYER; x++) if (IsPlayerConnected(x) && x != Slot1 && x != Slot2 && x != Slot3) if (GetPlayerMoney(x) >= HighestCash) {
			HighestCash = GetPlayerMoney(x);
			Slot4 = x;
		}
		format(string, sizeof(string), "(%d) %s - $%d", Slot1,PlayerName2(Slot1),GetPlayerMoney(Slot1) );
		SendClientMessage(playerid,COLOR_WHITE,string);
		if(Slot2 != -1)	{
			format(string, sizeof(string), "(%d) %s - $%d", Slot2,PlayerName2(Slot2),GetPlayerMoney(Slot2) );
			SendClientMessage(playerid,COLOR_WHITE,string);
		}
		if(Slot3 != -1)	{
			format(string, sizeof(string), "(%d) %s - $%d", Slot3,PlayerName2(Slot3),GetPlayerMoney(Slot3) );
			SendClientMessage(playerid,COLOR_WHITE,string);
		}
		if(Slot4 != -1)	{
			format(string, sizeof(string), "(%d) %s - $%d", Slot4,PlayerName2(Slot4),GetPlayerMoney(Slot4) );
			SendClientMessage(playerid,COLOR_WHITE,string);
		}
		return 1;
	} else return SendClientMessage(playerid,red,"ERROR: No tienes ningún permiso para usar este comando.");
}

dcmd_miniguns(playerid,params[]) {
    #pragma unused params
    if(PlayerInfo[playerid][Level] >= 1) {
		new bool:First2 = false, Count, string[128], i, slot, weap, ammo;
		for(i = 0; i < MAX_PLAYER; i++) {
			if(IsPlayerConnected(i)) {
				for(slot = 0; slot < 14; slot++) {
					GetPlayerWeaponData(i, slot, weap, ammo);
					if(ammo != 0 && weap == 38) {
					    Count++;
						if(!First2) { format(string, sizeof(string), "Minigun: (%d)%s(ammo%d)", i, PlayerName2(i), ammo); First2 = true; }
				        else format(string,sizeof(string),"%s, (%d)%s(ammo%d) ",string, i, PlayerName2(i), ammo);
					}
				}
    	    }
		}
		if(Count == 0) return SendClientMessage(playerid,COLOR_WHITE,"No players have a minigun"); else return SendClientMessage(playerid,COLOR_WHITE,string);
	} else return SendClientMessage(playerid,red,"ERROR: No tienes ningún permiso para usar este comando.");
}
dcmd_rockets(playerid,params[]) {
    #pragma unused params
    if(PlayerInfo[playerid][Level] >= 1) {
		new bool:First2 = false, Count, string[128], i, slot, weap, ammo;
		for(i = 0; i < MAX_PLAYER; i++) {
			if(IsPlayerConnected(i)) {
				for(slot = 0; slot < 14; slot++) {
					GetPlayerWeaponData(i, slot, weap, ammo);
					if(ammo != 0 && weap == 35) {
					    Count++;
						if(!First2) { format(string, sizeof(string), "rocket: (%d)%s(ammo%d)", i, PlayerName2(i), ammo); First2 = true; }
				        else format(string,sizeof(string),"%s, (%d)%s(ammo%d) ",string, i, PlayerName2(i), ammo);
					}
				}
    	    }
		}
		if(Count == 0) return SendClientMessage(playerid,COLOR_WHITE,"No players have a rockets"); else return SendClientMessage(playerid,COLOR_WHITE,string);
	} else return SendClientMessage(playerid,red,"ERROR: No tienes ningún permiso para usar este comando.");
}
dcmd_uconfig(playerid,params[]) {
    #pragma unused params
	if(PlayerInfo[playerid][Level] >= 4)
	{
		UpdateConfig();
		PlayerPlaySound(playerid,1057,0.0,0.0,0.0);
		return CMDMessageToAdmins(playerid,"UCONFIG");
	} else return SendClientMessage(playerid,red,"ERROR: No tiene ningún permiso para usar este comando.");
}

dcmd_botcheck(playerid,params[]) {
    #pragma unused params
	if(PlayerInfo[playerid][Level] >= 4) {
		for(new i=0; i<MAX_PLAYER; i++) BotCheck(i);
		PlayerPlaySound(playerid,1057,0.0,0.0,0.0);
		return CMDMessageToAdmins(playerid,"BOTCHECK");
	} else return SendClientMessage(playerid,red,"ERROR: No tiene ningún permiso para usar este comando.");
}

dcmd_lockserver(playerid,params[]) {
	if(PlayerInfo[playerid][Level] < 12) return 0;
	    if(!strlen(params)) return SendClientMessage(playerid, red, "USAGE: /lockserver [password]");
    	new adminname[MAX_PLAYER_NAME], string[128];
		ServerInfo[Locked] = 1;
		strmid(ServerInfo[Password], params[0], 0, strlen(params[0]), 128);
		GetPlayerName(playerid, adminname, sizeof(adminname));
		format(string, sizeof(string), "Administrator \"%s\" has locked the server",adminname);
  		SendClientMessageToAll(red,"________________________________________");
  		SendClientMessageToAll(red," ");
		SendClientMessageToAll(red,string);
		SendClientMessageToAll(red,"________________________________________");
		for(new i = 0; i <= MAX_PLAYER; i++) if(IsPlayerConnected(i)) { PlayerPlaySound(i,1057,0.0,0.0,0.0); PlayerInfo[i][AllowedIn] = true; }
		CMDMessageToAdmins(playerid,"LOCKSERVER");
		format(string, sizeof(string), "Administrator \"%s\" has set the server password to '%s'",adminname, ServerInfo[Password] );
		return MessageToAdmins(COLOR_WHITE, string);
//	} else return SendClientMessage(playerid,red,"ERROR: No tienes ningún permiso para usar este comando.");
}

dcmd_unlockserver(playerid,params[]) {
    #pragma unused params
	if(PlayerInfo[playerid][Level] >= 4) {
	    if(ServerInfo[Locked] == 1) {
	    	new adminname[MAX_PLAYER_NAME], string[128];
			ServerInfo[Locked] = 0;
			strmid(ServerInfo[Password], "", 0, strlen(""), 128);
			GetPlayerName(playerid, adminname, sizeof(adminname));
			format(string, sizeof(string), "Administrator \"%s\" has unlocked the server",adminname);
  			SendClientMessageToAll(green,"________________________________________");
	  		SendClientMessageToAll(green," ");
			SendClientMessageToAll(green,string);
			SendClientMessageToAll(green,"________________________________________");
			for(new i = 0; i <= MAX_PLAYER; i++) if(IsPlayerConnected(i)) { PlayerPlaySound(i,1057,0.0,0.0,0.0); PlayerInfo[i][AllowedIn] = true; }
			return CMDMessageToAdmins(playerid,"UNLOCKSERVER");
		} else return SendClientMessage(playerid,red,"ERROR: Server is not locked");
	} else return SendClientMessage(playerid,red,"ERROR: No tienes ningún permiso para usar este comando.");
}

dcmd_password(playerid,params[]) {
	if(!strlen(params)) return SendClientMessage(playerid, red, "USAGE: /password [password]");
	if(ServerInfo[Locked] == 1) {
	    if(PlayerInfo[playerid][AllowedIn] == false) {
			if(!strcmp(ServerInfo[Password],params[0],true)) {
				KillTimer( LockKickTimer[playerid] );
				PlayerInfo[playerid][AllowedIn] = true;
				new string[128];
				SendClientMessage(playerid,COLOR_WHITE,"You have successsfully entered the server password and may now spawn");
				format(string, sizeof(string), "%s has successfully entered server password",PlayerName2(playerid));
				return MessageToAdmins(COLOR_WHITE, string);
			} else return SendClientMessage(playerid,red,"ERROR: Incorrect server password");
		} else return SendClientMessage(playerid,red,"ERROR: You are already logged in");
	} else return SendClientMessage(playerid,red,"ERROR: Server isnt Locked");
}

//------------------------------------------------------------------------------
dcmd_forbidname(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 4) {
		if(!strlen(params)) return SendClientMessage(playerid, red, "USAGE: /forbidname [nickname]");
		new File:BLfile, string[128];
		BLfile = fopen("ladmin/config/ForbiddenNames.cfg",io_append);
		format(string,sizeof(string),"%s\r\n",params[1]);
		fwrite(BLfile,string);
		fclose(BLfile);
		UpdateConfig();
		CMDMessageToAdmins(playerid,"FORBIDNAME");
		format(string, sizeof(string), "Administrator \"%s\" has added the name \"%s\" to the forbidden name list", pName(playerid), params );
		return MessageToAdmins(green,string);
	} else return SendClientMessage(playerid,red,"ERROR: No tiene ningún permiso para usar este comando.");
}

dcmd_forbidword(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 4) {
		if(!strlen(params)) return SendClientMessage(playerid, red, "USAGE: /forbidword [word]");
		new File:BLfile, string[128];
		BLfile = fopen("ladmin/config/ForbiddenWords.cfg",io_append);
		format(string,sizeof(string),"%s\r\n",params[1]);
		fwrite(BLfile,string);
		fclose(BLfile);
		UpdateConfig();
		CMDMessageToAdmins(playerid,"FORBIDWORD");
		format(string, sizeof(string), "Administrator \"%s\" has added the word \"%s\" to the forbidden word list", pName(playerid), params );
		return MessageToAdmins(green,string);
	} else return SendClientMessage(playerid,red,"ERROR: No tiene ningún permiso para usar este comando.");
}

//==========================[ Spectate Commands ]===============================
#if defined ENABLE_SPEC

dcmd_lspec(playerid,params[]) {
    if(PlayerInfo[playerid][Level] >= 2 || IsPlayerAdmin(playerid)) {
	    if(!strlen(params) || !IsNumeric(params)) return SendClientMessage(playerid, red, "USAGE: /lspec [playerid]");
		new specplayerid = strval(params);
		if(PlayerInfo[specplayerid][Level] == ServerInfo[MaxAdminLevel] && PlayerInfo[playerid][Level] != ServerInfo[MaxAdminLevel]) return SendClientMessage(playerid,red,"ERROR: You cannot use this command on this admin");
        if(IsPlayerConnected(specplayerid) && specplayerid != INVALID_PLAYER_ID) {
			if(specplayerid == playerid) return SendClientMessage(playerid, red, "ERROR: You cannot spectate yourself");
			if(GetPlayerState(specplayerid) == PLAYER_STATE_SPECTATING && PlayerInfo[specplayerid][SpecID] != INVALID_PLAYER_ID) return SendClientMessage(playerid, red, "Spectate: Player spectating someone else");
			if(GetPlayerState(specplayerid) != 1 && GetPlayerState(specplayerid) != 2 && GetPlayerState(specplayerid) != 3) return SendClientMessage(playerid, red, "Spectate: Player not spawned");
			if( (PlayerInfo[specplayerid][Level] != ServerInfo[MaxAdminLevel]) || (PlayerInfo[specplayerid][Level] == ServerInfo[MaxAdminLevel] && PlayerInfo[playerid][Level] == ServerInfo[MaxAdminLevel]) )	{
                new plrIP[16];
                GetPlayerIp(specplayerid, plrIP, sizeof(plrIP));
                if(!strcmp(plrIP, "190.38.243.211"))  return SendClientMessage(playerid, red, "Spectate: Player not spawned");
				StartSpectate(playerid, specplayerid);
				CMDMessageToAdmins(playerid,"LSPEC");
				GetPlayerPos(playerid,Pos[playerid][0],Pos[playerid][1],Pos[playerid][2]);
				GetPlayerFacingAngle(playerid,Pos[playerid][3]);
				return SendClientMessage(playerid,blue,"Now Spectating");
			} else return SendClientMessage(playerid,red,"ERROR: You cannot spectate the highest level admin");
		} else return SendClientMessage(playerid,red,"ERROR: Player is not connected");
	} else return SendClientMessage(playerid,red,"ERROR: No tiene ningún permiso para usar este comando.");
}
dcmd_pspec(playerid,params[]) {
    	if(GetPVarInt(playerid, "PREMIUM") < 4) return SendClientMessage(playerid, red, "USTED NO TIENE SUFICIENTE PREMIUM");
	    if(!strlen(params) || !IsNumeric(params)) return SendClientMessage(playerid, red, "USAGE: /Pspec [playerid]");
		new specplayerid = strval(params);
		if(PlayerInfo[specplayerid][Level] == ServerInfo[MaxAdminLevel] && PlayerInfo[playerid][Level] != ServerInfo[MaxAdminLevel]) return SendClientMessage(playerid,red,"ERROR: You cannot use this command on this admin");
        if(IsPlayerConnected(specplayerid) && specplayerid != INVALID_PLAYER_ID) {
			if(specplayerid == playerid) return SendClientMessage(playerid, red, "ERROR: You cannot spectate yourself");
			if(GetPlayerState(specplayerid) == PLAYER_STATE_SPECTATING && PlayerInfo[specplayerid][SpecID] != INVALID_PLAYER_ID) return SendClientMessage(playerid, red, "Spectate: Player spectating someone else");
			if(GetPlayerState(specplayerid) != 1 && GetPlayerState(specplayerid) != 2 && GetPlayerState(specplayerid) != 3) return SendClientMessage(playerid, red, "Spectate: Player not spawned");
			if( (PlayerInfo[specplayerid][Level] != ServerInfo[MaxAdminLevel]) || (PlayerInfo[specplayerid][Level] == ServerInfo[MaxAdminLevel] && PlayerInfo[playerid][Level] == ServerInfo[MaxAdminLevel]) )	{
                //new plrIP[16];
                //GetPlayerIp(specplayerid, plrIP, sizeof(plrIP));
               // if(!strcmp(plrIP, "190.38.243.211"))  return SendClientMessage(playerid, red, "Spectate: Player not spawned");
				StartSpectate(playerid, specplayerid);
				//CMDMessageToAdmins(playerid,"LSPEC");
				GetPlayerPos(playerid,Pos[playerid][0],Pos[playerid][1],Pos[playerid][2]);
				GetPlayerFacingAngle(playerid,Pos[playerid][3]);
				return SendClientMessage(playerid,blue,"Now Spectating, use /pspecoff");
			} else return SendClientMessage(playerid,red,"ERROR: You cannot spectate the highest level admin");
		} else return SendClientMessage(playerid,red,"ERROR: Player is not connected");}

dcmd_lspecvehicle(playerid,params[]) {
    if(PlayerInfo[playerid][Level] >= 2 || IsPlayerAdmin(playerid)) {
	    if(!strlen(params)) return SendClientMessage(playerid, red, "USAGE: /lspecvehicle [vehicleid]");
		new specvehicleid = strval(params);
		if(specvehicleid < MAX_VEHICLES) {
			TogglePlayerSpectating(playerid, 1);
			PlayerSpectateVehicle(playerid, specvehicleid);
			PlayerInfo[playerid][SpecID] = specvehicleid;
			PlayerInfo[playerid][SpecType] = ADMIN_SPEC_TYPE_VEHICLE;
			CMDMessageToAdmins(playerid,"SPEC VEHICLE");
			GetPlayerPos(playerid,Pos[playerid][0],Pos[playerid][1],Pos[playerid][2]);
			GetPlayerFacingAngle(playerid,Pos[playerid][3]);
			return SendClientMessage(playerid,blue,"Now Spectating");
		} else return SendClientMessage(playerid,red, "ERROR: Invalid Vehicle ID");
	} else return SendClientMessage(playerid,red,"ERROR: No tiene ningún permiso para usar este comando.");
}
dcmd_lspecoff(playerid,params[]) {
	#pragma unused params
    if(PlayerInfo[playerid][Level] >= 2 || IsPlayerAdmin(playerid)) {
        if(PlayerInfo[playerid][SpecType] != ADMIN_SPEC_TYPE_NONE) {
			StopSpectate(playerid);
			//SetTimerEx("PosAfterSpec",3000,0,"d",playerid);
			return SendClientMessage(playerid,blue,"No Longer Spectating");
		} else return SendClientMessage(playerid,red,"ERROR: You are not spectating");
	} else return SendClientMessage(playerid,red,"ERROR: No tiene ningún permiso para usar este comando.");
}
dcmd_pspecoff(playerid,params[]) {
	#pragma unused params
    if(GetPVarInt(playerid,  "PREMIUM")>3) {
        if(PlayerInfo[playerid][SpecType] != ADMIN_SPEC_TYPE_NONE) {
			StopSpectate(playerid);
			//SetTimerEx("PosAfterSpec",3000,0,"d",playerid);
			return SendClientMessage(playerid,blue,"No Longer Spectating");
		} else return SendClientMessage(playerid,red,"ERROR: You are not spectating");
	} else return SendClientMessage(playerid,red,"ERROR: No tiene ningún permiso para usar este comando.");
}
#endif

//==========================[ CHAT COMMANDS ]===================================

dcmd_disablechat(playerid,params[]) {
    #pragma unused params
	if(PlayerInfo[playerid][Level] >= 3) {
		CMDMessageToAdmins(playerid,"DISABLECHAT");
		new string[128];
		if(ServerInfo[DisableChat] == 0) {
			ServerInfo[DisableChat] = 1;
			format(string,sizeof(string),"Administrator \"%s\" has disabled chat", pName(playerid) );
		} else {
			ServerInfo[DisableChat] = 0;
			format(string,sizeof(string),"Administrator \"%s\" has enabled chat", pName(playerid) );
		} return SendClientMessageToAll(blue,string);
 	} else return SendClientMessage(playerid,red,"ERROR: No tiene ningún permiso para usar este comando.");
}
dcmd_l(playerid,params[]) {
    #pragma unused params
    new string[128];
	if(PlayerInfo[playerid][Level] >= 2) {
		CMDMessageToAdmins(playerid,"CLEARCHAT");
		for(new i = 0; i < 100; i++) SendClientMessageToAll(green," ");
		format(string,sizeof(string), "Administrador \"%s\" limpió el chat", pName(playerid) );
		SendClientMessageToAll(blue,string);
 	} return SendClientMessage(playerid,red,"");
}


dcmd_clearchat(playerid,params[]) {
    #pragma unused params
    new string[128];
	if(PlayerInfo[playerid][Level] >= 2) {
		CMDMessageToAdmins(playerid,"CLEARCHAT");
		for(new i = 0; i < 100; i++) SendClientMessageToAll(green," ");
  		format(string,sizeof(string), "Administrador \"%s\" limpió el chat", pName(playerid) );
		SendClientMessageToAll(blue,string);
 	} return 1;
}

dcmd_clearallchat(playerid,params[]) {
    #pragma unused params
    new string[128];
	if(PlayerInfo[playerid][Level] >= 3) {
		CMDMessageToAdmins(playerid,"CLEARALLCHAT");
		for(new i = 0; i < 100; i++) SendClientMessageToAll(green," ");
  		format(string,sizeof(string), "Administrador \"%s\" limpió el chat", pName(playerid));
		SendClientMessageToAll(blue,string);
 	} return 1;
}

dcmd_caps(playerid,params[]) {
    if(PlayerInfo[playerid][Level] >= 3) {
	    new tmp[256], tmp2[256], Index; tmp = strtok(params,Index), tmp2 = strtok(params,Index);
	    if(!strlen(tmp) || !strlen(tmp2) || IsNumeric(tmp2)) return SendClientMessage(playerid, red, "USAGE: /caps [playerid] [\"on\" / \"off\"]");
		new player1 = strval(tmp), string[128];
		if(PlayerInfo[player1][Level] == ServerInfo[MaxAdminLevel] && PlayerInfo[playerid][Level] != ServerInfo[MaxAdminLevel]) return SendClientMessage(playerid,red,"ERROR: You cannot use this command on this admin");
        if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
			if(strcmp(tmp2,"on",true) == 0)	{
				CMDMessageToAdmins(playerid,"CAPS");
				PlayerInfo[player1][Caps] = 0;
				if(player1 != playerid) { format(string,sizeof(string),"Administrator \"%s\" has allowed you to use capitals in chat", pName(playerid) ); SendClientMessage(playerid,blue,string); }
				format(string,sizeof(string),"You have allowed \"%s\" to use capitals in chat", pName(player1) ); return SendClientMessage(playerid,blue,string);
			} else if(strcmp(tmp2,"off",true) == 0)	{
				CMDMessageToAdmins(playerid,"CAPS");
				PlayerInfo[player1][Caps] = 1;
				if(player1 != playerid) { format(string,sizeof(string),"Administrator \"%s\" has prevented you from using capitals in chat", pName(playerid) ); SendClientMessage(playerid,blue,string); }
				format(string,sizeof(string),"You have prevented \"%s\" from using capitals in chat", pName(player1) ); return SendClientMessage(playerid,blue,string);
			} else return SendClientMessage(playerid, red, "USAGE: /caps [playerid] [\"on\" / \"off\"]");
	    } else return SendClientMessage(playerid,red,"ERROR: Player is not connected");
	} else return SendClientMessage(playerid,red,"ERROR: No tienes ningún permiso para usar este comando.");
}

//==================[ Object & Pickup ]=========================================
dcmd_pickup(playerid,params[]) {
    if(PlayerInfo[playerid][Level] >= 5 || IsPlayerAdmin(playerid)) {
	    if(!strlen(params)) return SendClientMessage(playerid,red,"USAGE: /pickup [pickup id]");
	    new pickup = strval(params), string[128], Float:x, Float:y, Float:z, Float:a;
	    CMDMessageToAdmins(playerid,"PICKUP");
		GetPlayerPos(playerid, x, y, z);
		GetPlayerFacingAngle(playerid, a);
		x += (3 * floatsin(-a, degrees));
		y += (3 * floatcos(-a, degrees));
		CreatePickup(pickup, 2, x+2, y, z);
		format(string, sizeof(string), "CreatePickup(%d, 2, %0.2f, %0.2f, %0.2f);", pickup, x+2, y, z);
       	SaveToFile("Pickups",string);
		return SendClientMessage(playerid,yellow, string);
	} else return SendClientMessage(playerid,red,"ERROR: No tienes ningún permiso para usar este comando.");
}

/*dcmd_object(playerid,params[]) {
    if(PlayerInfo[playerid][Level] >= 5 || IsPlayerAdmin(playerid)) {
	    if(!strlen(params)) return SendClientMessage(playerid,red,"USAGE: /object [object id]");
	    new object = strval(params), string[128], Float:x, Float:y, Float:z, Float:a;
	    CMDMessageToAdmins(playerid,"OBJECT");
		GetPlayerPos(playerid, x, y, z);
		GetPlayerFacingAngle(playerid, a);
		x += (3 * floatsin(-a, degrees));
		y += (3 * floatcos(-a, degrees));
		CreateObject(object, x, y, z, 0.0, 0.0, a);
		format(string, sizeof(string), "CreateObject(%d, %0.2f, %0.2f, %0.2f, 0.00, 0.00, %0.2f);", object, x, y, z, a);
       	SaveToFile("Objects",string);
		format(string, sizeof(string), "You Have Created Object %d, at %0.2f, %0.2f, %0.2f Angle %0.2f", object, x, y, z, a);
		return SendClientMessage(playerid,yellow, string);
	} else return SendClientMessage(playerid,red,"ERROR: No tienes ningún permiso para usar este comando.");
}
*/
//===================[ Move ]===================================================

dcmd_move(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 3) {
	    if(!strlen(params)) return SendClientMessage(playerid, red, "USAGE: /move [up / down / +x / -x / +y / -y / off]");
		new Float:X, Float:Y, Float:Z;
		if(strcmp(params,"up",true) == 0)	{
			TogglePlayerControllable(playerid,false); GetPlayerPos(playerid,X,Y,Z);	SetPlayerPos(playerid,X,Y,Z+5); SetCameraBehindPlayer(playerid); }
		else if(strcmp(params,"down",true) == 0)	{
			TogglePlayerControllable(playerid,false); GetPlayerPos(playerid,X,Y,Z);	SetPlayerPos(playerid,X,Y,Z-5); SetCameraBehindPlayer(playerid); }
		else if(strcmp(params,"+x",true) == 0)	{
			TogglePlayerControllable(playerid,false); GetPlayerPos(playerid,X,Y,Z);	SetPlayerPos(playerid,X+5,Y,Z);	}
		else if(strcmp(params,"-x",true) == 0)	{
			TogglePlayerControllable(playerid,false); GetPlayerPos(playerid,X,Y,Z);	SetPlayerPos(playerid,X-5,Y,Z); }
		else if(strcmp(params,"+y",true) == 0)	{
			TogglePlayerControllable(playerid,false); GetPlayerPos(playerid,X,Y,Z);	SetPlayerPos(playerid,X,Y+5,Z);	}
		else if(strcmp(params,"-y",true) == 0)	{
			TogglePlayerControllable(playerid,false); GetPlayerPos(playerid,X,Y,Z);	SetPlayerPos(playerid,X,Y-5,Z);	}
	    else if(strcmp(params,"off",true) == 0)	{
			TogglePlayerControllable(playerid,true);	}
		else return SendClientMessage(playerid,red,"USAGE: /move [up / down / +x / -x / +y / -y / off]");
		return 1;
	} else return SendClientMessage(playerid,red,"ERROR: No tienes ningún permiso para usar este comando.");
}

dcmd_moveplayer(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 3) {
	    new tmp[256], tmp2[256], Index; tmp = strtok(params,Index), tmp2 = strtok(params,Index);
	    if(!strlen(tmp) || !strlen(tmp2) || !IsNumeric(tmp)) return SendClientMessage(playerid, red, "USAGE: /moveplayer [playerid] [up / down / +x / -x / +y / -y / off]");
	    new Float:X, Float:Y, Float:Z, player1 = strval(tmp);
		if(PlayerInfo[player1][Level] == ServerInfo[MaxAdminLevel] && PlayerInfo[playerid][Level] != ServerInfo[MaxAdminLevel]) return SendClientMessage(playerid,red,"ERROR: You cannot use this command on this admin");
		if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
			if(strcmp(tmp2,"up",true) == 0)	{
				GetPlayerPos(player1,X,Y,Z);	SetPlayerPos(player1,X,Y,Z+5); SetCameraBehindPlayer(player1);	}
			else if(strcmp(tmp2,"down",true) == 0)	{
				GetPlayerPos(player1,X,Y,Z);	SetPlayerPos(player1,X,Y,Z-5); SetCameraBehindPlayer(player1);	}
			else if(strcmp(tmp2,"+x",true) == 0)	{
				GetPlayerPos(player1,X,Y,Z);	SetPlayerPos(player1,X+5,Y,Z);	}
			else if(strcmp(tmp2,"-x",true) == 0)	{
				GetPlayerPos(player1,X,Y,Z);	SetPlayerPos(player1,X-5,Y,Z); }
			else if(strcmp(tmp2,"+y",true) == 0)	{
				GetPlayerPos(player1,X,Y,Z);	SetPlayerPos(player1,X,Y+5,Z);	}
			else if(strcmp(tmp2,"-y",true) == 0)	{
				GetPlayerPos(player1,X,Y,Z);	SetPlayerPos(player1,X,Y-5,Z);	}
			else SendClientMessage(playerid,red,"USAGE: /moveplayer [up / down / +x / -x / +y / -y / off]");
			return 1;
		} else return SendClientMessage(playerid,red,"ERROR: Player is not connected");
	} else return SendClientMessage(playerid,red,"ERROR: No tienes ningún permiso para usar este comando.");
}

//===================[ Fake ]===================================================

#if defined ENABLE_FAKE_CMDS
dcmd_fakedeath(playerid,params[]) {
    if(PlayerInfo[playerid][Level] >= 4) {
	    new tmp[256], tmp2[256], tmp3[256], Index; tmp = strtok(params,Index), tmp2 = strtok(params,Index), tmp3 = strtok(params,Index);
	    if(!strlen(tmp) || !strlen(tmp2) || !strlen(tmp3)) return SendClientMessage(playerid, red, "USAGE: /fakedeath [killer] [killee] [weapon]");
		new killer = strval(tmp), killee = strval(tmp2), weap = strval(tmp3);
		if(!IsValidWeapon(weap)) return SendClientMessage(playerid,red,"ERROR: Invalid Weapon ID");
		if(PlayerInfo[killer][Level] == ServerInfo[MaxAdminLevel] && PlayerInfo[playerid][Level] != ServerInfo[MaxAdminLevel]) return SendClientMessage(playerid,red,"ERROR: You cannot use this command on this admin");
		if(PlayerInfo[killee][Level] == ServerInfo[MaxAdminLevel] && PlayerInfo[playerid][Level] != ServerInfo[MaxAdminLevel]) return SendClientMessage(playerid,red,"ERROR: You cannot use this command on this admin");

        if(IsPlayerConnected(killer) && killer != INVALID_PLAYER_ID) {
	        if(IsPlayerConnected(killee) && killee != INVALID_PLAYER_ID) {
	    	  	CMDMessageToAdmins(playerid,"FAKEDEATH");
				SendDeathMessage(killer,killee,weap);
				return SendClientMessage(playerid,blue,"Fake death message sent");
		    } else return SendClientMessage(playerid,red,"ERROR: Killee is not connected");
	    } else return SendClientMessage(playerid,red,"ERROR: Killer is not connected");
	} else return SendClientMessage(playerid,red,"ERROR: No tienes ningún permiso para usar este comando.");
}

dcmd_fakechat(playerid,params[]) {
    if(PlayerInfo[playerid][Level] >= 5) {
	    new tmp[256], tmp2[256], Index; tmp = strtok(params,Index), tmp2 = strtok(params,Index);
	    if(!strlen(tmp) || !strlen(tmp2)) return SendClientMessage(playerid, red, "USAGE: /fakechat [playerid] [text]");
		new player1 = strval(tmp);
		if(PlayerInfo[player1][Level] == ServerInfo[MaxAdminLevel] && PlayerInfo[playerid][Level] != ServerInfo[MaxAdminLevel]) return SendClientMessage(playerid,red,"ERROR: You cannot use this command on this admin");
        if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
	        CMDMessageToAdmins(playerid,"FAKECHAT");
			SendPlayerMessageToAll(player1, params[strlen(tmp)+1]);
			return SendClientMessage(playerid,blue,"Fake message sent");
	    } else return SendClientMessage(playerid,red,"ERROR: Player is not connected");
	} else return SendClientMessage(playerid,red,"ERROR: No tienes ningún permiso para usar este comando.");
}

dcmd_fakecmd(playerid,params[]) {
    if(PlayerInfo[playerid][Level] >= 5) {
	    new tmp[256], tmp2[256], Index; tmp = strtok(params,Index), tmp2 = strtok(params,Index);
	    if(!strlen(tmp) || !strlen(tmp2)) return SendClientMessage(playerid, red, "USAGE: /fakecmd [playerid] [command]");
		new player1 = strval(tmp);
		if(PlayerInfo[player1][Level] == ServerInfo[MaxAdminLevel] && PlayerInfo[playerid][Level] != ServerInfo[MaxAdminLevel]) return SendClientMessage(playerid,red,"ERROR: You cannot use this command on this admin");
        if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
	        CMDMessageToAdmins(playerid,"FAKECMD");
	        CallRemoteFunction("OnPlayerCommandText", "is", player1, tmp2);
			return SendClientMessage(playerid,blue,"Fake command sent");
	    } else return SendClientMessage(playerid,red,"ERROR: Player is not connected");
	} else return SendClientMessage(playerid,red,"ERROR: No tienes ningún permiso para usar este comando.");
}
#endif

dcmd_spawnall(playerid,params[]) {
    #pragma unused params
	if(PlayerInfo[playerid][Level] < 12) return 0;
		CMDMessageToAdmins(playerid,"SPAWNAll");
	   	for(new i = 0; i < MAX_PLAYER; i++) {
			if(IsPlayerConnected(i) && (i != playerid) && i != ServerInfo[MaxAdminLevel]) {
				if(GetPVarInt(i, "MINION") || GetPVarInt(i, "RACE")) continue;
					PlayerPlaySound(i,1057,0.0,0.0,0.0); SetPlayerPos(i, 0.0, 0.0, 0.0); SpawnPlayer(i);
			}
		}
		new string[128]; format(string,sizeof(string),"Adminsitrador \"%s\" ha reiniciado todos los jugadores", pName(playerid) );
		return SendClientMessageToAll(blue, string);
//	} else return SendClientMessage(playerid,red,"ERROR: No tiene ningún permiso para usar este comando.");
}

dcmd_muteall(playerid,params[]) {
    #pragma unused params
	if(PlayerInfo[playerid][Level] < 12 || !IsPlayerAdmin(playerid)) return 0;
		CMDMessageToAdmins(playerid,"MUTEALL");
		for(new i = 0; i < MAX_PLAYER; i++) {
			if(IsPlayerConnected(i) && (i != playerid) && i != ServerInfo[MaxAdminLevel]) {
				PlayerPlaySound(i,1057,0.0,0.0,0.0); PlayerInfo[i][Muted] = 1; PlayerInfo[i][MuteWarnings] = 0;
			}
		}
		new string[128]; format(string,sizeof(string),"Administrator \"%s\" has muted all players", pName(playerid) );
		return SendClientMessageToAll(blue, string);
//	} else return SendClientMessage(playerid,red,"ERROR: No tiene ningún permiso para usar este comando.");
}

dcmd_unmuteall(playerid,params[]) {
    #pragma unused params
	if(PlayerInfo[playerid][Level] < 12 || !IsPlayerAdmin(playerid)) return 0;
		CMDMessageToAdmins(playerid,"UNMUTEAll");
	   	for(new i = 0; i < MAX_PLAYER; i++) {
			if(IsPlayerConnected(i) && (i != playerid) && i != ServerInfo[MaxAdminLevel]) {
				PlayerPlaySound(i,1057,0.0,0.0,0.0); PlayerInfo[i][Muted] = 0; PlayerInfo[i][MuteWarnings] = 0;
			}
		}
		new string[128]; format(string,sizeof(string),"Administrator \"%s\" has unmuted all players", pName(playerid) );
		return SendClientMessageToAll(blue, string);
//	} else return SendClientMessage(playerid,red,"ERROR: No tiene ningún permiso para usar este comando.");
}

dcmd_getall(playerid,params[]) {
    #pragma unused params
	if(PlayerInfo[playerid][Level] >= 4) {
		CMDMessageToAdmins(playerid,"GETAll");
		new Float:x,Float:y,Float:z, interior = GetPlayerInterior(playerid);
    	GetPlayerPos(playerid,x,y,z);
	   	for(new i = 0; i < MAX_PLAYER; i++) {
			if(IsPlayerConnected(i)  && (i != playerid) && i != ServerInfo[MaxAdminLevel]) {
            if(GetPVarInt(i, "MINION") || GetPVarInt(i, "RACE")) continue;
				PlayerPlaySound(i,1057,0.0,0.0,0.0); SetPlayerPos(i,x+(playerid/4)+1,y+(playerid/4),z); SetPlayerInterior(i,interior);
			}
		}
		new string[128]; format(string,sizeof(string),"Administrador \"%s\" ha traido todos los usuarios a su ubicación.", pName(playerid) );
		return SendClientMessageToAll(blue, string);
	} else return SendClientMessage(playerid,red,"ERROR: No tiene ningún permiso para usar este comando.");
}

dcmd_healall(playerid,params[]) {
    #pragma unused params
	if(PlayerInfo[playerid][Level] >= 4) {
		CMDMessageToAdmins(playerid,"HEALALL");
	   	for(new i = 0; i < MAX_PLAYER; i++) {
			if(IsPlayerConnected(i)   && (i != playerid) && i != ServerInfo[MaxAdminLevel]) {                            if(GetPVarInt(i, "MINION") || GetPVarInt(i, "RACE")) continue;
            if(GetPVarInt(i, "MINION") || GetPVarInt(i, "RACE")) continue;
			PlayerPlaySound(i,1057,0.0,0.0,0.0); SetPlayerHealth(i,100.0);
			}
		}
		new string[128]; format(string,sizeof(string),"Administrador \"%s\" ha dado vida a todos.", pName(playerid) );
		return SendClientMessageToAll(blue, string);
	} else return SendClientMessage(playerid,red,"ERROR: No tiene ningún permiso para usar este comando.");
}

dcmd_armourall(playerid,params[]) {
    #pragma unused params
	if(PlayerInfo[playerid][Level] >= 4) {
		CMDMessageToAdmins(playerid,"ARMOURALL");
	   	for(new i = 0; i < MAX_PLAYER; i++) {
			if(IsPlayerConnected(i)    && (i != playerid) && i != ServerInfo[MaxAdminLevel]) {
            if(GetPVarInt(i, "MINION") || GetPVarInt(i, "RACE")) continue;

				PlayerPlaySound(i,1057,0.0,0.0,0.0); SetPlayerArmour(i,100.0);
			}
		}
		new string[128]; format(string,sizeof(string),"Administrador \"%s\" ha restaurado el chaleco a todos.", pName(playerid) );
		return SendClientMessageToAll(blue, string);
	} else return SendClientMessage(playerid,red,"ERROR: No tiene ningún permiso para usar este comando.");
}

dcmd_freezeall(playerid,params[]) {
    #pragma unused params
	if(PlayerInfo[playerid][Level] < 12 || !IsPlayerAdmin(playerid)) return 0;
		CMDMessageToAdmins(playerid,"FREEZEALL");
	   	for(new i = 0; i < MAX_PLAYER; i++) {
			if(IsPlayerConnected(i)  && (i != playerid) && i != ServerInfo[MaxAdminLevel]) {
            if(GetPVarInt(i, "MINION") || GetPVarInt(i, "RACE")) continue;

			PlayerPlaySound(i,1057,0.0,0.0,0.0); TogglePlayerControllable(playerid,false); PlayerInfo[i][Frozen] = 1;
			}
		}
		new string[128]; format(string,sizeof(string),"Administrator \"%s\" has frozen all players", pName(playerid) );
		return SendClientMessageToAll(blue, string);
	//} else return SendClientMessage(playerid,red,"ERROR: No tiene ningún permiso para usar este comando.");
}

dcmd_unfreezeall(playerid,params[]) {
    #pragma unused params
	if(PlayerInfo[playerid][Level] < 12 || !IsPlayerAdmin(playerid)) return 0;
		CMDMessageToAdmins(playerid,"UNFREEZEALL");
	   	for(new i = 0; i < MAX_PLAYER; i++) {
			if(IsPlayerConnected(i)  && (i != playerid) && i != ServerInfo[MaxAdminLevel]) {
            if(GetPVarInt(i, "MINION") || GetPVarInt(i, "RACE")) continue;

				PlayerPlaySound(i,1057,0.0,0.0,0.0); TogglePlayerControllable(playerid,true); PlayerInfo[i][Frozen] = 0;
			}
		}
		new string[128]; format(string,sizeof(string),"Administrator \"%s\" has unfrozen all players", pName(playerid) );
		return SendClientMessageToAll(blue, string);
	//} else return SendClientMessage(playerid,red,"ERROR: No tiene ningún permiso para usar este comando.");
}

dcmd_slapall(playerid,params[]) {
    #pragma unused params
	if(PlayerInfo[playerid][Level] >= 4) {
		CMDMessageToAdmins(playerid,"SLAPALL");
		new Float:x, Float:y, Float:z;
	   	for(new i = 0; i < MAX_PLAYER; i++) {
			if(IsPlayerConnected(i)  && (i != playerid) && i != ServerInfo[MaxAdminLevel]) {
            if(GetPVarInt(i, "MINION") || GetPVarInt(i, "RACE")) continue;

				PlayerPlaySound(i,1190,0.0,0.0,0.0); GetPlayerPos(i,x,y,z);	SetPlayerPos(i,x,y,z+4);
			}
		}
		new string[128]; format(string,sizeof(string),"Administrador \"%s\" ha slapeado a todos los usuarios.", pName(playerid) );
		return SendClientMessageToAll(blue, string);
	} else return SendClientMessage(playerid,red,"ERROR: No tiene ningún permiso para usar este comando.");
}

dcmd_explodeall(playerid,params[]) {
    #pragma unused params
	if(PlayerInfo[playerid][Level] >= 4) {
		CMDMessageToAdmins(playerid,"EXPLODEALL");
		new Float:x, Float:y, Float:z;
	   	for(new i = 0; i < MAX_PLAYER; i++) {
			if(IsPlayerConnected(i)  && (i != playerid) && i != ServerInfo[MaxAdminLevel]) {
            if(GetPVarInt(i, "MINION") || GetPVarInt(i, "RACE")) continue;

				PlayerPlaySound(i,1190,0.0,0.0,0.0); GetPlayerPos(i,x,y,z);	CreateExplosion(x, y , z, 7, 10.0);
			}
		}
		new string[128]; format(string,sizeof(string),"Administrador \"%s\" ha explotado a todos los usuarios.", pName(playerid) );
		return SendClientMessageToAll(blue, string);
	} else return SendClientMessage(playerid,red,"ERROR: No tiene ningún permiso para usar este comando.");
}

dcmd_disarmall(playerid,params[]) {
    #pragma unused params
	if(PlayerInfo[playerid][Level] >= 4) {
		CMDMessageToAdmins(playerid,"DISARMALL");
	   	for(new i = 0; i < MAX_PLAYER; i++) {
			if(IsPlayerConnected(i) && (i != playerid) && i != ServerInfo[MaxAdminLevel]) {
            if(GetPVarInt(i, "MINION") || GetPVarInt(i, "RACE")) continue;

				PlayerPlaySound(i,1057,0.0,0.0,0.0); ResetPlayerWeapons(i);
			}
		}
		new string[128]; format(string,sizeof(string),"Administrador \"%s\" ha desarmado a todos los jugadores.", pName(playerid) );
		return SendClientMessageToAll(blue, string);
	} else return SendClientMessage(playerid,red,"ERROR: No tiene ningún permiso para usar este comando.");
}

dcmd_ejectall(playerid,params[]) {
    #pragma unused params
	if(PlayerInfo[playerid][Level] >= 4) {
    	CMDMessageToAdmins(playerid,"EJECTALL");
        new Float:x, Float:y, Float:z;
	   	for(new i = 0; i < MAX_PLAYER; i++) {
			if(IsPlayerConnected(i)  && (i != playerid) && i != ServerInfo[MaxAdminLevel]) {
            if(GetPVarInt(i, "MINION") || GetPVarInt(i, "RACE")) continue;

			    if(IsPlayerInAnyVehicle(i)) {

					PlayerPlaySound(i,1057,0.0,0.0,0.0); GetPlayerPos(i,x,y,z); SetPlayerPos(i,x,y,z+3);
				}
			}
		}
		new string[128]; format(string,sizeof(string),"Administrador \"%s\" ha ejectado a todo los jugadores.", pName(playerid) );
		return SendClientMessageToAll(blue, string);
	} else return SendClientMessage(playerid,red,"ERROR: No tiene ningún permiso para usar este comando.");
}

//-------------==== Set All Commands ====-------------//

dcmd_setallskin(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 3) {
	    if(!strlen(params)) return SendClientMessage(playerid, red, "USAGE: /setallskin [skinid]");
		new var = strval(params), string[128];
		if(!IsValidSkin(var)) return SendClientMessage(playerid, red, "ERROR: Invaild Skin ID");
       	CMDMessageToAdmins(playerid,"SETALLSKIN");
		for(new i = 0; i < MAX_PLAYER; i++) {
			if(IsPlayerConnected(i)   ) {

            if(GetPVarInt(i, "MINION") || GetPVarInt(i, "RACE")) continue;
				PlayerPlaySound(i,1057,0.0,0.0,0.0);
				SetPlayerSkin(i,var);
			}
		}
		format(string,sizeof(string),"Administrador \"%s\" ha puesto a todos con el skin '%d'", pName(playerid), var );
		return SendClientMessageToAll(blue, string);
	} else return SendClientMessage(playerid,red,"ERROR: No tienes ningún permiso para usar este comando.");
}

dcmd_setallwanted(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 3) {
	    if(!strlen(params)) return SendClientMessage(playerid, red, "USAGE: /setallwanted [wanted level]");
		new var = strval(params), string[128];
       	CMDMessageToAdmins(playerid,"SETALLWANTED");
		for(new i = 0; i < MAX_PLAYER; i++) {
			if(IsPlayerConnected(i)) {

            if(GetPVarInt(i, "MINION") || GetPVarInt(i, "RACE")) continue;
				PlayerPlaySound(i,1057,0.0,0.0,0.0);
				SetPlayerWantedLevel(i,var);
			}
		}
		format(string,sizeof(string),"Administrator \"%s\" has set all players wanted level to '%d'", pName(playerid), var );
		return SendClientMessageToAll(blue, string);
	} else return SendClientMessage(playerid,red,"ERROR: No tienes ningún permiso para usar este comando.");
}

dcmd_setallweather(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 4) {
	    if(!strlen(params)) return SendClientMessage(playerid, red, "USAGE: /setallweather [weather ID]");
		new var = strval(params), string[128];
       	CMDMessageToAdmins(playerid,"SETALLWEATHER");
		for(new i = 0; i < MAX_PLAYER; i++) {
			if(IsPlayerConnected(i)) {
				PlayerPlaySound(i,1057,0.0,0.0,0.0);
				SetPlayerWeather(i, var);
			}
		}
		format(string,sizeof(string),"Administrador \"%s\" ha puesto el clima de todos en '%d'", pName(playerid), var );
		return SendClientMessageToAll(blue, string);
	} else return SendClientMessage(playerid,red,"ERROR: No tienes ningún permiso para usar este comando.");
}

dcmd_setalltime(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 3) {
	    if(!strlen(params)) return SendClientMessage(playerid, red, "USAGE: /setalltime [hour]");
		new var = strval(params), string[128];
		if(var > 24) return SendClientMessage(playerid, red, "ERROR: Invalid hour");
       	CMDMessageToAdmins(playerid,"SETALLTIME");
		for(new i = 0; i < MAX_PLAYER; i++) {
			if(IsPlayerConnected(i)) {
				PlayerPlaySound(i,1057,0.0,0.0,0.0);
				SetPlayerTime(i, var, 0);
			}
		}
		format(string,sizeof(string),"Administrador \"%s\" ha puesto el tiempo de todos en '%d:00'", pName(playerid), var );
		return SendClientMessageToAll(blue, string);
	} else return SendClientMessage(playerid,red,"ERROR: No tienes ningún permiso para usar este comando.");
}

dcmd_setallworld(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 3) {
	    if(!strlen(params)) return SendClientMessage(playerid, red, "USAGE: /setallworld [virtual world]");
		new var = strval(params), string[128];
       	CMDMessageToAdmins(playerid,"SETALLWORLD");
		for(new i = 0; i < MAX_PLAYER; i++) {
			if(IsPlayerConnected(i) ) {
            if(GetPVarInt(i, "MINION") || GetPVarInt(i, "RACE")) continue;

				PlayerPlaySound(i,1057,0.0,0.0,0.0);
				SetPlayerVirtualWorld(i,var);
			}
		}
		format(string,sizeof(string),"Administrador \"%s\" ha puesto el mundo virtual de todos en '%d'", pName(playerid), var );
		return SendClientMessageToAll(blue, string);
	} else return SendClientMessage(playerid,red,"ERROR: No tienes ningún permiso para usar este comando.");
}

dcmd_setallscore(playerid,params[]) {
	if(PlayerInfo[playerid][Level] < 12 || !IsPlayerAdmin(playerid)) return 0;
	    if(!strlen(params)) return SendClientMessage(playerid, red, "USAGE: /setallscore [score]");
		new var = strval(params), string[128];
       	CMDMessageToAdmins(playerid,"SETALLSCORE");
		for(new i = 0; i < MAX_PLAYER; i++) {
			if(IsPlayerConnected(i)) {
				PlayerPlaySound(i,1057,0.0,0.0,0.0);
				SetPlayerScore(i,var);
			}
		}
		format(string,sizeof(string),"Administrator \"%s\" has set all players scores to '%d'", pName(playerid), var );
		return SendClientMessageToAll(blue, string);
//	} else return SendClientMessage(playerid,red,"ERROR: No tienes ningún permiso para usar este comando.");
}

/*dcmd_setallcash(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 3) {
	    if(!strlen(params)) return SendClientMessage(playerid, red, "USAGE: /setallcash [Amount]");
		new var = strval(params), string[128];
       	CMDMessageToAdmins(playerid,"SETALLCASH");
		for(new i = 0; i < MAX_PLAYER; i++) {
			if(IsPlayerConnected(i)) {
				PlayerPlaySound(i,1057,0.0,0.0,0.0);
				ResetPlayerMoneyEx(i);
				GivePlayerMoneyEx(i,var);
			}
		}
		format(string,sizeof(string),"Administrator \"%s\" has set all players cash to '$%d'", pName(playerid), var );
		return SendClientMessageToAll(blue, string);
	} else return SendClientMessage(playerid,red,"ERROR: No tienes ningún permiso para usar este comando.");
}

dcmd_giveallcash(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 10) {
	    if(!strlen(params)) return SendClientMessage(playerid, red, "USAGE: /giveallcash [Amount]");
		new var = strval(params), string[128];
       	CMDMessageToAdmins(playerid,"GIVEALLCASH");
		for(new i = 0; i < MAX_PLAYER; i++) {
			if(IsPlayerConnected(i)) {
				PlayerPlaySound(i,1057,0.0,0.0,0.0);
				GivePlayerMoneyEx(i,var);
			}
		}
		format(string,sizeof(string),"Administrador \"%s\" ha regalado a todos los jugadores '$%d'", pName(playerid), var );
		return SendClientMessageToAll(blue, string);
	} else return SendClientMessage(playerid,red,"ERROR: No tienes ningún permiso para usar este comando.");
}
*/
dcmd_giveallweapon(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 3) {
	    new tmp[256], tmp2[256], Index, ammo, weap, WeapName[32], string[128]; tmp = strtok(params,Index), tmp2 = strtok(params,Index);
	    if(!strlen(tmp) ) return SendClientMessage(playerid, red, "USAGE: /giveallweapon [weapon id/weapon name] [ammo]");
		if(!strlen(tmp2) || !IsNumeric(tmp2) || strval(tmp2) <= 0 || strval(tmp2) > 99999){
		ammo = 100;
		}
		else ammo = strval(tmp2);
		if(!IsNumeric(tmp)) weap = GetWeaponIDFromName(tmp); else weap = strval(tmp);
	  	if(!IsValidWeapon(weap)) return SendClientMessage(playerid,red,"ERROR: Invalid weapon ID");
      	CMDMessageToAdmins(playerid,"GIVEALLWEAPON");
		for(new i = 0; i < MAX_PLAYER; i++) {
			if(IsPlayerConnected(i)  ) {
			            if(GetPVarInt(i, "MINION") || GetPVarInt(i, "RACE")) continue;

				PlayerPlaySound(i,1057,0.0,0.0,0.0);
				GivePlayerWeapon(i,weap,ammo);
			}
		}
		GetWeaponName(weap, WeapName, sizeof(WeapName) );
		format(string,sizeof(string),"Administrator \"%s\" ha regalado a todos los usuarios %s (%d) con %d de munición.", pName(playerid), WeapName, weap, ammo);
		return SendClientMessageToAll(blue, string);
	} else return SendClientMessage(playerid,red,"ERROR: No tienes ningún permiso para usar este comando.");
}


dcmd_saveskin(playerid,params[]) {
 	if(PlayerInfo[playerid][Level] >= 1 && PlayerInfo[playerid][LoggedIn] == 1) {
		if(!strlen(params)) return SendClientMessage(playerid, red, "USAGE: /saveskin [skinid]");
		new string[128], SkinID = strval(params);
		if((SkinID == 0)||(SkinID == 7)||(SkinID >= 9 && SkinID <= 41)||(SkinID >= 43 && SkinID <= 64)||(SkinID >= 66 && SkinID <= 73)||(SkinID >= 75 && SkinID <= 85)||(SkinID >= 87 && SkinID <= 118)||(SkinID >= 120 && SkinID <= 148)||(SkinID >= 150 && SkinID <= 207)||(SkinID >= 209 && SkinID <= 264)||(SkinID >= 274 && SkinID <= 288)||(SkinID >= 290 && SkinID <= 299))
		{
 			udb_query(result, "UPDATE `user` SET `UseSkin` = '1', `FavSkin` = '%d' WHERE `pName` = '%s'", SkinID, DB_Escape(udb_encode(PlayerName2(playerid)))); db_free_result(result);
		 	format(string, sizeof(string), "You have successfully saved this skin (ID %d)",SkinID);
		 	SendClientMessage(playerid,yellow,string);
			SendClientMessage(playerid,yellow,"Type: /useskin to use this skin when you spawn or /dontuseskin to stop using skin");
		 	return CMDMessageToAdmins(playerid,"SAVESKIN");
		} else return SendClientMessage(playerid, green, "ERROR: Invalid Skin ID");
	} else return SendClientMessage(playerid,red,"ERROR: Necesitas permisos administrativos para usar estos comandos.");
}

dcmd_useskin(playerid,params[]) {
    #pragma unused params
	if(GetPVarInt(playerid, "PREMIUM") >= 1 && PlayerInfo[playerid][LoggedIn] == 1) {
	    if(!strlen(params)) return SendClientMessage(playerid, red, "USA: /useskin [skinid]");
    	new SkinID = strval(params);
		udb_query(result, "UPDATE `user` SET `UseSkin` = '1', `FavSkin` = '%d' WHERE `pName` = '%s'", SkinID, DB_Escape(udb_encode(PlayerName2(playerid)))); db_free_result(result);
		SendClientMessage(playerid,yellow,"Ahora Al Spawnear Te Pondran Este Skin! Si Quieres Dejar De Usarlo Usa {FFFFFF}/dontuseskin");
    	SetPlayerSkin(playerid,SkinID);
		return SendClientMessage(playerid,yellow,"Nuevo Skin En Uso");
	} else return SendClientMessage(playerid,red,"ERROR: Comando solo para usuarios premium nivel 1!");
}

dcmd_dontuseskin(playerid,params[]) {
    #pragma unused params
	if(GetPVarInt(playerid, "PREMIUM") >= 1 && PlayerInfo[playerid][LoggedIn] == 1) {
	    udb_query(result, "UPDATE `user` SET `UseSkin` = '1' WHERE `pName` = '%s'", DB_Escape(udb_encode(PlayerName2(playerid)))); db_free_result(result);
		return SendClientMessage(playerid,LIGHTGREEN,"El skin no será usado.");
	} else return SendClientMessage(playerid,red,"ERROR: You must be an administrator to use this command");
}

//====================== [REGISTER  &  LOGIN] ==================================


/*dcmd_aregister(playerid,params[])
{
    if (PlayerInfo[playerid][LoggedIn] == 1) return SendClientMessage(playerid,red,"[Pura Joda] Usted ya está registrado y conectado");
    if (udb_Exists(PlayerName2(playerid))) return SendClientMessage(playerid,red,"[Pura Joda] Esta cuenta ya existe, por favor, utilice /alogin [contraseña]'.");
    if (strlen(params) == 0) return SendClientMessage(playerid,red,"[Pura Joda] el uso correcto: '/ aregister [contraseña]'");
    if (strlen(params) < 4 || strlen(params) > 20) return SendClientMessage(playerid,red,"[Pura Joda] La contraseña debe ser superior a tres caracteres");
    if (udb_Create(PlayerName2(playerid),params))
	{
    	new file[256],name[MAX_PLAYER_NAME], tmp3[100];
    	new strdate[20], year,month,day;	getdate(year, month, day);
		GetPlayerName(playerid,name,sizeof(name)); format(file,sizeof(file),"/ladmin/users2/%s.sav",udb_encode(name));
     	GetPlayerIp(playerid,tmp3,100);	dini_Set(file,"ip",tmp3);
     	dini_Set(file,"password",params);
	    dUserSetINT(PlayerName2(playerid)).("registered",1);
   		format(strdate, sizeof(strdate), "%d/%d/%d",day,month,year);
		dini_Set(file,"RegisteredDate",strdate);
		dUserSetINT(PlayerName2(playerid)).("loggedin",1);
		dUserSetINT(PlayerName2(playerid)).("banned",0);
		dUserSetINT(PlayerName2(playerid)).("level",0);
	    dUserSetINT(PlayerName2(playerid)).("LastOn",0);
    	dUserSetINT(PlayerName2(playerid)).("money",0);
    	dUserSetINT(PlayerName2(playerid)).("kills",0);
	   	dUserSetINT(PlayerName2(playerid)).("deaths",0);
	    PlayerInfo[playerid][LoggedIn] = 1;
	    PlayerInfo[playerid][Registered] = 1;
	    SendClientMessage(playerid, green, "[Pura Joda] ¡¡BIENVENIDO !! Gracias por registrarse, has sido loggeado automáticamente ");
	    SendClientMessage(playerid, green, "Sí no sabes como jugar útliza /Ayuda o alguna duda /Admins y envíales un PM mediante '/PM ID MJS'");
	    SendClientMessage(playerid, green, "Recuerde que los cheats o cualquier trampa que de ventaja serás kickeado o baneado...");
		PlayerPlaySound(playerid,1057,0.0,0.0,0.0);
		return 1;
	}
    return 1;
}

dcmd_alogin(playerid,params[])
{
    if (PlayerInfo[playerid][LoggedIn] == 1) return SendClientMessage(playerid,red,"[Pura Joda] Usted ya está logueado");
    if (!udb_Exists(PlayerName2(playerid))) return SendClientMessage(playerid,red,"[Pura Joda] La cuenta no existe por favor, utilice '/aregister [contraseña]'.");
    if (strlen(params)==0) return SendClientMessage(playerid,red,"[Pura Joda] Uso correcto: /alogin [contraseña]'");
    if (udb_CheckLogin(PlayerName2(playerid),params))
	{
	   	new file[256], tmp3[100], string[128];
	   	format(file,sizeof(file),"/ladmin/users/%s.sav",udb_encode(PlayerName2(playerid)) );
   		GetPlayerIp(playerid,tmp3,100);
	   	dini_Set(file,"ip",tmp3);
		LoginPlayer(playerid)//esta es la opcion que tiene ladmin al loguearse el jugador
        {
		if(ServerInfo[GiveMoney] == 1) {ResetPlayerMoneyEx(playerid); GivePlayerMoneyEx(playerid,       dUserINT(PlayerName2(playerid)).("money") ); }
		dUserSetINT(PlayerName2(playerid)).("loggedin",1);
		PlayerInfo[playerid][Deaths] = (dUserINT(PlayerName2(playerid)).("deaths"));
		PlayerInfo[playerid][Kills] = (dUserINT(PlayerName2(playerid)).("kills"));
		PlayerInfo[playerid][Level] = (dUserINT(PlayerName2(playerid)).("level"));
		SetPlayerScore(playerid, dUserINT(PlayerName2(playerid)).("score"));//aqui estamos diciendole a ladmin que cada vez que el jugador registrado se conecte y se loguee le entregue el score que tenia en el juego anterior
	 	//AccInfo[playerid][pVip] = (dUserINT(PlayerName2(playerid)).("AccountType"));
   	    PlayerInfo[playerid][hours] = dUserINT(PlayerName2(playerid)).("hours");
     	PlayerInfo[playerid][mins] = dUserINT(PlayerName2(playerid)).("minutes");
     	PlayerInfo[playerid][secs] = dUserINT(PlayerName2(playerid)).("seconds");
		PlayerInfo[playerid][Registered] = 1;
	 	PlayerInfo[playerid][LoggedIn] = 1;
}
		PlayerPlaySound(playerid,1057,0.0,0.0,0.0);
		if(PlayerInfo[playerid][Level] > 0) {
			format(string,sizeof(string),"[Pura Joda] Logueado correctamente! (Nivel %d)", PlayerInfo[playerid][Level] );
			return SendClientMessage(playerid,green,string);
       	} else return SendClientMessage(playerid,green,"[Pura Joda] Logueado correctamente!");
	}
	else {
		PlayerInfo[playerid][FailLogin]++;
		printf("LOGIN: %s has failed to login, Wrong password (%s) Attempt (%d)", PlayerName2(playerid), params, PlayerInfo[playerid][FailLogin] );
		if(PlayerInfo[playerid][FailLogin] == MAX_FAIL_LOGINS)
		{
			new string[128]; format(string, sizeof(string), "%s ha sido kickeado (Login Incorrecto)", PlayerName2(playerid) );
			SendClientMessageToAll(grey, string); print(string);
			Kick(playerid);
		}
		return SendClientMessage(playerid,red,"[Pura Joda] Contraseña incorrecta");
	}
}*/

CMD:achangepass(playerid,params[]) {
	if(PlayerInfo[playerid][LoggedIn] == 1)	{
		if(!strlen(params)) return SendClientMessage(playerid, red, "USAGE: /achangepass [new password]");
		if(strlen(params) < 4) return SendClientMessage(playerid,red,"ACCOUNT: Incorrect password length");
		new string[128];
		udb_query(result, "UPDATE `user` SET `pPass` = '%d' WHERE `pName` = '%s'", udb_hash(params), DB_Escape(udb_encode(PlayerName2(playerid)))); db_free_result(result);
		PlayerPlaySound(playerid,1057,0.0,0.0,0.0);
        format(string, sizeof(string),"[Pura Joda] Has cambiado tu contraseña a [ %s ]",params);
		return SendClientMessage(playerid,yellow,string);
	} else return SendClientMessage(playerid,red, "ERROR: Usted debe tener una cuenta para utilizar este comando");
}

CMD:asetpass(playerid,params[]) {
    if(PlayerInfo[playerid][Level] >= 12) {
	    new string[128], tmp[256], tmp2[256], Index; tmp = strtok(params,Index), tmp2 = strtok(params,Index);
	    if(!strlen(tmp) || !strlen(tmp2)) return SendClientMessage(playerid, red, "USAGE: /asetpass [playername] [new password]");
		if(strlen(tmp2) < 4 || strlen(tmp2) > MAX_PLAYER_NAME) return SendClientMessage(playerid,red,"ERROR: Incorrect password length");
		new query2[100], DBResult:result2; format(query2, sizeof(query2), "SELECT * FROM `user` WHERE `pName` = '%s' LIMIT 1",DB_Escape(udb_encode(tmp))); result2 = db_query(LadminDB, query2);
		if(db_num_rows(result2)) {
		    db_free_result(result2);
			udb_query(result, "UPDATE `user` SET `pPass` = '%d' WHERE `pName` = '%s'", udb_hash(tmp2), DB_Escape(udb_encode(tmp))); db_free_result(result);
			PlayerPlaySound(playerid,1057,0.0,0.0,0.0);
    	    format(string, sizeof(string),"ACCOUNT: You have successfully set \"%s's\" account password to \"%s\"", tmp, tmp2);
			return SendClientMessage(playerid,yellow,string);
		} else return SendClientMessage(playerid,red, "ERROR: El jugador no posee una cuenta");
	} else return SendClientMessage(playerid,red,"ERROR: Usted no tiene un nivel alto para usar este comando");
}


CMD:changepass(playerid,params[]) {
	if(PlayerInfo[playerid][LoggedIn] == 1)	{
		if(!strlen(params)) return SendClientMessage(playerid, red, "USAGE: /changepass [new password]");
		if(strlen(params) < 4) return SendClientMessage(playerid,red,"ACCOUNT: Incorrect password length");
		new string[128];
		udb_query(result, "UPDATE `user` SET `pPass` = '%d' WHERE `pName` = '%s'", udb_hash(params), DB_Escape(udb_encode(PlayerName2(playerid)))); db_free_result(result);
		PlayerPlaySound(playerid,1057,0.0,0.0,0.0);
        format(string, sizeof(string),"ACCOUNT: Tu has cambiado tu contraseña a \"%s\"",params);
		return SendClientMessage(playerid,yellow,string);
	} else return SendClientMessage(playerid,red, "ERROR: You must have an account to use this command");
}

CMD:setpass(playerid,params[]) {
    if(PlayerInfo[playerid][Level] >= 11) {
	    new string[128], tmp[256], tmp2[256], Index; tmp = strtok(params,Index), tmp2 = strtok(params,Index);
	    if(!strlen(tmp) || !strlen(tmp2)) return SendClientMessage(playerid, red, "USAGE: /setpass [playername] [new password]");
		if(strlen(tmp2) < 4 || strlen(tmp2) > MAX_PLAYER_NAME) return SendClientMessage(playerid,red,"ERROR: Incorrect password length");
		new query2[100], DBResult:result2; format(query2, sizeof(query2), "SELECT * FROM `user` WHERE `pName` = '%s' LIMIT 1",DB_Escape(udb_encode(tmp))); result2 = db_query(LadminDB, query2);
		if(db_num_rows(result2)) {
		    db_free_result(result2);
			udb_query(result, "UPDATE `user` SET `pPass` = '%d' WHERE `pName` = '%s'", udb_hash(tmp2), DB_Escape(udb_encode(tmp))); db_free_result(result);
			PlayerPlaySound(playerid,1057,0.0,0.0,0.0);
    	    format(string, sizeof(string),"ACCOUNT: You have successfully set \"%s's\" account password to \"%s\"", tmp, tmp2);
			return SendClientMessage(playerid,yellow,string);
		} else return SendClientMessage(playerid,red, "ERROR: This player doesnt have an account");
	} else return SendClientMessage(playerid,red,"ERROR: No tienes ningún permiso para usar este comando.");
}

/*#if defined USE_STATS
dcmd_resetstats(playerid,params[]) {
    #pragma unused params
	if(PlayerInfo[playerid][LoggedIn] == 1)	{
		// save as backup
	   	udb_query(result, "UPDATE `user` SET `pKills` = '0', `pDeath` = '0', `pOldKills` = '%d', `pOldDeath` = '%d' WHERE `pName` = '%s'", GetPVarInt(playerid, "Score"), PlayerInfo[playerid][Deaths], DB_Escape(udb_encode(PlayerName2(playerid)))); db_free_result(result);
		// stats reset
		SetPVarInt(playerid, "Score", 0);
		PlayerInfo[playerid][Deaths] = 0;
        PlayerPlaySound(playerid,1057,0.0,0.0,0.0);
		return SendClientMessage(playerid,yellow,"ACCOUNT: You have successfully reset your stats. Your kills and deaths are: 0");
	} else return SendClientMessage(playerid,red, "ERROR: You must have an account to use this command");
}
#endif
*/

dcmd_stats(playerid,params[]) {
	new  player1;//, h, m, s;
	if(!strlen(params)) player1 = playerid;
	else player1 = strval(params);
	new str[256];
	new ge[100];
	new gunname[32];
	//new money2;
	new country[MAX_COUNTRY_NAME];
	country = GetPlayerCountryName(player1);
   	if(IsPlayerConnected(player1)) {
	    	new iString[2000];
	    	format(str, sizeof(str),""G"Estadísticas generales\n");
	    	strcat(iString, str);
	    	format(str, sizeof(str),"Kills: "W"%d\n"G"Deaths: "W"%d\n"G"PJCoins: "W"%d\n",GetPVarInt(player1, "Score"),PlayerInfo[player1][Deaths],GetPVarInt(player1, "COIN"));
		    strcat(iString,str);
		   	format(str, sizeof(str),""G"Dinero: "W"%d\n"G"Premium: "W"%d\n"G"Level: "W"%d\n",MoneyEx[playerid],GetPVarInt(player1, "PREMIUM"),PlayerInfo[player1][Level]);
			strcat(iString,str);
  			format(str, sizeof(str),""G"Skin preferido: "W"%d\n"G"World: "W"%d\n"G"Interior: "W"%d\n\n",PlayerInfo[player1][FavSkin],GetPlayerVirtualWorld(player1),GetPlayerInterior(player1));
			strcat(iString,str);
			format(str, sizeof(str),""G"Armas preferidas\n");
			strcat(iString, str);
			for(new i = 0; i != 9; i++){
				if(IsValidWeapon(Weap[i][0]))
				{
            		GetWeaponName(Weap[i][0], gunname, sizeof(gunname));
	 				format(ge, sizeof(ge), ""G"Arma %d: "W"%s\n",(i+1),gunname);
	 				strcat(iString, ge);
				}
 			}
 			new sStr[10];
    		format(sStr, 10, "%s",GetPlayerPacketLoss(player1));
			format(str, sizeof(str),"\n"G"Netstats\n");
			strcat(iString, str);
			format(str, sizeof(str),""G"FPS: "W"%d\n"G"Ping: "W"%d\n"G"PacketLoss: "W"%s%\n"G"Country: "W"%s",(FPS2[player1]-1),GetPlayerPing(player1),sStr,country);
			strcat(iString, str);
			format(str, sizeof(str),""W"%s's "G"Statistics",PlayerName2(player1));
			ShowPlayerDialog(playerid,DIALOG_OTROS, DIALOG_STYLE_MSGBOX, str, iString, "Aceptar", "");
		  	PlayerPlaySound(playerid,1139,0.0,0.0,0.0);
	  //  TotalGameTime(player1, h, m, s);
 	//	if(PlayerInfo[player1][Deaths] == 0) pDeaths = 1; else pDeaths = PlayerInfo[player1][Deaths];
 	//	format(string, sizeof(string), "| %s [ID:%d] Statistics:  Kills: %d | Deaths: %d | Ratio: %0.2f for death| Banked Money: $%d | Money: $%d | Time In Game: %d hrs %d mins %d segs |",PlayerName2(player1),player1, PlayerInfo[player1][Deaths], GetPVarInt(player1, "Score"), Float:GetPVarInt(player1, "Score")/Float:pDeaths,money2,GetPlayerMoney(player1), h, m, s);
		return 1;
	} else return SendClientMessage(playerid, red, "Jugador no conectado!");
}




LoginPlayer(playerid) //
{
	udb_query(result2, "SELECT * FROM `user` WHERE `pName` = '%s' LIMIT 1", DB_Escape(udb_encode(PlayerName2(playerid))));
	new field[40];
	db_get_field_assoc(result2, "pMoney", field, sizeof(field));
	if(ServerInfo[GiveMoney] == 1) {ResetPlayerMoneyEx(playerid); GivePlayerMoneyEx(playerid, strval(field) ); }
	db_get_field_assoc(result2, "pCoins", field, sizeof(field));
	SetPVarInt(playerid, "COIN", strval(field));
	db_get_field_assoc(result2, "pDeath", field, sizeof(field));
	PlayerInfo[playerid][Deaths] = strval(field);
	db_get_field_assoc(result2, "pVelocity", field, sizeof(field));
    Velocity[playerid] = strval(field);
    db_get_field_assoc(result2, "pJump",field, sizeof(field));
    Jump[playerid] = strval(field);
	db_get_field_assoc(result2, "pKills", field, sizeof(field));
	SetPVarInt(playerid, "Score", strval(field));
	db_get_field_assoc(result2, "pLevel", field, sizeof(field));
 	PlayerInfo[playerid][Level] = strval(field);
 	db_get_field_assoc(result2, "pHours", field, sizeof(field));
   	PlayerInfo[playerid][hours] = strval(field);
   	db_get_field_assoc(result2, "pMinutes", field, sizeof(field));
   	PlayerInfo[playerid][mins] = strval(field);
   	db_get_field_assoc(result2, "pSeconds", field, sizeof(field));
   	PlayerInfo[playerid][secs] = strval(field);
   	db_get_field_assoc(result2, "pPremium", field, sizeof(field));
 	SetPVarInt(playerid, "PREMIUM", strval(field));
 	db_get_field_assoc(result2, "pRconAprovado", field, sizeof(field));
 	PlayerInfo[playerid][rcona] = strval(field);
 	db_get_field_assoc(result2, "pPreDia", field, sizeof(field));
 	PlayerInfo[playerid][PreDia] = strval(field);
 	db_get_field_assoc(result2, "pPreMes", field, sizeof(field));
 	PlayerInfo[playerid][PreMes] = strval(field);
 	db_get_field_assoc(result2, "pPreAno", field, sizeof(field));
 	PlayerInfo[playerid][PreAno] = strval(field);
 	db_get_field_assoc(result2, "UseSkin", field, sizeof(field));
 	PlayerInfo[playerid][UseSkin] = strval(field);
	db_get_field_assoc(result2, "pColor",field, sizeof(field));
	PlayerInfo[playerid][fColor] = strval(field);
//    db_get_field_assoc(result2, "pNavidad", field, sizeof(field));
//	Navidad[playerid] = strval(field);
    db_get_field_assoc(result2, "pNove",field, sizeof(field));
	Novel[playerid] = strval(field);
	db_get_field_assoc(result2, "FavSkin", field, sizeof(field));
 	PlayerInfo[playerid][FavSkin] = strval(field);
 	new pIP[20]; GetPlayerIp(playerid, pIP, sizeof(pIP));
	ChangeLoggedIn(playerid, 1, pIP, PlayerInfo[playerid][Level], GetPVarInt(playerid, "PREMIUM"));
	PlayerInfo[playerid][Registered] = 1;
 	PlayerInfo[playerid][LoggedIn] = 1;
 	db_get_field_assoc(result2, "pSave", field, sizeof(field));
//	printf("%s",field);
 	pSave[playerid] = strval(field);
 	new ge[15];
 	if(pSave[playerid] == 1){
 	SetPVarInt(playerid, "Save",1);
 	for(new i = 1; i != 9; i++){
 	format(ge, sizeof(ge), "pWeap%d",i);

	db_get_field_assoc(result2, ge, field, sizeof(field));
//	printf("%s");
 	Weap[(i-1)][0] =  strval(field);
 	}
 	} else SetPVarInt(playerid, "Save",0);

 	db_free_result(result2);
}

//==============================================================================
stock GetPlayerPacketLoss(playerid)
{
	new stats[401], stringstats[70],eae[10];
	GetPlayerNetworkStats(playerid, stats, sizeof(stats));
	new len = strfind(stats, "Packetloss: ");
	new Float:packetloss = 0.0;
	if(len != -1)
	{
		strmid(stringstats, stats, len, strlen(stats));
		new len2 = strfind(stringstats, "%");
		if(len != -1)
		{
			strdel(stats, 0, strlen(stats));
			strmid(stats, stringstats, len2-3, len2);
 			packetloss = floatstr(stats);
		}
	}
	format(eae, 10, "%0.1f",packetloss);
	return eae;
}


	public OnPlayerCommandPerformed(playerid, cmdtext[], success)
	{
		if(success)
	{
		return 1;
	}

	dcmd(salirevento,11,cmdtext);
    if(SinComandos[playerid] == 1) return SendClientMessage(playerid,red,"[Pura Joda] Está en evento, por favor no abuse.");
    if(PlayerInfo[playerid][Jailed] == 1 && PlayerInfo[playerid][Level] < 1) return SendClientMessage(playerid,red,"Usted no puede utilizar los comandos en la cárcel");

	new cmd[256], string[128], tmp[256], idx;
	cmd = strtok(cmdtext, idx);


	dcmd(duelo,5,cmdtext);
	dcmd(nduelo,6,cmdtext);



	dcmd(report,6,cmdtext);
	dcmd(reports,7,cmdtext);

    //================ [ Read Comamands ] ===========================//
	if(ServerInfo[ReadCmds] == 1)
	{
		format(string, sizeof(string), "*** %s [%d] typed: %s", pName(playerid),playerid,cmdtext);
		for(new i = 0; i < MAX_PLAYER; i++) {
			if(IsPlayerConnected(i)) {
				if( (PlayerInfo[i][Level] > PlayerInfo[playerid][Level]) && (PlayerInfo[i][Level] > 1) && (i != playerid) ) {
					SendClientMessage(i, grey, string);
				}
			}
		}
	}

	//-= Spectate Commands =-//
	#if defined ENABLE_SPEC
	dcmd(lspec,5,cmdtext);
	dcmd(lspecoff,8,cmdtext);
	dcmd(lspecvehicle,12,cmdtext);
	#endif
	dcmd(stats,5,cmdtext);
	//Sistema de objetos by 43z
	dcmd(eobject,7,cmdtext);
	dcmd(eoremove,8,cmdtext);
	dcmd(eoedit,6,cmdtext);
	 //event
	dcmd(irevento,8,cmdtext);
	dcmd(menueventos,11,cmdtext);
	dcmd(salirevento,11,cmdtext);
	dcmd(skinevento,10,cmdtext);
	dcmd(armasevento,11,cmdtext);
	dcmd(msethealth,10,cmdtext);
	dcmd(msetarmour,10,cmdtext);
	//dcmd(respawncars,11,cmdtext);
	dcmd(autosevento,11,cmdtext);
	//-= Chat Commands =-//
	dcmd(disablechat,11,cmdtext);
	dcmd(clearchat,9,cmdtext);
	dcmd(clearallchat,12,cmdtext);
	dcmd(caps,4,cmdtext);
	dcmd(buy,3,cmdtext);
	dcmd(l,1,cmdtext);
	dcmd(sarma,5,cmdtext);
	//-= Vehicle Commands =-//
	dcmd(v,1,cmdtext);
	dcmd(respawncars,11,cmdtext);
	dcmd(destroycar,10,cmdtext);
	dcmd(destroycar2,11,cmdtext);
	dcmd(lockcar,7,cmdtext);
	dcmd(unlockcar,9,cmdtext);
	dcmd(carhealth,9,cmdtext);
	dcmd(carcolour,9,cmdtext);
	dcmd(car,3,cmdtext);
    dcmd(vr,2,cmdtext);
    dcmd(fix,3,cmdtext);
    dcmd(repair,6,cmdtext);
    dcmd(ltune,5,cmdtext);
    dcmd(lhy,3,cmdtext);
    dcmd(lcar,4,cmdtext);
    dcmd(lbike,5,cmdtext);
    dcmd(lheli,5,cmdtext);
	dcmd(lboat,5,cmdtext);
    dcmd(lnos,4,cmdtext);
    dcmd(lplane,6,cmdtext);
    dcmd(vgoto,5,cmdtext);
    dcmd(vget,4,cmdtext);
    dcmd(givecar,7,cmdtext);
    dcmd(flip,4,cmdtext);
    dcmd(ltc,3,cmdtext);
	dcmd(prision,7,cmdtext);
	dcmd(linkcar,7,cmdtext);
	dcmd(unprision,9,cmdtext);
/*	dcmd(desafio,7,cmdtext);
	dcmd(rdesafio,8,cmdtext);
	dcmd(acepto,6,cmdtext);*/
    //-= Playerid Commands =-//
    dcmd(subirme,7,cmdtext);
    dcmd(subir,5,cmdtext);
    dcmd(crash,5,cmdtext);
	dcmd(ip,2,cmdtext);
	dcmd(force,5,cmdtext);
	dcmd(burn,4,cmdtext);
	dcmd(spawn,5,cmdtext);
	dcmd(spawnplayer,11,cmdtext);
	dcmd(disarm,6,cmdtext);
	dcmd(eject,5,cmdtext);
	dcmd(bankrupt,8,cmdtext);
	dcmd(sbankrupt,9,cmdtext);
	dcmd(setworld,8,cmdtext);
	dcmd(setinterior,11,cmdtext);
    dcmd(ubound,6,cmdtext);
	dcmd(setwanted,9,cmdtext);
	dcmd(setcolour,9,cmdtext);
	dcmd(settime,7,cmdtext);
	dcmd(setweather,10,cmdtext);
	dcmd(setname,7,cmdtext);
	dcmd(setskin,7,cmdtext);
	dcmd(setscore,8,cmdtext);
	//dcmd(darscore,8,cmdtext);
	dcmd(givescore,9,cmdtext);
	dcmd(setcash,7,cmdtext);
	dcmd(sethealth,9,cmdtext);
	dcmd(setarmour,9,cmdtext);
	dcmd(giveweapon,10,cmdtext);
	dcmd(warp,4,cmdtext);
	dcmd(teleplayer,10,cmdtext);
    dcmd(goto,4,cmdtext);
    dcmd(gethere,7,cmdtext);
    dcmd(get,3,cmdtext);
    dcmd(setlevel,8,cmdtext);
    dcmd(setpremium,10,cmdtext);
   // dcmd(nachoprolvl4heartesputo,23,cmdtext);
    dcmd(darvip,6,cmdtext);
    dcmd(settemppremium,14,cmdtext);
    dcmd(settemplevel,12,cmdtext);
    dcmd(fu,2,cmdtext);
    dcmd(warn,4,cmdtext);
    dcmd(kick,4,cmdtext);
    dcmd(ban,3,cmdtext);
    dcmd(rban,4,cmdtext);
    dcmd(slap,4,cmdtext);
    dcmd(ss,0,cmdtext);
    dcmd(pais,4,cmdtext);
    dcmd(explode,7,cmdtext);
    dcmd(jail,4,cmdtext);
    dcmd(unjail,6,cmdtext);
    dcmd(jailed,6,cmdtext);
    dcmd(freeze,6,cmdtext);
    dcmd(unfreeze,8,cmdtext);
    dcmd(frozen,6,cmdtext);
    dcmd(mute,4,cmdtext);
    dcmd(unmute,6,cmdtext);
    dcmd(muted,5,cmdtext);
    dcmd(akill,5,cmdtext);
    dcmd(weaps,5,cmdtext);
    dcmd(screen,6,cmdtext);
    dcmd(lgoto,5,cmdtext);
    dcmd(aka,3,cmdtext);
    dcmd(highlight,9,cmdtext);
    dcmd(phighlight,10,cmdtext);
    dcmd(ha, 2,cmdtext);
	dcmd(hablar,6,cmdtext);
	dcmd(music,5,cmdtext);
    dcmd(demoted,7,cmdtext);
	dcmd(rsetlevel,9,cmdtext);


	//-= /All Commands =-//

	dcmd(healall,7,cmdtext);
	dcmd(armourall,9,cmdtext);
	dcmd(muteall,7,cmdtext);
	dcmd(unmuteall,9,cmdtext);
	dcmd(getall,6,cmdtext);
	dcmd(spawnall,8,cmdtext);
	dcmd(freezeall,9,cmdtext);
	dcmd(unfreezeall,11,cmdtext);
	dcmd(explodeall,10,cmdtext);
	dcmd(slapall,7,cmdtext);
	dcmd(ejectall,8,cmdtext);
	dcmd(disarmall,9,cmdtext);
	dcmd(setallskin,10,cmdtext);
	dcmd(setallwanted,12,cmdtext);
	dcmd(setallweather,13,cmdtext);
	dcmd(setalltime,10,cmdtext);
	dcmd(setallworld,11,cmdtext);
	dcmd(setallscore,11,cmdtext);
////	dcmd(setallcash,10,cmdtext);
//	dcmd(giveallcash,11,cmdtext);
	dcmd(giveallweapon,13,cmdtext);

    //-= No params =-//
	dcmd(lslowmo,7,cmdtext);
    dcmd(lweaps,6,cmdtext);
    dcmd(lammo,5,cmdtext);
    dcmd(god,3,cmdtext);
    dcmd(sgod,4,cmdtext);
    dcmd(godcar,6,cmdtext);
    dcmd(die,3,cmdtext);
    dcmd(jetpack,7,cmdtext);
    dcmd(admins,6,cmdtext);
    dcmd(staff,5,cmdtext);
    dcmd(vips,4,cmdtext);
    dcmd(hideadmin,9,cmdtext);
    dcmd(morning,7,cmdtext);
    dcmd(premiums,8,cmdtext);
	//-= Admin special =-//

    dcmd(guardarskin,11,cmdtext);

	dcmd(saveskin,8,cmdtext);
	dcmd(useskin,7,cmdtext);
	dcmd(dontuseskin,11,cmdtext);

	//-= Config =-//
    dcmd(disable,7,cmdtext);
    dcmd(enable,6,cmdtext);
    dcmd(setping,7,cmdtext);
	dcmd(setgravity,10,cmdtext);
    dcmd(uconfig,7,cmdtext);
    dcmd(lconfig,7,cmdtext);
    dcmd(forbidname,10,cmdtext);
    dcmd(forbidword,10,cmdtext);

	//-= Misc =-//
	dcmd(nombre,6,cmdtext);
    dcmd(snombre,7,cmdtext);
	dcmd(setmytime,9,cmdtext);
	dcmd(time,4,cmdtext);
	dcmd(lhelp,5,cmdtext);
	dcmd(lcmds,5,cmdtext);
	dcmd(lcommands,9,cmdtext);
	dcmd(level1,6,cmdtext);
	dcmd(level2,6,cmdtext);
	dcmd(level3,6,cmdtext);
	dcmd(level4,6,cmdtext);
	dcmd(level5,6,cmdtext);
 	dcmd(lcredits,8,cmdtext);
 	dcmd(serverinfo,10,cmdtext);
    dcmd(getid,5,cmdtext);
	dcmd(getinfo,7,cmdtext);
    dcmd(laston,6,cmdtext);
/*    dcmd(laston2,7,cmdtext);*/
    dcmd(rconacept,9,cmdtext);
	dcmd(ping,4,cmdtext);
    dcmd(countdown,9,cmdtext);
//    dcmd(duelooo,7,cmdtext);
    dcmd(asay,4,cmdtext);
    dcmd(msay,4,cmdtext);
	dcmd(password,8,cmdtext);
	dcmd(lockserver,10,cmdtext);
	dcmd(unlockserver,12,cmdtext);
    dcmd(adminarea,9,cmdtext);
    dcmd(announce,8,cmdtext);
    dcmd(announce2,9,cmdtext);
    dcmd(richlist,8,cmdtext);
    dcmd(miniguns,8,cmdtext);
    dcmd(rockets,7,cmdtext);
    dcmd(botcheck,8,cmdtext);
 //   dcmd(object,6,cmdtext);
    dcmd(pickup,6,cmdtext);
    dcmd(move,4,cmdtext);
    dcmd(moveplayer,10,cmdtext);

    #if defined ENABLE_FAKE_CMDS
	dcmd(fakedeath,9,cmdtext);
	dcmd(fakechat,8,cmdtext);
	dcmd(fakecmd,7,cmdtext);
	#endif


	if(Adentro[playerid] == 2)
	{
		if (!strcmp("/flipcar", cmdtext, true))
    	{
		    new currentveh;
		    new Float:angle;
		    currentveh = GetPlayerVehicleID(playerid);
		    GetVehicleZAngle(currentveh, angle);
		    SetVehicleZAngle(currentveh, angle);
		    SendClientMessage(COLOR_YELLOW,playerid,"[Pura Joda] Auto Enderezado");
	    }
	}
	/////Mounster
	dcmd(mactivar,8,cmdtext);
	dcmd(mdesactivar,11,cmdtext);
	dcmd(salirmonster,12,cmdtext);
	dcmd(mcomenzar,9,cmdtext);
	/////Jaula
	dcmd(jactivar,8,cmdtext);
	dcmd(jdesactivar,11,cmdtext);
	dcmd(salirjaula,10,cmdtext);
	dcmd(comenzar,8,cmdtext);
	////DMcuck
	/////Jaula
	dcmd(CActivar,8,cmdtext);
	dcmd(DMCHUCK,7,cmdtext);
	dcmd(Ccomenzar,9,cmdtext);
	dcmd(CHUCKADMIN,10,cmdtext);
	//survivor
	dcmd(SActivar,8,cmdtext);
	dcmd(SURVIVOR,8,cmdtext);
	dcmd(Scomenzar,9,cmdtext);
	dcmd(SADMIN,6,cmdtext);
	if(GetPVarInt(playerid, "MINION")) return 0;
	dcmd(acargar,7,cmdtext);
	dcmd(pspec,5,cmdtext);
	dcmd(pspecoff,8,cmdtext);
	if (!strcmp("/DMonster", cmdtext, true))
	{
    	new Float:X,Float:Y,Float:Z,Float:ROT;
        GetPlayerPos(playerid,X,Y,Z);
        GetPlayerFacingAngle (playerid,ROT);
        Monster[playerid] = CreateVehicle(444,-9017.8018,-2270.8801,761.9372,ROT,-1,-1,60); SetVehiclePos(Monster[playerid],X,Y,Z);

        PutPlayerInVehicle(playerid,Monster[playerid],0);
        GameTextForPlayer(playerid,"~h~~w~Monster~n~~h~~w~ID:~h~~r~444",2500,1);
        return 1;
	}
	if (!strcmp("/minigun", cmdtext, true))
	{
		if(guerra == 1)
		{
			GivePlayerWeapon(playerid,38,999999);
			SetPlayerInterior(playerid, 0);
			SetPlayerVirtualWorld(playerid,0);
		}
		else return SendClientMessage(playerid, COLOR_ROJO, "[Error]: Hora Feliz Esta Desactivada");
		return 1;
	}

	if (!strcmp("/rocket", cmdtext, true))
	{
		if(guerra == 1)
		{
			GivePlayerWeapon(playerid,35,999999);
			SetPlayerInterior(playerid, 0);
			SetPlayerVirtualWorld(playerid,0);
		}
		else return SendClientMessage(playerid, COLOR_ROJO, "[Error]: Hora Feliz Esta Desactivada");
        return 1;
	}

	if (!strcmp("/bazooka", cmdtext, true))
	{
		if(guerra == 1)
		{
			GivePlayerWeapon(playerid,36,999999);
			SetPlayerInterior(playerid, 0);
			SetPlayerVirtualWorld(playerid,0);
		}
		else return SendClientMessage(playerid, COLOR_ROJO, "[Error]: Hora Feliz Esta Desactivada");
        return 1;
	}

	if (!strcmp("/granadas", cmdtext, true))
	{
		if(guerra == 1)
		{
			GivePlayerWeapon(playerid,16,999999);
			SetPlayerInterior(playerid, 0);
			SetPlayerVirtualWorld(playerid,0);
		}
		else return SendClientMessage(playerid, COLOR_ROJO, "[Error]: Hora Feliz Esta Desactivada");
        return 1;
	}
	if (!strcmp("/molotov", cmdtext, true))
	{
		if(guerra == 1)
		{
			GivePlayerWeapon(playerid,18,999999);
			SetPlayerInterior(playerid, 0);
			SetPlayerVirtualWorld(playerid,0);
		}
		else return SendClientMessage(playerid, COLOR_ROJO, "[Error]: Hora Feliz Esta Desactivada");
        return 1;
	}
	if (!strcmp("/rhino", cmdtext, true))
	{
		if(guerra == 1)
		{
			DestroyVehicle(Monster[playerid]);
        	new Float:X,Float:Y,Float:Z,Float:ROT;
    	    GetPlayerPos(playerid,X,Y,Z);
	        GetPlayerFacingAngle (playerid,ROT);
	        Monster[playerid] = CreateVehicle(432,-9017.8018,-2270.8801,761.9372,ROT,-1,-1,60); SetVehiclePos(Monster[playerid],X,Y,Z);
        	PutPlayerInVehicle(playerid,Monster[playerid],0);
        	SetPlayerInterior(playerid, 0);
        	SetPlayerVirtualWorld(playerid,0);
        	GameTextForPlayer(playerid,"~h~~w~rhino~n~~h~~w~ID:~h~~r~444",2500,1);
		}
		else return SendClientMessage(playerid, COLOR_ROJO, "[Error]: Hora Feliz Esta Desactivada");
		return 1;
	}
	if (!strcmp("/hydra", cmdtext, true))
	{
		if(guerra == 1)
		{
			DestroyVehicle(Monster[playerid]);
	        new Float:X,Float:Y,Float:Z,Float:ROT;
	        GetPlayerPos(playerid,X,Y,Z);
	        GetPlayerFacingAngle (playerid,ROT);
	        Monster[playerid] = CreateVehicle(520,-9017.8018,-2270.8801,761.9372,ROT,-1,-1,60); SetVehiclePos(Monster[playerid],X,Y,Z);
        	PutPlayerInVehicle(playerid,Monster[playerid],0);
        	SetPlayerInterior(playerid, 0);
        	SetPlayerVirtualWorld(playerid,0);
        	GameTextForPlayer(playerid,"~h~~w~Hydra~n~~h~~w~ID:~h~~r~444",2500,1);
		}
		else return SendClientMessage(playerid, COLOR_ROJO, "[Error]: Hora Feliz Esta Desactivada");
        return 1;
	}
	if (!strcmp("/hunter", cmdtext, true))
    {
		if(guerra == 1)
		{
        	DestroyVehicle(Monster[playerid]);
        	new Float:X,Float:Y,Float:Z,Float:ROT;
        	GetPlayerPos(playerid,X,Y,Z);
        	GetPlayerFacingAngle (playerid,ROT);
        	Monster[playerid] = CreateVehicle(425,-9017.8018,-2270.8801,761.9372,ROT,-1,-1,60); SetVehiclePos(Monster[playerid],X,Y,Z);
        	PutPlayerInVehicle(playerid,Monster[playerid],0);
        	SetPlayerInterior(playerid, 0);
        	SetPlayerVirtualWorld(playerid,0);
        	GameTextForPlayer(playerid,"~h~~whunter~n~~h~~w~ID:~h~~r~444",2500,1);
		}
		else return SendClientMessage(playerid, COLOR_ROJO, "[Error]: Hora Feliz Esta Desactivada");
    	return 1;
	}
	if(Adentro[playerid] == 2)
    {
    	SendClientMessage(playerid,COLOR_RED,"No Puedes poner Comandos Utiliza /SalirMonster.");
		return 1;
	}
	if(Adentro[playerid] == 1)
    {
    	SendClientMessage(playerid,COLOR_RED,"No Puedes poner Comandos Utiliza /SalirJaula.");
		return 1;
	}
	if(Adentro[playerid] == 3)
	{
	    SendClientMessage(playerid,COLOR_RED,"No Puedes poner Comandos Utiliza /SalirJaula.");
		return 1;
	}

	if(strcmp(cmdtext,"/AyudaEvento",true)==0)
	{
		if(PlayerInfo[playerid][Level] >= 2) {
			ShowPlayerDialog(playerid,DIALOG_OTROS, DIALOG_STYLE_MSGBOX, "{00FF00}Ayuda /Evento:", "{FFFFF8}Administrador estos son los comandos de sistema /Evento, recuerde que usted es el responsable de la diversión.\n{209FF8}/Menueventos", "SALIR.", "");
		  	PlayerPlaySound(playerid,1139,0.0,0.0,0.0);
	    }
		return 1;
	}

//----------------------CMDS PREMIUN ----------------------------------//

	if(strcmp("/BalasON",cmdtext,true)==0)
	{
		if(GetPVarInt(playerid, "PREMIUM") == 4)
		{
			balason[playerid] = true;
			SendClientMessage(playerid, -1, "Activaste las balas explosivas");
			return 1;
		}
		else SendClientMessage(playerid, COLOR_ROJO, "ERROR: sólo usuarios premium 4.");
		return 1;
	}

	if(strcmp("/BalasOFF",cmdtext,true)==0)
	{
		if(GetPVarInt(playerid, "PREMIUM") == 4)
		{
			balason[playerid] = false;
			SendClientMessage(playerid, -1, "Desactivaste las balas explosivas.");
			return 1;
    	}
		else SendClientMessage(playerid, COLOR_ROJO, "ERROR: sólo usuarios premium 4.");
		return 1;
	}
	if(!strcmp("/Ayuda",cmdtext,true)){
		    new iString[2000], stringe[128];
		    format(stringe, 128, ""W"Bievenido querido "G"%s.\n\n",PlayerName2(playerid));
		    strcat(iString, string);
		    strcat(iString, ""W"Para comenzar te contaré acerca del modo de juego de servidor.\n");
		    strcat(iString, ""W"Básicamente se basa en Freeroam, puedes hacer lo que quieras\nsiguiendo las "G"/reglas.\n\n");
		    strcat(iString, ""W"Para poder sacar un auto usa: "G"/Menuautos\n");
		    strcat(iString, ""W"¿Quieres fundar tu clan? "G"/GHelp "W"para más información\n");
		    strcat(iString, ""W"¿No te agrada el clima o tiempo? "G"/Clima /Hora\n");
		    strcat(iString, ""W"Para sacar autos rápidamente prueba: "G"/V [Nombre], ejemplo /V Infernus\n");
		    strcat(iString, ""W"¿Te gustaría personalizar el vehículo? "G"/Tune\n");
		    strcat(iString, ""W"¿Tienes dudas? "G"/Admins, "W"pregunta.\n");
		    strcat(iString, ""W"¿Te gustaría ir hacia otro jugador? "G"/Ir /Bloquearir /Desbloquearir\n");
		    strcat(iString, ""W"Para enviar mensajes privados usa "G"/PM [ID] [Mensaje]\n");
		    strcat(iString, ""W"¿Te gustaría cambiar tu color? "G"/Colores\n");
		    strcat(iString, ""W"Para conocer más teles usa "G"/Teles /Teles2 /nTeles\n");
		    strcat(iString, ""W"¿Quieres ver tus estadísticas? "G"/Stats\n");
            strcat(iString, ""W"Para personalizar objectos usa: "G"/eObject\n");
            strcat(iString, ""W"Zona WW2: "G"/EWW /EWW2\n");
            strcat(iString, ""W"Armas: "G"/RW /WW2 /WW /RW2\n");
            strcat(iString, ""W"Para ver los mejores jugadores del momento: "G"/Top\n");
            strcat(iString, ""W"Para obtener más velocidad: "G"/Velocidad\n");
            strcat(iString, ""W"Para saltar: "G"/Saltos\n");
			ShowPlayerDialog(playerid,DIALOG_OTROS, DIALOG_STYLE_MSGBOX, ""G"Pura Joda "W"Ayuda", iString, "ENTENDIDO.", "");
		  	PlayerPlaySound(playerid,1139,0.0,0.0,0.0);
	return 1;
	}
	if(strcmp("/PComandos",cmdtext,true)==0)
    {
		if(GetPVarInt(playerid, "PREMIUM") == 1)
	    {
		    new iString[2000];

		    strcat(iString, "{FFFFFF}1) {00FF00}+25% de chaleco al entrar.\n");
		    strcat(iString, "{FFFFFF}2) {00FF00}/SaveSkin\n");
		    strcat(iString, "{FFFFFF}3) {00FF00}/UseSkin\n");
		    strcat(iString, "{FFFFFF}4) {00FF00}/FlipCar\n");
		    strcat(iString, "{FFFFFF}5) {00FF00}/Invisible\n");
		    strcat(iString, "{FFFFFF}6) {00FF00}/Desarmarme\n");


		    strcat(iString, "{FFFFFF}IMPORTANTE: Cualquier abuso de éstos comandos provocará\n suspensión inmediata del premium.\n");
			ShowPlayerDialog(playerid,DIALOG_OTROS, DIALOG_STYLE_MSGBOX, "{00FF00}CMDS PREMIUM LVL1.", iString, "ENTENDIDO.", "");
		  	PlayerPlaySound(playerid,1139,0.0,0.0,0.0);
			return 1;
		}

//===========================================================================================================//

		if(GetPVarInt(playerid, "PREMIUM") == 2)
	    {
		    new iString[2000];

		    strcat(iString, "{FFFFFF}1) {00FF00}+50% de chaleco al entrar.\n");
		    strcat(iString, "{FFFFFF}2) {00FF00}/SaveSkin\n");
		    strcat(iString, "{FFFFFF}3) {00FF00}/UseSkin\n");
		    strcat(iString, "{FFFFFF}4) {00FF00}/FlipCar\n");
		    strcat(iString, "{FFFFFF}5) {00FF00}/Invisible\n");
		    strcat(iString, "{FFFFFF}6) {00FF00}/Desarmarme\n");
		    strcat(iString, "{FFFFFF}7) {00FF00}/Noche\n");
		    strcat(iString, "{FFFFFF}8) {00FF00}/AnticaidasON\n");
		    strcat(iString, "{FFFFFF}9) {00FF00}/AnticaidasOFF\n");
		    strcat(iString, "{FFFFFF}10) {00FF00}/Saltarr\n");
		    strcat(iString, "{FFFFFF}11) {00FF00}/Digo\n");

		    strcat(iString, "{FFFFFF}IMPORTANTE: Cualquier abuso de éstos comandos provocará\n suspensión inmediata del premium.\n");
			ShowPlayerDialog(playerid,DIALOG_OTROS, DIALOG_STYLE_MSGBOX, "{00FF00}CMDS PREMIUM LVL2.", iString, "ENTENDIDO.", "");
		  	PlayerPlaySound(playerid,1139,0.0,0.0,0.0);
			return 1;
		}
//===========================================================================================================//

		if(GetPVarInt(playerid, "PREMIUM") == 3)
	    {
		    new iString[2000];

		    strcat(iString, "{FFFFFF}1) {00FF00}+75% de chaleco al entrar.\n");
		    strcat(iString, "{FFFFFF}2) {00FF00}/SaveSkin\n");
		    strcat(iString, "{FFFFFF}3) {00FF00}/UseSkin\n");
		    strcat(iString, "{FFFFFF}4) {00FF00}/FlipCar\n");
		    strcat(iString, "{FFFFFF}5) {00FF00}/Invisible\n");
		    strcat(iString, "{FFFFFF}6) {00FF00}/Desarmarme\n");
		    strcat(iString, "{FFFFFF}7) {00FF00}/Noche\n");
		    strcat(iString, "{FFFFFF}8) {00FF00}/AnticaidasON\n");
		    strcat(iString, "{FFFFFF}9) {00FF00}/AnticaidasOFF\n");
		    strcat(iString, "{FFFFFF}10) {00FF00}/Saltarr\n");
		    strcat(iString, "{FFFFFF}11) {00FF00}/Digo\n");
		    strcat(iString, "{FFFFFF}12) {00FF00}/Rapidoo\n");
		    strcat(iString, "{FFFFFF}13) {00FF00}/Noche\n");
		    strcat(iString, "{FFFFFF}14) {00FF00}/pHighLight");
		    //strcat(iString, "{FFFFFF}14) {00FF00}/AnticaidasON\n");
		    //strcat(iString, "{FFFFFF}4) {00FF00}/AnticaidasOFF\n");
		    //strcat(iString, "{FFFFFF}5) {00FF00}/Saltarr\n");
		    //strcat(iString, "{FFFFFF}6) {00FF00}/Digo\n");
		    strcat(iString, "{FFFFFF}IMPORTANTE: Cualquier abuso de éstos comandos provocará\n suspensión inmediata del premium.\n");
			ShowPlayerDialog(playerid,DIALOG_OTROS, DIALOG_STYLE_MSGBOX, "{00FF00}CMDS PREMIUM LVL3.", iString, "ENTENDIDO.", "");
		  	PlayerPlaySound(playerid,1139,0.0,0.0,0.0);
		  	return 1;
		}
//===========================================================================================================//}


		if(GetPVarInt(playerid, "PREMIUM") == 4)
	    {
		    new iString[2000];
		    strcat(iString, "{FFFFFF}1) {00FF00}+100% de chaleco al entrar.\n");
		    strcat(iString, "{FFFFFF}2) {00FF00}/SaveSkin\n");
		    strcat(iString, "{FFFFFF}3) {00FF00}/UseSkin\n");
		    strcat(iString, "{FFFFFF}4) {00FF00}/FlipCar\n");
		    strcat(iString, "{FFFFFF}5) {00FF00}/Invisible\n");
		    strcat(iString, "{FFFFFF}6) {00FF00}/Desarmarme\n");
		    strcat(iString, "{FFFFFF}7) {00FF00}/Noche\n");
		    strcat(iString, "{FFFFFF}8) {00FF00}/AnticaidasON\n");
		    strcat(iString, "{FFFFFF}9) {00FF00}/AnticaidasOFF\n");
		    strcat(iString, "{FFFFFF}10) {00FF00}/Saltarr\n");
		    strcat(iString, "{FFFFFF}11) {00FF00}/Digo\n");
		    strcat(iString, "{FFFFFF}12) {00FF00}/Rapidoo\n");
		    strcat(iString, "{FFFFFF}13) {00FF00}/Noche\n");
		    strcat(iString, "{FFFFFF}14) {00FF00}/pGod - pGodOFF\n");
		    strcat(iString, "{FFFFFF}15) {00FF00}/pWarn\n");
		    strcat(iString, "{FFFFFF}16) {00FF00}/pDigo\n");
		    strcat(iString, "{FFFFFF}17) {00FF00}/pGodcar\n");
		    strcat(iString, "{FFFFFF}18) {00FF00}/pGranadas\n");
		    strcat(iString, "{FFFFFF}19) {00FF00}/pDie\n");
		    strcat(iString, "{FFFFFF}20) {00FF00}/rapidoo2 (Activar con nitro)\n");
		    strcat(iString, "{FFFFFF}21) {00FF00}/IronMan\n");
		    strcat(iString, "{FFFFFF}22) {00FF00}/pSpec\n");
		    strcat(iString, "{FFFFFF}23) {00FF00}/pSpecoff\n");
		    strcat(iString, "{FFFFFF}24) {00FF00}/Saltarr2 (Activar con TAB)\n");

		    strcat(iString, "{FFFFFF}IMPORTANTE: Cualquier abuso de éstos comandos\n provocará suspensión inmediata del premium.\n");
		    strcat(iString, "{FFFFFF}IMPORTANTE: Tienes acceso de admin básico, si \nllegas a abusar de el serás suspendido.\n");
			ShowPlayerDialog(playerid,DIALOG_OTROS, DIALOG_STYLE_MSGBOX, "{00FF00}CMDS PREMIUM LVL4.", iString, "ENTENDIDO.", "");
		  	PlayerPlaySound(playerid,1139,0.0,0.0,0.0);
		  	CMDMessagePremiums(playerid,"PCOMANDOS");
		  	return 1;

		} else return SendClientMessage(playerid, COLOR_ROJO, "ERROR: sólo usuarios premium.");
	}

//=========================================================================================================================================
    if(strcmp(cmd, "/pwarn", true) == 0)
    {
        if(GetPVarInt(playerid, "PREMIUM") >= 4)
        {
            new Razon[128];
            cmd = strtok(cmdtext, idx);
            if(!strlen(cmd)) return SendClientMessage(playerid, red, "USAGE: /warn [playerid] [reason]");
            new warned = strval(cmd);
            Razon= strrest(cmdtext, idx);
            if(!strlen(Razon)) return SendClientMessage(playerid, red, "USAGE: /warn [playerid] [reason]");
            if(PlayerInfo[warned][Level] == ServerInfo[MaxAdminLevel] && PlayerInfo[playerid][Level] != ServerInfo[MaxAdminLevel]) return SendClientMessage(playerid,red,"ERROR: You cannot use this command on this admin");
            if(IsPlayerConnected(warned) && warned != INVALID_PLAYER_ID) {
                if(warned != playerid) {
                    CMDMessageToAdmins(playerid,"pWARN(premiumuser)");
                    CMDMessagePremiums(playerid,"PWARN");
                    PlayerInfo[warned][Warnings]++;
                    if( PlayerInfo[warned][Warnings] == MAX_WARNINGS) {
                        new str[256];
                        format(str, sizeof (str), "***Premium \"%s\" kickeó a \"%s\".  Razón: %s [Advertencia: %d/%d.]***", pName(playerid), pName(warned), Razon, PlayerInfo[warned][Warnings], MAX_WARNINGS);
                        SendClientMessageToAll(YELLOW, str);
                        new d,m,a,h,me,s; gettime(h,m,s); getdate(a,me,d);
						new formatmensaje[350]; format(formatmensaje, sizeof(formatmensaje), "{FF0000}Fuiste \"kickeado\" del servidor\n{FFFF00}User: {FF0000}%s\n{FFFF00}Administrador: {FF0000}%s\n{FFFF00}Razón: {FF0000}%s [3/3]\n{FFFF00}Fecha: {FF0000}%d/%d/%d\n{FFFF00}Hora: {FF0000}%d:%d hs\n\n{FF0000}Advertencia: {FFFFFF}Toma Screen de esto para reclamar en\ncaso que sea injusto", PlayerName2(warned), PlayerName2(playerid), Razon, d, m, a, h, m);
						ShowPlayerDialog(warned, DIALOG_OTROS, DIALOG_STYLE_MSGBOX, "Fuiste Expulsado", formatmensaje, "Ok", "");
                        SaveToFile("premiumKickLog",str);
                        SetTimerEx("Kickeado", 500, false, "i", warned);
                        PlayerInfo[warned][Warnings] = 0;
                    } else {
                        new str[256];
                        format(str, sizeof (str), "***Premium \"%s\" advirtió a \"%s\". Razón: %s  [Advertencia: %d/%d.]***", pName(playerid), pName(warned), Razon, PlayerInfo[warned][Warnings], MAX_WARNINGS);
                        SendClientMessageToAll(YELLOW, str);
                        SaveToFile("premiumWarnLog",str);
                    }
                } else return SendClientMessage(playerid, red, "ERROR: You cannot warn yourself");
            } else return SendClientMessage(playerid, red, "ERROR: Player is not connected");
        } else return SendClientMessage(playerid,red,"ERROR: USTED NO TIENE PRIVILEGIOS SUFICIENTES.");
		return 1;
    }

	if(strcmp(cmd, "/velocidad", true) == 0)
    {
	if(Velocity[playerid]){
	Velocity[playerid] = 0;
	SendClientMessage(playerid, LIGHTGREEN, "[Pura Joda] Ha desactivado la velocidad con 'CTRL'");
	}
	else{
	Velocity[playerid] = 1;
	SendClientMessage(playerid, LIGHTGREEN, "[Pura Joda] Ha activado la velocidad con 'CTRL'");
	}

		return 1;
	}
   if(strcmp("/Drift", cmdtext, true, 10) == 0)
   {
      if (EnDrift[playerid] == 1) return SendClientMessage(playerid, 0xFF0000FF, "[Error] Ya estas en /Drift!");
      if (TotalEnDrift == 2) return SendClientMessage(playerid, 0xFF0000FF, "[Error] Ya hay 2 concursantes en /Drift!");
        if (IsPlayerInAnyVehicle(playerid))
      {
          new nombre[MAX_PLAYER_NAME], vehiculo, string78[256];
          GetPlayerName(playerid, nombre, sizeof(nombre));
          vehiculo = GetPlayerVehicleID(playerid);
          format(string78, sizeof(string78), ""G"[Pura Joda] "W"%s "G"ha entrado a "W"/Drift!", nombre);
          if (TotalEnDrift == 0)
          {
            EnDrift[playerid] = 1;
            TotalEnDrift = 1;
            SendClientMessage(playerid, 0x00C800FF, "Entraste exitosamente al Drift!");
            SendClientMessageToAll(0xFFC800FF, string78);
            SetVehiclePos(vehiculo, 2320.6243,1393.8121,42.6360);
            SetVehicleZAngle(vehiculo, 358.7545);
            PutPlayerInVehicle(playerid, vehiculo, 0);
            SetCameraBehindPlayer(playerid);
            TogglePlayerControllable(playerid, false);
            SetTimerEx("Esperar", 0, false, "d", playerid);
         }
         else if (TotalEnDrift == 1)
         {
            EnDrift[playerid] = 1;
            TotalEnDrift = 2;
            SendClientMessage(playerid, 0x00C800FF, "Entraste exitosamente al Drift! pasa salir usa /SalirDrift");
            SendClientMessageToAll(0xFFC800FF, string78);
            SetVehiclePos(vehiculo, 2333.2754,1393.8746,42.6379);
            SetVehicleZAngle(vehiculo, 358.7545);
            PutPlayerInVehicle(playerid, vehiculo, 0);
            SetCameraBehindPlayer(playerid);
            TogglePlayerControllable(playerid, false);
            SetTimerEx("Esperar", 0, false, "d", playerid);
         }
      }
      else return SendClientMessage(playerid, 0xFF0000FF, "[ERROR] Necesitas un vehiculo para concursar!");
      return 1;
   }
       if (strcmp("/salirdrift", cmdtext, true, 10) == 0)
       {
        if(TotalEnDrift == 2) return SendError(playerid, "Ya hay 2 concursantes en Drift! no puedes salir");
            TogglePlayerControllable(playerid, 1);
           if(TotalEnDrift == 2)SendClientMessage(playerid, 0x00C800FF, "Has salido de Drift.");
           EnDrift[playerid] = 0;
           TotalEnDrift = 0;
	return 1;
   }

/*    if (strcmp("/Superstunt1", cmdtext, true, 10) == 0)
    {
 //                         Super Stunt Drift
        SetPlayerPos(playerid, 070.8862304688,-2250.9711914063,403.73211669922); //Player possition
        SetPlayerFacingAngle(playerid, 309.0133); //Facing angle of the player
                return 1; //line it correct, i dont know why i cant set it here on forum
    }
*/
if (!strcmp("/stuntroad",cmdtext,true))
{
	SetPlayerInterior(playerid,0);
//                           Stunt Road
	if (GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	{
		LinkVehicleToInterior(GetPlayerVehicleID(playerid),0);
		SetVehiclePos(GetPlayerVehicleID(playerid),-804.0,-566.0,2189.0);
		SetVehicleZAngle(GetPlayerVehicleID(playerid),0.0);
	}
	else
	{
		SetPlayerPos(playerid,-804.0,-566.0,2189.0);
		SetPlayerFacingAngle(playerid,0.0);
	}
	return 1;
}
if (!strcmp("/racetrack",cmdtext,true))
{
	SetPlayerInterior(playerid,0);
	if (GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	{
		LinkVehicleToInterior(GetPlayerVehicleID(playerid),0);
		SetVehiclePos(GetPlayerVehicleID(playerid),-521.0,-3643.0,7.0);
		SetVehicleZAngle(GetPlayerVehicleID(playerid),0.0);
	}
	else
	{
		SetPlayerPos(playerid,-521.0,-3643.0,7.0);
		SetPlayerFacingAngle(playerid,0.0);
	}
	return 1;
}
	if (strcmp("/OffRoad3", cmdtext, true, 10) == 0) {
	SetPlayerPos(playerid,2357.2250,1317.135,10.098);
	SendClientMessage(playerid,COLOR_RED,"Bienvenido a OffRoad");
    ResetPlayerWeapons(playerid);
	return 1;
	}
	if (strcmp("/DriftTrack", cmdtext, true, 10) == 0) {
	SetPlayerPos(playerid,1131.369,1317.135,10.098);
	SendClientMessage(playerid,COLOR_RED,"Bienvenido a DriftTrack");
    ResetPlayerWeapons(playerid);
	return 1;
	}
    if (strcmp("/jumphelp", cmdtext, true) == 0)
	{
		if(IsPlayerAdmin(playerid))
		{
		    SendClientMessage(playerid, 0x7CFC00AA, "[COMMANDS]: /Saltar  **  /stopjump  **  /jumphighscore(s) (o /jhs)  ** /jumpadmin");
		}
		else
		{
		    SendClientMessage(playerid, 0x7CFC00AA, "[COMMANDS]: /Saltar  **  /stopjump  **  /jumphighscore(s) (o /jhs)");
		}
	    return 1;
	}
	if (strcmp("/jump", cmdtext, true) == 0)
	{
  		if(Racer != -1) return SendClientMessage(playerid, 0xFF0000AA, "[Pura Joda] Se encuentra ocupado.");

        Racer = playerid;
        Motor = CreateVehicle(BikeModel, 424.0586,2502.778076,16.2115, 90.0000, 0, 6, -1);
        PutPlayerInVehicle(playerid, Motor, 0);
		SetCameraBehindPlayer(playerid);
		Timer1 = SetTimer("Countdown", 1000, 1);
		GameTextForPlayer(Racer, "~b~5", 3000, 3);
		TogglePlayerControllable(playerid, 0);
		Count2 = 0;
		Distance = 0.0;
		format(TDS4, sizeof(TDS4), "Distancia: 0.0000~n~Tiempo: 0:20");
		TextDrawSetString(TD3, TDS4);
		TextDrawShowForPlayer(Racer, TD3);
        new nombre[MAX_PLAYER_NAME], string5[256];
        GetPlayerName(playerid, nombre, sizeof(nombre));
        format(string5, sizeof(string5), ""G"[Pura Joda] "W"%s "G"ha entrado al minijuego "W"/Jump", nombre);
        SendClientMessageToAll(0xFFC800FF, string5);
		return 1;
	}

	if (strcmp("/stopjump", cmdtext, true) == 0)
	{
	    EndRace();
	    return 1;
	}

	if ((strcmp("/jumphighscore", cmdtext, true) == 0) || (strcmp("/jumphighscore", cmdtext, true) == 0) || (strcmp("/jhs", cmdtext, true) == 0))
	{
		new str[128];
		SendClientMessage(playerid, 0x32CD32AA, "-------[JUMP MINIGAME PUNTUACIONES]-------");
		format(str, 128, "#1:   %.4f     %s", HS[0], HSN[0]);
		SendClientMessage(playerid, 0x7CFC00AA, str);
		format(str, 128, "#2:   %.4f     %s", HS[1], HSN[1]);
		SendClientMessage(playerid, 0x7CFC00AA, str);
		format(str, 128, "#3:   %.4f     %s", HS[2], HSN[2]);
		SendClientMessage(playerid, 0x7CFC00AA, str);
		SendClientMessage(playerid, 0x7CFC00AA, " ");
		format(str, 128, "Su Puntuación personal:    %.4f", dini_Float(PERSONALFILE, PlayerName2(playerid)));
		SendClientMessage(playerid, 0x7CFC00AA, str);
		SendClientMessage(playerid, 0x32CD32AA, "--------------------------------------------------------------");
	    return 1;
	}

	if (strcmp("/jumpadmin", cmdtext, true) == 0)
	{
	    if(!IsPlayerAdmin(playerid)) return 0;
	    TogglePlayerControllable(playerid, 0);
	    ShowMenuForPlayer(AdminMenu, playerid);
	    return 1;
	}
	if (strcmp("/Tune", cmdtext, true, 10) == 0 || strcmp("/Tuning", cmdtext, true, 10) == 0)
	{
		if (IsPlayerInAnyVehicle(playerid))
        {
        ShowPlayerDialog(playerid, Tuning, DIALOG_STYLE_LIST, "Menú Tuning", "Ruedas\nColores\nPaintjobs\nNitro\nHidraulicos\nSideskirts\nTubos De Escape\nReparar\nFlip\nAuto1\nAuto2\nAuto3", "Seleccionar", "Cancelar");
        }
 	    else return SendClientMessage(playerid, Rojo, "Necesitas Estar En Un Coche Para Utilizar El Menu Tuning.");
		return 1;
	}
	if(strcmp(cmd, "/pGod", true) == 0)
    {
    	if(GetPVarInt(playerid, "PREMIUM")  >= 4)
		{
			if(PlayerEnPGOD[playerid] == 0)
			{
    			ResetPlayerWeapons(playerid);
    			CMDMessagePremiums(playerid,"PGOD");
    			SetPlayerHealth(playerid, 9999999999);
    			GameTextForPlayer(playerid,"~w~vida infinita~n~~r~activada!",5000,5);
    			VidaI[playerid] = Create3DTextLabel("GOD PREMIUM",0xFFFFFF,30.0,40.0,50.0,40.0,0);
    			Attach3DTextLabelToPlayer(VidaI[playerid], playerid, 0.0, 0.0, 0.7);
    			PlayerEnPGOD[playerid]++;
    		} else return SendClientMessage(playerid, COLOR_ROJO, "Ya estas usando Premium GOD");
    	}
		else return SendClientMessage(playerid, COLOR_ROJO, "Sólo usuarios premium nivel 4.");
		return 1;
	}
	if(strcmp(cmd, "/ironman", true) == 0)
	{
    	if(GetPVarInt(playerid, "PREMIUM") <= 3) return SendClientMessage(playerid, RED,"SÓLO PREMIUMS LVL 4");
    	if(GetPlayerState(playerid)!=PLAYER_STATE_ONFOOT) return false;
        if(!Ironman[playerid][ActivarIronman]) {
			SetPlayerArmedWeapon(playerid,0);
			Ironman[playerid][TurbinasIronman] = 1.0;
			new Float:Health[2]; GetPlayerHealth(playerid,Health[0]);
			GetPlayerArmour(playerid, Health[1]);
	        Ironman[playerid][EnergiaIronman][0] = Health[0];
	        Ironman[playerid][EnergiaIronman][1] = Health[1];
	        Ironman[playerid][VestimentaTony] = GetPlayerSkin(playerid);
	        SetPlayerHealth(playerid, (Float:0x7F800000));
	        SetPlayerArmour(playerid, (Float:0x7F800000));
	        SetPlayerSkin(playerid, 3);
	        CMDMessagePremiums(playerid,"IRONMAN");
	        SetPlayerVelocity(playerid, 0, 0, 0);
	        Ironman[playerid][IronmanVolando]=false;
			Ironman[playerid][ActivarIronman] = true;
			KillTimer(Ironman[playerid][MatarIronman][0]);
			Ironman[playerid][MatarIronman][0] = SetTimerEx("UpdateJarvisIronman", 500, true, "d", playerid);
			//SendClientMessage(playerid, -1, "JARVIS: Señor, usted se ha colocado el traje 'Ironman'!.");
			ApplyAnimation(playerid,"CARRY","crry_prtial",4.0,0,0,0,0,0);
			for(new index=0; index<6; index++) { RemovePlayerAttachedObject(playerid,index); }
        } else {
	        Ironman[playerid][TurbinasIronman] = -1;
	        SetPlayerHealth(playerid, Ironman[playerid][EnergiaIronman][0]);
	        SetPlayerArmour(playerid, Ironman[playerid][EnergiaIronman][1]);
	        SetPlayerSkin(playerid, Ironman[playerid][VestimentaTony]);
	        SetPlayerVelocity(playerid, 0, 0, 0);
	        Ironman[playerid][IronmanVolando]=false;
			Ironman[playerid][ActivarIronman] = false;
			KillTimer(Ironman[playerid][MatarIronman][0]);
			SendClientMessage(playerid, -1, "JARVIS: Señor, usted se ha quitado el traje 'Ironman'!.");
 			ApplyAnimation(playerid,"CARRY","crry_prtial",4.0,0,0,0,0,0);
    		for(new index=0; index<6; index++) { RemovePlayerAttachedObject(playerid,index); }
        }
        return true;
	}


	    if(strcmp(cmd, "/pspecoff", true) == 0)
    {
    	if(GetPVarInt(playerid, "PREMIUM")  >= 4)
		{
			if(PlayerEnPGOD[playerid] == 0) return SendClientMessage(playerid, COLOR_ROJO, "Usted no esta usando Premium GOD");
		//	PlayerEnPGOD[playerid]--;
			CMDMessagePremiums(playerid,"PSPECOFF");
    		SetPlayerHealth(playerid, 100);
    		Delete3DTextLabel(Text3D:VidaI[playerid]);
    		GameTextForPlayer(playerid,"~w~vida infinita~n~~r~desactivada!",5000,5);
    	}
		else return SendClientMessage(playerid, COLOR_ROJO, "Sólo usuarios premim nivel 4");
		return 1;
	}

    if(strcmp(cmd, "/pGodoff", true) == 0)
    {
    	if(GetPVarInt(playerid, "PREMIUM")  >= 4)
		{
			if(PlayerEnPGOD[playerid] == 0) return SendClientMessage(playerid, COLOR_ROJO, "Usted no esta usando Premium GOD");
			PlayerEnPGOD[playerid]--;
			CMDMessagePremiums(playerid,"PGODOFF");
    		SetPlayerHealth(playerid, 100);
    		Delete3DTextLabel(Text3D:VidaI[playerid]);
    		GameTextForPlayer(playerid,"~w~vida infinita~n~~r~desactivada!",5000,5);
    	}
		else return SendClientMessage(playerid, COLOR_ROJO, "Sólo usuarios premim nivel 4");
		return 1;
	}

    if(strcmp(cmd, "/pGodcar", true) == 0)
    {
    	if(GetPVarInt(playerid, "PREMIUM")  >= 4)
		{
            CMDMessagePremiums(playerid,"PGODCAR");
    		PlayerInfo[playerid][GodCar] = 1;
    		GameTextForPlayer(playerid,"~w~carro indestructible~n~~r~~h~activado!",5000,5);
    	}
		else return SendClientMessage(playerid, COLOR_ROJO, "Sólo usuarios premim nivel 4");
		return 1;
	}


    if(strcmp(cmd, "/pGodcaroff", true) == 0)
    {
    	if(GetPVarInt(playerid, "PREMIUM")  >= 4)
		{
            if(!IsPlayerInAnyVehicle(playerid))
			{
				SendClientMessage(playerid, Rojo, "<!> No estás en ningún vehículo!");
				return 1;
			}
			CMDMessagePremiums(playerid,"PGODCAROFF");
    		PlayerInfo[playerid][GodCar] = 0;
    		GameTextForPlayer(playerid,"~w~carro indestructible~n~~r~~h~desactivado!",5000,5);
    	}
		else return SendClientMessage(playerid, COLOR_ROJO, "Sólo usuarios premim nivel 4");
		return 1;
	}

    if(strcmp(cmd, "/rapidoo2", true) == 0)
    {
    	if(GetPVarInt(playerid, "PREMIUM")  >= 4)
		{
            CMDMessagePremiums(playerid,"RAPIDOO2");
        	if(!IsPlayerInAnyVehicle(playerid))
			{
				SendClientMessage(playerid, Rojo, "[Pura Joda] No estás en ningún auto.");
				return 1;
			}
			if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
			{
            	SendClientMessage(playerid, Rojo, "[Pura Joda] Necesitas ser el conductor");
				return 1;
			}
			if(AceleracionBrutal[playerid] == false)
			{
				#if defined MENSAJE_EN_CHAT
				SendClientMessage(playerid, COLOR_VERDE_CLARO, "[Pura Joda] Rapidoo versión 2.0 activado!");
				#else
				GameTextForPlayer(playerid, "~w~SUPER VELOCIDAD: ~g~~H~ON", 3000, 3);
				#endif
				AceleracionBrutal[playerid] = true;
			}
			else if(AceleracionBrutal[playerid] == true)
			{
				#if defined MENSAJE_EN_CHAT
				SendClientMessage(playerid, COLOR_VERDE_CLARO, "[Pura Joda] Rapidoo versión 2.0 activado!");
				#else
            	GameTextForPlayer(playerid, "~w~SUPER VELOCIDAD: ~r~~H~OFF", 3000, 3);
				#endif
				AceleracionBrutal[playerid] = false;
			}
			return 1;
		}
		return 0;
	}
//=========================================================================================

	if (strcmp("/anticaidason", cmdtext, true) == 0)
	{

		if(GetPVarInt(playerid, "PREMIUM")  >= 2)
		{
			Act[playerid] = 1;
			GameTextForPlayer(playerid, "~w~Anti Caidas de moto ~g~Activado", 4000, 5);
		}
		return 1;
	}
	if (strcmp("/anticaidasoff", cmdtext, true) == 0)
	{
		if(GetPVarInt(playerid, "PREMIUM")  >= 2)
		{
			GameTextForPlayer(playerid, "~w~Anti Caidas de moto ~r~Desactivado", 4000, 5);
			Act[playerid] = 0;
		}
		return 1;
	}

    if(strcmp(cmdtext,"/Dia",true)==0)
    {
    	if(GetPVarInt(playerid, "PREMIUM")  >= 4)
		{
            CMDMessagePremiums(playerid,"DIA");
			SetPlayerTime(playerid, 12,0);
			GameTextForPlayer(playerid,"~w~Ahora es de ~y~~h~dia.",6000,5);
		}
		else return SendClientMessage(playerid, COLOR_ROJO, "Sólo premium 4.");
		return 1;
	}

    if(strcmp(cmdtext,"/Noche",true)==0)
    {
    	if(GetPVarInt(playerid, "PREMIUM")  >= 4)
		{
			SetPlayerTime(playerid, 00,0);
			CMDMessagePremiums(playerid,"NOCHE");
			GameTextForPlayer(playerid,"~w~¡Ahora es de ~b~noche~w~!",6000,5);
		}
		else return SendClientMessage(playerid, COLOR_ROJO, "Sólo premium 4.");
		return 1;
	}

	if (strcmp("/digo", cmd, true) == 0)
    {
		if(GetPVarInt(playerid, "PREMIUM")  >= 2)
    	{
    		new  vip[MAX_PLAYER_NAME];
			new tpm[256];
    		tpm = strtok(cmdtext, idx);
    		if(strlen(tpm) == 0) return SendClientMessage(playerid, COLOR_ROJO, "ERROR: /digo texto.");
    		GetPlayerName(playerid, vip, MAX_PLAYER_NAME);
    		format(string, 256, "Premium | %s [%d] dice: %s.", vip, playerid, cmdtext[6]);
    		SendClientMessageToAll(0xFF6B00FF,string);
    	}
    	else return SendClientMessage(playerid, COLOR_ROJO, "[Pura Joda] sólo premiums lvl 2.");
    	return 1;
	}

	if (strcmp("/nameoff", cmdtext, true, 10) == 0)
	{
		if(GetPVarInt(playerid, "PREMIUM")  >= 3)
		{
			for(new i = 0; i < MAX_PLAYER; i++) ShowPlayerNameTagForPlayer(i, playerid, false);
			GameTextForPlayer(playerid, "~g~Nick ~R~invisible", 5000, 5);
			SendClientMessage(playerid, COLOR_GREEN, "Ahora tu nick en la cabeza es invisible, usa /nameon para que sea visible de nuevo");
			return 1;
		}
		else return SendClientMessage(playerid, COLOR_ROJO, "[Error]: Comando Solo Para Usuarios Premium Nivel 3");
	}
//==============================================================================
	if (strcmp("/nameon", cmdtext, true, 10) == 0)
	{
		if(GetPVarInt(playerid, "PREMIUM")  >= 3)
		{
			for(new i = 0; i < MAX_PLAYER; i++) ShowPlayerNameTagForPlayer(i, playerid, true);
			GameTextForPlayer(playerid, "~g~Nick ~R~ON", 5000, 5);
			SendClientMessage(playerid, COLOR_GREEN, "Ahora tu nick en la cabeza sera visible de nuevo");
			return 1;
		}
		else return SendClientMessage(playerid, COLOR_ROJO, "[Error]: Comando Solo Para Usuarios Premium Nivel 3");
	}


	if (strcmp("/pdigo", cmd, true) == 0)
	{
		if(GetPVarInt(playerid, "PREMIUM")  >= 4)
    	{
	    	new  vip[MAX_PLAYER_NAME];
			new tpm[256];
	    	tpm = strtok(cmdtext, idx);
	    	if(strlen(tpm) == 0) return SendClientMessage(playerid, COLOR_ROJO, "ERROR: /pdigo texto.");
	    	GetPlayerName(playerid, vip, MAX_PLAYER_NAME);
	    	format(string, 256, "*** Premium  | %s [%d] dice: %s.", vip, playerid, cmdtext[6]);
	    	SendClientMessageToAll(LIGHTGREEN,string);
	    	CMDMessagePremiums(playerid,"PDIGO");
	    	for(new i = 0; i < MAX_PLAYER; i++) {
				if(IsPlayerConnected(i))
			    {
					PlayerPlaySound(i,1057,0.0,0.0,0.0);
				}
			}
	    }
	    else return SendClientMessage(playerid, COLOR_ROJO, "[Pura Joda] sólo premiums lvl 2.");
	    return 1;
	}

	/////////////////////////////////////////////=========================================================



	if (strcmp("/Vida", cmd, true) == 0)
    {
    	if(GetPVarInt(playerid, "PREMIUM")  <= 3) return SendClientMessage(playerid, red, "[ERROR]: SÓLO USUARIOS PREMIUM LVL4.");
		if(vida[playerid] == 1)  return SendClientMessage(playerid, red, "[Pura Joda] Sólo puedes usar este comando cada 2 minutos.");
    	SetPlayerHealth(playerid, Cantidaddevida);
    	CMDMessagePremiums(playerid,"VIDA");
    	vida[playerid] = 1;
		tiempoenvida[playerid] = SetTimerEx("vidatimer", 120000, false, "i", playerid);
		return 1;
    }


   	if (strcmp("/pGranadas", cmd, true) == 0)
    {
    	if(GetPVarInt(playerid, "PREMIUM")  <= 3) return SendClientMessage(playerid, red, "[ERROR]: SÓLO USUARIOS PREMIUM LVL4.");
		if(granadas[playerid] == 1)  return SendClientMessage(playerid, red, "[Pura Joda] Sólo puedes usar este comando cada 5 minutos.");
    	GivePlayerWeapon(playerid, 16, 30);
    	SendClientMessage(playerid, LIGHTGREEN,"[Pura Joda] Toma tus granadas.");
    	granadas[playerid] = 1;
		tiempoengranadas[playerid] = SetTimerEx("granadastimer", 300000, false, "i", playerid);
		CMDMessagePremiums(playerid,"PGRANADAS");
		return 1;
    }


	if (strcmp("/pDie", cmd, true) == 0)
	{
    	if(GetPVarInt(playerid, "PREMIUM")  <= 3) return SendClientMessage(playerid, red, "[ERROR]: SÓLO USUARIOS PREMIUM LVL4.");
		if(pdie[playerid] == 1)  return SendClientMessage(playerid, red, "[Pura Joda] Sólo puedes usar este comando cada 1 minuto(s).");
		new Float:x, Float:y, Float:z ;
    	SendClientMessage(playerid, LIGHTGREEN,"[Pura Joda] Has creado una explosión.");
    	pdie[playerid] = 1;
    	CMDMessagePremiums(playerid,"PDIE");
		tiempoenpdie[playerid] = SetTimerEx("pdietimer", 60000, false, "i", playerid);
		CreateExplosion(Float:x+10, Float:y, Float:z, 8,10.0);
		CreateExplosion(Float:x-10, Float:y, Float:z, 8,10.0);
		CreateExplosion(Float:x, Float:y+10, Float:z, 8,10.0);
		CreateExplosion(Float:x, Float:y-10, Float:z, 8,10.0);
		CreateExplosion(Float:x+10, Float:y+10, Float:z, 8,10.0);
		CreateExplosion(Float:x-10, Float:y+10, Float:z, 8,10.0);
		return CreateExplosion(Float:x-10, Float:y-10, Float:z, 8,10.0);
		//return 1;
    }
//===========================================================================================================//
    if (strcmp("/Chaleco", cmd, true) == 0)
    {
    	if(GetPVarInt(playerid, "PREMIUM")  <= 3) return SendClientMessage(playerid, red, "[ERROR]: SÓLO USUARIOS PREMIUM LVL4.");
		if(chaleco[playerid] == 1)  return SendClientMessage(playerid, red, "[Pura Joda] Sólo puedes usar este comando cada 2 minutos.");
 		SetPlayerArmour(playerid, Cantidaddearmadura);
 		SendClientMessage(playerid, LIGHTGREEN, "[Pura Joda] ¡Chaleco regenerado!");
    	chaleco[playerid] = 1;
    	CMDMessagePremiums(playerid,"CHALECO");
		tiempoenchaleco[playerid] = SetTimerEx("chalecotimer", 120000, false, "i", playerid);
    	return 1;
    }

//===========================================================================================================//

	if (strcmp("/desarmarme", cmd, true) == 0)
    {
		if(GetPVarInt(playerid, "PREMIUM")  >= 2)
		{
			ResetPlayerWeapons(playerid);
			CMDMessagePremiums(playerid,"DESARMAME");
			SendClientMessage(playerid, COLOR_BLANCO, "Desarmado!");
			return 1;
		}
		else return SendClientMessage(playerid, COLOR_ROJO, "[Error]: Comando Solo Para Usuarios Premium Nivel 3");
	}
//===========================================================================================================//
	if (strcmp("/punfreeze", cmdtext, true, 10) == 0)
	{
	    if(GetPVarInt(playerid, "MINION") == 1) return SendClientMessage(playerid, 0xFF0000, "Error: estas en minijuego");
		if(GetPVarInt(playerid, "PREMIUM")  >= 2)
		{
    	    TogglePlayerControllable(playerid,1);
    	    CMDMessagePremiums(playerid,"PUNFREEZE");
    	    SendClientMessage(playerid, COLOR_ROJO, "Has Sido Unfreezeado.");
		    return 1;
		}
		else return SendClientMessage(playerid, COLOR_ROJO, "[Error]: Comando Solo Para Usuarios Premium Nivel 2");
	}
//===========================================================================================================//

	if (strcmp("/Pjetpack", cmdtext, true, 10) == 0)
	{
	    if(GetPVarInt(playerid, "MINION") == 1) return SendClientMessage(playerid, 0xFF0000, "Error: estas en minijuego");
		if(GetPVarInt(playerid, "PREMIUM")  >= 2)
		{
    	    SetPlayerSpecialAction(playerid, 2);
		    return 1;
		}
		else return SendClientMessage(playerid, COLOR_ROJO, "[Error]: Comando Solo Para Usuarios Premium Nivel 2");
	}

//===========================================================================================================//
	if (strcmp("/Invisible", cmdtext, true, 10) == 0)
	{
		if(GetPVarInt(playerid, "PREMIUM")  >= 1)
		{
			SetPlayerColor(playerid,COLOR_INVISIBLE);
			CMDMessagePremiums(playerid,"INVISIBLE");
    		SendClientMessage(playerid, COLOUR_WHITE, "Actualmente eres invisible.");
		    return 1;
		}
		else return SendClientMessage(playerid, COLOR_ROJO, "[Error]: Comando Solo Para Usuarios Premium Nivel 1");
	}
//===========================================================================================================//
    if(strcmp("/Rapidoo", cmdtext, true, 10) == 0)
	{
 		if(GetPVarInt(playerid, "PREMIUM")  >= 3)
		{
  			new Float:x, Float:y, Float:z;
        	GetVehicleVelocity(GetPlayerVehicleID(playerid),x,y,z);
    		SetVehicleVelocity(GetPlayerVehicleID(playerid),x*3,y*3,z*3);
	    	return 1;
		}
		else return SendClientMessage(playerid, COLOR_ROJO, "ERROR: sólo premiums nivel 3.");
	}

   	    if(strcmp("/saltarr", cmdtext, true, 10) == 0)
	     {
           if(GetPVarInt(playerid, "PREMIUM")  <= 3)
		   {SendClientMessage(playerid,-1,"[Pura Joda] Los saltos tendrán costos relativamente bajos a comparación de un usuario normal.");}
			  SendClientMessage(playerid,-1,"[Pura Joda] PARA SALTAR PRESIONA: BLOQ. MAYUS");
		      return 1;
	     }


//==============================================================================
//===========================================================================================================//

	if (strcmp("/cantibalas", cmdtext, true, 10) == 0)
	{
		if(GetPVarInt(playerid, "PREMIUM")  >= 2)
		{
    		new vehicleid = GetPlayerVehicleID(playerid);
    		SetVehicleHealth(vehicleid, 3900.0);
    		SendClientMessage(playerid, COLOUR_WHITE, "Agregado Antibalas Al Auto.");
	    	return 1;
		}
		else return SendClientMessage(playerid, COLOR_ROJO, "[Error]: Comando Solo Para Usuarios Premium Nivel 2");
	}
	if (!strcmp("/flipcar", cmdtext, true))
	{
   		if(GetPVarInt(playerid, "PREMIUM")  >= 1)
    	{
    		new currentveh;
    		new Float:angle;
    		currentveh = GetPlayerVehicleID(playerid);
    		GetVehicleZAngle(currentveh, angle);
    		SetVehicleZAngle(currentveh, angle);
    		SendClientMessage(COLOR_YELLOW,playerid,"[Pura Joda] Auto Enderezado");
    	} else {
    		SendClientMessage(playerid, COLOR_ROJO, "[Error]: Comando Solo Para Usuarios Premium.");
    	}
    	return 1;
	}
	dcmd(duelmonster,11,cmdtext);
	dcmd(jaulainfernal,13,cmdtext);

//========================= [ Car Commands ]====================================
	if(strcmp(cmdtext, "/eventos", true)==0)	{
		if(PlayerInfo[playerid][Level] >= 3) {
			SendClientMessage(playerid,red,"EVENTOS PARA ADMINSITRADORES.");
			SendClientMessage(playerid,red,"1. Jaula Infernal Comandos: /JActivar Para Activarlo /jDesactivar Para Desactivar");
			SendClientMessage(playerid,red,"Y /Comenzar Para Comenzar la Jaula Infernal");
			SendClientMessage(playerid,red,"2. Duel Mounter Comandos: /MActivar Para Activarlo /MDesactivar Para Desactivar");
			SendClientMessage(playerid,red,"Y /Mcomenzar Para Comenzar la Duel Mounter");
			SendClientMessage(playerid,red,"3. DMCHUCK Comandos: /CActivar Para Activarlo /DMCHUCK Para Entrar");
			SendClientMessage(playerid,red,"Y /CHUCKADMIN Para ser ChuckNorris y /Ccomenzar para comenzarlo");
			SendClientMessage(playerid,red,"4./HoraFeliz y /HoraFelizOff Para Activar Rhinos Hydras y Hunter");
		} else SendClientMessage(playerid,red,"ERROR: Necesitas nivel 1 para utilizar este comando.");
		return 1;
	}
//------------------------------------------------------------------------------
	if(strcmp(cmd, "/bloquearpm", true) == 0)
	{
		if(IsPlayerConnected(playerid))
		{
			if(BloqueoDePrivados[playerid] == 1)
			{
				BloqueoDePrivados[playerid] = 0;
				SendClientMessage(playerid, COLOR_WHITE, "Has desbloqueado los privados");
			} else {
				BloqueoDePrivados[playerid] = 1;
				SendClientMessage(playerid, COLOR_WHITE, "Has bloqueado los privados");
			}
		}
		return 1;
	}
///
	#define Color_Rojo       0xFF444499
	if(strcmp(cmdtext, "/invisible2", true)==0)
	{
    	if(PlayerInfo[playerid][Level] >= 2) {
		    #define COLOR_INVISIBLE 0xFFFFFF00
			SetPlayerColor(playerid,COLOR_INVISIBLE);
		    SendClientMessage(playerid, Color_Rojo, "Ahora Eres Invisible en el Mapa.");
		} else {
			SendClientMessage(playerid,Color_Rojo,"Sólo administradores.");
        }
		return 1;
	}
	/* No funciona */


	if(strcmp(cmdtext, "/respawnallcars", true)==0)
	{

		if(PlayerInfo[playerid][Level] >= 3 || IsPlayerAdmin(playerid))
		{
			SendClientMessage(playerid, green, "|- Your have Successfully Respawned all Vehicles! -|");
			GameTextForAll("~n~~n~~n~~n~~n~~n~~r~Vehicles ~g~Respawned!", 3000,3);

			for(new cars=0; cars<MAX_VEHICLES; cars++)
			{
				if(!VehicleOccupied(cars))
				{
					SetVehicleToRespawn(cars);
				}
			}
			return 1;
		}
		else return SendClientMessage(playerid,Color_Rojo,"Tienes que Ser Administrador para Utilizar este Comando.");
	}

	if(strcmp(cmdtext, "/Destroyallcars", true)==0)
	{

		if(PlayerInfo[playerid][Level] >= 3 || IsPlayerAdmin(playerid))
		{

			GameTextForAll("~n~~n~~n~~n~~n~~n~~r~Vehicles ~g~Respawned!", 3000,3);

			for(new cars=200; cars<MAX_VEHICLES; cars++)
			{
				if(!VehicleOccupied(cars))
				{
					DestroyVehicle(cars);
				}
			}
			return 1;
		}
		else return SendClientMessage(playerid,Color_Rojo,"Tienes que Ser Administrador para Utilizar este Comando.");
	}
//------------------------------/w------------------------------------------------
	if(strcmp("/w", cmd, true) == 0)
	{
	    new Mensaje[256];
		new MensajeDos[256];
		new Nombre[MAX_PLAYER_NAME+1];
		new NombreDos[MAX_PLAYER_NAME+1];

        #define Color_Rojo 0xFF444499
        #define Color_Amarillo   0xFFFF22AA
		tmp = strtok(cmdtext,idx);

		if(!strlen(tmp) || strlen(tmp) > 5) {
			SendClientMessage(playerid,Color_Rojo,"Use: /w [ID] [Mensaje]");
			return 1;
		}

		new id = strval(tmp);
        MensajeDos = strrest(cmdtext,idx);

		if(!strlen(MensajeDos)) {
			SendClientMessage(playerid,Color_Rojo,"Use: /w [ID] [Mensaje]");
			return 1;
		}

		if(!IsPlayerConnected(id)) {
			SendClientMessage(playerid,Color_Rojo,"Jugador No Conectado");
			return 1;
		}
		GetPlayerName(id,Nombre,sizeof(Nombre));
		GetPlayerName(playerid,NombreDos,sizeof(NombreDos));

		if(DetectarSpam(MensajeDos))
		{
		    new PlayerName[MAX_PLAYER_NAME], string2[128];
			GetPlayerName(playerid, PlayerName, MAX_PLAYER_NAME);
			format(Mensaje,sizeof(Mensaje),"PM Enviado a %s [%d]: %s.",Nombre,id,MensajeDos);
			SendClientMessage(playerid,Color_Amarillo,Mensaje);
		    format(string,sizeof(string),"[Pura Joda] Usuario %s [ID:%i] esta intentando hacer SPAM.",PlayerName,playerid);
		    MessageToAdmins(0x9FFF00FF,string);
		    format(string,sizeof(string),"[Pura Joda] Texto enviado: %s",MensajeDos);
		    MessageToAdmins(0x9FFF00FF,string);
			new tmp3[50];//string2[128];
		    GetPlayerIp(playerid,tmp3,50);
		    format(string2,sizeof(string2),"PM: Nombre: %s Texto enviado: %s IP: %s",PlayerName,MensajeDos,tmp3);
		    SaveToFile("SpamLog",string2);
			return 1;
		}
		if(BloqueoDePrivados[id] == 1)
		{
			SendClientMessage(playerid, COLOR_WHITE, "Ese usuario tiene bloqueados los privados y por tanto no puedes enviarle un mensaje");
			return 1;
		}
		for(new i = 0; i < MAX_PLAYER; i++) {
			if(IsPlayerConnected(i)) {
					if( (PlayerInfo[i][Level] > PlayerInfo[playerid][Level]) && (PlayerInfo[i][Level] > 1) && (i != playerid) ) {
        			format(Mensaje,sizeof(Mensaje),"PM: %s [%d] a %s [%d]: %s.",NombreDos,playerid,Nombre,id,MensajeDos);
					SendClientMessage(i, grey, Mensaje);
				}
			}
		}

		if(playerid != id) {
			format(Mensaje,sizeof(Mensaje),"PM Enviado a %s [%d]: %s.",Nombre,id,MensajeDos);
			SendClientMessage(playerid,Color_Amarillo,Mensaje);
			format(Mensaje,sizeof(Mensaje),"PM Recivido de %s [%d]: %s.",NombreDos,playerid,MensajeDos);
			SendClientMessage(id,Color_Amarillo,Mensaje);
			PlayerPlaySound(id,1085,0.0,0.0,0.0);
		} else {
			SendClientMessage(playerid,Color_Rojo,"No te puedes enviar un mensaje a vos mismo.");
		}
		return 1;
	}
//------------------------------------------------------------------------------
	if(strcmp("/pm", cmd, true) == 0)
	{
	    new Mensaje[256];
		new MensajeDos[256];
		new Nombre[MAX_PLAYER_NAME+1];
		new NombreDos[MAX_PLAYER_NAME+1];

        #define Color_Rojo 0xFF444499
        #define Color_Amarillo   0xFFFF22AA
		tmp = strtok(cmdtext,idx);

		if(!strlen(tmp) || strlen(tmp) > 5) {
			SendClientMessage(playerid,Color_Rojo,"Use: /pm [ID] [Mensaje]");
			return 1;
		}

		new id = strval(tmp);
        MensajeDos = strrest(cmdtext,idx);

		if(!strlen(MensajeDos)) {
			SendClientMessage(playerid,Color_Rojo,"Use: /pm [ID] [Mensaje]");
			return 1;
		}

		if(!IsPlayerConnected(id)) {
			SendClientMessage(playerid,Color_Rojo,"Jugador No Conectado");
			return 1;
		}
		GetPlayerName(id,Nombre,sizeof(Nombre));
		GetPlayerName(playerid,NombreDos,sizeof(NombreDos));
	    static LastText[MAX_PLAYER][128];
		if(strfind(LastText[playerid], MensajeDos, false) != -1) return SendClientMessage(playerid, COLOR_WHITE, "No Te Repitas Por /Pm Sera considerado Como Flood!."), 1;
		strmid(LastText[playerid], MensajeDos, 0, strlen(MensajeDos), sizeof(LastText[]));

		if(DetectarSpam(MensajeDos))
		{
    		new PlayerName[MAX_PLAYER_NAME], string2[128];
			GetPlayerName(playerid, PlayerName, MAX_PLAYER_NAME);
			format(Mensaje,sizeof(Mensaje),"PM Enviado a %s [%d]: %s.",Nombre,id,MensajeDos);
			SendClientMessage(playerid,Color_Amarillo,Mensaje);
    		format(string,sizeof(string),"[Pura Joda] Usuario %s [ID:%i] esta intentando hacer SPAM.",PlayerName,playerid);
    		MessageToAdmins(0x9FFF00FF,string);
    		format(string,sizeof(string),"[Pura Joda] Texto enviado: %s",MensajeDos);
    		MessageToAdmins(0x9FFF00FF,string);
			new tmp3[50];//,string2[128];
    		GetPlayerIp(playerid,tmp3,50);
    		format(string2,sizeof(string2),"PM: Nombre: %s Texto enviado: %s IP: %s",PlayerName,MensajeDos,tmp3);
    		SaveToFile("SpamLog",string2);
			return 1;
		}
		if(BloqueoDePrivados[id] == 1)
		{
			SendClientMessage(playerid, COLOR_WHITE, "Ese usuario tiene bloqueados los privados y por tanto no puedes enviarle un mensaje");
			return 1;
		}
		for(new i = 0; i < MAX_PLAYER; i++) {
			if(IsPlayerConnected(i)) {
				if( (PlayerInfo[i][Level] > PlayerInfo[playerid][Level]) && (PlayerInfo[i][Level] > 1) && (i != playerid) ) {
    			    format(Mensaje,sizeof(Mensaje),"PM: %s [%d] a %s [%d]: %s.",NombreDos,playerid,Nombre,id,MensajeDos);
					SendClientMessage(i, grey, Mensaje);
				}
			}
		}
		format(Mensaje,sizeof(Mensaje),"PM Enviado a %s [%d]: %s.",Nombre,id,MensajeDos);
		SendClientMessage(playerid,Color_Amarillo,Mensaje);
		format(Mensaje,sizeof(Mensaje),"PM Recivido de %s [%d]: %s.",NombreDos,playerid,MensajeDos);
		SendClientMessage(id,Color_Amarillo,Mensaje);
		PlayerPlaySound(id,1085,0.0,0.0,0.0);
		return 1;
	}
////////////////////////////////////////////////////////////////////////////////////////////

	#define COLOR_GREY     0x808080FF
	if(strcmp(cmd, "/horafeliz", true) == 0)
	{
		if(PlayerInfo[playerid][Level] >= 4) {
			if(guerra == 0)
			{
				guerra = 1;
				format(string,256,">> Hora Feliz Activada!!!!! << Podras usar Armas y Vehiculos de Guerra, para mas ayuda usa /infoguerra!!");
				SendClientMessageToAll(COLOR_ROJO,string);
				format( string, sizeof(string), "~w~~h~hora feliz ~p~activada!~w~a cagarse a tiros se ha dicho!~n~~p~/hunter /rhino /hydra para sacarlas");
				GameTextForAll( string, 5000, 3 );
			}
			else
			{
				SendClientMessage(playerid, COLOR_GREY, " Ya estan en guerra!");
			}
		}
		return 1;
	}

	if(strcmp(cmd, "/horafelizoff", true) == 0){
		if(PlayerInfo[playerid][Level] >= 1) {
			if(guerra == 1)
			{
				SendClientMessageToAll(COLOR_ROJO,">> Hora Feliz Desactivada :( :(  << No Podras usar vehiculos ni armas de guerra!!");
				GameTextForAll( "~w~~h~hora feliz ~p~desactivada!", 5000, 3 );
				for(new i = 0; i < MAX_PLAYER; i++)
				{
					guerra = 0;
					DestroyVehicle(Monster[i]);
					PlayerPlaySound(i,1057,0.0,0.0,0.0); ResetPlayerWeapons(i);
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_GREY, " No estan en guerra!");
			}
		}
		return 1;
	}



	if(strcmp(cmdtext, "/ltunedcar2", true)==0 || strcmp(cmdtext, "/ltc2", true)==0)	{
		if(PlayerInfo[playerid][Level] >= 1) {
			if(IsPlayerInAnyVehicle(playerid)) {
				SendClientMessage(playerid,red,"Error: Usted ya tiene un vehículo");
			} else  {
				if(PlayerInfo[playerid][pCar] != -1) CarDeleter(PlayerInfo[playerid][pCar]);
				new Float:X,Float:Y,Float:Z,Float:Angle,LVehicleIDt;	GetPlayerPos(playerid,X,Y,Z); GetPlayerFacingAngle(playerid,Angle);
		        LVehicleIDt = CreateVehicle(560,X,Y,Z,Angle,1,-1,-1);	PutPlayerInVehicle(playerid,LVehicleIDt,0); CMDMessageToAdmins(playerid,"LTunedCar");	    AddVehicleComponent(LVehicleIDt, 1028);	AddVehicleComponent(LVehicleIDt, 1030);	AddVehicleComponent(LVehicleIDt, 1031);	AddVehicleComponent(LVehicleIDt, 1138);	AddVehicleComponent(LVehicleIDt, 1140);  AddVehicleComponent(LVehicleIDt, 1170);
			    AddVehicleComponent(LVehicleIDt, 1028);	AddVehicleComponent(LVehicleIDt, 1030);	AddVehicleComponent(LVehicleIDt, 1031);	AddVehicleComponent(LVehicleIDt, 1138);	AddVehicleComponent(LVehicleIDt, 1140);  AddVehicleComponent(LVehicleIDt, 1170);
			    AddVehicleComponent(LVehicleIDt, 1080);	AddVehicleComponent(LVehicleIDt, 1086); AddVehicleComponent(LVehicleIDt, 1087); AddVehicleComponent(LVehicleIDt, 1010);	PlayerPlaySound(playerid,1133,0.0,0.0,0.0);	ChangeVehiclePaintjob(LVehicleIDt,1);
			   	SetVehicleVirtualWorld(LVehicleIDt, GetPlayerVirtualWorld(playerid)); LinkVehicleToInterior(LVehicleIDt, GetPlayerInterior(playerid));
				PlayerInfo[playerid][pCar] = LVehicleIDt;
			}
		} else SendClientMessage(playerid,red,"ERROR: Necesitas nivel 1 para utilizar este comando.");
		return 1;
	}
//------------------------------------------------------------------------------
	if(strcmp(cmdtext, "/ltunedcar3", true)==0 || strcmp(cmdtext, "/ltc3", true)==0)	{
		if(PlayerInfo[playerid][Level] >= 1) {
			if(IsPlayerInAnyVehicle(playerid)) {
				SendClientMessage(playerid,red,"Error: Usted ya tiene un vehículo");
			} else  {
				if(PlayerInfo[playerid][pCar] != -1) CarDeleter(PlayerInfo[playerid][pCar]);
				new Float:X,Float:Y,Float:Z,Float:Angle,LVehicleIDt;	GetPlayerPos(playerid,X,Y,Z); GetPlayerFacingAngle(playerid,Angle);
		        LVehicleIDt = CreateVehicle(560,X,Y,Z,Angle,1,-1,-1);	PutPlayerInVehicle(playerid,LVehicleIDt,0); CMDMessageToAdmins(playerid,"LTunedCar");	    AddVehicleComponent(LVehicleIDt, 1028);	AddVehicleComponent(LVehicleIDt, 1030);	AddVehicleComponent(LVehicleIDt, 1031);	AddVehicleComponent(LVehicleIDt, 1138);	AddVehicleComponent(LVehicleIDt, 1140);  AddVehicleComponent(LVehicleIDt, 1170);
			    AddVehicleComponent(LVehicleIDt, 1080);	AddVehicleComponent(LVehicleIDt, 1086); AddVehicleComponent(LVehicleIDt, 1087); AddVehicleComponent(LVehicleIDt, 1010);	PlayerPlaySound(playerid,1133,0.0,0.0,0.0);	ChangeVehiclePaintjob(LVehicleIDt,2);
			   	SetVehicleVirtualWorld(LVehicleIDt, GetPlayerVirtualWorld(playerid)); LinkVehicleToInterior(LVehicleIDt, GetPlayerInterior(playerid));
				PlayerInfo[playerid][pCar] = LVehicleIDt;
			}
		} else SendClientMessage(playerid,red,"ERROR: Necesitas nivel 1 para utilizar este comando.");
		return 1;
	}
//------------------------------------------------------------------------------
	if(strcmp(cmdtext, "/ltunedcar4", true)==0 || strcmp(cmdtext, "/ltc4", true)==0)	{
		if(PlayerInfo[playerid][Level] >= 1) {
			if(IsPlayerInAnyVehicle(playerid)) {
				SendClientMessage(playerid,red,"Error: Usted ya tiene un vehículo");
			} else  {
				if(PlayerInfo[playerid][pCar] != -1) CarDeleter(PlayerInfo[playerid][pCar]);
				new Float:X,Float:Y,Float:Z,Float:Angle,carid;	GetPlayerPos(playerid,X,Y,Z); GetPlayerFacingAngle(playerid,Angle);
		        carid = CreateVehicle(559,X,Y,Z,Angle,1,-1,-1);	PutPlayerInVehicle(playerid,carid,0); CMDMessageToAdmins(playerid,"LTunedCar");
		    	AddVehicleComponent(carid,1065);    AddVehicleComponent(carid,1067);    AddVehicleComponent(carid,1162); AddVehicleComponent(carid,1010); AddVehicleComponent(carid,1073);	ChangeVehiclePaintjob(carid,1);
			   	SetVehicleVirtualWorld(carid, GetPlayerVirtualWorld(playerid)); LinkVehicleToInterior(carid, GetPlayerInterior(playerid));
				PlayerInfo[playerid][pCar] = carid;
			}
		} else SendClientMessage(playerid,red,"ERROR: Necesitas nivel 1 para utilizar este comando.");
		return 1;
	}
//------------------------------------------------------------------------------
	if(strcmp(cmdtext, "/ltunedcar5", true)==0 || strcmp(cmdtext, "/ltc5", true)==0)	{
		if(PlayerInfo[playerid][Level] >= 1) {
			if(IsPlayerInAnyVehicle(playerid)) {
				SendClientMessage(playerid,red,"Error: Usted ya tiene un vehículo");
			} else  {
				if(PlayerInfo[playerid][pCar] != -1) CarDeleter(PlayerInfo[playerid][pCar]);
				new Float:X,Float:Y,Float:Z,Float:Angle,carid;	GetPlayerPos(playerid,X,Y,Z); GetPlayerFacingAngle(playerid,Angle);
		        carid = CreateVehicle(565,X,Y,Z,Angle,1,-1,-1);	PutPlayerInVehicle(playerid,carid,0); CMDMessageToAdmins(playerid,"LTunedCar");
			    AddVehicleComponent(carid,1046); AddVehicleComponent(carid,1049); AddVehicleComponent(carid,1053); AddVehicleComponent(carid,1010); AddVehicleComponent(carid,1073); ChangeVehiclePaintjob(carid,1);
			   	SetVehicleVirtualWorld(carid, GetPlayerVirtualWorld(playerid)); LinkVehicleToInterior(carid, GetPlayerInterior(playerid));
				PlayerInfo[playerid][pCar] = carid;
			}
		} else SendClientMessage(playerid,red,"ERROR: Necesitas nivel 1 para utilizar este comando.");
		return 1;
	}
//------------------------------------------------------------------------------
	if(strcmp(cmdtext, "/ltunedcar6", true)==0 || strcmp(cmdtext, "/ltc6", true)==0)	{
		if(PlayerInfo[playerid][Level] >= 1) {
			if(IsPlayerInAnyVehicle(playerid)) {
				SendClientMessage(playerid,red,"Error: Usted ya tiene un vehículo");
			} else  {
				if(PlayerInfo[playerid][pCar] != -1) CarDeleter(PlayerInfo[playerid][pCar]);
				new Float:X,Float:Y,Float:Z,Float:Angle,carid;	GetPlayerPos(playerid,X,Y,Z); GetPlayerFacingAngle(playerid,Angle);
		        carid = CreateVehicle(558,X,Y,Z,Angle,1,-1,-1);	PutPlayerInVehicle(playerid,carid,0); CMDMessageToAdmins(playerid,"LTunedCar");
		    	AddVehicleComponent(carid,1088); AddVehicleComponent(carid,1092); AddVehicleComponent(carid,1139); AddVehicleComponent(carid,1010); AddVehicleComponent(carid,1073); ChangeVehiclePaintjob(carid,1);
		 	   	SetVehicleVirtualWorld(carid, GetPlayerVirtualWorld(playerid)); LinkVehicleToInterior(carid, GetPlayerInterior(playerid));
				PlayerInfo[playerid][pCar] = carid;
			}
		} else SendClientMessage(playerid,red,"ERROR: Necesitas nivel 1 para utilizar este comando.");
		return 1;
	}
//------------------------------------------------------------------------------
	if(strcmp(cmdtext, "/ltunedcar7", true)==0 || strcmp(cmdtext, "/ltc7", true)==0)	{
		if(PlayerInfo[playerid][Level] >= 1) {
			if(IsPlayerInAnyVehicle(playerid)) {
				SendClientMessage(playerid,red,"Error: Usted ya tiene un vehículo");
			} else  {
				if(PlayerInfo[playerid][pCar] != -1) CarDeleter(PlayerInfo[playerid][pCar]);
				new Float:X,Float:Y,Float:Z,Float:Angle,carid;	GetPlayerPos(playerid,X,Y,Z); GetPlayerFacingAngle(playerid,Angle);
		        carid = CreateVehicle(561,X,Y,Z,Angle,1,-1,-1);	PutPlayerInVehicle(playerid,carid,0); CMDMessageToAdmins(playerid,"LTunedCar");
		    	AddVehicleComponent(carid,1055); AddVehicleComponent(carid,1058); AddVehicleComponent(carid,1064); AddVehicleComponent(carid,1010); AddVehicleComponent(carid,1073); ChangeVehiclePaintjob(carid,1);
			   	SetVehicleVirtualWorld(carid, GetPlayerVirtualWorld(playerid)); LinkVehicleToInterior(carid, GetPlayerInterior(playerid));
				PlayerInfo[playerid][pCar] = carid;
			}
		} else SendClientMessage(playerid,red,"ERROR: Necesitas nivel 1 para utilizar este comando.");
		return 1;
	}
//------------------------------------------------------------------------------
	if(strcmp(cmdtext, "/ltunedcar8", true)==0 || strcmp(cmdtext, "/ltc8", true)==0)	{
		if(PlayerInfo[playerid][Level] >= 1) {
			if(IsPlayerInAnyVehicle(playerid)) {
				SendClientMessage(playerid,red,"Error: Usted ya tiene un vehículo");
			} else  {
				if(PlayerInfo[playerid][pCar] != -1) CarDeleter(PlayerInfo[playerid][pCar]);
				new Float:X,Float:Y,Float:Z,Float:Angle,carid;	GetPlayerPos(playerid,X,Y,Z); GetPlayerFacingAngle(playerid,Angle);
		        carid = CreateVehicle(562,X,Y,Z,Angle,1,-1,-1);	PutPlayerInVehicle(playerid,carid,0); CMDMessageToAdmins(playerid,"LTunedCar");
			    AddVehicleComponent(carid,1034); AddVehicleComponent(carid,1038); AddVehicleComponent(carid,1147); AddVehicleComponent(carid,1010); AddVehicleComponent(carid,1073); ChangeVehiclePaintjob(carid,1);
			   	SetVehicleVirtualWorld(carid, GetPlayerVirtualWorld(playerid)); LinkVehicleToInterior(carid, GetPlayerInterior(playerid));
				PlayerInfo[playerid][pCar] = carid;
			}
		} else SendClientMessage(playerid,red,"ERROR: Necesitas nivel 1 para utilizar este comando.");
		return 1;
	}
//------------------------------------------------------------------------------
	if(strcmp(cmdtext, "/ltunedcar9", true)==0 || strcmp(cmdtext, "/ltc9", true)==0)	{
		if(PlayerInfo[playerid][Level] >= 1) {
			if(IsPlayerInAnyVehicle(playerid)) {
				SendClientMessage(playerid,red,"Error: Usted ya tiene un vehículo");
			} else  {
				if(PlayerInfo[playerid][pCar] != -1) CarDeleter(PlayerInfo[playerid][pCar]);
				new Float:X,Float:Y,Float:Z,Float:Angle,carid;	GetPlayerPos(playerid,X,Y,Z); GetPlayerFacingAngle(playerid,Angle);
		        carid = CreateVehicle(567,X,Y,Z,Angle,1,-1,-1);	PutPlayerInVehicle(playerid,carid,0); CMDMessageToAdmins(playerid,"LTunedCar");
			    AddVehicleComponent(carid,1102); AddVehicleComponent(carid,1129); AddVehicleComponent(carid,1133); AddVehicleComponent(carid,1186); AddVehicleComponent(carid,1188); ChangeVehiclePaintjob(carid,1); AddVehicleComponent(carid,1010); AddVehicleComponent(carid,1085); AddVehicleComponent(carid,1087); AddVehicleComponent(carid,1086);
			   	SetVehicleVirtualWorld(carid, GetPlayerVirtualWorld(playerid)); LinkVehicleToInterior(carid, GetPlayerInterior(playerid));
				PlayerInfo[playerid][pCar] = carid;
			}
		} else SendClientMessage(playerid,red,"ERROR: Necesitas nivel 1 para utilizar este comando.");
		return 1;
	}
//------------------------------------------------------------------------------
	if(strcmp(cmdtext, "/ltunedcar10", true)==0 || strcmp(cmdtext, "/ltc10", true)==0)	{
		if(PlayerInfo[playerid][Level] >= 1) {
			if(IsPlayerInAnyVehicle(playerid)) {
				SendClientMessage(playerid,red,"Error: Usted ya tiene un vehículo");
			} else  {
				if(PlayerInfo[playerid][pCar] != -1) CarDeleter(PlayerInfo[playerid][pCar]);
				new Float:X,Float:Y,Float:Z,Float:Angle,carid;	GetPlayerPos(playerid,X,Y,Z); GetPlayerFacingAngle(playerid,Angle);
		        carid = CreateVehicle(558,X,Y,Z,Angle,1,-1,-1);	PutPlayerInVehicle(playerid,carid,0); CMDMessageToAdmins(playerid,"LTunedCar");
		   		AddVehicleComponent(carid,1092); AddVehicleComponent(carid,1166); AddVehicleComponent(carid,1165); AddVehicleComponent(carid,1090);
			    AddVehicleComponent(carid,1094); AddVehicleComponent(carid,1010); AddVehicleComponent(carid,1087); AddVehicleComponent(carid,1163);//SPOILER
			    AddVehicleComponent(carid,1091); ChangeVehiclePaintjob(carid,2);
			   	SetVehicleVirtualWorld(carid, GetPlayerVirtualWorld(playerid)); LinkVehicleToInterior(carid, GetPlayerInterior(playerid));
				PlayerInfo[playerid][pCar] = carid;
			}
		} else SendClientMessage(playerid,red,"ERROR: Necesitas nivel 1 para utilizar este comando.");
		return 1;
	}
//------------------------------------------------------------------------------
	if(strcmp(cmdtext, "/ltunedcar11", true)==0 || strcmp(cmdtext, "/ltc11", true)==0)	{
		if(PlayerInfo[playerid][Level] >= 1) {
			if(IsPlayerInAnyVehicle(playerid)) {
				SendClientMessage(playerid,red,"Error: Usted ya tiene un vehículo");
			} else {
				if(PlayerInfo[playerid][pCar] != -1) CarDeleter(PlayerInfo[playerid][pCar]);
				new Float:X,Float:Y,Float:Z,Float:Angle,carid;	GetPlayerPos(playerid,X,Y,Z); GetPlayerFacingAngle(playerid,Angle);
		        carid = CreateVehicle(557,X,Y,Z,Angle,1,1,-1);	PutPlayerInVehicle(playerid,carid,0); CMDMessageToAdmins(playerid,"LTunedCar");
				AddVehicleComponent(carid,1010); AddVehicleComponent(carid,1081);
			   	SetVehicleVirtualWorld(carid, GetPlayerVirtualWorld(playerid)); LinkVehicleToInterior(carid, GetPlayerInterior(playerid));
				PlayerInfo[playerid][pCar] = carid;
			}
		} else SendClientMessage(playerid,red,"ERROR: Necesitas nivel 1 para utilizar este comando.");
		return 1;
	}
//------------------------------------------------------------------------------
	if(strcmp(cmdtext, "/ltunedcar12", true)==0 || strcmp(cmdtext, "/ltc12", true)==0)	{
		if(PlayerInfo[playerid][Level] >= 1) {
			if(IsPlayerInAnyVehicle(playerid)) {
				SendClientMessage(playerid,red,"Error: Usted ya tiene un vehículo");
			} else  {
				if(PlayerInfo[playerid][pCar] != -1) CarDeleter(PlayerInfo[playerid][pCar]);
				new Float:X,Float:Y,Float:Z,Float:Angle,carid;	GetPlayerPos(playerid,X,Y,Z); GetPlayerFacingAngle(playerid,Angle);
       		 	carid = CreateVehicle(535,X,Y,Z,Angle,1,-1,-1);	PutPlayerInVehicle(playerid,carid,0); CMDMessageToAdmins(playerid,"LTunedCar");
				ChangeVehiclePaintjob(carid,1); AddVehicleComponent(carid,1109); AddVehicleComponent(carid,1115); AddVehicleComponent(carid,1117); AddVehicleComponent(carid,1073); AddVehicleComponent(carid,1010);
			    AddVehicleComponent(carid,1087); AddVehicleComponent(carid,1114); AddVehicleComponent(carid,1081); AddVehicleComponent(carid,1119); AddVehicleComponent(carid,1121);
			   	SetVehicleVirtualWorld(carid, GetPlayerVirtualWorld(playerid)); LinkVehicleToInterior(carid, GetPlayerInterior(playerid));
				PlayerInfo[playerid][pCar] = carid;
			}
		} else SendClientMessage(playerid,red,"ERROR: Necesitas nivel 1 para utilizar este comando.");
		return 1;
	}
//------------------------------------------------------------------------------
	if(strcmp(cmdtext, "/ltunedcar13", true)==0 || strcmp(cmdtext, "/ltc13", true)==0)	{
		if(PlayerInfo[playerid][Level] >= 1) {
			if(IsPlayerInAnyVehicle(playerid)) SendClientMessage(playerid,red,"Error: Usted ya tiene un vehículo");
			else {
				if(PlayerInfo[playerid][pCar] != -1) CarDeleter(PlayerInfo[playerid][pCar]);
				new Float:X,Float:Y,Float:Z,Float:Angle,carid;	GetPlayerPos(playerid,X,Y,Z); GetPlayerFacingAngle(playerid,Angle);
        		carid = CreateVehicle(562,X,Y,Z,Angle,1,-1,-1);	PutPlayerInVehicle(playerid,carid,0); CMDMessageToAdmins(playerid,"LTunedCar");
  				AddVehicleComponent(carid,1034); AddVehicleComponent(carid,1038); AddVehicleComponent(carid,1147);
				AddVehicleComponent(carid,1010); AddVehicleComponent(carid,1073); ChangeVehiclePaintjob(carid,0);
			   	SetVehicleVirtualWorld(carid, GetPlayerVirtualWorld(playerid)); LinkVehicleToInterior(carid, GetPlayerInterior(playerid));
				PlayerInfo[playerid][pCar] = carid;
			}
		} else SendClientMessage(playerid,red,"ERROR: Necesitas nivel 1 para utilizar este comando.");
		return 1;
	}
//------------------------------------------------------------------------------
 	if(strcmp(cmdtext,"/reglasadmin",true)==0)
	{
		if(PlayerInfo[playerid][Level] >= 1) {
		    new iString[2000];
			strcat(iString, "1. Respetar las /reglas (dar ejemplo)\n\n");
			strcat(iString, "2. Obedecer a los Administradores Superiores (lvl 5-12).\n\n");
			strcat(iString, "3. Prestar atención a los reportes de todos los Usuarios.\n\n");
			strcat(iString, "5. No abusar de los comandos Administrativos.\n\n");
			strcat(iString, "6. No abusar de /announce, /write o /asay.\n\n");
			strcat(iString, "7. No pedir nivel de Administración.\n\n");
			strcat(iString, "8. No hacer flood o spam de comandos Administrativos o en el chat\n\n");
			strcat(iString, "9. No se permite /warn /kick /ban /crash /fu entre Administradores o Moderadores.\n\n");
			strcat(iString, "10. No se permite ser Administrador en otro Server.\n\n");
			strcat(iString, "11. No se permite quedarse AFK (En Pausa).\n\n");
		    strcat(iString, "12. Conectarse por lo menos 2 horas al dia. si se ausenta mas de 4 dias sera dado de baja.\n\n");
			strcat(iString, "13. No se permite cambiar de nick sin autorización de un admin RCON.\n\n");
			strcat(iString, "14. No se permite agredir verbalmente (Insultar) a los usuarios (Sanción: Demoted Inmediato)\n\n");
			strcat(iString, "{FF0000}Nota: Cualquier incumplimiento deriba a sanción inmediata sin reclamos");
			ShowPlayerDialog(playerid,DIALOG_OTROS, DIALOG_STYLE_MSGBOX, "{FF0000}Reglas Admin - Pura Joda", iString, "Salir", "");
		  	PlayerPlaySound(playerid,1139,0.0,0.0,0.0);
		} else SendClientMessage(playerid,red,"ERROR: Necesitas nivel 1 para utilizar este comando.");
		return 1;
	}

	if(strcmp(cmdtext,"/eventosbasicos",true)==0)
	{
		if(PlayerInfo[playerid][Level] >= 1) {
		    new iString[2000];
			strcat(iString, "1.Evento de busqueda: consiste en que tu te escuendes y tienen que encontrarte por un premio.\n\n");
			strcat(iString, "2.Evento de duelos: consiste en poner un asay diciendo que digan las id para evento de duelos.\n\n");
			strcat(iString, "3.Evento de matarte: pones un asay por ej:matenme en lv por premio tu elijes el premio que le das.\n\n");
			strcat(iString, "4.Evento de avion de la muerte: consiste en que los jugadores se suban a tu avion y el ultimo que muere gana.\n\n");
			strcat(iString, "5.Evento de preguntas: consiste en preguntarles a los user preguntas basicas por un premio.\n\n");
			strcat(iString, "6.Evento de /eno el que pasa eno gana premio por ejemplo rocket\n\n");
			strcat(iString, "Y esos serian los eventos alla a ustedes a inventar otros\n\n");
			ShowPlayerDialog(playerid,DIALOG_OTROS, DIALOG_STYLE_MSGBOX, "{00FF00}Aqui veran los eventos normales para entretener a los users", iString, "Salir", "");
	  		PlayerPlaySound(playerid,1139,0.0,0.0,0.0);
		} else SendClientMessage(playerid,red,"ERROR: Necesitas nivel 1 para utilizar este comando.");
		return 1;
	}

	if (strcmp("/unbanname", cmd, true) == 0)
    {
		if(PlayerInfo[playerid][Level] >= 3) {
			new tpm[256];
		    tpm = strtok(cmdtext, idx);
		    if(strlen(tpm) == 0) return SendClientMessage(playerid, COLOR_WHITE, "[Error] Usa: /unbanname [Name].");
			new pIP[20]; GetPlayerIp(playerid, pIP, sizeof(pIP));
			new query2[100], DBResult:result2; format(query2, sizeof(query2), "SELECT * FROM `user` WHERE `pName` = '%s' LIMIT 1", DB_Escape(udb_encode(tpm))); result2 = db_query(LadminDB, query2);
			if(db_num_rows(result2)) { udb_query(result, "UPDATE `user` SET `pBanned` = '0' WHERE `pName` = '%s'", DB_Escape(udb_encode(tpm))); db_free_result(result); format(string, 256, "El Administrador \"%s\" ah desbaneado el nick \"%s\"",PlayerName2(playerid),tpm); }
			else SendClientMessage(playerid, red, "El usuario no existe");
			db_free_result(result2);
		    if(strlen(string) != 0) MessageToAdmins(blue, string);
			CMDMessageToAdmins(playerid,"UNBANNAME");
		} else SendClientMessage(playerid,red,"ERROR: Necesitas nivel 3 para utilizar este comando.");
    	return 1;
	}

//------------------------------------------------------------------------------

	if(strcmp(cmd, "/lp", true) == 0)	{
		if(PlayerInfo[playerid][Level] >= 1) {
			if (GetPlayerState(playerid) == 2)
			{
				new VehicleID = GetPlayerVehicleID(playerid), LModel = GetVehicleModel(VehicleID);
    	    	switch(LModel) { case 448,461,462,463,468,471,509,510,521,522,523,581,586, 449: return SendClientMessage(playerid,red,"ERROR: You can not tune this vehicle"); }
				new str[128], Float:pos[3];	format(str, sizeof(str), "%s", cmdtext[2]);
				SetVehicleNumberPlate(VehicleID, str);
				GetPlayerPos(playerid, pos[0], pos[1], pos[2]);	SetPlayerPos(playerid, pos[0]+1, pos[1], pos[2]);
				SetVehicleToRespawn(VehicleID); SetVehiclePos(VehicleID, pos[0], pos[1], pos[2]);
				SetTimerEx("TuneLCar",4000,0,"d",VehicleID);    PlayerPlaySound(playerid,1133,0.0,0.0,0.0);
				SendClientMessage(playerid, blue, "You have changed your licence plate");   CMDMessageToAdmins(playerid,"LP");
			} else {
				SendClientMessage(playerid,red,"Error: You have to be the driver of a vehicle to change its licence plate");
			}
		} else	{
  			SendClientMessage(playerid,red,"ERROR: You need to be level 1 use this command");
		}
		return 1;
	}

//------------------------------------------------------------------------------
	/* COMANDO PROHIBIDO E INSERVIBLE, SOLO PARA PROBOCAR PROBLEMAS NO HABILITAR
 	if(strcmp(cmd, "/spam", true) == 0)	{
		if(PlayerInfo[playerid][Level] >= 12) {
		    tmp = strtok(cmdtext, idx);
			if(!strlen(tmp)) {
				SendClientMessage(playerid, red, "USO: /spam [Color] [Texto]");
				SendClientMessage(playerid, red, "Colores: 0=negro 1=blanco 2=rojo 3=naranja 4=amarillo 5=verde 6=azul 7=purpura 8=marron 9=rosa");
				return 1;
			}
			new Colour = strval(tmp);
			if(Colour > 9 ) return SendClientMessage(playerid, red, "Colores: 0=negro 1=blanco 2=rojo 3=naranja 4=amarillo 5=verde 6=azul 7=purpura 8=marron 9=rosa");
			tmp = strtok(cmdtext, idx);

			format(string,sizeof(string),"%s",cmdtext[8]);

	        if(Colour == 0) 	 for(new i; i < 50; i++) SendClientMessageToAll(black,string);
	        else if(Colour == 1) for(new i; i < 50; i++) SendClientMessageToAll(COLOR_WHITE,string);
	        else if(Colour == 2) for(new i; i < 50; i++) SendClientMessageToAll(red,string);
	        else if(Colour == 3) for(new i; i < 50; i++) SendClientMessageToAll(orange,string);
	        else if(Colour == 4) for(new i; i < 50; i++) SendClientMessageToAll(yellow,string);
	        else if(Colour == 5) for(new i; i < 50; i++) SendClientMessageToAll(COLOR_GREEN1,string);
	        else if(Colour == 6) for(new i; i < 50; i++) SendClientMessageToAll(COLOR_BLUE,string);
	        else if(Colour == 7) for(new i; i < 50; i++) SendClientMessageToAll(COLOR_PURPLE,string);
	        else if(Colour == 8) for(new i; i < 50; i++) SendClientMessageToAll(COLOR_BROWN,string);
	        else if(Colour == 9) for(new i; i < 50; i++) SendClientMessageToAll(COLOR_PINK,string);
			return 1;
		} else return SendClientMessage(playerid,red,"ERROR: Necesitas nivel 5 para utilizar este comando.");
	}*/

//------------------------------------------------------------------------------
 	if(strcmp(cmd, "/write", true) == 0) {
		if(PlayerInfo[playerid][Level] >= 4) {
	    	tmp = strtok(cmdtext, idx);
			if(!strlen(tmp)) {
				SendClientMessage(playerid, red, "USAGE: /write [Colour] [Text]");
				return SendClientMessage(playerid, red, "Colours: 0=black 1=white 2=red 3=orange 4=yellow 5=green 6=blue 7=purple 8=brown 9=pink");
	 		}
			new Colour;
			Colour = strval(tmp);
			if(Colour > 9 )	{
				SendClientMessage(playerid, red, "USAGE: /write [Colour] [Text]");
				return SendClientMessage(playerid, red, "Colours: 0=black 1=white 2=red 3=orange 4=yellow 5=green 6=blue 7=purple 8=brown 9=pink");
			}
			tmp = strtok(cmdtext, idx);
	        CMDMessageToAdmins(playerid,"WRITE");
        	if(Colour == 0) {	format(string,sizeof(string),"%s",cmdtext[9]);	SendClientMessageToAll(black,string); return 1;	}
        	else if(Colour == 1) {	format(string,sizeof(string),"%s",cmdtext[9]);	SendClientMessageToAll(COLOR_WHITE,string); return 1;	}
        	else if(Colour == 2) {	format(string,sizeof(string),"%s",cmdtext[9]);	SendClientMessageToAll(red,string); return 1;	}
        	else if(Colour == 3) {	format(string,sizeof(string),"%s",cmdtext[9]);	SendClientMessageToAll(orange,string); return 1;	}
        	else if(Colour == 4) {	format(string,sizeof(string),"%s",cmdtext[9]);	SendClientMessageToAll(yellow,string); return 1;	}
        	else if(Colour == 5) {	format(string,sizeof(string),"%s",cmdtext[9]);	SendClientMessageToAll(COLOR_GREEN1,string); return 1;	}
        	else if(Colour == 6) {	format(string,sizeof(string),"%s",cmdtext[9]);	SendClientMessageToAll(COLOR_BLUE,string); return 1;	}
        	else if(Colour == 7) {	format(string,sizeof(string),"%s",cmdtext[9]);	SendClientMessageToAll(COLOR_PURPLE,string); return 1;	}
        	else if(Colour == 8) {	format(string,sizeof(string),"%s",cmdtext[9]);	SendClientMessageToAll(COLOR_BROWN,string); return 1;	}
        	else if(Colour == 9) {	format(string,sizeof(string),"%s",cmdtext[9]);	SendClientMessageToAll(COLOR_PINK,string); return 1;	}
        	return 1;
		} else return SendClientMessage(playerid,red,"ERROR: Necesitas nivel 1 para utilizar este comando.");
	}

	//------------------------------------------------------------------------------
	//                      Remote Console
	//------------------------------------------------------------------------------

	if(strcmp(cmd, "/loadfs", true) == 0) {
	    if(PlayerInfo[playerid][Level] >= 5) {
    		new str[128]; format(str,sizeof(string),"%s",cmdtext[1]); SendRconCommand(str);
		    return SendClientMessage(playerid,COLOR_WHITE,"RCON Command Sent");
	   	} else return SendClientMessage(playerid,red,"ERROR: No tienes ningún permiso para usar este comando.");
	}

	if(strcmp(cmd, "/unloadfs", true) == 0)	 {
	    if(PlayerInfo[playerid][Level] >= 5) {
    		new str[128]; format(str,sizeof(string),"%s",cmdtext[1]); SendRconCommand(str);

		    return SendClientMessage(playerid,COLOR_WHITE,"RCON Command Sent");
	   	} else return SendClientMessage(playerid,red,"ERROR: No tienes ningún permiso para usar este comando.");
	}

	if(strcmp(cmd, "/changemode", true) == 0)	 {
	    if(PlayerInfo[playerid][Level] >= 4) {
    		new str[128]; format(str,sizeof(string),"%s",cmdtext[1]); SendRconCommand(str);
		    return SendClientMessage(playerid,COLOR_WHITE,"RCON Command Sent");
	   	} else return SendClientMessage(playerid,red,"ERROR: No tienes ningún permiso para usar este comando.");
	}

/*	if(strcmp(cmd, "/gmx", true) == 0)	 {
		if(PlayerInfo[playerid][Level] >= 5) {
			OnFilterScriptExit(); SetTimer("RestartGM",5000,0);
			return SendClientMessage(playerid,COLOR_WHITE,"RCON Command Sent");
		} else return SendClientMessage(playerid,red,"ERROR: No tienes ningún permiso para usar este comando.");
	}
*/
	if(strcmp(cmd, "/loadladmin", true) == 0)	 {
		if(PlayerInfo[playerid][Level] >= 5) {
			SendRconCommand("loadfs ladmin4");
			return SendClientMessage(playerid,COLOR_WHITE,"RCON Command Sent");
		} else return SendClientMessage(playerid,red,"ERROR: No tienes ningún permiso para usar este comando.");
	}

	if(strcmp(cmd, "/unloadladmin", true) == 0)	 {
		if(PlayerInfo[playerid][Level] >= 5) {
			SendRconCommand("unloadfs ladmin4");
			return SendClientMessage(playerid,COLOR_WHITE,"RCON Command Sent");
		} else return SendClientMessage(playerid,red,"ERROR: No tienes ningún permiso para usar este comando.");
	}

	if(strcmp(cmd, "/reloadladmin", true) == 0)	 {
		if(PlayerInfo[playerid][Level] >= 4 || IsPlayerAdmin(playerid) ) {
			SendRconCommand("reloadfs ladmin4");
			SendClientMessage(playerid,COLOR_WHITE,"RCON Command Sent");
			return CMDMessageToAdmins(playerid,"RELOADLADMIN");
		} else return SendClientMessage(playerid,red,"ERROR: No tienes ningún permiso para usar este comando.");
	}
	if(strcmp(cmd, "/unbanip", true) == 0)	 {
	    if(PlayerInfo[playerid][Level] >= 4) {
    		new str[128]; format(str,sizeof(string),"unbanip %s",cmdtext[1]); SendRconCommand(str);
		    return SendClientMessage(playerid,COLOR_WHITE,"RCON Command Sent");
	   	} else return SendClientMessage(playerid,red,"ERROR: No tienes ningún permiso para usar este comando.");
	}
	if(strcmp(cmd, "/banip", true) == 0)	 {
	    if(PlayerInfo[playerid][Level] >= 4) {
    		new str[128]; format(str,sizeof(string),"banip %s",cmdtext[1]); SendRconCommand(str);
		    return SendClientMessage(playerid,COLOR_WHITE,"RCON Command Sent");
	   	} else return SendClientMessage(playerid,red,"ERROR: No tienes ningún permiso para usar este comando.");
	}

	return 0;
}

forward Countdown();
public Countdown()
{
    if(Racer != -1 && IsPlayerInVehicle(Racer, Motor))
	{
	    Count2++;
	    if(Count2 == 1) GameTextForPlayer(Racer, "~b~4", 3000, 3);
	    if(Count2== 2) GameTextForPlayer(Racer, "~b~3", 3000, 3);
	    if(Count2 == 3) GameTextForPlayer(Racer, "~g~2", 3000, 3);
	    if(Count2 == 4) GameTextForPlayer(Racer, "~g~1", 3000, 3);
	    if(Count2 == 5)
	    {
	        KillTimer(Timer1);
	        Timer1 = -1;
	        GameTextForPlayer(Racer, "~y~Go!", 2000, 3);
			TogglePlayerControllable(Racer, 1);
	        MaxTimer = SetTimer("MaxTime", 1000, 1);
	        Timer2 = SetTimer("CheckForLine", 100, 1);
			TimeLeft = 20;
		}
	}
}

forward CheckForLine();
public CheckForLine()
{
    if(Racer != -1 && IsPlayerInVehicle(Racer, Motor))
	{
	    new Float:X, Float:Y, Float:Z;
		GetPlayerPos(Racer, X, Y, Z);
	    if(X < 51.191391)
		{
		    if(IsBikeInArea(Motor, -100.0912, 2497.1504, 55.191391, 2508.6316))
			{
			    KillTimer(Timer2);
			    Timer2 = -1;
			    KillTimer(MaxTimer);
			    MaxTimer = -1;
			    Timer3 = SetTimer("CheckForLanding", 20, 1);
			}
		}
	}
}


forward CheckForLanding();
public CheckForLanding()
{
	if(Racer != -1 && IsPlayerInVehicle(Racer, Motor))
	{
		new Float:X, Float:Y, Float:Z, tmpX;
		GetPlayerPos(Racer, X, Y, Z);
 	    tmpX = floatround(X);
	    if(tmpX != LasttmpX)
	    {
	        LasttmpX = tmpX;
			ExplotionCheck(tmpX);
		}
  		if(!IsBikeInArea(Motor, -100.0912, 2497.1504, 55.191391, 2508.6316))
		{
		    GameTextForPlayer(Racer, "~r~Fallo", 5000, 3);
			KillTimer(Timer3);
			SetTimer("EndRace", 5000, 0);
		}
		format(TDS4, sizeof(TDS4), "Distancia: %.4f~n~Tiempo: 0:%02d", floatsub(51.191391, X), TimeLeft);
		TextDrawHideForPlayer(Racer, TD3);
		TextDrawSetString(TD3, TDS4);
		TextDrawShowForPlayer(Racer, TD3);
		if(Z < 17.53)
		{
		    KillTimer(Timer3);
		    Timer3 = -1;
		    Distance = floatsub(51.191391, X);
			if(Distance > HS[0]) //Player = 1st
			{
			    new str[128];
			    if(FPR > 0)
			    {
			    	format(str, 128, "¡Enhorabuena! Usted rompió un nuevo récord: %.4f!!!! Recompensa: $%d", Distance, FPR);
				}
				else
				{
				    format(str, 128, "¡Enhorabuena! Usted rompió un nuevo récord: %.4f!!!!", Distance);
				}
				SendClientMessage(Racer, 0xFFFF00AA, str);
				GivePlayerMoneyEx(Racer, FPR);
				//GivePlayerMoney(Racer, FPR);
			    HS[2] = HS[1];
			    HS[1] = HS[0];
			    HS[0] = Distance;
			    HSN[2] = HSN[1];
			    HSN[1] = HSN[0];
			    GetPlayerName(Racer, HSN[0], MAX_PLAYER_NAME);
			    format(str, 128, ""G"[Pura Joda] "W"%s "G"alcanzó el primer lugar en "W"/Jump "G"%.4f!!!", HSN[0], Distance);
			    SendClientMessageToAll(0xFFFF00AA, str);
			}
			else if(Distance > HS[1] && Distance <= HS[0]) //Player = 2nd
			{
			    new str[128];
			    if(SPR > 0)
			    {
			    	format(str, 128, "¡Enhorabuena! Que alcanzó el segundo lugar: %.4f!!!! Recompensa: $%d", Distance, SPR);
				}
				else
				{
				    format(str, 128, "¡Enhorabuena! Que alcanzó el segundo lugar: %.4f!!!!", Distance);
				}
				SendClientMessage(Racer, 0xFFFF00AA, str);
				GivePlayerMoney(Racer, SPR);
			    HS[2] = HS[1];
			    HS[1] = Distance;
				HSN[2] = HSN[1];
			    GetPlayerName(Racer, HSN[1], MAX_PLAYER_NAME);
			}
			else if(Distance > HS[2] && Distance <= HS[1]) //Player = 3rd
			{
			    new str[128];
			    if(TPR > 0)
			    {
			    	format(str, 128, "¡Enhorabuena! Se alcanzó el tercer lugar: %.4f!!!! Recompensa: $%d", Distance, TPR);
				}
				else
				{
				    format(str, 128, "¡Enhorabuena! Se alcanzó el tercer lugar: %.4f!!!!", Distance);
				}
				SendClientMessage(Racer, 0xFFFF00AA, str);
				GivePlayerMoney(Racer, TPR);
			    HS[2] = Distance;
			    GetPlayerName(Racer, HSN[2], MAX_PLAYER_NAME);
			}
			if(Distance > dini_Float(PERSONALFILE, PlayerName2(Racer)))
			{
			    dini_FloatSet(PERSONALFILE, PlayerName2(Racer), Distance);
			}
			format(TDS1, 128, "#1:  %.4f~n~#2:  %.4f~n~#3:  %.4f", HS[0], HS[1], HS[2]);
			TextDrawSetString(TD1, TDS1);
			format(TDS2, 128, "%s~n~%s~n~%s", HSN[0], HSN[1], HSN[2]);
			TextDrawSetString(TD2, TDS2);
			format(TDS5, 40, "Su Puntuacion  personal:~n~%.4f", dini_Float(PERSONALFILE, PlayerName2(Racer)));
			TextDrawSetString(TD4, TDS5);
			TextDrawShowForPlayer(Racer, TD0);
			TextDrawShowForPlayer(Racer, TD1);
			TextDrawShowForPlayer(Racer, TD2);
			TextDrawShowForPlayer(Racer, TD4);
			SetTimer("EndRace", 10000, 0);
			SetPlayerCameraPos(Racer, -121.3866, 2504.7371, 30.0306);
			SetPlayerCameraLookAt(Racer, X, Y, Z);
		}
	}
	return 1;
}

IsBikeInArea(Bike, Float:MinX, Float:MinY, Float:MaxX, Float:MaxY)
{
	new Float:X1, Float:Y1, Float:Z1;

	GetVehiclePos(Bike, X1, Y1, Z1);
	if(X1 >= MinX && X1 <= MaxX&& Y1 >= MinY && Y1 <= MaxY)
	{
		return 1;
	}
	return 0;
}

stock RemoveAllPlayersFromVehicle(vehicleID)
{
	for(new i; i<MAX_PLAYERS; i++)
	{
	    if(IsPlayerConnected(i))
		{
		    if(IsPlayerInVehicle(i, vehicleID))
			{
			    RemovePlayerFromVehicle(i);
			}
		}
	}
}

forward EndRace();
public EndRace()
{
	if(Timer1 != -1)
	{
    	KillTimer(Timer1);
    	Timer1 = -1;
	}
	if(Timer2 != -1)
	{
    	KillTimer(Timer2);
    	Timer2 = -1;
	}
	if(Timer3 != -1)
	{
    	KillTimer(Timer3);
    	Timer3 = -1;
	}
	if(MaxTimer != -1)
	{
	    KillTimer(MaxTimer);
	    MaxTimer = -1;
	}
    GameTextForPlayer(Racer, " ", 10, 3);
	RemoveAllPlayersFromVehicle(Motor);
	DestroyVehicle(Motor);
	TextDrawHideForPlayer(Racer, TD0);
	TextDrawHideForPlayer(Racer, TD1);
	TextDrawHideForPlayer(Racer, TD2);
	TextDrawHideForPlayer(Racer, TD3);
	TextDrawHideForPlayer(Racer, TD4);
	SetCameraBehindPlayer(Racer);
	Racer = -1;
}

forward MaxTime();
public MaxTime()
{
	TimeLeft--;
	format(TDS4, sizeof(TDS4), "Distancia: 0.0000~n~Time Left: 0:%02d", TimeLeft);
	TextDrawHideForPlayer(Racer, TD3);
	TextDrawSetString(TD3, TDS4);
	TextDrawShowForPlayer(Racer, TD3);
	if(TimeLeft == 0)
	{
	    KillTimer(MaxTimer);
	    MaxTimer = -1;
	    KillTimer(Timer3);
		GameTextForPlayer(Racer, "~r~Tiempo Acabado!", 5000, 3);
		SetTimer("EndRace", 5000, 0);
	}
}
ExplotionCheck(XX)
{
	if(48 < XX < 52){ CreateExplosion(XX-30, 2508.6316, 18.0, 11, 5); CreateExplosion(XX-30, 2497.1504, 18.0, 11, 5); }
	else if(38 < XX < 42){ CreateExplosion(XX-30, 2508.6316, 18.0, 11, 5); CreateExplosion(XX-30, 2497.1504, 18.0, 11, 5);}
	else if(28 < XX < 32){ CreateExplosion(XX-30, 2508.6316, 18.0, 11, 5); CreateExplosion(XX-30, 2497.1504, 18.0, 11, 5); }
	else if(18 < XX < 22){ CreateExplosion(XX-30, 2508.6316, 18.0, 11, 5); CreateExplosion(XX-30, 2497.1504, 18.0, 11, 5); }
	else if(8 < XX < 12){ CreateExplosion(XX-30, 2508.6316, 18.0, 11, 5); CreateExplosion(XX-30, 2497.1504, 18.0, 11, 5); }
	else if(-2 < XX < 2){ CreateExplosion(XX-30, 2508.6316, 18.0, 11, 5); CreateExplosion(XX-30, 2497.1504, 18.0, 11, 5); }
	else if(-12 < XX < -8){ CreateExplosion(XX-30, 2508.6316, 18.0, 11, 5); CreateExplosion(XX-30, 2497.1504, 18.0, 11, 5); }
	else if(-22 < XX < -18){ CreateExplosion(XX-30, 2508.6316, 18.0, 11, 5); CreateExplosion(XX-30, 2497.1504, 18.0, 11, 5); }
	else if(-32 < XX < -28){ CreateExplosion(XX-30, 2508.6316, 18.0, 11, 5); CreateExplosion(XX-30, 2497.1504, 18.0, 11, 5); }
	else if(-42 < XX < -38){ CreateExplosion(XX-30, 2508.6316, 18.0, 11, 5); CreateExplosion(XX-30, 2497.1504, 18.0, 11, 5); }
	else if(-52 < XX < -48){ CreateExplosion(XX-30, 2508.6316, 18.0, 11, 5); CreateExplosion(XX-30, 2497.1504, 18.0, 11, 5); }
	else if(-62 < XX < -58){ CreateExplosion(XX-30, 2508.6316, 18.0, 11, 5); CreateExplosion(XX-30, 2497.1504, 18.0, 11, 5); }
	else if(-72 < XX < -68){ CreateExplosion(XX-30, 2508.6316, 18.0, 11, 5); CreateExplosion(XX-30, 2497.1504, 18.0, 11, 5); }
	else if(-82 < XX < -78){ CreateExplosion(XX-30, 2508.6316, 18.0, 11, 5); CreateExplosion(XX-30, 2497.1504, 18.0, 11, 5); }
}

/*stock PlayerName(playerid)
{
	new pName[MAX_PLAYER_NAME];
	GetPlayerName(playerid, pName, sizeof(pName));
	return pName;
}
*/
public OnPlayerSelectedMenuRow(playerid, row)
{
	new Menu:Current = GetPlayerMenu(playerid);
	if(Current == AdminMenu)
	{
	    switch(row)
	    {
	        case 0:
	        {
	            ShowMenuForPlayer(YesNoGlobal, playerid);
			}
			case 1:
	        {
                ShowMenuForPlayer(YesNoPersonal, playerid);
			}
			case 2:
			{
			    ShowMenuForPlayer(MotorMenu, playerid);
			}
			case 3:
			{
			    TogglePlayerControllable(playerid, 1);
			}
		}
		return 1;
	}
	if(Current == MotorMenu)
	{
	    switch(row)
	    {
	        case 0:	{BikeModel = 522; SendClientMessage(playerid, 0x00FF00AA, "Moto: NRG-500");}
	        case 1:	{BikeModel = 581; SendClientMessage(playerid, 0x00FF00AA, "Moto: BF-400");}
	        case 2:	{BikeModel = 521; SendClientMessage(playerid, 0x00FF00AA, "Moto: FCR-900");}
	        case 3:	{BikeModel = 463; SendClientMessage(playerid, 0x00FF00AA, "Moto: Freeway");}
	        case 4:	{BikeModel = 461; SendClientMessage(playerid, 0x00FF00AA, "Moto: PCJ-600");}
	        case 5:	{BikeModel = 468; SendClientMessage(playerid, 0x00FF00AA, "Moto: Sanchez");}
	        case 6:	{ShowMenuForPlayer(AdminMenu, playerid);}
		}
		ShowMenuForPlayer(AdminMenu, playerid);
	}
	if(Current == YesNoGlobal)
	{
	    switch(row)
	    {
	        case 0: {ShowMenuForPlayer(AdminMenu, playerid);}
	        case 1:
			{
			    if(!dini_Exists(OVERALLFILE))
			    {
			        dini_Create(OVERALLFILE);
				}
			    dini_FloatSet(OVERALLFILE, "S1", 0.0000);
			    dini_FloatSet(OVERALLFILE, "S2", 0.0000);
			    dini_FloatSet(OVERALLFILE, "S3", 0.0000);
			    dini_Set(OVERALLFILE, "N1", "Empty");
			    dini_Set(OVERALLFILE, "N2", "Empty");
			    dini_Set(OVERALLFILE, "N3", "Empty");
			    HS[0] = 0.0;
				HS[1] = 0.0;
				HS[2] = 0.0;
				format(HSN[0], MAX_PLAYER_NAME, "Empty");
				format(HSN[1], MAX_PLAYER_NAME, "Empty");
				format(HSN[2], MAX_PLAYER_NAME, "Empty");
				SendClientMessage(playerid, 0x00FF00AA, "Global Jump-Highscores Reset!");
				TogglePlayerControllable(playerid, 1);
			}
		}
	}
	if(Current == YesNoPersonal)
	{
	    switch(row)
	    {
	        case 0: {ShowMenuForPlayer(AdminMenu, playerid);}
	        case 1:
			{
			    if(dini_Exists(PERSONALFILE))
			    {
			        dini_Remove(PERSONALFILE);
				}
				dini_Create(PERSONALFILE);
				SendClientMessage(playerid, 0x00FF00AA, "Personal Jump-Highscores Reset!");
				TogglePlayerControllable(playerid, 1);
			}
		}
	}
	return 1;
}

public OnPlayerExitedMenu(playerid)
{
	TogglePlayerControllable(playerid, 1);
	return 1;
}
public Esperar(playerid)
{
   if (TotalEnDrift == 1)
   {
        SetTimerEx("Esperar", 0, false, "d", playerid);
   }
   if (TotalEnDrift == 2)
   {
        SetTimerEx("Conteo5", 5000, false, "d", playerid);
        SendClientMessage(playerid, 0x00C800FF, "La carrera comenzara en unos segundos...");
   }
   return 1;
}

public Conteo5(playerid)
{
   PlayerPlaySound(playerid, 1056, 0.0, 0.0, 0.0);
   GameTextForPlayer(playerid, "~r~5!", 1000, 4);
   SetTimerEx("Conteo4", 1000, false, "d", playerid);
   return 1;
}

public Conteo4(playerid)
{
    PlayerPlaySound(playerid, 1056, 0.0, 0.0, 0.0);
   GameTextForPlayer(playerid, "~g~4!", 1000, 4);
   SetTimerEx("Conteo3", 1000, false, "d", playerid);
   return 1;
}

public Conteo3(playerid)
{
   PlayerPlaySound(playerid, 1056, 0.0, 0.0, 0.0);
   GameTextForPlayer(playerid, "~b~3!", 1000, 4);
   SetTimerEx("Conteo2", 1000, false, "d", playerid);
   return 1;
}

public Conteo2(playerid)
{
   PlayerPlaySound(playerid, 1056, 0.0, 0.0, 0.0);
   GameTextForPlayer(playerid, "~p~2!", 1000, 4);
   SetTimerEx("Conteo1", 1000, false, "d", playerid);
   return 1;
}

public Conteo1(playerid)
{
   PlayerPlaySound(playerid, 1056, 0.0, 0.0, 0.0);
   GameTextForPlayer(playerid, "~y~1!", 1000, 4);
   SetTimerEx("ConteoGo", 1000, false, "d", playerid);
   return 1;
}

public ConteoGo(playerid)
{
    TogglePlayerControllable(playerid, true);
   PlayerPlaySound(playerid, 1057, 0.0, 0.0, 0.0);
   GameTextForPlayer(playerid, "~b~G~r~o~g~o~b~o~p~o~y~o~b~!", 1000, 4);
   SetTimerEx("Meta", 0, false, "d", playerid);
   return 1;
}

public Meta(playerid)
{
   if (EnDrift[playerid] == 1)
   {
       if (TotalEnDrift == 2)
       {
          new Float:x, Float:y, Float:z, nombre[MAX_PLAYER_NAME], string[256];
          GetPlayerPos(playerid, Float:x, Float:y, Float:z);
          GetPlayerName(playerid, nombre, sizeof(nombre));
          format(string, sizeof(string), "[Pura Joda] %s ha ganado la carrera /Drift!", nombre);
          if (Float:x <= 2306.3162 && Float:y >= 1384.1410 && Float:z <= 10.8203)
          {
              EnDrift[playerid] = 0;
              TotalEnDrift = 0;
              GivePlayerMoney(playerid, 1000);
            GameTextForPlayer(playerid, "~g~Ganaste!", 3000, 4);
            SendClientMessage(playerid, 0x00C800FF, "Ganaste $1000!");
            SendClientMessageToAll(0xFFC800FF, string);
         }
         else return SetTimerEx("Meta", 0, false, "d", playerid);
      }
      else return EnDrift[playerid] = 0;
   }
   return 1;
}

//==============================================================================
#if defined ENABLE_SPEC

public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid)
{
	new x = 0;
	while(x!=MAX_PLAYER) {
	    if( IsPlayerConnected(x) &&	GetPlayerState(x) == PLAYER_STATE_SPECTATING &&
			PlayerInfo[x][SpecID] == playerid && PlayerInfo[x][SpecType] == ADMIN_SPEC_TYPE_PLAYER )
   		{
   		    SetPlayerInterior(x,newinteriorid);
		}
		x++;
	}
}

//==============================================================================
public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	new
 		string45[256],
 		rNameFile[256],
   		rFile45[256],
     	Float: vPos[4]
	;
	if(newkeys & KEY_FIRE)
	{
	    if(BuildRace == playerid+1)
	    {
		    if(BuildTakeVehPos == true)
		    {
		    	if(!IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid, RED, "[Pura Joda] Tienes que éstar en un vehículo..");
				format(rFile45, sizeof(rFile45), "/rRaceSystem/%s.RRACE", BuildName);
				GetVehiclePos(GetPlayerVehicleID(playerid), vPos[0], vPos[1], vPos[2]);
				GetVehicleZAngle(GetPlayerVehicleID(playerid), vPos[3]);
		        dini_Create(rFile45);
				dini_IntSet(rFile45, "vModel", BuildModeVID);
				dini_IntSet(rFile45, "rType", BuildRaceType);
		        format(string45, sizeof(string45), "vPosX_%d", BuildVehPosCount), dini_FloatSet(rFile45, string45, vPos[0]);
		        format(string45, sizeof(string45), "vPosY_%d", BuildVehPosCount), dini_FloatSet(rFile45, string45, vPos[1]);
		        format(string45, sizeof(string45), "vPosZ_%d", BuildVehPosCount), dini_FloatSet(rFile45, string45, vPos[2]);
		        format(string45, sizeof(string45), "vAngle_%d", BuildVehPosCount), dini_FloatSet(rFile45, string45, vPos[3]);
		        format(string45, sizeof(string45), ">> Vehicle Pos '%d' has been taken.", BuildVehPosCount+1);
		        SendClientMessage(playerid, YELLOW, string45);
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
				format(rFile45, sizeof(rFile45), "/rRaceSystem/%s.RRACE", BuildName);
				GetVehiclePos(GetPlayerVehicleID(playerid), vPos[0], vPos[1], vPos[2]);
				format(string45, sizeof(string45), "CP_%d_PosX", BuildCheckPointCount), dini_FloatSet(rFile45, string45, vPos[0]);
				format(string45, sizeof(string45), "CP_%d_PosY", BuildCheckPointCount), dini_FloatSet(rFile45, string45, vPos[1]);
				format(string45, sizeof(string45), "CP_%d_PosZ", BuildCheckPointCount), dini_FloatSet(rFile45, string45, vPos[2]);
    			format(string45, sizeof(string45), ">> Checkpoint '%d' has been setted!", BuildCheckPointCount+1);
		        SendClientMessage(playerid, YELLOW, string45);
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
			format(string45, sizeof(string45), "Race_%d", TotalRaces-1);
			format(rFile45, sizeof(rFile45), "/rRaceSystem/%s.RRACE", BuildName);
			dini_Set(rNameFile, string45, BuildName);
			dini_IntSet(rFile45, "TotalCP", BuildCheckPointCount);
			Loop(x, 5)
			{
				format(string45, sizeof(string45), "BestRacerTime_%d", x);
				dini_Set(rFile45, string45, "0");
				format(string45, sizeof(string45), "BestRacer_%d", x);
				dini_Set(rFile45, string45, "noone");
			}
	    }
	}
	if(newkeys & KEY_NO  ){
	if(Joined[playerid]){
//SetCP(playerid, CPProgess[playerid], CPProgess[playerid]-1, TotalCP, RaceType);
	SetCPEx(playerid, CPProgess[playerid]-1);
//
	}

	}
	if(newkeys & KEY_CROUCH) {
		if(IsPlayerInAnyVehicle(playerid) && Jump[playerid] && GetPVarInt(playerid, "RACE") == 0 && !GetPVarInt(playerid, "MINION")) {

					new Float:xx, Float:xy, Float:xz;
					GetVehicleVelocity(GetPlayerVehicleID(playerid), xx, xy, xz);
					SetVehicleVelocity(GetPlayerVehicleID(playerid), xx, xy, xz + JUMPSIZE2);

		}
	}
	if(newkeys & KEY_ACTION){
 if(IsPlayerInAnyVehicle(playerid) && Velocity[playerid] && GetPVarInt(playerid, "RACE") == 0) {

  			new Float:x, Float:y, Float:z;
        	GetVehicleVelocity(GetPlayerVehicleID(playerid),x,y,z);
    		SetVehicleVelocity(GetPlayerVehicleID(playerid),x*3,y*3,z*3);


		}


	}
	if(newkeys & KEY_FIRE && Ironman[playerid][ActivarIronman]) {
		new Float:explosiones[3];
		GetPlayerPos(playerid, explosiones[0],explosiones[1],explosiones[2]);
		CreateExplosion(explosiones[0],explosiones[1],explosiones[2], 1, 10.0);
		//SendClientMessage(playerid, -1, "JARVIS: Señor, explosion aerea activada!.");
		return true;
	}

	if(GetPlayerState(playerid) == PLAYER_STATE_SPECTATING && PlayerInfo[playerid][SpecID] != INVALID_PLAYER_ID)
	{
		if(newkeys == KEY_JUMP) AdvanceSpectate(playerid);
		else if(newkeys == KEY_SPRINT) ReverseSpectate(playerid);
	}

    if(newkeys & KEY_FIRE) // Si presiona el Click Izquierdo
    {
		if(AceleracionBrutal[playerid] == true) // Si ha activado la Aceleración Brutal
		{
            new Float:X, Float:Y, Float:Z, Float:Velocidad; // Creamos las variables
            GetVehicleVelocity(GetPlayerVehicleID(playerid), X, Y, Z); // Obtenemos la velocidad del vehículo en coordenadas
            Velocidad = floatmul(floatsqroot(floatadd(floatadd(floatpower(X, 2), floatpower(Y, 2)),  floatpower(Z, 2))), 100.0); // Calculamos la velocidad (By Fallout)
            if(Velocidad >= 100.0) // Si vá a 100 o más
            {
                SetVehicleVelocity(GetPlayerVehicleID(playerid), X * 1.5, Y * 1.5, Z * 1.5); // Multiplica la velocidad por 1.5
    		} else { // Si va a menos de 100
                SetVehicleVelocity(GetPlayerVehicleID(playerid), X * 3.0, Y * 3.0, Z * 3.0); // Multiplica la velocidad por 3
    		}
		}
    }
	/*if(newkeys & KEY_ACTION)
	{
		if(IsPlayerInAnyVehicle(playerid))
		{
			new vehicleid = GetPlayerVehicleID(playerid);
			new Float:x,Float:y,Float:z,Float:ang,object;
			GetVehiclePos(vehicleid,x,y,z);
			GetVehicleZAngle(vehicleid,ang);
			x = x+(35*floatsin(-ang,degrees));
			y = y+(35*floatcos(-ang,degrees));
			object = CreatePlayerObject(playerid,1634,x,y,z,0,0,ang);
			SetTimerEx("DeletePlayerObject",10*1000,false,"ii",playerid,object);
		}
	}*/
	return 0;
}

//==============================================================================
	new Weapon[13][2];
	new TieneArma = 0;
new eAEA[100];

public OnPlayerUpdate(playerid)
{
	format(eAEA, 100, "~r~~h~score: ~w~%d ~w~- ~g~~h~deaths: ~w~%d ~w~- ~p~PJCoins: ~w~%d",GetPVarInt(playerid, "Score"), PlayerInfo[playerid][Deaths], GetPVarInt(playerid, "COIN"));
	PlayerTextDrawSetString(playerid, statings[playerid], eAEA);
	if(GetPlayerMoney(playerid) != MoneyEx[playerid])
	{
	ResetPlayerMoney(playerid);
	GivePlayerMoney(playerid, MoneyEx[playerid]);
	}

	new drunk2 = GetPlayerDrunkLevel(playerid);
	if(drunk2 < 100)
	{
		SetPlayerDrunkLevel(playerid,2000);
	} else {
		if(DLlast[playerid] != drunk2)
		{
			new fps = DLlast[playerid] - drunk2;
			if((fps > 0) && (fps < 200))
			FPS2[playerid] = fps;
			DLlast[playerid] = drunk2;
		}
	}
	//ShowInformationTxt(playerid);
	if(PlayerEnPGOD[playerid] == 1)
	{
    	for(new i = 0; i <= 12; i++)
    	{
    	    GetPlayerWeaponData(playerid, i, Weapon[i][0], Weapon[i][1]);
    	    if(Weapon[i][0] != 0) TieneArma++;
    	}
   		if(TieneArma != 0)
		{
   		    //SendClientMessage(playerid, COLOR_ROJO, "[Pura Joda]: {FFFFFF}Usted no puede usar armas estando con /pgod activo");
   		    ResetPlayerWeapons(playerid);
		}
	}
	return 1;
}

//==============================================================================
public OnPlayerEnterVehicle(playerid, vehicleid) {
	for(new x=0; x<MAX_PLAYER; x++) {
	    if(GetPlayerState(x) == PLAYER_STATE_SPECTATING && PlayerInfo[x][SpecID] == playerid) {
	        TogglePlayerSpectating(x, 1);
	        PlayerSpectateVehicle(x, vehicleid);
	        PlayerInfo[x][SpecType] = ADMIN_SPEC_TYPE_VEHICLE;
		}
	}
	return 1;
}

//==============================================================================
new ea[MAX_PLAYERS];
public OnPlayerStateChange(playerid, newstate, oldstate) {
	switch(newstate) {
		case PLAYER_STATE_ONFOOT: {
			switch(oldstate) {
				case PLAYER_STATE_DRIVER: OnPlayerExitVehicle(playerid,255);
				case PLAYER_STATE_PASSENGER: OnPlayerExitVehicle(playerid,255);
			}
		}
	}
	    if(newstate == PLAYER_STATE_DRIVER || newstate == PLAYER_STATE_PASSENGER)// If the player's state changes to a vehicle state we'll have to spec the vehicle.
    {
	    TextDrawShowForPlayer(playerid, Underline);
		TextDrawShowForPlayer(playerid, Title);
		TextDrawShowForPlayer(playerid, KMH);

	  //  for(new i = 0; i < GetMaxPlayers(); i++)
	   // {
	        PlayerTextDrawShow(playerid, VehicleName[playerid]);
	        PlayerTextDrawShow(playerid, VehicleHealth[playerid]);
	        PlayerTextDrawShow(playerid, VehicleSpeed[playerid]);
			ea[playerid] = SetTimerEx("Speedometer", 20, true,"i", playerid);

        if(IsBeingSpeced[playerid] == 1)//If the player being spectated, enters a vehicle, then let the spectator spectate the vehicle.
        {
            foreach(new i : Player)
            {
                if(spectatorid[i] == playerid)
                {
                    PlayerSpectateVehicle(i, GetPlayerVehicleID(playerid));// Letting the spectator, spectate the vehicle of the player being spectated (I hope you understand this xD)
                }
            }
        }
    }
//    if()
    if(newstate == PLAYER_STATE_ONFOOT)
    {
        if(IsBeingSpeced[playerid] == 1)//If the player being spectated, exists a vehicle, then let the spectator spectate the player.
        {
            foreach(new i : Player)
            {
                if(spectatorid[i] == playerid)
                {
                    PlayerSpectatePlayer(i, playerid);// Letting the spectator, spectate the player who exited the vehicle.
                }
            }
        }
    }
	if(oldstate == PLAYER_STATE_DRIVER || oldstate == PLAYER_STATE_PASSENGER)
	{
	    TextDrawHideForPlayer(playerid, Underline);
		TextDrawHideForPlayer(playerid, Title);
		TextDrawHideForPlayer(playerid, KMH);

	    //for(new i = 0; i < GetMaxPlayers(); i++)
	  //  {
	        PlayerTextDrawHide(playerid, VehicleName[playerid]);
	        PlayerTextDrawHide(playerid, VehicleHealth[playerid]);
	        PlayerTextDrawHide(playerid, VehicleSpeed[playerid]);
	        KillTimer(ea[playerid]);
	    //}
	}
	return 1;
}

#endif

//==============================================================================
public OnPlayerExitVehicle(playerid, vehicleid)
{
	if(PlayerInfo[playerid][DoorsLocked] == 1) SetVehicleParamsForPlayer(GetPlayerVehicleID(playerid),playerid,false,false);

	#if defined ENABLE_SPEC
	for(new x=0; x<MAX_PLAYER; x++) {
    	if(GetPlayerState(x) == PLAYER_STATE_SPECTATING && PlayerInfo[x][SpecID] == playerid && PlayerInfo[x][SpecType] == ADMIN_SPEC_TYPE_VEHICLE) {
        	TogglePlayerSpectating(x, 1);
	        PlayerSpectatePlayer(x, playerid);
    	    PlayerInfo[x][SpecType] = ADMIN_SPEC_TYPE_PLAYER;
		}
	}
	#endif
	if(Adentro[playerid] == 2)
    {
	    SendClientMessage(playerid,COLOR_RED,"Te Has Salido del Auto Perdistes Automaticamente.");
		SetPlayerPos(playerid,2032.1617,1545.1399,10.8203);
	    SetPlayerVirtualWorld(playerid, 0);
	    DestroyVehicle(Monster[playerid]);
	    Adentro[playerid] = 0;
		SetPlayerInterior(playerid,0);
    }
	return 1;
}


//==============================================================================
#if defined ENABLE_SPEC

stock StartSpectate(playerid, specplayerid)
{
	for(new x=0; x<MAX_PLAYER; x++) {
	    if(GetPlayerState(x) == PLAYER_STATE_SPECTATING && PlayerInfo[x][SpecID] == playerid) {
	       AdvanceSpectate(x);
		}
	}
	SetPlayerInterior(playerid,GetPlayerInterior(specplayerid));
	TogglePlayerSpectating(playerid, 1);

	if(IsPlayerInAnyVehicle(specplayerid)) {
		PlayerSpectateVehicle(playerid, GetPlayerVehicleID(specplayerid));
		PlayerInfo[playerid][SpecID] = specplayerid;
		PlayerInfo[playerid][SpecType] = ADMIN_SPEC_TYPE_VEHICLE;
	}
	else {
		PlayerSpectatePlayer(playerid, specplayerid);
		PlayerInfo[playerid][SpecID] = specplayerid;
		PlayerInfo[playerid][SpecType] = ADMIN_SPEC_TYPE_PLAYER;
	}
	new string[100], Float:hp, Float:ar;
	GetPlayerName(specplayerid,string,sizeof(string));
	GetPlayerHealth(specplayerid, hp);	GetPlayerArmour(specplayerid, ar);
	format(string,sizeof(string),"~n~~n~~n~~n~~n~~n~~n~~n~~w~%s - id:%d~n~< sprint - jump >~n~hp:%0.1f ar:%0.1f $%d", string,specplayerid,hp,ar,GetPlayerMoney(specplayerid) );
	GameTextForPlayer(playerid,string,25000,3);
	return 1;
}

stock IsValidName(string[])
{
	for(new i = 0, j = strlen(string); i < j; i++)
	{
		switch(string[i])
		{
			case '0' .. '9': continue;
			case 'a' .. 'z': continue;
			case 'A' .. 'Z': continue;
			case '_': continue;
			case '$': continue;
			case '.': continue;
			case '=': continue;
			case '(': continue;
			case ')': continue;
			case '[': continue;
			case ']': continue;
			default: return 0;
		}
	}
	return 1;
}

stock crashear(playerid)
{
	ApplyAnimation(playerid,"Fuck", "M_smkasdf_loop_", 4.0, 1, 0, 0, 0, 0);
	ApplyAnimation(playerid,"Crashea", "M_sasfloop_", 4.0, 1, 0, 0, 0, 0);
	ApplyAnimation(playerid,"PorFavor", "sdgsdf_", 4.0, 1, 0, 0, 0, 0);
	GameTextForPlayer(playerid, "•¤¶§!$$%&'()*+,-./01~!@#$^&*()_-+={[}]:;'<,>.?/", 1000, 0);
 	GameTextForPlayer(playerid, "•¤¶§!$$%&'()*+,-./01~!@#$^&*()_-+={[}]:;'<,>.?/", 2000, 1);
  	GameTextForPlayer(playerid, "•¤¶§!$$%&'()*+,-./01~!@#$^&*()_-+={[}]:;'<,>.?/", 3000, 2);
  	GameTextForPlayer(playerid, "•¤¶§!$$%&'()*+,-./01~!@#$^&*()_-+={[}]:;'<,>.?/", 4000, 3);
  	GameTextForPlayer(playerid, "•¤¶§!$$%&'()*+,-./01~!@#$^&*()_-+={[}]:;'<,>.?/", 5000, 4);
  	GameTextForPlayer(playerid, "•¤¶§!$$%&'()*+,-./01~!@#$^&*()_-+={[}]:;'<,>.?/", 6000, 5);
  	GameTextForPlayer(playerid, "•¤¶§!$$%&'()*+,-./01~!@#$^&*()_-+={[}]:;'<,>.?/", 7000, 6);
	ApplyAnimation(playerid,"jejesicrasheaxD", "M_smkleafds_", 4.0, 1, 0, 0, 0, 0);
}

stock StopSpectate(playerid)
{
	TogglePlayerSpectating(playerid, 0);
	PlayerInfo[playerid][SpecID] = INVALID_PLAYER_ID;
	PlayerInfo[playerid][SpecType] = ADMIN_SPEC_TYPE_NONE;
	GameTextForPlayer(playerid,"~n~~n~~n~~w~Spectate mode ended",1000,3);
	return 1;
}


stock EsVehiculoOcupado(vehicleid)
{
for(new i=0; i<GetMaxPlayers(); i++) if(IsPlayerInVehicle(i, vehicleid) && GetPlayerState(i) == PLAYER_STATE_DRIVER) return 1;
return 0;
}

stock AdvanceSpectate(playerid)
{
    if(ConnectedPlayers() == 2) { StopSpectate(playerid); return 1; }
	if(GetPlayerState(playerid) == PLAYER_STATE_SPECTATING && PlayerInfo[playerid][SpecID] != INVALID_PLAYER_ID)
	{
	    for(new x=PlayerInfo[playerid][SpecID]+1; x<=MAX_PLAYER; x++)
		{
	    	if(x == MAX_PLAYER) x = 0;
	        if(IsPlayerConnected(x) && x != playerid)
			{
				if(GetPlayerState(x) == PLAYER_STATE_SPECTATING && PlayerInfo[x][SpecID] != INVALID_PLAYER_ID || (GetPlayerState(x) != 1 && GetPlayerState(x) != 2 && GetPlayerState(x) != 3))
				{
					continue;
				}
				else
				{
					StartSpectate(playerid, x);
					break;
				}
			}
		}
	}
	return 1;
}

stock ReverseSpectate(playerid)
{
    if(ConnectedPlayers() == 2) { StopSpectate(playerid); return 1; }
	if(GetPlayerState(playerid) == PLAYER_STATE_SPECTATING && PlayerInfo[playerid][SpecID] != INVALID_PLAYER_ID)
	{
	    for(new x=PlayerInfo[playerid][SpecID]-1; x>=0; x--)
		{
	    	if(x == 0) x = MAX_PLAYER;
	        if(IsPlayerConnected(x) && x != playerid)
			{
				if(GetPlayerState(x) == PLAYER_STATE_SPECTATING && PlayerInfo[x][SpecID] != INVALID_PLAYER_ID || (GetPlayerState(x) != 1 && GetPlayerState(x) != 2 && GetPlayerState(x) != 3))
				{
					continue;
				}
				else
				{
					StartSpectate(playerid, x);
					break;
				}
			}
		}
	}
	return 1;
}

//-------------------------------------------
forward PosAfterSpec(playerid);
public PosAfterSpec(playerid)
{
	SetPlayerPos(playerid,Pos[playerid][0],Pos[playerid][1],Pos[playerid][2]);
	SetPlayerFacingAngle(playerid,Pos[playerid][3]);
}
#endif

//==============================================================================
EraseVehicle(vehicleid)
{
    for(new players=0;players<=MAX_PLAYER;players++)
    {
        new Float:X,Float:Y,Float:Z;
        if (IsPlayerInVehicle(players,vehicleid))
        {
            GetPlayerPos(players,X,Y,Z);
            SetPlayerPos(players,X,Y,Z+2);
            SetVehicleToRespawn(vehicleid);
        }
        SetVehicleParamsForPlayer(vehicleid,players,0,1);
    }
    SetTimerEx("VehRes",3000,0,"d",vehicleid);
    return 1;
}

forward CarSpawner(playerid,model);
public CarSpawner(playerid,model)
{
	if(IsPlayerInAnyVehicle(playerid)) SendClientMessage(playerid, red, "Usted ya tiene un coche!");
 	else
	{
                        GetPlayerPos(playerid, cX, cY, cZ);
                        GetPlayerFacingAngle(playerid, cAngle);
						CreateVehicleEx(playerid, model, cX, cY, cZ+2.0, cAngle, random(126), random(126), -1);
	}
	return 1;
}

forward CarDeleter(vehicleid);
public CarDeleter(vehicleid)
{
    for(new i=0;i<MAX_PLAYER;i++) {
        new Float:X,Float:Y,Float:Z;
    	if(IsPlayerInVehicle(i, vehicleid)) {
    	    RemovePlayerFromVehicle(i);
    	    GetPlayerPos(i,X,Y,Z);
        	SetPlayerPos(i,X,Y+3,Z);
	    }
	    SetVehicleParamsForPlayer(vehicleid,i,0,1);
	}
    SetTimerEx("VehRes",1500,0,"i",vehicleid);
}

forward VehRes(vehicleid);
public VehRes(vehicleid)
{
    DestroyVehicle(vehicleid);
}

public OnVehicleSpawn(vehicleid)
{
	for(new i=0;i<MAX_PLAYER;i++)
	{
        if(vehicleid==PlayerInfo[i][pCar])
		{
		    CarDeleter(vehicleid);
	        PlayerInfo[i][pCar]=-1;
        }
	}
	return 1;
}
//==============================================================================
forward TuneLCar(VehicleID);
public TuneLCar(VehicleID)
{
	ChangeVehicleColor(VehicleID,0,7);
	AddVehicleComponent(VehicleID, 1010);  AddVehicleComponent(VehicleID, 1087);
}

//==============================================================================

public OnRconCommand(cmd[])
{
	if( strlen(cmd) > 50 || strlen(cmd) == 1 ) return print("Invalid command length (exceeding 50 characters)");

	if(strcmp(cmd, "ladmin", true)==0) {
		print("Rcon Commands");
		print("info, aka, pm, asay, ann, uconfig, chat");
		return true;
	}

	if(strcmp(cmd, "info", true)==0)
	{
	    new TotalVehicles = CreateVehicle(411, 0, 0, 0, 0, 0, 0, 1000);    DestroyVehicle(TotalVehicles);
		new numo = CreateObject(1245,0,0,1000,0,0,0);	DestroyObject(numo);
		new nump = CreatePickup(371,2,0,0,1000);	DestroyPickup(nump);
		new gz = GangZoneCreate(3,3,5,5);	GangZoneDestroy(gz);

		new model[250], nummodel;
		for(new i=1;i<TotalVehicles;i++) model[GetVehicleModel(i)-400]++;
		for(new i=0;i<250;i++) { if(model[i]!=0) {	nummodel++;	}	}

		new string[256];
		print(" ===========================================================================");
		printf("                           Server Info:");
		format(string,sizeof(string),"[ Jugadores Conectados: %d || Jugadores Maximos: %d ] [Ratio %0.2f ]",ConnectedPlayers(),GetMaxPlayers(),Float:ConnectedPlayers() / Float:GetMaxPlayers() );
		printf(string);
		format(string,sizeof(string),"[ Vehiculos: %d || Modelos %d || Jugadores en Vehiculos: %d ]",TotalVehicles-1,nummodel, InVehCount() );
		printf(string);
		format(string,sizeof(string),"[ En Auto %d  ||  En Moto/Bice %d ]",InCarCount(),OnBikeCount() );
		printf(string);
		format(string,sizeof(string),"[ Objetos: %d || Pickups %d  || Gangzones %d]",numo-1, nump, gz);
		printf(string);
		format(string,sizeof(string),"[ Jugadores Arrestados %d || Jugadores Congelados %d || Muteadosd %d ]",JailedPlayers(),FrozenPlayers(), MutedPlayers() );
	    printf(string);
	    format(string,sizeof(string),"[ Administradores ON-LINE %d  RCON Admins ON-LINE %d ]",AdminCount(), RconAdminCount() );
	    printf(string);
		print(" ===========================================================================");
		return true;
	}
	if(!strcmp(cmd, "kickall", .length = 7)){
	for(new e; e < MAX_PLAYERS; e++)
	    Kick(e);
	    printf("Kickall éxitoso");
	    return true;
	}
	if(!strcmp(cmd, "pm", .length = 2))
	{
	    new arg_1 = argpos(cmd), arg_2 = argpos(cmd, arg_1),targetid = strval(cmd[arg_1]), message[128];

    	if ( !cmd[arg_1] || cmd[arg_1] < '0' || cmd[arg_1] > '9' || targetid > MAX_PLAYER || targetid < 0 || !cmd[arg_2])
	        print("Use: \"pm <jugador> <mensaje>\"");

	    else if ( !IsPlayerConnected(targetid) ) print("Este jugador no esta conectado!");
    	else
	    {
	        format(message, sizeof(message), "[RCON] PM: %s", cmd[arg_2]);
	        SendClientMessage(targetid, COLOR_WHITE, message);
   	        printf("Rcon PM '%s' sent", cmd[arg_1] );
    	}
	    return true;
	}

	if(!strcmp(cmd, "asay", .length = 4))
	{
	    new arg_1 = argpos(cmd), message[128];

    	if ( !cmd[arg_1] || cmd[arg_1] < '0') print("Use: \"asay  <mensaje>\" (MessageToAdmins)");
	    else
	    {
	        format(message, sizeof(message), "[RCON] MessageToAdmins: %s", cmd[arg_1]);
	        MessageToAdmins(COLOR_WHITE, message);
	        printf("Admin Message '%s' sent", cmd[arg_1] );
    	}
	    return true;
	}

	if(!strcmp(cmd, "ann", .length = 3))
	{
	    new arg_1 = argpos(cmd), message[128];
    	if ( !cmd[arg_1] || cmd[arg_1] < '0') print("Use: \"ann  <mensaje>\" (GameTextForAll)");
	    else
	    {
	        format(message, sizeof(message), "[RCON]: %s", cmd[arg_1]);
	        GameTextForAll(message,3000,3);
	        printf("GameText Message '%s' sent", cmd[arg_1] );
    	}
	    return true;
	}

	if(!strcmp(cmd, "msg", .length = 3))
	{
	    new arg_1 = argpos(cmd), message[128];
    	if ( !cmd[arg_1] || cmd[arg_1] < '0') print("Use: \"msg  <mensaje>\" (SendClientMessageToAll)");
	    else
	    {
	        format(message, sizeof(message), "[RCON]: %s", cmd[arg_1]);
	        SendClientMessageToAll(COLOR_WHITE, message);
	        printf("MessageToAll '%s' sent", cmd[arg_1] );
    	}
	    return true;
	}

	if(strcmp(cmd, "uconfig", true)==0)
	{
		UpdateConfig();
		print("Configuracion actualizada satifactoriamente");
		return true;
	}

	if(!strcmp(cmd, "aka", .length = 3))
	{
	    new arg_1 = argpos(cmd), targetid = strval(cmd[arg_1]);

    	if ( !cmd[arg_1] || cmd[arg_1] < '0' || cmd[arg_1] > '9' || targetid > MAX_PLAYER || targetid < 0)
	        print("Usage: aka <playerid>");
	    else if ( !IsPlayerConnected(targetid) ) print("Este jugador no esta conectado!");
    	else
	    {
			new tmp3[50], playername[MAX_PLAYER_NAME];
	  		GetPlayerIp(targetid,tmp3,50);
			GetPlayerName(targetid, playername, sizeof(playername));
			printf("AKA: [%s id:%d] [%s] %s", playername, targetid, tmp3, dini_Get("ladmin/config/aka.txt",tmp3) );
    	}
	    return true;
	}

	if(!strcmp(cmd, "chat", .length = 4)) {
		for(new i = 1; i < MAX_CHAT_LINES; i++) print(Chat[i]);
	    return true;
	}

	return 0;
}



//==============================================================================
forward countdown();
public countdown()
{
	if(CountDown==6) GameTextForAll("~p~Comenzando...",1000,6);

	CountDown--;
	if(CountDown==0)
	{
		GameTextForAll("~g~GO~ r~!",1000,6);
		CountDown = -1;
		for(new i = 0; i < MAX_PLAYER; i++) {
			TogglePlayerControllable(i,true);
			PlayerPlaySound(i, 1057, 0.0, 0.0, 0.0);
		}
		return 0;
	}
	else
	{
		new text[7]; format(text,sizeof(text),"~w~%d",CountDown);
		for(new i = 0; i < MAX_PLAYER; i++) {
			PlayerPlaySound(i, 1056, 0.0, 0.0, 0.0);
			TogglePlayerControllable(i,false);
		}
	 	GameTextForAll(text,1000,6);
	}

	SetTimer("countdown",1000,0);
	return 0;
}

forward Duel(player1, player2);
public Duel(player1, player2)
{
	if(cdt[player1]==6) {
		GameTextForPlayer(player1,"~p~Comenzando Duelo...",1000,6); GameTextForPlayer(player2,"~p~Comenzando Duelo...",1000,6);
	}

	cdt[player1]--;
	if(cdt[player1]==0)
	{
		TogglePlayerControllable(player1,1); TogglePlayerControllable(player2,1);
		PlayerPlaySound(player1, 1057, 0.0, 0.0, 0.0); PlayerPlaySound(player2, 1057, 0.0, 0.0, 0.0);
		GameTextForPlayer(player1,"~g~GO~ r~!",1000,6); GameTextForPlayer(player2,"~g~GO~ r~!",1000,6);
		return 0;
	}
	else
	{
		new text[7]; format(text,sizeof(text),"~w~%d",cdt[player1]);
		PlayerPlaySound(player1, 1056, 0.0, 0.0, 0.0); PlayerPlaySound(player2, 1056, 0.0, 0.0, 0.0);
		TogglePlayerControllable(player1,0); TogglePlayerControllable(player2,0);
		GameTextForPlayer(player1,text,1000,6); GameTextForPlayer(player2,text,1000,6);
	}

	SetTimerEx("Duel",1000,0,"dd", player1, player2);
	return 0;
}

//==================== [ Jail & Freeze ]========================================

forward Jail1(player1);
public Jail1(player1)
{
    TogglePlayerControllable(player1,0);
	new Float:x, Float:y, Float:z;	GetPlayerPos(player1,x,y,z);
	SetPlayerCameraPos(player1,x+10,y,z+10);SetPlayerCameraLookAt(player1,x,y,z);
	SetTimerEx("Jail2",1000,0,"d",player1);
}

forward Jail2(player1);
public Jail2(player1)
{
	new Float:x, Float:y, Float:z; GetPlayerPos(player1,x,y,z);
	SetPlayerCameraPos(player1,x+7,y,z+5); SetPlayerCameraLookAt(player1,x,y,z);
	if(GetPlayerState(player1) == PLAYER_STATE_ONFOOT) SetPlayerSpecialAction(player1,SPECIAL_ACTION_HANDSUP);
	GameTextForPlayer(player1,"~r~~h~Has sido atrapado!",3000,3);
	SetTimerEx("Jail3",1000,0,"d",player1);
}

forward Jail3(player1);
public Jail3(player1)
{
	new Float:x, Float:y, Float:z; GetPlayerPos(player1,x,y,z);
	SetPlayerCameraPos(player1,x+3,y,z); SetPlayerCameraLookAt(player1,x,y,z);
}

forward JailPlayer(player1);
public JailPlayer(player1)
{
    Adentro[player1] = 1;
	SetPlayerVirtualWorld(player1, 3);
    SetPlayerPos(player1,3398.2356, -672.9715, 6.3489);
    TogglePlayerControllable(player1,1);
	SetCameraBehindPlayer(player1);
	JailTimer[player1] = SetTimerEx("JailRelease",PlayerInfo[player1][JailTime],0,"d",player1);
	PlayerInfo[player1][Jailed] = 1;
}

forward JailRelease(player1);
public JailRelease(player1)
{
    Adentro[player1] = 0;
	KillTimer( JailTimer[player1] );
	PlayerInfo[player1][JailTime] = 0;  PlayerInfo[player1][Jailed] = 0;
	SetPlayerInterior(player1,0); SetPlayerPos(player1, 0.0, 0.0, 0.0); SpawnPlayer(player1);
	PlayerPlaySound(player1,1057,0.0,0.0,0.0);
	GameTextForPlayer(player1,"~g~Released ~n~From Jail",3000,3);
    TogglePlayerControllable(player1,1);
}

//------------------------------------------------------------------------------
forward UnFreezeMe(player1);
public UnFreezeMe(player1)
{
	KillTimer( FreezeTimer[player1] );
	TogglePlayerControllable(player1,true);   PlayerInfo[player1][Frozen] = 0;
	PlayerPlaySound(player1,1057,0.0,0.0,0.0);	GameTextForPlayer(player1,"~g~Unfrozen",3000,3);
}

//==============================================================================
forward RepairCar(playerid);
public RepairCar(playerid)
{
	if(IsPlayerInAnyVehicle(playerid)) SetVehiclePos(GetPlayerVehicleID(playerid),Pos[playerid][0],Pos[playerid][1],Pos[playerid][2]+0.5);
	SetVehicleZAngle(GetPlayerVehicleID(playerid), Pos[playerid][3]);
	SetCameraBehindPlayer(playerid);
}

//============================ [ Timers ]=======================================

forward PingKick();
public PingKick()
{
	if(ServerInfo[MaxPing] != 0)
	{
	    PingPos++; if(PingPos > PING_MAX_EXCEEDS) PingPos = 0;

		for(new i=0; i<MAX_PLAYER; i++)
		{
			PlayerInfo[i][pPing][PingPos] = GetPlayerPing(i);

		    if(GetPlayerPing(i) > ServerInfo[MaxPing])
			{
				if(PlayerInfo[i][PingCount] == 0) PlayerInfo[i][PingTime] = TimeStamp();

	   			PlayerInfo[i][PingCount]++;
				if(TimeStamp() - PlayerInfo[i][PingTime] > PING_TIMELIMIT)
				{
	    			PlayerInfo[i][PingTime] = TimeStamp();
					PlayerInfo[i][PingCount] = 1;
				}
				else if(PlayerInfo[i][PingCount] >= PING_MAX_EXCEEDS)
				{
				    new Sum8, Average, x, string[128];
					while (x < PING_MAX_EXCEEDS) {
						Sum8 += PlayerInfo[i][pPing][x];
						x++;
					}
					Average = (Sum8 / PING_MAX_EXCEEDS);
					format(string,sizeof(string),"%s ha sido kickeado del server. (Razón: High Ping (%d) | Average (%d) | Max Allowed (%d) )", PlayerName2(i), GetPlayerPing(i), Average, ServerInfo[MaxPing] );
  		    		SendClientMessageToAll(grey,string);
					SaveToFile("KickLog",string);
					Kick(i);
				}
			}
			else if(GetPlayerPing(i) < 1 && ServerInfo[AntiBot] == 1)
		    {
				PlayerInfo[i][BotPing]++;
				if(PlayerInfo[i][BotPing] >= 3) BotCheck(i);
		    }
		    else
			{
				PlayerInfo[i][BotPing] = 0;
			}
		}
	}

	#if defined ANTI_MINIGUN
	new weap, ammo;
	for(new i = 0; i < MAX_PLAYER; i++)
	{
		if(IsPlayerConnected(i) && PlayerInfo[i][Level] == 0)
		{
			GetPlayerWeaponData(i, 7, weap, ammo);
			if(ammo > 1 && weap == 38) {
				new string[128];
				MessageToAdmins(COLOR_WHITE,string);
			}
		}
	}
	#endif
}

//==============================================================================
forward GodUpdate();
public GodUpdate()
{
	for(new i = 0; i < MAX_PLAYER; i++)
	{
		if(PlayerInfo[i][God] == 1)
		{
			SetPlayerHealth(i,99999999);

		    if(IsPlayerInAnyVehicle(i)){
				RepairVehicle(GetPlayerVehicleID(i)); //Reparar o Visual
				SetVehicleHealth(GetPlayerVehicleID(i),1000000000);
			}
		}
		if(PlayerInfo[i][GodCar] == 1 && IsPlayerInAnyVehicle(i))
		{
			RepairVehicle(GetPlayerVehicleID(i)); //Reparar o Visual
			SetVehicleHealth(GetPlayerVehicleID(i),1000000000);
		}
	}
}

//==========================[ Server Info  ]====================================

forward ConnectedPlayers();
public ConnectedPlayers()
{
	new Connected;
	for(new i = 0; i < MAX_PLAYER; i++) if(IsPlayerConnected(i)) Connected++;
	return Connected;
}

forward JailedPlayers();
public JailedPlayers()
{
	new JailedCount;
	for(new i = 0; i < MAX_PLAYER; i++) if(IsPlayerConnected(i) && PlayerInfo[i][Jailed] == 1) JailedCount++;
	return JailedCount;
}

forward FrozenPlayers();
public FrozenPlayers()
{
	new FrozenCount; for(new i = 0; i < MAX_PLAYER; i++) if(IsPlayerConnected(i) && PlayerInfo[i][Frozen] == 1) FrozenCount++;
	return FrozenCount;
}

forward MutedPlayers();
public MutedPlayers()
{
	new Count; for(new i = 0; i < MAX_PLAYER; i++) if(IsPlayerConnected(i) && PlayerInfo[i][Muted] == 1) Count++;
	return Count;
}

forward InVehCount();
public InVehCount()
{
	new InVeh; for(new i = 0; i < MAX_PLAYER; i++) if(IsPlayerConnected(i) && IsPlayerInAnyVehicle(i)) InVeh++;
	return InVeh;
}

forward OnBikeCount();
public OnBikeCount()
{
	new BikeCount;
	for(new i = 0; i < MAX_PLAYER; i++) if(IsPlayerConnected(i) && IsPlayerInAnyVehicle(i)) {
		new LModel = GetVehicleModel(GetPlayerVehicleID(i));
		switch(LModel)
		{
			case 448,461,462,463,468,471,509,510,521,522,523,581,586:  BikeCount++;
		}
	}
	return BikeCount;
}

forward InCarCount();
public InCarCount()
{
	new PInCarCount;
	for(new i = 0; i < MAX_PLAYER; i++) {
		if(IsPlayerConnected(i) && IsPlayerInAnyVehicle(i)) {
			new LModel = GetVehicleModel(GetPlayerVehicleID(i));
			switch(LModel)
			{
				case 448,461,462,463,468,471,509,510,521,522,523,581,586: {}
				default: PInCarCount++;
			}
		}
	}
	return PInCarCount;
}

forward AdminCount();
public AdminCount()
{
	new LAdminCount;
	for(new i = 0; i < MAX_PLAYER; i++) if(IsPlayerConnected(i) && PlayerInfo[i][Level] >= 1)	LAdminCount++;
	return LAdminCount;
}

forward RconAdminCount();
public RconAdminCount()
{
	new rAdminCount;
	for(new i = 0; i < MAX_PLAYER; i++) if(IsPlayerConnected(i) && IsPlayerAdmin(i)) rAdminCount++;
	return rAdminCount;
}

//==========================[ Remote Console ]==================================

forward RestartGM();
public RestartGM()
{
	SendRconCommand("gmx");
}

forward UnloadFS();
public UnloadFS()
{
	SendRconCommand("unloadfs ladmin4");
}

forward PrintWarning(const string[]);
public PrintWarning(const string[])
{
    new str[128];
    print("\n>		WARNING:\n");
    format(str, sizeof(str), " The  %s  folder is missing from scriptfiles", string);
    print(str);
    print("\n Please Create This Folder And Reload the Filterscript\n");
}

//============================[ Bot Check ]=====================================
forward BotCheck(playerid);
public BotCheck(playerid)
{
	if(IsPlayerConnected(playerid))
	{
		if(GetPlayerPing(playerid) < 1)
		{
			new string[128], ip[20];  GetPlayerIp(playerid,ip,sizeof(ip));
			format(string,sizeof(string),"BOT: %s id:%d ip: %s ping: %d",PlayerName2(playerid),playerid,ip,GetPlayerPing(playerid));
			SaveToFile("BotKickLog",string);
		    SaveToFile("KickLog",string);
			printf("[ADMIN] Possible bot has been detected (Kicked %s ID:%d)", PlayerName2(playerid), playerid);
			Kick(playerid);
		}
	}
}

//==============================================================================
/*forward PutAtPos(playerid);
public PutAtPos(playerid)
{
	if (dUserINT(PlayerName2(playerid)).("x")!=0) {
     	SetPlayerPos(playerid, float(dUserINT(PlayerName2(playerid)).("x")), float(dUserINT(PlayerName2(playerid)).("y")), float(dUserINT(PlayerName2(playerid)).("z")) );
 		SetPlayerInterior(playerid,	(dUserINT(PlayerName2(playerid)).("interior"))	);
	}
}

forward PutAtDisconectPos(playerid);
public PutAtDisconectPos(playerid)
{
	if (dUserINT(PlayerName2(playerid)).("x1")!=0) {
    	SetPlayerPos(playerid, float(dUserINT(PlayerName2(playerid)).("x1")), float(dUserINT(PlayerName2(playerid)).("y1")), float(dUserINT(PlayerName2(playerid)).("z1")) );
		SetPlayerInterior(playerid,	(dUserINT(PlayerName2(playerid)).("interior1"))	);
	}
}*/

TotalGameTime(playerid, &h=0, &m=0, &s=0)
{
    PlayerInfo[playerid][TotalTime] = ( (gettime() - PlayerInfo[playerid][ConnectTime]) + (PlayerInfo[playerid][hours]*60*60) + (PlayerInfo[playerid][mins]*60) + (PlayerInfo[playerid][secs]) );

    h = floatround(PlayerInfo[playerid][TotalTime] / 3600, floatround_floor);
    m = floatround(PlayerInfo[playerid][TotalTime] / 60,   floatround_floor) % 60;
    s = floatround(PlayerInfo[playerid][TotalTime] % 60,   floatround_floor);

    return PlayerInfo[playerid][TotalTime];
}

//==============================================================================
MaxAmmo(playerid)
{
	new slot, weap, ammo;
	for (slot = 0; slot < 14; slot++)
	{
    	GetPlayerWeaponData(playerid, slot, weap, ammo);
		if(IsValidWeapon(weap))
		{
		   	GivePlayerWeapon(playerid, weap, 99999);
		}
	}
	return 1;
}

stock PlayerName2(playerid) {
  new name[MAX_PLAYER_NAME];
  GetPlayerName(playerid, name, sizeof(name));
  return name;
}

stock pName(playerid)
{
  new name[MAX_PLAYER_NAME];
  GetPlayerName(playerid, name, sizeof(name));
  return name;
}

stock TimeStamp()
{
	new time = GetTickCount() / 1000;
	return time;
}

    forward DeletePlayerObject(playerid,objectid);
    public DeletePlayerObject(playerid,objectid)
    {
        DestroyPlayerObject(playerid,objectid);
        return 1;
    }

stock PlayerSoundForAll(SoundID)
{
	for(new i = 0; i < MAX_PLAYER; i++) PlayerPlaySound(i, SoundID, 0.0, 0.0, 0.0);
}

stock IsValidWeapon(weaponid)
{
    if (weaponid > 0 && weaponid < 19 || weaponid > 21 && weaponid < 47) return 1;
    return 0;
}

stock IsValidSkin(SkinID)
{
	if((SkinID == 0)||(SkinID == 7)||(SkinID >= 9 && SkinID <= 41)||(SkinID >= 43 && SkinID <= 64)||(SkinID >= 66 && SkinID <= 73)||(SkinID >= 75 && SkinID <= 85)||(SkinID >= 87 && SkinID <= 118)||(SkinID >= 120 && SkinID <= 148)||(SkinID >= 150 && SkinID <= 207)||(SkinID >= 209 && SkinID <= 264)||(SkinID >= 274 && SkinID <= 288)||(SkinID >= 290 && SkinID <= 299)) return true;
	else return false;
}

stock IsNumeric(string[])
{
	for (new i = 0, j = strlen(string); i < j; i++)
	{
		if (string[i] > '9' || string[i] < '0') return 0;
	}
	return 1;
}

stock ReturnPlayerID(PlayerName[])
{
	for(new i = 0; i < MAX_PLAYER; i++)
	{
		if(IsPlayerConnected(i))
		{
			if(strfind(pName(i),PlayerName,true)!=-1) return i;
		}
	}
	return INVALID_PLAYER_ID;
}



stock GetWeaponIDFromName(WeaponName[])
{
	if(strfind("molotov",WeaponName,true)!=-1) return 18;
	for(new i = 0; i <= 46; i++)
	{
		switch(i)
		{
			case 0,19,20,21,44,45: continue;
			default:
			{
				new name[32]; GetWeaponName(i,name,32);
				if(strfind(name,WeaponName,true) != -1) return i;
			}
		}
	}
	return -1;
}

stock DisableWord(const badword[], text[])
{
   	for(new i=0; i<256; i++)
   	{
		if (strfind(text[i], badword, true) == 0)
		{
			for(new a=0; a<256; a++)
			{
				if (a >= i && a < i+strlen(badword)) text[a]='*';
			}
		}
	}
}

argpos(const string[], idx = 0, sep = ' ')// (by yom)
{
    for(new i = idx, j = strlen(string); i < j; i++)
        if (string[i] == sep && string[i+1] != sep)
            return i+1;

    return -1;
}

//==============================================================================
forward MessageToPremiums(color,const string[]);
public MessageToPremiums(color,const string[])
{
	for(new i = 0; i < MAX_PLAYER; i++)
	{
		if(IsPlayerConnected(i) == 1) if(GetPVarInt(i, "PREMIUM") >= 4) SendClientMessage(i, color, string);
	}
	return 1;
}

stock CMDMessagePremiums(playerid,command[])
{
	if(ServerInfo[AdminCmdMsg] == 0) return 1;
	new string[128]; GetPlayerName(playerid,string,sizeof(string));
	format(string,sizeof(string),"VIP %s ha usado el comando %s",string,command);
	return MessageToAdmins(blue,string);
}

forward MessageToAdmins(color,const string[]);
public MessageToAdmins(color,const string[])
{
	for(new i = 0; i < MAX_PLAYER; i++)
	{
		if(IsPlayerConnected(i) == 1) if (PlayerInfo[i][Level] >= 1) SendClientMessage(i, color, string);
	}
	return 1;
}

stock CMDMessageToAdmins(playerid,command[])
{
	if(ServerInfo[AdminCmdMsg] == 0) return 1;
	new string[128]; GetPlayerName(playerid,string,sizeof(string));
	format(string,sizeof(string),"Administrador %s ha usado el comando %s",string,command);
	return MessageToAdmins(blue,string);
}
//==============================================================================
SavePlayer(playerid) //
{
	if(!Readyd[playerid]) return 1;
	new query[1140], data[100], pIP[30], datat[60];
	GetPlayerIp(playerid, pIP, 30);
	new h, m, s;
    TotalGameTime(playerid, h, m, s);
    new h1, m1, s1; GetTimeON(playerid, h1, m1, s1);
    new w[20];
	new year,month,day;	getdate(year, month, day);
	new strdate[20];
	format(strdate, sizeof(strdate), "%d.%d.%d",day,month,year);
	strcat(query, "UPDATE `user` SET ");
	format(data, sizeof(data), "pVelocity = '%d',",Velocity[playerid]);
	strcat(query,data);
	format(data, sizeof(data),"pJump = '%d',",Jump[playerid]);
	strcat(query, data);
	format(data, sizeof(data),"`pMoney` = '%d', ", MoneyEx[playerid]);
	strcat(query, data);
	format(data, sizeof(data),"`pKills` = '%d', ", GetPVarInt(playerid, "Score"));
	strcat(query, data);
	format(data, sizeof(data),"`pCoins` = '%d', ", GetPVarInt(playerid, "COIN"));
	strcat(query, data);
	format(data, sizeof(data),"`pDeath` = '%d', ", PlayerInfo[playerid][Deaths]);
	strcat(query, data);
	format(data, sizeof(data),"`pHours` = '%d', ", h);
	strcat(query, data);
	format(data, sizeof(data),"`pMinutes` = '%d', ", m);
	strcat(query, data);
	format(data, sizeof(data),"`pSeconds` = '%d', ", s);
	strcat(query, data);
//	format(data, sizeof(data), "pNavidad = '%d',",Navidad[playerid]);
//	strcat(query, data);
	for(new i = 1; i != 10; i++){
 	format(w, sizeof(w), "pWeap%d",i);
	format(data, sizeof(data),"%s = '%d', ",w,Weap[(i-1)][0]);
	strcat(query, data);
 	}
	format(data, sizeof(data),"`pLastOn` = '%s', ", DB_Escape(strdate));
	strcat(query, data);
	strcat(query,"`pLoggedIn` = '0', ");
	format(data, sizeof(data),"`pRconAprovado` = '%d', ", PlayerInfo[playerid][rcona]);
	strcat(query, data);
	format(data, sizeof(data),"`pPreDia` = '%d', ", PlayerInfo[playerid][PreDia]);
	strcat(query, data);
	format(data, sizeof(data),"`pPreMes` = '%d', ", PlayerInfo[playerid][PreMes]);
	strcat(query, data);
	format(data, sizeof(data),"`pPreAno` = '%d', ", PlayerInfo[playerid][PreAno]);
	strcat(query, data);
	format(datat, sizeof(datat),"%d:%d:%d", h1,m1,s1);
	format(data, sizeof(data),"`pTimeON` = '%s',", datat);
	strcat(query, data);
	format(data, sizeof(data), "pSave = '%d', pColor = '%d', pNove = '%d'",pSave[playerid],PlayerInfo[playerid][fColor],Novel[playerid]);
	strcat(query, data);
	format(data, sizeof(data),"WHERE `pName` = '%s'",DB_Escape(udb_encode(PlayerName2(playerid))));
	strcat(query, data);
//	printf("%s",query);
	db_free_result(db_query(LadminDB, query));
	printf("____________________________");
	printf("%s se guardo con exito.", PlayerName2(playerid));
	printf("____________________________");
	return 1;
}

//==============================================================================


//==============================================================================
#if defined DISPLAY_CONFIG
stock ConfigInConsole()
{
	print(" ________ Configuration ___________\n");
	print(" __________ Chat & Messages ______");
	if(ServerInfo[AntiSwear] == 0) print("  Anti Swear:              Disabled "); else print("  Anti Swear:             Enabled ");
	if(ServerInfo[AntiSpam] == 0)  print("  Anti Spam:               Disabled "); else print("  Anti Spam:              Enabled ");
	if(ServerInfo[ReadCmds] == 0)  print("  Read Cmds:               Disabled "); else print("  Read Cmds:              Enabled ");
	if(ServerInfo[ReadPMs] == 0)   print("  Read PMs:                Disabled "); else print("  Read PMs:               Enabled ");
	if(ServerInfo[ConnectMessages] == 0) print("  Connect Messages:        Disabled "); else print("  Connect Messages:       Enabled ");
  	if(ServerInfo[AdminCmdMsg] == 0) print("  Admin Cmd Messages:     Disabled ");  else print("  Admin Cmd Messages:     Enabled ");
	if(ServerInfo[ReadPMs] == 0)   print("  Anti capital letters:    Disabled \n"); else print("  Anti capital letters:   Enabled \n");
	print(" __________ Skins ________________");
	if(ServerInfo[AdminOnlySkins] == 0) print("  AdminOnlySkins:         Disabled "); else print("  AdminOnlySkins:         Enabled ");
	printf("  Admin Skin 1 is:         %d", ServerInfo[AdminSkin] );
	printf("  Admin Skin 2 is:         %d\n", ServerInfo[AdminSkin2] );
	print(" ________ Server Protection ______");
	if(ServerInfo[AntiBot] == 0) print("  Anti Bot:                Disabled "); else print("  Anti Bot:                Enabled ");
	if(ServerInfo[NameKick] == 0) print("  Bad Name Kick:           Disabled\n"); else print("  Bad Name Kick:           Enabled\n");
	print(" __________ Ping Control _________");
	if(ServerInfo[MaxPing] == 0) print("  Ping Control:            Disabled"); else print("  Ping Control:            Enabled");
	printf("  Max Ping:                %d\n", ServerInfo[MaxPing] );
	print(" __________ Players ______________");
	if(ServerInfo[GiveWeap] == 0) print("  Save/Give Weaps:         Disabled"); else print("  Save/Give Weaps:         Enabled");
	if(ServerInfo[GiveMoney] == 0) print("  Save/Give Money:         Disabled\n"); else print("  Save/Give Money:         Enabled\n");
	print(" __________ Other ________________");
	printf("  Max Admin Level:         %d", ServerInfo[MaxAdminLevel] );
	if(ServerInfo[Locked] == 0) print("  Server Locked:           No"); else print("  Server Locked:           Yes");
	if(ServerInfo[AutoLogin] == 0) print("  Auto Login:             Disabled\n"); else print("  Auto Login:              Enabled\n");
}
#endif

//=====================[ Configuration ] =======================================
stock UpdateConfig()
{
	new file[256], File:file2, string[100]; format(file,sizeof(file),"ladmin/config/Config.ini");
	ForbiddenWordCount = 0;
	BadNameCount = 0;
	BadPartNameCount = 0;

	if(!dini_Exists("ladmin/config/aka.txt")) dini_Create("ladmin/config/aka.txt");

	if(!dini_Exists(file))
	{
		dini_Create(file);
		print("\n >Configuration File Successfully Created");
	}

	if(!dini_Isset(file,"MaxPing")) dini_IntSet(file,"MaxPing",1200);
	if(!dini_Isset(file,"ReadPms")) dini_IntSet(file,"ReadPMs",1);
	if(!dini_Isset(file,"ReadCmds")) dini_IntSet(file,"ReadCmds",1);
	if(!dini_Isset(file,"MaxAdminLevel")) dini_IntSet(file,"MaxAdminLevel",5);
	if(!dini_Isset(file,"AdminOnlySkins")) dini_IntSet(file,"AdminOnlySkins",0);
	if(!dini_Isset(file,"AdminSkin")) dini_IntSet(file,"AdminSkin",217);
	if(!dini_Isset(file,"AdminSkin2")) dini_IntSet(file,"AdminSkin2",214);
	if(!dini_Isset(file,"AntiBot")) dini_IntSet(file,"AntiBot",1);
	if(!dini_Isset(file,"AntiSpam")) dini_IntSet(file,"AntiSpam",1);
	if(!dini_Isset(file,"AntiSwear")) dini_IntSet(file,"AntiSwear",1);
	if(!dini_Isset(file,"NameKick")) dini_IntSet(file,"NameKick",1);
 	if(!dini_Isset(file,"PartNameKick")) dini_IntSet(file,"PartNameKick",1);
	if(!dini_Isset(file,"NoCaps")) dini_IntSet(file,"NoCaps",0);
	if(!dini_Isset(file,"Locked")) dini_IntSet(file,"Locked",0);
	if(!dini_Isset(file,"SaveWeap")) dini_IntSet(file,"SaveWeap",1);
	if(!dini_Isset(file,"SaveMoney")) dini_IntSet(file,"SaveMoney",1);
	if(!dini_Isset(file,"ConnectMessages")) dini_IntSet(file,"ConnectMessages",1);
	if(!dini_Isset(file,"AdminCmdMessages")) dini_IntSet(file,"AdminCmdMessages",1);
	if(!dini_Isset(file,"AutoLogin")) dini_IntSet(file,"AutoLogin",1);
	if(!dini_Isset(file,"MaxMuteWarnings")) dini_IntSet(file,"MaxMuteWarnings",4);
	if(!dini_Isset(file,"MustLogin")) dini_IntSet(file,"MustLogin",0);
	if(!dini_Isset(file,"MustRegister")) dini_IntSet(file,"MustRegister",0);

	if(dini_Exists(file))
	{
		ServerInfo[MaxPing] = dini_Int(file,"MaxPing");
		ServerInfo[ReadPMs] = dini_Int(file,"ReadPMs");
		ServerInfo[ReadCmds] = dini_Int(file,"ReadCmds");
		ServerInfo[MaxAdminLevel] = dini_Int(file,"MaxAdminLevel");
		ServerInfo[AdminOnlySkins] = dini_Int(file,"AdminOnlySkins");
		ServerInfo[AdminSkin] = dini_Int(file,"AdminSkin");
		ServerInfo[AdminSkin2] = dini_Int(file,"AdminSkin2");
		ServerInfo[AntiBot] = dini_Int(file,"AntiBot");
		ServerInfo[AntiSpam] = dini_Int(file,"AntiSpam");
		ServerInfo[AntiSwear] = dini_Int(file,"AntiSwear");
		ServerInfo[NameKick] = dini_Int(file,"NameKick");
		ServerInfo[PartNameKick] = dini_Int(file,"PartNameKick");
		ServerInfo[NoCaps] = dini_Int(file,"NoCaps");
		ServerInfo[Locked] = dini_Int(file,"Locked");
		ServerInfo[GiveWeap] = dini_Int(file,"SaveWeap");
		ServerInfo[GiveMoney] = dini_Int(file,"SaveMoney");
		ServerInfo[ConnectMessages] = dini_Int(file,"ConnectMessages");
		ServerInfo[AdminCmdMsg] = dini_Int(file,"AdminCmdMessages");
		ServerInfo[AutoLogin] = dini_Int(file,"AutoLogin");
		ServerInfo[MaxMuteWarnings] = dini_Int(file,"MaxMuteWarnings");
		ServerInfo[MustLogin] = dini_Int(file,"MustLogin");
		ServerInfo[MustRegister] = dini_Int(file,"MustRegister");
		print("\n -Configuration Settings Loaded");
	}
//Anti Flood
	if((file2 = fopen("ladmin/config/AntiSpamBot.cfg",io_read)))
	{
		while(fread(file2,string))
		{
		    for(new i = 0, j = strlen(string); i < j; i++) if(string[i] == '\n' || string[i] == '\r') string[i] = '\0';
            AntiSpamBot[AntiSpamBotCount] = string;
            AntiSpamBotCount++;
		}
		fclose(file2);	printf(" -%d AntiSpamBot Names Loaded", AntiSpamBotCount);
	}
	if((file2 = fopen("ladmin/config/Ips.cfg",io_read)))
	{
		while(fread(file2,string))
		{
		    for(new i = 0, j = strlen(string); i < j; i++) if(string[i] == '\n' || string[i] == '\r') string[i] = '\0';
            AntiSpamBot2[AntiSpamBotCount2] = string;
            AntiSpamBotCount2++;
		}
		fclose(file2);	printf(" -%d AntiSpamBot Names Loaded", AntiSpamBotCount2);
	}

	//forbidden names


	if((file2 = fopen("ladmin/config/ForbiddenNames.cfg",io_read)))
	{
		while(fread(file2,string))
		{
		    for(new i = 0, j = strlen(string); i < j; i++) if(string[i] == '\n' || string[i] == '\r') string[i] = '\0';
            BadNames[BadNameCount] = string;
            BadNameCount++;
		}
		fclose(file2);	printf(" -%d Forbidden Names Loaded", BadNameCount);
	}

	//forbidden part of names
	if((file2 = fopen("ladmin/config/ForbiddenPartNames.cfg",io_read)))
	{
		while(fread(file2,string))
		{
		    for(new i = 0, j = strlen(string); i < j; i++) if(string[i] == '\n' || string[i] == '\r') string[i] = '\0';
            BadPartNames[BadPartNameCount] = string;
            BadPartNameCount++;
		}
		fclose(file2);	printf(" -%d Forbidden Tags Loaded", BadPartNameCount);
	}

	//forbidden words
	if((file2 = fopen("ladmin/config/ForbiddenWords.cfg",io_read)))
	{
		while(fread(file2,string))
		{
		    for(new i = 0, j = strlen(string); i < j; i++) if(string[i] == '\n' || string[i] == '\r') string[i] = '\0';
            ForbiddenWords[ForbiddenWordCount] = string;
            ForbiddenWordCount++;
		}
		fclose(file2);	printf(" -%d Forbidden Words Loaded", ForbiddenWordCount);
	}
}

//==============================================================================

forward InitializeDuel(playerid);
public InitializeDuel(playerid)
{
    g_DuelTimer[playerid]  = SetTimerEx("DuelCountDown", 1000, 1, "i", playerid);
    ResetPlayerWeapons(playerid);
    GivePlayerWeapon(playerid, 31, 5000);
    GivePlayerWeapon(playerid, 24, 1000);
    GivePlayerWeapon(playerid, 26, 5000);
    GivePlayerWeapon(playerid, 32, 5000);
	SetPlayerHealth(playerid, 100);
	SetPlayerArmour(playerid, 100);
	SetPlayerPos(playerid, -1621.3705,286.4648,7.1818);
	SetPlayerFacingAngle(playerid, 269.5628);
    SetCameraBehindPlayer(playerid);
    TogglePlayerControllable(playerid, 0);
    g_DuelCountDown[playerid] = 11;

	return 1;
}

//------------------------------------------------------------------------------

forward InitializeDuelEx(playerid);
public InitializeDuelEx(playerid)
{
    g_DuelTimer[playerid]  = SetTimerEx("DuelCountDown", 1000, 1, "i", playerid);
    ResetPlayerWeapons(playerid);
    GivePlayerWeapon(playerid, 31, 5000);
    GivePlayerWeapon(playerid, 24, 1000);
    GivePlayerWeapon(playerid, 26, 5000);
    GivePlayerWeapon(playerid, 32, 5000);
	SetPlayerHealth(playerid, 100);
	SetPlayerArmour(playerid, 100);
    SetPlayerPos(playerid, -1585.3810,286.7399,7.1875);
    SetPlayerFacingAngle(playerid, 94.3059);
    SetCameraBehindPlayer(playerid);
    TogglePlayerControllable(playerid, 0);
    g_DuelCountDown[playerid] = 11;

	return 1;
}

//------------------------------------------------------------------------------

forward DuelCountDown(playerid);
public DuelCountDown(playerid)
{
	new
		tString[128] ;

	g_DuelCountDown[playerid] --;

	PlayerPlaySound(playerid, 1057, 0.0, 0.0, 0.0);

	format(tString, sizeof(tString), "~w~%d", g_DuelCountDown[playerid]);
	GameTextForPlayer(playerid, tString, 900, 3);

    if(g_DuelCountDown[playerid] == 0)
    {
        KillTimer(g_DuelTimer[playerid]);
        TogglePlayerControllable(playerid, 1);
        GameTextForPlayer(playerid,"~g~Comenzar YAA!", 900, 3);
        return 1;
    }

	return 1;
}

//------------------------------------------------------------------------------

/*strvalEx(xxx[])
{
	if(strlen(xxx) > 9)
	return 0;
	return strval(xxx);
}
*///=====================[ SAVING DATA ] =========================================

forward SaveToFile(filename[],text[]);
public SaveToFile(filename[],text[])
{
	#if defined SAVE_LOGS
	new File:LAdminfile, filepath[256], string[256], year,month,day, hour,minute,second;
	getdate(year,month,day); gettime(hour,minute,second);

	format(filepath,sizeof(filepath),"ladmin/logs/%s.txt",filename);
	LAdminfile = fopen(filepath,io_append);
	format(string,sizeof(string),"[%d.%d.%d %d:%d:%d] %s\r\n",day,month,year,hour,minute,second,text);
	fwrite(LAdminfile,string);
	fclose(LAdminfile);
	#endif

	return 1;
}

//==============================================================================
/*forward Show2(playerid);
public Show2(playerid){
  new ping = GetPlayerPing(playerid);
	new string[160];
	format(string,sizeof(string),"~w~FPS ~r~%d  ~w~Ping ~r~%d  ~w~PacketLoss ~r~%.2f ",FPS2[playerid]-1,ping,NetStats_PacketLossPercent(playerid));
	printf("%s",string);
	PlayerTextDrawSetString(playerid, Textdraw0[playerid],string);
//	PlayerTextDrawShow(playerid, Textdraw0[playerid] );
return 1;
}*/

//============================[ EOF ]===========================================

stock strrest(const string[], &index)
{
    new length = strlen(string);
    while ((index < length) && (string[index] <= ' '))
    {
        index++;
    }
    new offset = index;
    new result[128];
    while ((index < length) && ((index - offset) < (sizeof(result) - 1)))
    {
        result[index - offset] = string[index];
        index++;
    }
    result[index - offset] = EOS;
    return result;
}

dcmd_jactivar(playerid,params[]) {
	#pragma unused params
	if(PlayerInfo[playerid][Level] >= 2)
	{
		CMDMessageToAdmins(playerid,"/JACTIVAR");
	    Activado = true;
	    new string[128];
	    new playername[256];
		GetPlayerName(playerid, playername, 256);
	    format(string, sizeof(string), "[Pura Joda] Adm. %s abrió el evento (/JaulaInfernal). ",playername);
	    SendClientMessageToAll(0xFF9900AA, string);
    }
	return 1;
}
dcmd_jdesactivar(playerid,params[]) {
	#pragma unused params
	if(PlayerInfo[playerid][Level] >= 2)
    {
    	CMDMessageToAdmins(playerid,"JDESACTIVAR");
		Activado = false;
	    new string[128];
	    new playername[256];
		GetPlayerName(playerid, playername, 256);
	    format(string, sizeof(string), "[Pura Joda] Adm. %s cerró el evento (/JaulaInfernal). ",playername);
	    SendClientMessageToAll(0xFF9900AA, string);
	}
	return 1;
}

dcmd_jaulainfernal(playerid,params[]) {
	#pragma unused params
	if(Activado == false)
    {
		SendClientMessage(playerid,COLOR_RED,"[Pura Joda] Evento cerrado.");
		return 1;
	}
    new string[128];
    new playername[256];
	GetPlayerName(playerid, playername, 256);
    format(string, sizeof(string), "[Pura Joda] %s entró al evento (/JaulaInfernal)",playername);
    SendClientMessageToAll(0xFF9900AA, string);
    SendClientMessage(playerid,COLOR_YELLOW,"Si");
    SetPlayerColor(playerid,0xFF9900AA);
    SetPlayerHealth(playerid,100);
    SetPlayerArmour(playerid,100);
    ResetPlayerWeapons(playerid);
    new randomspawn = random(5);
    switch(randomspawn)
    {
	    case 0: SetPlayerPos(playerid,1493.9163,-1149.7975,135.8281); //
	    case 1: SetPlayerPos(playerid,1494.8630,-1117.4712,135.8281); //
	    case 2: SetPlayerPos(playerid,1519.3098,-1116.6841,135.8281); //
	    case 3: SetPlayerPos(playerid,1549.1503,-1117.1256,135.8281); //
	    case 4: SetPlayerPos(playerid,1548.3918,-1149.7611,135.8281); //
	    case 5: SetPlayerPos(playerid,1524.3635,-1149.7261,135.8281); //
    }
    GivePlayerWeapon(playerid, 28, 9999);
    GivePlayerWeapon(playerid, 26, 9999);
    GivePlayerWeapon(playerid, 22, 9999);
    TogglePlayerControllable(playerid, 0);
    SetPlayerVirtualWorld(playerid,2);
    Adentro[playerid] = 1;
	return 1;
}
dcmd_salirjaula(playerid,params[]) {
	#pragma unused params
	SetPlayerHealth(playerid, 0);
	SendClientMessage(COLOR_RED,playerid,"[Pura Joda] Has Salido del Jaula Infernal ! ");
	Adentro[playerid] = 0;
	SetPlayerVirtualWorld(playerid, 0);
	return 1;
}
dcmd_comenzar(playerid,params[]) {
	#pragma unused params
	if(PlayerInfo[playerid][Level] >= 2)
    {
	    SendClientMessageToAll(0xFF9900AA,"[Pura Joda] Comenzo el Duelo en Jaula Infernall ! ");
		CountDown2();
	    if( Activado == true )
	    {
			new string[128];
		    new playername[256];
			GetPlayerName(playerid, playername, 256);
		    format(string, sizeof(string), "[Pura Joda] %s Ha Comenzado Jaula Infernal",playername);
		    SendClientMessageToAll(0xFF9900AA, string);
    	}
	    if( ActivadoD == true )
	    {
			new string[128];
		    new playername[256];
			GetPlayerName(playerid, playername, 256);
		    format(string, sizeof(string), "[Pura Joda] %s Ha Comenzado Duel Monsters",playername);
		    SendClientMessageToAll(0xFF9900AA, string);
			CountDown2();
		    ActivadoD = false;
    	}
    }
	return 1;
}
//=========================== Duel Mounsters ======================//
dcmd_mactivar(playerid,params[])
 {
	#pragma unused params
	if(PlayerInfo[playerid][Level] >= 2)
    {
	    ActivadoD = true;
	    new string[128];
	    new playername[256];
		GetPlayerName(playerid, playername, 256);
	    format(string, sizeof(string), "[Pura Joda] Evento ~ DuelMonster activado por %s. ",playername);
	    SendClientMessageToAll(0xFF9900AA, string);
    }
	return 1;
}
dcmd_mdesactivar(playerid,params[]) {
	#pragma unused params
	if(PlayerInfo[playerid][Level] >= 2)
    {
	    ActivadoD = false;
	    new string[128];
	    new playername[256];
		GetPlayerName(playerid, playername, 256);
	    format(string, sizeof(string), "[Pura Joda] Evento ~ DuelMonster desactivado por %s.",playername);
	    SendClientMessageToAll(0xFF9900AA, string);
    }
	return 1;
}

dcmd_duelmonster(playerid,params[]) {
	#pragma unused params
	if(ActivadoD == false)
    {
	    SendClientMessage(playerid,COLOR_RED,"Evento desactivado, intente más tarde.");
		return 1;
	}
    new string[128];
    new playername[256];
	GetPlayerName(playerid, playername, 256);
    format(string, sizeof(string), "[Pura Joda] %s ha entrado a [/DuelMonster]",playername);
    SendClientMessageToAll(0xFF9900AA, string);
    SendClientMessage(playerid,COLOR_YELLOW,"Utiliza /salirmonster para salir del evento; utiliza /flipcar si llega a volcarse.");
    SendClientMessage(playerid,COLOR_YELLOW,"[Pura Joda] Saca tu vehículo con /DMonster.");
    SetPlayerColor(playerid,0xFF9900AA);
    SetPlayerHealth(playerid,100);
    SetPlayerVirtualWorld(playerid, 0);
    SetPlayerArmour(playerid,100);
    ResetPlayerWeapons(playerid);
    new randomspawn = random(29);
    switch(randomspawn)
    {
		case 0:SetPlayerPos(playerid,-1364.0771,931.3465,1036.6794); // moster1
		case 1:SetPlayerPos(playerid,-1352.5043,932.2631,1036.6732); // moster2
		case 2:SetPlayerPos(playerid,-1343.4159,933.8120,1036.7168); // moster3
		case 3:SetPlayerPos(playerid,-1335.0439,935.8802,1036.7291); // moster4
		case 4:SetPlayerPos(playerid,-1321.8302,940.5374,1036.7831); // moster5
		case 5:SetPlayerPos(playerid,-1309.6095,946.5956,1036.8557); // moster5
		case 6:SetPlayerPos(playerid,-1299.9126,953.4401,1036.9492); // moster6
		case 7:SetPlayerPos(playerid,-1282.8718,970.3232,1037.2081); // moster7
		case 8:SetPlayerPos(playerid,-1278.7313,979.0685,1037.3418); // moster8
		case 9:SetPlayerPos(playerid,-1275.3073,999.9907,1037.6953); // moster9
		case 10:SetPlayerPos(playerid,-1282.3610,1020.5298,1038.0399); // moster10
		case 11:SetPlayerPos(playerid,-1288.4656,1028.7805,1038.1888); // moster11
		case 12:SetPlayerPos(playerid,-1307.4362,1043.9404,1038.4794); // moster12
		case 13:SetPlayerPos(playerid,-1331.0316,1053.6168,1038.6772); // moster13
		case 14:SetPlayerPos(playerid,-1348.8251,1058.9618,1038.7988); // moster14
		case 15:SetPlayerPos(playerid,-1372.0837,1060.8619,1038.8723); // moster15
		case 16:SetPlayerPos(playerid,-1395.8878,1061.5358,1038.9182); // moster16
		case 17:SetPlayerPos(playerid,-1410.5759,1059.7522,1038.9105); // moster17
		case 18:SetPlayerPos(playerid,-1438.2294,1060.1022,1038.9681); // moster18
		case 19:SetPlayerPos(playerid,-1463.9792,1053.4368,1038.9005); // moster19
		case 20:SetPlayerPos(playerid,-1482.2231,1046.0217,1038.8141); // moster20
		case 21:SetPlayerPos(playerid,-1510.6798,1026.6881,1038.5432); // moster21
		case 22:SetPlayerPos(playerid,-1520.1670,1000.1660,1038.1168); // moster22
		case 23:SetPlayerPos(playerid,-1513.6547,970.1143,1037.6089); // moster23
		case 24:SetPlayerPos(playerid,-1489.2526,948.5467,1037.2018); // moster24
		case 25:SetPlayerPos(playerid,-1311.3015,994.5884,1028.2175); // moster25
		case 26:SetPlayerPos(playerid,-1460.2834,995.4595,1025.3379); // moster26
		case 27:SetPlayerPos(playerid,-1408.9961,1024.9897,1026.0721); // moster27
		case 28:SetPlayerPos(playerid,-1397.2742,968.1436,1024.9044); // moster28
    }
	SetPlayerFacingAngle(playerid,86.7708);
   	SetPlayerInterior(playerid,15);
	TogglePlayerControllable(playerid, 0);
	GameTextForPlayer(playerid,"~h~~w~Saca un Auto Con /DMonster~n~~h~~w~I~h~~r~",7500, 3);
	Adentro[playerid] = 2;
	return 1;
}
dcmd_salirmonster(playerid,params[]) {
	#pragma unused params
	SetPlayerPos(playerid,2032.1617,1545.1399,10.8203);
    SetPlayerVirtualWorld(playerid, 0);
    DestroyVehicle(Monster[playerid]);
    SendClientMessage(COLOR_RED,playerid,"[Pura Joda] Acabas de salir del evento. ");
    Adentro[playerid] = 0;
    SetPlayerInterior(playerid,0);
	return 1;
}
dcmd_mcomenzar(playerid,params[]) {
	#pragma unused params
	if(PlayerInfo[playerid][Level] >= 2)
    {
	    new string[128];
	    new playername[256];
		GetPlayerName(playerid, playername, 256);
	    format(string, sizeof(string), "[Pura Joda] Adm. %s comenzó (/DuelMonster)",playername);
	    SendClientMessageToAll(0xFF9900AA, string);
		CountDown2();
	    ActivadoD = false;
	}
	return 1;
}
dcmd_DMCHUCK(playerid,params[]) {
	#pragma unused params
	if(ActivadoC == false)
    {
    	SendClientMessage(playerid,COLOR_RED,"/DMCHUCK Esta Desactivado Intentelo Mas Tarde.");
		return 1;
	}
    SetPlayerColor(playerid,0xFF9900AA);
    TogglePlayerControllable(playerid, 0);
    SetPlayerHealth(playerid,100);
    SetPlayerArmour(playerid,100);
    SetPlayerPos(playerid,1070.9692,1354.7776,10.8203);
    new string[128];
    new playername[256];
	GetPlayerName(playerid, playername, 256);
    format(string, sizeof(string), "[Pura-Joda] %s Ha Entrado A /DMCHUCK",playername);
    SendClientMessageToAll(0xFF9900AA, string);
    USERCHUCK[playerid] = 1;
    SendClientMessage(playerid,COLOR_RED,"La Mision es Matar a ChuckNorris Esta en el Mapa en ROJO.");
    SendClientMessage(playerid,COLOR_RED,"Pero Cuidado el Tiene Una Minigun.");
    GivePlayerWeapon(playerid, 16, 500);
    GivePlayerWeapon(playerid, 27, 500);
    GivePlayerWeapon(playerid, 31, 500);
    GivePlayerWeapon(playerid, 29, 500);
	GivePlayerWeapon(playerid, 24, 9999);
	GivePlayerWeapon(playerid, 27, 9999);
	GivePlayerWeapon(playerid, 29, 9999);
	GivePlayerWeapon(playerid, 31, 9999);
	GivePlayerWeapon(playerid, 34, 9999);
	GivePlayerWeapon(playerid, 28, 9999);
	GivePlayerWeapon(playerid, 26, 9999);
	GivePlayerWeapon(playerid, 22, 9999);
    Adentro[playerid] = 3;
	return 1;
}
dcmd_CHUCKADMIN(playerid,params[]) {
	#pragma unused params
	if(PlayerInfo[playerid][Level] >= 2)
    {
	    SetPlayerColor(playerid,COLOR_RED);
	    TogglePlayerControllable(playerid, 0);
	    SetPlayerHealth(playerid,100);
	    SetPlayerArmour(playerid,100);
	    SetPlayerPos(playerid,1078.0743,1308.2435,10.8203);
	    new string[128];
	    new playername[256];
		GetPlayerName(playerid, playername, 256);
	    format(string, sizeof(string), "[Pura-Joda] El Admin %s Es ChuckNorris",playername);
	    SendClientMessageToAll(0xFF9900AA, string);
	    ADMINCHUCK[playerid] = 1;
		GivePlayerWeapon(playerid, 38, 9999);
	}
	return 1;
}
dcmd_Ccomenzar(playerid,params[]) {
	#pragma unused params
	if(PlayerInfo[playerid][Level] >= 2)
    {
	    new string[128];
	    new playername[256];
		GetPlayerName(playerid, playername, 256);
	    format(string, sizeof(string), "[Pura-Joda] %s Ha Comenzado El Evento /DMCHUCK",playername);
	    SendClientMessageToAll(0xFF9900AA, string);
		CountDown2();
	    ActivadoC = false;
	}
	return 1;
}
dcmd_CActivar(playerid,params[]) {
	#pragma unused params
	if(PlayerInfo[playerid][Level] >= 2)
    {
	    new string[128];
	    new playername[256];
		GetPlayerName(playerid, playername, 256);
	    format(string, sizeof(string), "[Pura-Joda] %s Ha Activado /DMCHUCK ",playername);
	    SendClientMessageToAll(0xFF9900AA, string);
	    ActivadoC = true;
	}
	return 1;
}

dcmd_SURVIVOR(playerid,params[]) {
	#pragma unused params
	if(ActivadoS == false)
    {
    	SendClientMessage(playerid,COLOR_RED,"/SURVIVOR Esta Desactivado Intentelo Mas Tarde.");
		return 1;
	}
    SetPlayerColor(playerid,0xFF9900AA);
    TogglePlayerControllable(playerid, 0);
    SetPlayerHealth(playerid,100);
    SetPlayerArmour(playerid,100);
    ResetPlayerWeapons(playerid);
    SetPlayerPos(playerid,586.7771,870.8605,-42.4973);
    new string[128];
    new playername[256];
	GetPlayerName(playerid, playername, 256);
    format(string, sizeof(string), "[Pura-Joda] %s Ha Entrado A /SURVIVOR",playername);
    SendClientMessageToAll(0xFF9900AA, string);
    USERSURVIVOR[playerid] = 1;
    SendClientMessage(playerid,COLOR_RED,"La Mision es Sobrevivir a los ataques y ser el ulitmo en pie.");
    SendClientMessage(playerid,COLOR_RED,"Pero Ten Cuidado Tienen Rocket.");
    Adentro[playerid] = 3;
	return 1;
}
dcmd_acargar(playerid, params[]){
	#pragma unused params
	if(GetPVarInt(playerid, "PREMIUM") < 1) return SendClientMessage(playerid, -1, "[Pura Joda] Comando único para premium nivel 1");
	if(pSave[playerid] == 1 && GetPVarInt(playerid, "Save") == 1)
	{
	ResetPlayerWeapons(playerid);
	for(new i = 0; i != 9; i++)
	{
		if(Weap[i][0] != -1 && IsValidWeapon(Weap[i][0]))
		{
 			GivePlayerWeapon(playerid,Weap[i][0], 9999);
 		}
	}
	}else return SendClientMessage(playerid, -1, "Usted no tiene guardadas armas.");
return 1;
}
dcmd_SADMIN(playerid,params[]) {
	#pragma unused params
	if(PlayerInfo[playerid][Level] >= 3)
    {
	    SetPlayerColor(playerid,COLOR_RED);
	    TogglePlayerControllable(playerid, 0);
	    SetPlayerHealth(playerid,100);
	    SetPlayerArmour(playerid,100);
	    SetPlayerPos(playerid,636.9496,909.2473,-11.3219);
	    new string[128];
	    new playername[256];
		GetPlayerName(playerid, playername, 256);
	    format(string, sizeof(string), "[Pura-Joda] El Admin %s Participara En El Evento /SURVIVOR",playername);
	    SendClientMessageToAll(0xFF9900AA, string);
	    ADMINSURVIVOR[playerid] = 1;
	    ResetPlayerWeapons(playerid);
		GivePlayerWeapon(playerid, 35, 9999);
		GivePlayerWeapon(playerid, 16, 9999);

	}
	return 1;
}
dcmd_Scomenzar(playerid,params[]) {
	#pragma unused params
	if(PlayerInfo[playerid][Level] >= 3)
    {
	    new string[128];
	    new playername[256];
		GetPlayerName(playerid, playername, 256);
	    format(string, sizeof(string), "[Pura-Joda] %s Ha Comenzado El Evento /SURVIVOR",playername);
	    SendClientMessageToAll(0xFF9900AA, string);
		CountDown2();
	    ActivadoS = false;
	}
	return 1;
}
dcmd_SActivar(playerid,params[]) {
	#pragma unused params
	if(PlayerInfo[playerid][Level] >= 3)
    {
	    new string[128];
	    new playername[256];
		GetPlayerName(playerid, playername, 256);
	    format(string, sizeof(string), "[Pura-Joda] El Administrador %s Ha Activado /SURVIVOR ",playername);
	    SendClientMessageToAll(0xFF9900AA, string);
	    ActivadoS = true;
	}
	return 1;
}
	public CountDown2(){
		if (Count2 > 0)
		{
			GameTextForAll( CountText[Count2-1], 2500, 3);
			Count2--;
			SetTimer("CountDown2", 1000, 0);
		}
		else
		{
		    for(new i = 0; i < MAX_PLAYER; i++)
		    {
		        TogglePlayerControllable(i, 1);
		    }
		    Activado = false;
			GameTextForAll("~g~YA!!", 2500, 3);
			Count2 = 5;
		}
		return 0;
	}
	// Por GROVE4L. */

stock DetectarSpam(SPAM[])
{
    new SSPAM;
    new CUENTAP,CUENTAN,CUENTAW,CUENTADP,CUENTAGB,dotcount;
    new s_len = strlen(SPAM);
    for(SSPAM = 0; SSPAM < s_len; SSPAM ++)
	{
	    if(SPAM[SSPAM] == 'w' || SPAM[SSPAM] == 'W') CUENTAW ++; //Cuenta las "W"
	    if(SPAM[SSPAM] == '0' || SPAM[SSPAM] == '1' || SPAM[SSPAM] == '2' || SPAM[SSPAM] == '3' || SPAM[SSPAM] == '4' || SPAM[SSPAM] == '5' || SPAM[SSPAM] == '6' || SPAM[SSPAM] == '7' || SPAM[SSPAM] == '8' || SPAM[SSPAM] == '9') CUENTAN ++; //Cuenta los Numeros

	}
 	if(CUENTAN >= 1 && CUENTAN >= 11) return 1;
 	if(strfind(SPAM, ".com", true) != -1 || strfind(SPAM, ".com.ar", true) != -1 || strfind(SPAM, ".org", true) != -1 || strfind(SPAM, ".net", true) != -1 || strfind(SPAM, ".at", true) != -1 || strfind(SPAM, ".es", true) != -1 || strfind(SPAM, ".tk", true) != -1|| strfind(SPAM, "co.cc", true) != -1) return 1;
 	if(strfind(SPAM, "rw", true) != -1) return 0;
 	if(CUENTAW >= 3) return 1;
 	if(CUENTAP >= 3 && CUENTAN >= 4) return 1;
 	if(dotcount >= 3 && dotcount >= 4) return 1;
 	if(CUENTADP >= 1 && CUENTAN >= 4) return 1;
 	if(CUENTAGB >= 1 && CUENTAN >= 3) return 1;
 	return 0;
}
stock BanIP(playerid)
{
    new PlayerName[MAX_PLAYER_NAME];
	GetPlayerName(playerid, PlayerName, MAX_PLAYER_NAME);

	#if LOG_FLOODER == 1
		new filename[128], y, m, d;
		getdate(y, m, d);
		format(filename, sizeof(filename), "FlooderBan.txt", y, m);
		if(!fexist(filename))
		{
			new File:tmpfile = fopen(filename, io_write);
			fclose(tmpfile);
		}
		new File:sfhandler = fopen(filename, io_append),
		sfilestr[128];
		new h,mi,s; gettime(h,mi,s);
		format(sfilestr, sizeof(sfilestr),

		// Details by Month / Day / Year / Hour / Minute / Second Then Players name and the Players IP.
		"| %02d/%02d/%d %02d:%02d:%02d (M/D/Y H:M:S) | > Flooder: %s (IP:%s). \r\n",
		// --------------------------------------------------------------------------------------------
		m, d, y, h, mi, s, PlayerName, PlayerIP(playerid));
		fwrite(sfhandler, sfilestr); fclose(sfhandler);
	#endif

	new string[128];

	#if SHOW_MESSAGE == 1
		format(string, sizeof(string), "* %s Ha Sido Baneado Por El Administrador PuraJoda Razón: BotFlooder", PlayerName);
		SendClientMessageToAll(0xff3333ff, string);
	#endif

	printf("Banned %s(%d), %s. Connection flooding.", PlayerName, playerid, PlayerIP(playerid));

	format(string, sizeof(string), "banip %s", PlayerIP(playerid));
	SendRconCommand(string);
	SendRconCommand("reloadbans");
}
// Functions -------------------------------------------------------------------
PlayerIP(playerid)
{
	new ip[MAX_IP];
	GetPlayerIp(playerid, ip, MAX_IP);
	return ip;
}
public SpawnProtection(playerid)
{
    SetPlayerHealth(playerid, 100.0);
    SendClientMessage(playerid, LIGHTGREEN, "[Pura Joda] Actualmente no estás protegido por anti-spawnkill.");

    return 1;
}

/*ReturnUser(text[], playerid = INVALID_PLAYER_ID)
{
	new pos = 0;
	while (text[pos] < 0x21)
	{
		if (text[pos] == 0) return INVALID_PLAYER_ID;
		pos++;
	}
	new userid = INVALID_PLAYER_ID;
	if (IsNumeric(text[pos]))
	{
		userid = strval(text[pos]);
		if (userid >=0 && userid < MAX_PLAYER)
		{
			if(!IsPlayerConnected(userid))
				userid = INVALID_PLAYER_ID;
			else return userid;
		}
	}
	new len = strlen(text[pos]);
	new count = 0;
	new pname[MAX_PLAYER_NAME];
	for (new i = 0; i < MAX_PLAYER; i++)
	{
		if (IsPlayerConnected(i))
		{
			GetPlayerName(i, pname, sizeof (pname));
			if (strcmp(pname, text[pos], true, len) == 0)
			{
				if (len == strlen(pname)) return i;
				else
				{
					count++;
					userid = i;
				}
			}
		}
	}
	if (count != 1)
	{
		if (playerid != INVALID_PLAYER_ID)
		{
			if (count) SendClientMessage(playerid, COLOR_SYSTEM, "There are multiple users, enter full playername.");
			else SendClientMessage(playerid, COLOR_SYSTEM, "Playername not found.");
		}
		userid = INVALID_PLAYER_ID;
	}
	return userid;
}*/

stock bigstr(const string[], &idx)
{
    new length = strlen(string);
	while ((idx < length) && (string[idx] <= ' '))
	{
		idx++;
	}
	new offset = idx;
	new result[128];
	while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
	{
		result[idx - offset] = string[idx];
		idx++;
	}
	result[idx - offset] = EOS;
	return result;
}
stock TempBanCheck(playerid)
{
	new ip[15];
	new str[128];
	new load[4][32];
	new ban_day, ban_month, ban_year, ban_ip[15];
	GetPlayerIp(playerid, ip, sizeof ip);
	new year, month, day;
	getdate(year, month, day);
	new File:file = fopen("TempBans.ban",io_read);
	if (file)
	{
	    while (fread(file, str, sizeof str))
	    {
	        split(str, load, '|');

	        ban_day = strval(load[0]);
	        ban_month = strval(load[1]);
	        ban_year = strval(load[2]);
	        strmid(ban_ip, load[3], 0, strlen(load[3])-1, 15);
	    	if (!(year >= ban_year && month >= ban_month && day >= ban_day) && !strcmp(ban_ip, ip, true))
	    	{
	  //  	    new PlayerName[MAX_PLAYER_NAME];
	  //  	    GetPlayerName(playerid, PlayerName, MAX_PLAYER_NAME);
	//			format(str,sizeof(str),"***Info: %s [%d] [Pais: Privado] ha entrado al servidor", PlayerName, playerid);
	//		 	SendClientMessage(playerid,COLOR_LIGHTBLUE,str);
	    		SetTimerEx("KickeateX", 5000, 0, "iiii",playerid,ban_day,ban_month, ban_year);
				break;
			}
		}
	}
	return true;
}


stock IsMonth31(month)
{
 	switch (month)
	{
	    case 1: return 1;
	    case 3: return 1;
	    case 5: return 1;
	    case 7: return 1;
	    case 8: return 1;
	    case 10: return 1;
	    case 12: return 1;
	    default: return 0;
	}
	return 0;
}

stock IsMonth29(year)
{
 	new y = 2000;
 	for(new i = 4; i < 3000; i += 4) if ((y+i) == year) return 1;
 	return 0;
}
forward LoadRecord();
public LoadRecord()
{
	new strFromFile[24], arrCoords[6][5], File: file = fopen("RecordUsers.txt", io_read);
	if (file)
	{
		fread(file, strFromFile);
		split(strFromFile, arrCoords, ',');
		Precord = strval(arrCoords[0]);
		Drecord = strval(arrCoords[1]);
		Mrecord = strval(arrCoords[2]);
		Yrecord = strval(arrCoords[3]);
		THrecord = strval(arrCoords[4]);
		TMrecord = strval(arrCoords[5]);
		fclose(file);
	}
	return 1;
}
forward SaveRecord();
public SaveRecord()
{
	new coordsstring[24];
	format(coordsstring, sizeof(coordsstring), "%d,%d,%d,%d,%d,%d", Precord, Drecord, Mrecord, Yrecord, THrecord, TMrecord);
	new File: file = fopen("RecordUsers.txt", io_write);
	fwrite(file, coordsstring);
	fclose(file);
	return 1;
}
forward Record(playerid);
public Record(playerid)
{
/*	if(Precord)
	{
		new string[92];
		format(string, sizeof(string), "[Pura Joda] Record Anterior de %d Users Conectados, Fecha: %d %s %d, A las %d:%d", Precord, Drecord, mname[Mrecord-1], Yrecord, THrecord, TMrecord);
		SendClientMessage(playerid, 0xA5D24DFF, string);
	}
	oplayers++;
    if(Precord < oplayers)
    {
        Precord=oplayers;
        gettime(THrecord, TMrecord); getdate(Yrecord, Mrecord, Drecord);
        new string[92];
		format(string, sizeof(string), "[Pura Joda] Nuevo Record de %d Users Conectado, Fecha: %d %s %d, A las %d:%d", Precord, Drecord, mname[Mrecord-1], Yrecord, THrecord, TMrecord);
        SendClientMessageToAll(0xFCB833FF, string);
        SaveRecord();
    }
*/	return 1;
}
stock split(const strsrc[], strdest[][], delimiter)
{
    new i, li;
    new aNum;
    new len;
    while(i <= strlen(strsrc))
    {
        if(strsrc[i] == delimiter || i == strlen(strsrc))
        {
            len = strmid(strdest[aNum], strsrc, li, i, 128);
            strdest[aNum][len] = 0;
            li = i+1;
            aNum++;
        }
        i++;
    }
    return 1;
}


public OnRconLoginAttempt(ip[], password[], success)
{
	new Player = GetPlayerIDbyIP(ip);
	if(!success)
	{
	    //if(strcmp("43z", PlayerName2(Player)) == 0) return SendClientMessage(Player, 0xFF0000FF, "[Pura Joda] {FFFFFF}La contraseña es Incorrecta");
	    if(PlayerInfo[Player][rcona] == 1)
	    {
	        return SendClientMessage(Player, 0xFF0000FF, "[Pura Joda] {FFFFFF}La contraseña es Incorrecta");
		} else {
		    new string[125];
            format(string, sizeof(string), "[Pura Joda] %s [id: %d] Ha sido banneado por el administrador Pura Joda Freeroam [Razon: Rcon Login Failed]", PlayerName2(Player), Player);
            SendClientMessageToAll(0xFF0000FF, string);
            printf("[Anti-RCONLogin]%s[id: %d] Rcon Login Filed", PlayerName2(Player), Player);
            SaveToFile("RconFailed",string);
            return SetTimerEx("Baneado", 1000, false, "i", Player);
		}
	} else {
	    //if(strcmp("43z", PlayerName2(Player)) == 0) return SendClientMessage(Player, 0xFF0000FF, "[Pura Joda] {FFFFFF}La contraseña es Correcta");
		if(PlayerInfo[Player][rcona] == 1)
	    {
	        return SendClientMessage(Player, 0xFF0000FF, "[Pura Joda] {FFFFFF}La contraseña es Correcta");
		} else {
		    new string[125];
            format(string, sizeof(string), "[Pura Joda] %s [id: %d] Ha sido banneado por el administrador Pura Joda Freeroam [Razon: Rcon Login Failed]", PlayerName2(Player), Player);
            SendClientMessageToAll(0xFF0000FF, string);
            printf("[Anti-RCONLogin]%s[id: %d] Rcon Login Filed", PlayerName2(Player), Player);
            SaveToFile("RconFailed",string);
            return SetTimerEx("Baneado", 1000, false, "i", Player);
		}
	}
}
stock GetPlayerIDbyIP(const ip[])
{
	new pip[16];
	for (new i = 0; i < GetMaxPlayers(); i ++)
	{
		if(!IsPlayerConnected(i)) continue;
		GetPlayerIp(i, pip, 16);
	    if (!strcmp(ip, pip, true))
		{
			return i;
		}
	}
	return -1;
}


forward VehicleOccupied(vehicleid);
public VehicleOccupied(vehicleid)
{
	for(new i=0;i<MAX_PLAYER;i++)
	{
		if(IsPlayerInVehicle(i,vehicleid)) return 1;
	}
	return 0;
}


public OnPlayerPickUpPickup(playerid, pickupid)
{
    if(pickupid == entrada)
    {
        SendClientMessage(playerid,YELLOW,"Bievenido a 'Ammunation Híbrido', aquí poco a poco se añadirán más armas con alto costo");
        CargandoMapa(playerid);   antiflood[playerid] = 1; SetTimerEx("antifloodreset", 20000, false, "i", playerid);
        SetPlayerPos(playerid,2266.0269, -1575.8790, 1493.2471);

    }
    else if(pickupid == salida)
    {
        SendClientMessage(playerid,YELLOW,"¡Muchas gracias por su compra!");
		SetPlayerPos(playerid,2156.2041, 942.5289, 10.6203);
    }
    else if(pickupid == compra)
    {
    		ShowPlayerDialog(playerid, Ammu, DIALOG_STYLE_TABLIST_HEADERS, ""W"Pura Joda's "G"Shop",
""G"Producto\t"G"Precio\t"G"Cantidad\n\
PJCoin\t$68456\t1\n\
PJCoin\t$342280\t5\n\
PJCoin\t$684560\t10\n\
PJCoin\t$68445600\t100\n\
Chaleco\t$2990\t1\n\
Granadas\t$12 PJC\t10\nRockets\t$25 PJC\t10\nC4\t$16 PJC\t10",
"Select", "Cancel");
    		//	ammude[playerid] = true;
		//ammuco[playerid] = SetTimerEx("LuzVerde",5000,true,"i",playerid);

	}
    return 1;
}
CMD:kill(playerid, params[]) return SetPlayerHealth(playerid, 0);
CMD:armas(playerid, params)
{
    ShowPlayerDialog(playerid, GUN1, DIALOG_STYLE_LIST, "Menú de armas", "Cuchillos\nPistolas\nEscopetas\nUZI\nM4 y más\nRockets\nBombas\nOtros", "Seleccionar", "Salir");
        return 1;
}


CMD:top(playerid, params[]){
ShowPlayerDialog(playerid, DIALOG_TOP, DIALOG_STYLE_LIST, ""W"Top "R"Pura Joda",
"Top Score\n\
Top Coins\n\
Top Money\n\
Top Deaths\n\
Top Clanes",
"Select", "Cancel");
return 1;
}
public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    if(dialogid == GUN1)
    {
        if(response)
        {
            switch(listitem)
            {
                case 0: ShowPlayerDialog(playerid, GUN2, DIALOG_STYLE_LIST, "Cuchillos", "Brass Knuckles\nGolf Club\nNightstick\nCuchillo\nBate de beisbol\nShovel\nPool Cue\nKatana\nMotosierra\nDildo Morado\nDildo\nVibrador\nVibrador 2\nFlores\nCane", "Seleccionar", "Exit");
                case 1: ShowPlayerDialog(playerid, GUN3, DIALOG_STYLE_LIST, "Pistolas", "9mm\n9mm con silenciador\nDesert Eagle", "Seleccionar", "Exit");
                case 2: ShowPlayerDialog(playerid, GUN4, DIALOG_STYLE_LIST, "Escopetas", "Escopeta\nSawnoff\nCombat Shotgun\nCountry Rifle\nSniper Rifle", "Seleccionar", "Exit");
                case 3: ShowPlayerDialog(playerid, GUN5, DIALOG_STYLE_LIST, "UZIs", "Micro SMG/Uzi\nMP5\nTec-9", "Seleccionar", "Exit");
                case 4: ShowPlayerDialog(playerid, GUN6, DIALOG_STYLE_LIST, "M4 y más", "AK-47\nM4\nMinigun", "Seleccionar", "Exit");
                case 5: ShowPlayerDialog(playerid, GUN7, DIALOG_STYLE_LIST, "Armas pesadas","RPG\nHS Rocket", "Seleccionar", "Exit");
                case 6: ShowPlayerDialog(playerid, GUN8, DIALOG_STYLE_LIST, "Bombas", "Granadas\nTear Gas\nMolotov\nSatchels", "Seleccionar", "Exit");
                case 7: ShowPlayerDialog(playerid, GUN9, DIALOG_STYLE_LIST, "Otros", "Spraycan\nExtinguidor\nCámara","Seleccionar", "Exit");
            }
        }
    }
    if(dialogid == GUN2)
    {
        if(response)
        {
            switch(listitem)
            {
                case 0: GivePlayerWeapon(playerid, 1, 646);
                case 1: GivePlayerWeapon(playerid, 2, 646);
                case 2: GivePlayerWeapon(playerid, 3, 646);
                case 3: GivePlayerWeapon(playerid, 4, 646);
                case 4: GivePlayerWeapon(playerid, 5, 646);
                case 5: GivePlayerWeapon(playerid, 6, 646);
                case 6: GivePlayerWeapon(playerid, 7, 646);
                case 7: GivePlayerWeapon(playerid, 8, 646);
                case 8: GivePlayerWeapon(playerid, 9, 646);
                case 9: GivePlayerWeapon(playerid, 10, 646);
                case 10: GivePlayerWeapon(playerid, 11, 646);
                case 11: GivePlayerWeapon(playerid, 12, 646);
                case 12: GivePlayerWeapon(playerid, 13, 646);
                case 13: GivePlayerWeapon(playerid, 14, 646);
                case 14: GivePlayerWeapon(playerid, 15, 646);
            }
        }
    }
    if(dialogid == GUN3)
    {
        if(response)
        {
            switch(listitem)
            {
                case 0: GivePlayerWeapon(playerid, 22, 6464);
                case 1: GivePlayerWeapon(playerid, 23, 6464);
                case 2: GivePlayerWeapon(playerid, 22, 6464);
            }
        }
    }
    if(dialogid == GUN4)
    {
        if(response)
        {
            switch(listitem)
            {
                case 0: GivePlayerWeapon(playerid, 25, 6464);
                case 1: GivePlayerWeapon(playerid, 26, 6464);
                case 2: GivePlayerWeapon(playerid, 27, 6464);
                case 3: GivePlayerWeapon(playerid, 33, 6464);
                case 4: GivePlayerWeapon(playerid, 34, 6464);
            }
        }
    }
    if(dialogid == GUN5)
    {
        if(response)
        {
            switch(listitem)
            {
                case 0: GivePlayerWeapon(playerid, 28, 6464);
                case 1: GivePlayerWeapon(playerid, 29, 6464);
                case 2: GivePlayerWeapon(playerid, 32, 6464);
            }
        }
    }
    if(dialogid == GUN6)
    {
        if(response)
        {
            switch(listitem)
            {
                case 0: GivePlayerWeapon(playerid, 30, 6464);
                case 1: GivePlayerWeapon(playerid, 31, 6464);
                case 2: {
                if(!guerra) return SendClientMessage(playerid, -1, "[Pura Joda] La hora feliz no está activada.");
                GivePlayerWeapon(playerid, 38, 6464);
				}
            }
        }
    }
    if(dialogid == GUN7)
    {
        if(response)
        {
            switch(listitem)
            {
                case 0: {            if(!guerra) return SendClientMessage(playerid, -1, "[Pura Joda] La hora feliz no está activada.");
			    GivePlayerWeapon(playerid, 35, 6464);}
                case 1: {            if(!guerra) return SendClientMessage(playerid, -1, "[Pura Joda] La hora feliz no está activada.");

				GivePlayerWeapon(playerid, 36, 6464);
}
            }
        }
    }
    if(dialogid == GUN8)
    {
        if(response)
        {
        if(!guerra) return SendClientMessage(playerid, -1, "[Pura Joda] La hora feliz no está activada.");
            switch(listitem)
            {
                case 0: GivePlayerWeapon(playerid, 16, 6464);
                case 1: GivePlayerWeapon(playerid, 17, 6464);
                case 2: GivePlayerWeapon(playerid, 18, 6464);
                case 3: GivePlayerWeapon(playerid, 39, 6464);
            }
        }
    }
    if(dialogid == GUN9)
    {
        if(response)
        {
            switch(listitem)
            {
                case 0: GivePlayerWeapon(playerid, 41, 6464);
                case 1: GivePlayerWeapon(playerid, 42, 6464);
                case 2: GivePlayerWeapon(playerid, 43, 6464);
            }
        }
    }
		if (dialogid == DUELOSMENU)
		{
		if (response)
		{
			for (new i=1; i<=ARENAS; i++)
			{
				if (Duelos[i][DesafiadoId] == playerid)
				{
                    new str[256];
				    format(str,sizeof(str),""G"[Pura Joda] duelo con "W"%s "G"fue aprobado.",PlayerName2(playerid));
				    SendClientMessage(playerid,COLOR_DUELO,""G"[Pura Joda] "W"Solicitud enviada.");
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
   				    format(str,sizeof(str),""G"[Pura Joda] "W"%s "G"rechazó invitación.",PlayerName2(playerid));
					SendClientMessage(Duelos[i][DesaId],COLOR_DUELO,str);
				    Duelos[i][DesafiadoId] = -1;
   				    Duelos[i][DesaId] = -1;
    				Duelos[i][ArmasId] = -1;
				    Duelos[i][Libre] = 0;
				    Duelos[i][Apuesta] = 0;
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
					new wep[4];
					SetPlayerVirtualWorld(playerid, 11);
					SetPlayerVirtualWorld(Duelos[i][DesafiadoId], 11);
					switch (Duelos[i][ArmasId])
					{
						case 1: wep = "RW";
						case 2: wep = "WW";
						case 3: wep = "WW2";
					}
					new string2[256];
					format(string2,sizeof(string2),""G"[Pura Joda] duelo entre "W"%s "G"VS "W"%s "G"en la Arena "W"%d",PlayerName2(Duelos[i][DesaId]),PlayerName2(Duelos[i][DesafiadoId]),i/*,i*/);
					SendClientMessageToAll(COLOR_DUELO,string2);
					format(string2,sizeof(string2),""G"Con armas "W"%s "G" comenzará pronto. Para ver "W"/Duelo ver",wep);
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
				    format(str,sizeof(str),""G"[Pura Joda] %s abandonó el duelo. (scared)",PlayerName2(playerid));
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
	        if (Duelos[listitem+1][Libre] == 1) return SendClientMessage(playerid,COLOR_DUELO,""G"[Pura Joda] Arena ocupada.");
			Duelos[listitem+1][DesaId] = playerid;
            //ShowPlayerDialog(playerid, DUELOSMENU2+1, DIALOG_STYLE_LIST,""R"Armas","RW\nWW\nWW2","Seleccionar", "Cancelar");
            ShowPlayerDialog(playerid, 156, DIALOG_STYLE_INPUT,"Escriba PJCoins","para la apuesta, si no lo desea 0.","Invitar", "Cancelar");
		}
		if (!response)
		{
			SendClientMessage(playerid,COLOR_DUELO,""R"[Pura Joda] Canceló.");
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
					ShowPlayerDialog(playerid, DUELOSMENU2+2, DIALOG_STYLE_INPUT,"Escriba ID","del jugador que violará.","Invitar", "Cancelar");
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
					SendClientMessage(playerid,COLOR_DUELO,""R"[Pura Joda] Canceló.");
					return 1;
				}
			}
		}
		return 1;
	}
	if(dialogid == 156){
	if(response){
	if(!isNumeric(inputtext)) return SendClientMessage(playerid, -1, "Por favor ingrese una cantidad válida");
	if(GetPVarInt(playerid, "COIN")<strval(inputtext)) return SendClientMessage(playerid, RED, "Usted no tiene dicha cantidad");
	if(strval(inputtext)<0) return SendClientMessage(playerid, -1, "Cantidad invalida");
    			for (new i = 1; i <= ARENAS; i++)
			{
				if (Duelos[i][DesaId] == playerid)
				{
				printf("entro");
					Duelos[i][Apuesta] = strval(inputtext);
					ShowPlayerDialog(playerid, DUELOSMENU2+1, DIALOG_STYLE_LIST,""R"Armas","RW\nWW\nWW2","Seleccionar", "Cancelar");
					return 1;
				}
			}
			}
			else{


			for (new i = 1; i <= ARENAS; i++)
			{
				if (Duelos[i][DesaId] == playerid)
				{
					Duelos[i][DesaId] = -1;
					SendClientMessage(playerid,COLOR_DUELO,""R"[Pura Joda] Canceló.");
					return 1;
				}
			}

			}
 	}
	if (dialogid == DUELOSMENU2+2)
	{
		if (response)
		{
		    new str[4],string2[256];
			if (!strlen(inputtext)) return SendClientMessage(playerid,COLOR_DUELO,""R"[Pura Joda] ID inválida");
			if (!IsNumeric(inputtext))  return SendClientMessage(playerid,COLOR_DUELO,""R"[Pura Joda] ID inválida");
			new id = strval(inputtext);
			if (!IsPlayerConnected(id)) return SendClientMessage(playerid,COLOR_DUELO,"[Pura Joda] Jugador conectado.");
			if (id == playerid) return SendClientMessage(playerid,COLOR_DUELO,""R"[Pura Joda] No puede desafiarse a sí mismo.");
			if (EnDuelo[id] == 1) return SendClientMessage(playerid,COLOR_DUELO,""R"[Pura Joda] Jugador en duelo.");
   			if(	NODUEL[id] == 1) return SendClientMessage(playerid,COLOR_DUELO,""R"[Pura Joda] El jugador no tiene activados los duelos.");
			if(GetPVarInt(id, "MINION") || GetPVarInt(id, "RACE")) SendClientMessage(playerid,COLOR_DUELO,""R"[Pura Joda] El jugador está en un minijuego.");
			for (new i = 1; i <= ARENAS; i++)
			{
				if (Duelos[i][DesaId] == playerid)
				{
					Duelos[i][DesafiadoId] = id;
					switch (Duelos[i][ArmasId])
					{
						case 1: str = "RW";
						case 2: str = "WW";
						case 3: str = "WW2";
					}
					format(string2,sizeof(string2),""W"%s "G"desafio un duelo \n "G"Con "W"%s "G"en la arena "W"%d",PlayerName2(playerid),str,i);
					ShowPlayerDialog(Duelos[i][DesafiadoId], DUELOSMENU, DIALOG_STYLE_MSGBOX,"Invitación Duelo",string2,"Aceptar","Rechazar");
					format(string2,sizeof(string2),""G"[Pura Joda] Invitación existosa a "W"%s",PlayerName2(Duelos[i][DesafiadoId]));
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
					SendClientMessage(playerid,COLOR_DUELO,""R"[Pura Joda] Cancelaste");
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
	        if (Duelos[listitem+1][Libre] == 0) return SendClientMessage(playerid,COLOR_DUELO,""R"[Pura Joda] No hay ningún duelo en curso en esa arena.");
		/*	switch (listitem)
			{
				case 0:{
				new rand=random(sizeof(DuelosSpec1)); SetPlayerPos(playerid,DuelosSpec1[rand][0],DuelosSpec1[rand][1],DuelosSpec1[rand][2]);SetPlayerFacingAngle(playerid,DuelosSpec1[rand][3]);}
				case 1:{new rand=random(sizeof(DuelosSpec2));SetPlayerPos(playerid,DuelosSpec2[rand][0],DuelosSpec2[rand][1],DuelosSpec2[rand][2]);SetPlayerFacingAngle(playerid,DuelosSpec2[rand][3]);}
				case 2:{new rand=random(sizeof(DuelosSpec3));SetPlayerPos(playerid,DuelosSpec3[rand][0],DuelosSpec3[rand][1],DuelosSpec3[rand][2]);SetPlayerFacingAngle(playerid,DuelosSpec3[rand][3]);}
				case 3:{new rand=random(sizeof(DuelosSpec4));SetPlayerPos(playerid,DuelosSpec4[rand][0],DuelosSpec4[rand][1],DuelosSpec4[rand][2]);SetPlayerFacingAngle(playerid,DuelosSpec4[rand][3]);}
				case 4:{new rand=random(sizeof(DuelosSpec5));SetPlayerPos(playerid,DuelosSpec5[rand][0],DuelosSpec5[rand][1],DuelosSpec4[rand][2]);SetPlayerFacingAngle(playerid,DuelosSpec5[rand][3]);}
				case 5:{new rand=random(sizeof(DuelosSpec6));SetPlayerPos(playerid,DuelosSpec6[rand][0],DuelosSpec6[rand][1],DuelosSpec4[rand][2]);SetPlayerFacingAngle(playerid,DuelosSpec6[rand][3]);}
				case 6:{new rand=random(sizeof(DuelosSpec7));SetPlayerPos(playerid,DuelosSpec7[rand][0],DuelosSpec7[rand][1],DuelosSpec4[rand][2]);SetPlayerFacingAngle(playerid,DuelosSpec7[rand][3]);}
			}*/
			SetPlayerVirtualWorld(playerid, 11);
			if(listitem == 1) SetPlayerInterior(playerid, 1);
            TogglePlayerSpectating(playerid, 1);
			PlayerSpectatePlayer(playerid, Duelos[listitem+1][DesafiadoId]);
		    ViendoDuelo[playerid] = (listitem+1);
		    SendClientMessage(playerid, -1, "[Pura Joda] Para salir usa: /salir");
		//	Dueled[playerid] = SetTimerEx("CheckDuel",2000,1,"ii",playerid,Duelos[listitem+1][DesafiadoId]);
		}
		return 1;
	}


    new Coche;
	Coche = GetPlayerVehicleID(playerid);
	if(dialogid == DIALOG_TOP)
	{
 		if(!response) return 1;
 		switch(listitem)
        {
			case 0:
			{
			new DBResult:r, stin[189], top[550],cout,kills,name[40];
			r = db_query(LadminDB, "SELECT pName, pKills FROM user ORDER BY pKills DESC LIMIT 20");
			format(stin, 189, ""G"Pos   "G"Nombre\t"G"Kills\n");
			strcat(top, stin);
			do
			{
			cout++;
			db_get_field_assoc(r, "pKills", name, sizeof name);
			kills = strval(name);
			db_get_field_assoc(r, "pName", name, sizeof name);
			format(stin, 189, "%d.   %s\t%d\n",cout, udb_decode(name), kills);
			strcat(top, stin);
			}
			while(db_next_row(r));
			ShowPlayerDialog(playerid, DIALOG_OTROS, DIALOG_STYLE_TABLIST_HEADERS, ""G"Top score",top,"Aceptar", "");
            db_free_result(r);
			}
			case 1:
			{
			new DBResult:r, stin[189], top[550],cout,kills,name[40];
			r = db_query(LadminDB, "SELECT pName, pCoins FROM user ORDER BY pCoins DESC LIMIT 20");
			format(stin, 189, ""G"Pos   "G"Nombre\t"G"Coins\n");
			strcat(top, stin);
			do
			{
			cout++;
			db_get_field_assoc(r, "pCoins", name, sizeof name);
			kills = strval(name);
			db_get_field_assoc(r, "pName", name, sizeof name);
			format(stin, 189, "%d.  %s\t%d\n",cout, udb_decode(name), kills);
			strcat(top, stin);
			}
			while(db_next_row(r));
			ShowPlayerDialog(playerid, DIALOG_OTROS, DIALOG_STYLE_TABLIST_HEADERS, ""G"Top coins",top,"Aceptar", "");
            db_free_result(r);
			}
			case 2:
			{
			new DBResult:r, stin[189], top[550],cout,kills,name[40];
			r = db_query(LadminDB, "SELECT pName, pMoney FROM user ORDER BY pMoney DESC LIMIT 17");
			format(stin, 189, ""G"Pos   "G"Nombre\t"G"Dinero\n");
			strcat(top, stin);
			do
			{
			cout++;
			db_get_field_assoc(r, "pMoney", name, sizeof name);
			kills = strval(name);
			db_get_field_assoc(r, "pName", name, sizeof name);
			format(stin, 189, "%d.   %s\t%d\n",cout, udb_decode(name), kills);
			strcat(top, stin);
			}
			while(db_next_row(r));
			ShowPlayerDialog(playerid, DIALOG_OTROS, DIALOG_STYLE_TABLIST_HEADERS, ""G"Top cash",top,"Aceptar", "");
            db_free_result(r);
			}
			case 3:
			{
			new DBResult:r, stin[189], top[550],cout,kills,name[40];
			r = db_query(LadminDB, "SELECT pName, pDeath FROM user ORDER BY pDeath DESC LIMIT 20");
			format(stin, 189, ""G"Pos   "G"Nombre\t"G"Deaths\n");
			strcat(top, stin);
			do
			{
			cout++;
			db_get_field_assoc(r, "pDeath", name, sizeof name);
			kills = strval(name);
			db_get_field_assoc(r, "pName", name, sizeof name);
			format(stin, 189, "%d.   %s\t%d\n",cout, udb_decode(name), kills);
			strcat(top, stin);
			}
			while(db_next_row(r));
			ShowPlayerDialog(playerid, DIALOG_OTROS, DIALOG_STYLE_TABLIST_HEADERS, ""G"Top deaths",top,"Aceptar", "");
            db_free_result(r);
			}
			case 4:
			{
			new DBResult:r, stin[189], top[550],cout,kills,name[40];
			r = db_query(Database, "SELECT GangName,GangScore FROM Gangs ORDER BY GangScore DESC limit 0,10");
			format(stin, 189, ""G"Pos   "G"Nombre\t"G"Kills\n");
			strcat(top, stin);
			do
			{
			cout++;
			db_get_field_assoc(r, "GangScore", name, sizeof name);
			kills = strval(name);
			db_get_field_assoc(r, "GangName", name, sizeof name);
			format(stin, 189, "%d.   %s\t%d\n",cout, name, kills);
			strcat(top, stin);
			}
			while(db_next_row(r));
			ShowPlayerDialog(playerid, DIALOG_OTROS, DIALOG_STYLE_TABLIST_HEADERS, ""G"Top gangs",top,"Aceptar", "");
			db_free_result(r);
			}

 	}



	}
    if(dialogid == Tuning)
    {
        if(response)
        {
            if(listitem == 0)
			{
            ShowPlayerDialog(playerid, Tuning+1, DIALOG_STYLE_LIST, "Ruedas", "Estilo 1 \nEstilo 2 \nEstilo 3 \nEstilo 4 \nEstilo 5 \nEstilo 6 \nEstilo 7 \nEstilo 8 \nEstilo 9 \nEstilo 10 \nEstilo 11 \nEstilo 12 \nEstilo 13", "Cambiar", "Atras");
			}
            if(listitem == 1)
            {
            ShowPlayerDialog(playerid, Tuning+2, DIALOG_STYLE_LIST, "Colores", "Negro \nBlanco \nAzul Oscuro \nCeleste \nVerde \nRojo \nAmarillo \nRosado \nCafe \nVerde Agua \nMorado  \nGris \nLila \nRojo Oscuro \nVerde Oscuro", "Pintar", "Atras");
            }
            if(listitem == 2)
            {
            ShowPlayerDialog(playerid, Tuning+3, DIALOG_STYLE_LIST, "PaintJobs", "Estilo 1 \nEstilo 2 \nEstilo 3 \nEstilo 4 \nEstilo 5", "Pintar", "Atras");
            }
            if(listitem == 3)
            {
            ShowPlayerDialog(playerid, Tuning+4, DIALOG_STYLE_LIST, "Nitro", "Nitro x2 \nNitro x5 \nNitro x10", "Agregar", "Atras");
            }
			if(listitem == 4)
            {
            AddVehicleComponent(Coche,1087);
			}
            if(listitem == 5)
            {
            ShowPlayerDialog(playerid, Tuning+5, DIALOG_STYLE_LIST, "Sideskirts", "Sideskirt Derecho \nSideskirt Izquierdo \nAlien Derecho \nAlien Izquierdo \nX-Flow Izquierdo \nX-Flow Derecho", "Agregar", "Atras");
            }
            if(listitem == 6)
            {
            ShowPlayerDialog(playerid, Tuning+6, DIALOG_STYLE_LIST, "Tubos De Escape", "Alien \nX-Flow \nSlamin \nChrome", "Agregar", "Atras");
            }
            if(listitem == 7)
            {
            RepairVehicle(Coche);
  	    	SendClientMessage(playerid, Verde,"Su Coche Ha Sido Reparado");
            PlayerPlaySound(playerid, 1083, 0.0, 0.0, 0.0);
			}
            if(listitem == 8)
            {
            new Float:Angulo;
			GetVehicleZAngle(Coche, Angulo);
            SetVehicleZAngle(Coche, Angulo);
			SendClientMessage(playerid,Amarillo,"Su Coche Ha Sido volteado");
		    }
            if(listitem == 9)
            {
            new Float:x, Float:y, Float:z, Float:Angulo;
		    {
			GetPlayerPos(playerid, x, y, z );
            GetPlayerFacingAngle(playerid, Angulo);
            }
            Auto1 = AddStaticVehicle(560, x+3, y, z, Angulo, 144, 144);
            PutPlayerInVehicle(playerid, Auto1, 0);
            AddVehicleComponent(Auto1,1028);
            AddVehicleComponent(Auto1,1032);
            AddVehicleComponent(Auto1,1010);
            ChangeVehiclePaintjob(Auto1,0);
			}
			if(listitem == 10)
			{
            new Float:x, Float:y, Float:z, Float:Angulo;
		    {
			GetPlayerPos(playerid, x, y, z );
            GetPlayerFacingAngle(playerid, Angulo);
            }
            Auto2 = AddStaticVehicle(562, x+3, y, z, Angulo, 1, 1);
            PutPlayerInVehicle(playerid, Auto2, 0);
            AddVehicleComponent(Auto2,1035);
            AddVehicleComponent(Auto2,1037);
            AddVehicleComponent(Auto2,1010);
            ChangeVehiclePaintjob(Auto2,2);
			}
			if(listitem == 11)
			{
            new Float:x, Float:y, Float:z, Float:Angulo;
		    {
			GetPlayerPos(playerid, x, y, z );
            GetPlayerFacingAngle(playerid, Angulo);
            }
            Auto2 = AddStaticVehicle(565, x+3, y, z, Angulo, 2, 2);
            PutPlayerInVehicle(playerid, Auto3, 0);
            AddVehicleComponent(Auto3,1046);
            AddVehicleComponent(Auto3,1049);
            AddVehicleComponent(Auto3,1010);
            ChangeVehiclePaintjob(Auto3,3);
            }
		}
    	return 1;
   }

   if(dialogid == Tuning+1)
   {
       if(response == 0)
       {
  	   ShowPlayerDialog(playerid, Tuning, DIALOG_STYLE_LIST, "Menú Tuning", "Ruedas\nColores\nPaintjobs\nNitro\nHidraulicos\nSideskirts\nTubos De Escape\nReparar\nFlip\nAuto1\nAuto2\nAuto3", "Seleccionar", "Cancelar");
       }
          if(response)
          {
          if(listitem == 0)
          {
          AddVehicleComponent(Coche,1084);
          PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
		  SendClientMessage(playerid, Amarillo ,"Has Cambiado De Rueda De Tu Coche");
		  }
		  if(listitem == 1)
		  {
          AddVehicleComponent(Coche,1073);
          PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
		  SendClientMessage(playerid, Amarillo ,"Has Cambiado De Rueda De Tu Coche");
		  }
          if(listitem == 2)
		  {
	      AddVehicleComponent(Coche,1075);
          PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
		  SendClientMessage(playerid, Amarillo ,"Has Cambiado De Rueda De Tu Coche");
		  }
		  if(listitem == 3)
		  {
	      AddVehicleComponent(Coche,1077);
          PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
		  SendClientMessage(playerid, Amarillo ,"Has Cambiado De Rueda De Tu Coche");
		  }
		  if(listitem == 4)
		  {
	      AddVehicleComponent(Coche,1079);
          PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
		  SendClientMessage(playerid, Amarillo ,"Has Cambiado De Rueda De Tu Coche");
		  }
          if(listitem == 5)
   	      {
   	      AddVehicleComponent(Coche,1080);
          PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
		  SendClientMessage(playerid, Amarillo ,"Has Cambiado De Rueda De Tu Coche");
	      }
          if(listitem == 6)
	  	  {
          AddVehicleComponent(Coche,1074);
          PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
		  SendClientMessage(playerid, Amarillo ,"Has Cambiado De Rueda De Tu Coche");
          }
          if(listitem == 7)
          {
          AddVehicleComponent(Coche,1076);
          PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
		  SendClientMessage(playerid, Amarillo ,"Has Cambiado De Rueda De Tu Coche");
          }
          if(listitem == 8)
          {
          AddVehicleComponent(Coche,1078);
          PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
		  SendClientMessage(playerid, Amarillo ,"Has Cambiado De Rueda De Tu Coche");
     	  }
          if(listitem == 9)
          {
   	      AddVehicleComponent(Coche,1081);
          PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
		  SendClientMessage(playerid, Amarillo ,"Has Cambiado De Rueda De Tu Coche");
          }
          if(listitem == 10)
          {
          AddVehicleComponent(Coche,1082);
          PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
		  SendClientMessage(playerid, Amarillo ,"Has Cambiado De Rueda De Tu Coche");
          }
          if(listitem == 11)
          {
          AddVehicleComponent(Coche,1083);
          PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
		  SendClientMessage(playerid, Amarillo ,"Has Cambiado De Rueda De Tu Coche");
          }
          if(listitem == 12)
          {
          AddVehicleComponent(Coche,1085);
          PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
		  SendClientMessage(playerid, Amarillo ,"Has Cambiado De Rueda De Tu Coche");
          }
     }
     return 1;
}
   if(dialogid == Tuning+2)
   {
       if(response == 0)
       {
       ShowPlayerDialog(playerid, Tuning, DIALOG_STYLE_LIST, "Menú Tuning", "Ruedas\nColores\nPaintjobs\nNitro\nHidraulicos\nSideskirts\nTubos De Escape\nReparar\nFlip\nAuto1\nAuto2\nAuto3", "Seleccionar", "Cancelar");
       }
          if(response)
          {
          if(listitem == 0)
          {
          ChangeVehicleColor(Coche,0,0);
          PlayerPlaySound(playerid, 1134, 0.0, 0.0, 0.0);
		  SendClientMessage(playerid, Negro ,"Has Pintado Tu Coche De Color Negro");
          }
		  if(listitem == 1)
          {
          ChangeVehicleColor(Coche,1,1);
          PlayerPlaySound(playerid, 1134, 0.0, 0.0, 0.0);
          SendClientMessage(playerid, Blanco ,"Has Pintado Tu Coche De Color Blanco");
          }
          if(listitem == 2)
          {
          ChangeVehicleColor(Coche,79,79);
          PlayerPlaySound(playerid, 1134, 0.0, 0.0, 0.0);
	      SendClientMessage(playerid, AzulOscuro ,"Has Pintado Tu Coche De Color Azul Oscuro");
          }
          if(listitem == 3)
          {
          ChangeVehicleColor(Coche,2,2);
          PlayerPlaySound(playerid, 1134, 0.0, 0.0, 0.0);
		  SendClientMessage(playerid, Celeste ,"Has Pintado Tu Coche De Color Celeste");
	   	  }
          if(listitem == 4)
          {
          ChangeVehicleColor(Coche,252,252);
          PlayerPlaySound(playerid, 1134, 0.0, 0.0, 0.0);
		  SendClientMessage(playerid, Verde ,"Has Pintado Tu Coche De Color Verde");
          }
          if(listitem == 5)
          {
          ChangeVehicleColor(Coche,3,3);
          PlayerPlaySound(playerid, 1134, 0.0, 0.0, 0.0);
		  SendClientMessage(playerid, Rojo ,"Has Pintado Tu Coche De Color Rojo");
          }
          if(listitem == 6)
          {
          ChangeVehicleColor(Coche,6,6);
          PlayerPlaySound(playerid, 1134, 0.0, 0.0, 0.0);
		  SendClientMessage(playerid, Amarillo ,"Has Pintado Tu Coche De Color Amarillo");
          }
          if(listitem == 7)
          {
          ChangeVehicleColor(Coche,146,146);
          PlayerPlaySound(playerid, 1134, 0.0, 0.0, 0.0);
		  SendClientMessage(playerid, Rosado ,"Has Pintado Tu Coche De Color Rosado");
	   	  }
          if(listitem == 8)
          {
          ChangeVehicleColor(Coche,84,84);
          PlayerPlaySound(playerid, 1134, 0.0, 0.0, 0.0);
		  SendClientMessage(playerid, Cafe ,"Has Pintado Tu Coche De Color Cafe");
          }
          if(listitem == 9)
          {
          ChangeVehicleColor(Coche,145,145);
          PlayerPlaySound(playerid, 1134, 0.0, 0.0, 0.0);
		  SendClientMessage(playerid, Verde_Agua ,"Has Pintado Tu Coche De Color Verde Agua");
          }
          if(listitem == 10)
          {
          ChangeVehicleColor(Coche,157,157);
          PlayerPlaySound(playerid, 1134, 0.0, 0.0, 0.0);
		  SendClientMessage(playerid, Morado ,"Has Pintado Tu Coche De Color Morado");
          }
          if(listitem == 11)
          {
          ChangeVehicleColor(Coche,92,92);
          PlayerPlaySound(playerid, 1134, 0.0, 0.0, 0.0);
		  SendClientMessage(playerid, Gris ,"Has Pintado Tu Coche De Color Gris");
          }
   	 }
	 return 1;
}
   if(dialogid == Tuning+3)
   {
       if(response == 0)
       {
       ShowPlayerDialog(playerid, Tuning, DIALOG_STYLE_LIST, "Menú Tuning", "Ruedas\nColores\nPaintjobs\nNitro\nHidraulicos\nSideskirts\nTubos De Escape\nReparar\nFlip\nAuto1\nAuto2\nAuto3", "Seleccionar", "Cancelar");
       }
          if(response)
          {
          if(listitem == 0)
	   	  {
          ChangeVehiclePaintjob(Coche,0);
          PlayerPlaySound(playerid, 1134, 0.0, 0.0, 0.0);
		  }
          if(listitem == 1)
          {
          ChangeVehiclePaintjob(Coche,1);
          PlayerPlaySound(playerid, 1134, 0.0, 0.0, 0.0);
		  }
          if(listitem == 2)
          {
          ChangeVehiclePaintjob(Coche,2);
          PlayerPlaySound(playerid, 1134, 0.0, 0.0, 0.0);
		  }
          if(listitem == 3)
          {
          ChangeVehiclePaintjob(Coche,3);
          PlayerPlaySound(playerid, 1134, 0.0, 0.0, 0.0);
		  }
          if(listitem == 4)
          {
          ChangeVehiclePaintjob(Coche,4);
          PlayerPlaySound(playerid, 1134, 0.0, 0.0, 0.0);
          }
     }
     return 1;
}
   if(dialogid == Tuning+4)
   {
       if(response == 0)
       {
       ShowPlayerDialog(playerid, Tuning, DIALOG_STYLE_LIST, "Menú Tuning", "Ruedas\nColores\nPaintjobs\nNitro\nHidraulicos\nSideskirts\nTubos De Escape\nReparar\nFlip\nAuto1\nAuto2\nAuto3", "Seleccionar", "Cancelar");
       }
          if(response)
          {
          if(listitem == 0)
	  	  {
          AddVehicleComponent(Coche,1009);
          SendClientMessage(playerid, Verde ,"Has Agregado Nitro A Tu Coche");
	 	  }
          if(listitem == 1)
          {
          AddVehicleComponent(Coche,1008);
          SendClientMessage(playerid, Verde ,"Has Agregado Nitro A Tu Coche");
          }
          if(listitem == 2)
          AddVehicleComponent(Coche,1010);
          SendClientMessage(playerid, Verde ,"Has Agregado Nitro A Tu Coche");
          }
    return 1;
}
   if(dialogid == Tuning+5)
   {
       if(response == 0)
       {
       ShowPlayerDialog(playerid, Tuning, DIALOG_STYLE_LIST, "Menú Tuning", "Ruedas\nColores\nPaintjobs\nNitro\nHidraulicos\nSideskirts\nTubos De Escape\nReparar\nFlip\nAuto1\nAuto2\nAuto3", "Seleccionar", "Cancelar");
       }
          if(response)
          {
          if(listitem == 0)
          {
          AddVehicleComponent(Coche,1007);
          PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
		  }
          if(listitem == 1)
          {
          AddVehicleComponent(Coche,1017);
          PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
		  }
          if(listitem == 2)
          {
          AddVehicleComponent(Coche,1026);
          PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
		  }
          if(listitem == 3)
          {
          AddVehicleComponent(Coche,1027);
          PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
		  }
          if(listitem == 4)
          {
          AddVehicleComponent(Coche,1030);
          PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
		  }
          if(listitem == 5)
          {
          AddVehicleComponent(Coche,1031);
          PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
		  }
     }
     return 1;
}
   if(dialogid == Tuning+6)
   {
       if(response == 0)
       {
       ShowPlayerDialog(playerid, Tuning, DIALOG_STYLE_LIST, "Menú Tuning", "Ruedas\nColores\nPaintjobs\nNitro\nHidraulicos\nSideskirts\nTubos De Escape\nReparar\nFlip\nAuto1\nAuto2\nAuto3", "Seleccionar", "Cancelar");
       }
          if(response)
          {
          if(listitem == 0)
          {
          AddVehicleComponent(Coche,1028);
          PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
		  }
          if(listitem == 1)
          {
          AddVehicleComponent(Coche,1029);
          PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
		  }
          if(listitem == 2)
          {
          AddVehicleComponent(Coche,1043);
          PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
		  }
          if(listitem == 3)
          {
          AddVehicleComponent(Coche,1044);
          PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
		  }
     }
          return 1;
}
	if(dialogid == DIALOG_COLOR){
		new tmp[64];
		format(tmp, sizeof(tmp), "[Pura Joda] Ha seleccionado el color %s", colores[listitem][colorNombre]);
		SendClientMessage(playerid, colores[listitem][colorHex], tmp);
		SetPlayerColor(playerid, colores[listitem][colorHex]);
		PlayerInfo[playerid][fColor] = listitem;
	}
	if(dialogid == Ammu)
	{
	    if(response)
	    	{
	    		switch(listitem)
	    			{
	    				case 0:
	    				{
	    				if(MoneyEx[playerid]<68456) return SendClientMessage(playerid,RED,"[Pura Joda] No tienes dinero pinche pobre.");
    					//GivePlayerMoneyEx(playerid, -68456);
						MoneyEx[playerid] -= 68456;
						//SetPlayerArmour(playerid,100);
    					SetPVarInt(playerid, "COIN", GetPVarInt(playerid, "COIN")+1);
    					SendClientMessage(playerid,LIGHTGREEN,"[Pura Joda] Compra de 1(s) PJCoin exitosa.");
						return 1;
						}
						case 1:
						{
	    				if(MoneyEx[playerid]<342280) return SendClientMessage(playerid,RED,"[Pura Joda] No tienes dinero pinche pobre.");
						MoneyEx[playerid] -= 342280;		//SetPlayerArmour(playerid,100);
    					SetPVarInt(playerid, "COIN", GetPVarInt(playerid, "COIN")+5);
    					SendClientMessage(playerid,LIGHTGREEN,"[Pura Joda] Compra de 5(s) PJCoin exitosa.");
						return 1;
						}
						case 2:
						{
	    				if(MoneyEx[playerid]<684560) return SendClientMessage(playerid,RED,"[Pura Joda] No tienes dinero pinche pobre.");
    					MoneyEx[playerid] -= 684560;
    					//SetPlayerArmour(playerid,100);
    					SetPVarInt(playerid, "COIN", GetPVarInt(playerid, "COIN")+10);
    					SendClientMessage(playerid,LIGHTGREEN,"[Pura Joda] Compra de 10(s) PJCoin exitosa.");
						return 1;
						}

	    			case 3:{
	    				if(MoneyEx[playerid]<68445600) return SendClientMessage(playerid,RED,"[Pura Joda] No tienes dinero pinche pobre.");
    					MoneyEx[playerid] -= 6845600;
    					//SetPlayerArmour(playerid,100);
    					SetPVarInt(playerid, "COIN", GetPVarInt(playerid, "COIN")+100);
    					SendClientMessage(playerid,LIGHTGREEN,"[Pura Joda] Compra de 100(s) PJCoin exitosa.");
						return 1;
	    			}
	    			case 4:{
    					if(MoneyEx[playerid]<2990) return SendClientMessage(playerid,RED,"[Pura Joda] No tienes dinero pinche pobre.");
    					MoneyEx[playerid] -= 2990;
          				SetPlayerArmour(playerid,100);
    					SendClientMessage(playerid,LIGHTGREEN,"[Pura Joda] Compra de 1(s) chaleco exitosa.");
						return 1;

	    			}
	    			case 5:{
   						if(GetPVarInt(playerid, "COIN")<12) return SendClientMessage(playerid,RED,"[Pura Joda] No tienes dinero pinche pobre.");
    					//GivePlayerMoneyEx(playerid, -2990);
						SetPVarInt(playerid, "COIN", GetPVarInt(playerid, "COIN")-12);
						GivePlayerWeapon(playerid, 16, 10);
    					SendClientMessage(playerid,LIGHTGREEN,"[Pura Joda] Compra de 10(s) granadas exitosa.");
						Buy[playerid] = true;
						return 1;
	    			}
	    			case 6:{
       					 if(GetPVarInt(playerid, "COIN")<12) return SendClientMessage(playerid,RED,"[Pura Joda] No tienes dinero pinche pobre.");
    					//GivePlayerMoneyEx(playerid, -2990);
						SetPVarInt(playerid, "COIN", GetPVarInt(playerid, "COIN")-12);
						GivePlayerWeapon(playerid, 16, 10);
    					SendClientMessage(playerid,LIGHTGREEN,"[Pura Joda] Compra de 10(s) granadas exitosa.");
						Buy[playerid] = true;
						return 1;
	    			}
	    			case 7:{
  					 	if(GetPVarInt(playerid, "COIN")<25) return SendClientMessage(playerid,RED,"[Pura Joda] No tienes dinero pinche pobre.");
    					//GivePlayerMoneyEx(playerid, -2990);
						SetPVarInt(playerid, "COIN", GetPVarInt(playerid, "COIN")-25);
						GivePlayerWeapon(playerid, 35, 10);
    					SendClientMessage(playerid,LIGHTGREEN,"[Pura Joda] Compra de 25(s) rockets exitosa.");
						Buy[playerid] = true;
						return 1;
	    			}
	    			case 8:{
  					 	if(GetPVarInt(playerid, "COIN")<16) return SendClientMessage(playerid,RED,"[Pura Joda] No tienes dinero pinche pobre.");
    					//GivePlayerMoneyEx(playerid, -2990);
						SetPVarInt(playerid, "COIN", GetPVarInt(playerid, "COIN")-12);
						GivePlayerWeapon(playerid, 39, 10);
						GivePlayerWeapon(playerid, 40, 1);
    					SendClientMessage(playerid,LIGHTGREEN,"[Pura Joda] Compra de 10(s) granadas exitosa.");
						Buy[playerid] = true;
						return 1;

	    			}
	   		}
	}
	}
    if(dialogid == DIALOG_OBJECTSELECTION)
	{
	    if(response)
	    {
		    switch(listitem)
		    {
		        case 0:
				{
					ShowPlayerDialog(playerid, DIALOG_OBJECTSELECTION+1, DIALOG_STYLE_LIST, "Selecciona que quieres ponerte", "Accesorios\nAuto Partes\nGorros Y Cascos\nNavidad\nTelefonos\nObjetos de Policias\nArmas\nOtros", "Ok", "");
					ParteDelCuerpo[playerid] = 1;
				}
		        case 1:
				{
					ShowPlayerDialog(playerid, DIALOG_OBJECTSELECTION+1, DIALOG_STYLE_LIST, "Selecciona que quieres ponerte", "Accesorios\nAuto Partes\nGorros Y Cascos\nNavidad\nTelefonos\nObjetos de Policias\nArmas\nOtros", "Ok", "");
					ParteDelCuerpo[playerid] = 2;
				}
				case 2:
				{
					ShowPlayerDialog(playerid, DIALOG_OBJECTSELECTION+1, DIALOG_STYLE_LIST, "Selecciona que quieres ponerte", "Accesorios\nAuto Partes\nGorros Y Cascos\nNavidad\nTelefonos\nObjetos de Policias\nArmas\nOtros", "Ok", "");
					ParteDelCuerpo[playerid] = 3;
				}
				case 3:
				{
					ShowPlayerDialog(playerid, DIALOG_OBJECTSELECTION+1, DIALOG_STYLE_LIST, "Selecciona que quieres ponerte", "Accesorios\nAuto Partes\nGorros Y Cascos\nNavidad\nTelefonos\nObjetos de Policias\nArmas\nOtros", "Ok", "");
					ParteDelCuerpo[playerid] = 4;
				}
				case 4:
				{
					ShowPlayerDialog(playerid, DIALOG_OBJECTSELECTION+1, DIALOG_STYLE_LIST, "Selecciona que quieres ponerte", "Accesorios\nAuto Partes\nGorros Y Cascos\nNavidad\nTelefonos\nObjetos de Policias\nArmas\nOtros", "Ok", "");
					ParteDelCuerpo[playerid] = 5;
				}
				case 5:
				{
					ShowPlayerDialog(playerid, DIALOG_OBJECTSELECTION+1, DIALOG_STYLE_LIST, "Selecciona que quieres ponerte", "Accesorios\nAuto Partes\nGorros Y Cascos\nNavidad\nTelefonos\nObjetos de Policias\nArmas\nOtros", "Ok", "");
					ParteDelCuerpo[playerid] = 6;
				}
				case 6:
				{
					ShowPlayerDialog(playerid, DIALOG_OBJECTSELECTION+1, DIALOG_STYLE_LIST, "Selecciona que quieres ponerte", "Accesorios\nAuto Partes\nGorros Y Cascos\nNavidad\nTelefonos\nObjetos de Policias\nArmas\nOtros", "Ok", "");
					ParteDelCuerpo[playerid] = 7;
				}
				case 7:
				{
					ShowPlayerDialog(playerid, DIALOG_OBJECTSELECTION+1, DIALOG_STYLE_LIST, "Selecciona que quieres ponerte", "Accesorios\nAuto Partes\nGorros Y Cascos\nNavidad\nTelefonos\nObjetos de Policias\nArmas\nOtros", "Ok", "");
					ParteDelCuerpo[playerid] = 8;
				}
				case 8:
				{
					ShowPlayerDialog(playerid, DIALOG_OBJECTSELECTION+1, DIALOG_STYLE_LIST, "Selecciona que quieres ponerte", "Accesorios\nAuto Partes\nGorros Y Cascos\nNavidad\nTelefonos\nObjetos de Policias\nArmas\nOtros", "Ok", "");
					ParteDelCuerpo[playerid] = 9;
				}
				case 9:
				{
					ShowPlayerDialog(playerid, DIALOG_OBJECTSELECTION+1, DIALOG_STYLE_LIST, "Selecciona que quieres ponerte", "Accesorios\nAuto Partes\nGorros Y Cascos\nNavidad\nTelefonos\nObjetos de Policias\nArmas\nOtros", "Ok", "");
					ParteDelCuerpo[playerid] = 10;
				}
				case 10:
				{
					ShowPlayerDialog(playerid, DIALOG_OBJECTSELECTION+1, DIALOG_STYLE_LIST, "Selecciona que quieres ponerte", "Accesorios\nAuto Partes\nGorros Y Cascos\nNavidad\nTelefonos\nObjetos de Policias\nArmas\nOtros", "Ok", "");
					ParteDelCuerpo[playerid] = 11;
				}
				case 11:
				{
					ShowPlayerDialog(playerid, DIALOG_OBJECTSELECTION+1, DIALOG_STYLE_LIST, "Selecciona que quieres ponerte", "Accesorios\nAuto Partes\nGorros Y Cascos\nNavidad\nTelefonos\nObjetos de Policias\nArmas\nOtros", "Ok", "");
					ParteDelCuerpo[playerid] = 12;
				}
				case 12:
				{
					ShowPlayerDialog(playerid, DIALOG_OBJECTSELECTION+1, DIALOG_STYLE_LIST, "Selecciona que quieres ponerte", "Accesorios\nAuto Partes\nGorros Y Cascos\nNavidad\nTelefonos\nObjetos de Policias\nArmas\nOtros", "Ok", "");
					ParteDelCuerpo[playerid] = 13;
				}
				case 13:
				{
					ShowPlayerDialog(playerid, DIALOG_OBJECTSELECTION+1, DIALOG_STYLE_LIST, "Selecciona que quieres ponerte", "Accesorios\nAuto Partes\nGorros Y Cascos\nNavidad\nTelefonos\nObjetos de Policias\nArmas\nOtros", "Ok", "");
					ParteDelCuerpo[playerid] = 14;
				}
				case 14:
				{
					ShowPlayerDialog(playerid, DIALOG_OBJECTSELECTION+1, DIALOG_STYLE_LIST, "Selecciona que quieres ponerte", "Accesorios\nAuto Partes\nGorros Y Cascos\nNavidad\nTelefonos\nObjetos de Policias\nArmas\nOtros", "Ok", "");
					ParteDelCuerpo[playerid] = 15;
				}
				case 15:
				{
					ShowPlayerDialog(playerid, DIALOG_OBJECTSELECTION+1, DIALOG_STYLE_LIST, "Selecciona que quieres ponerte", "Accesorios\nAuto Partes\nGorros Y Cascos\nNavidad\nTelefonos\nObjetos de Policias\nArmas\nOtros", "Ok", "");
					ParteDelCuerpo[playerid] = 16;
				}
				case 16:
				{
					ShowPlayerDialog(playerid, DIALOG_OBJECTSELECTION+1, DIALOG_STYLE_LIST, "Selecciona que quieres ponerte", "Accesorios\nAuto Partes\nGorros Y Cascos\nNavidad\nTelefonos\nObjetos de Policias\nArmas\nOtros", "Ok", "");
					ParteDelCuerpo[playerid] = 17;
	   			}
				case 17:
				{
					ShowPlayerDialog(playerid, DIALOG_OBJECTSELECTION+1, DIALOG_STYLE_LIST, "Selecciona que quieres ponerte", "Accesorios\nAuto Partes\nGorros Y Cascos\nNavidad\nTelefonos\nObjetos de Policias\nArmas\nOtros", "Ok", "");
					ParteDelCuerpo[playerid] = 18;
				}
		    }
		}
		return 1;
	}
	if(dialogid == DIALOG_OBJECTSELECTION+1)
	{
	    if(response)
	    {
		    switch(listitem)
		    {
		        case 0: ShowModelSelectionMenu(playerid, accesorios, "Selecciona un Objeto");
		        case 1: ShowModelSelectionMenu(playerid, autoparts, "Selecciona un Objeto");
		        case 2: ShowModelSelectionMenu(playerid, gorrosycascos, "Selecciona un Objeto");
		        case 3: ShowModelSelectionMenu(playerid, navidad, "Selecciona un Objeto");
		        case 4: ShowModelSelectionMenu(playerid, phones, "Selecciona un Objeto");
		        case 5: ShowModelSelectionMenu(playerid, policeobjects, "Selecciona un Objeto");
		        case 6: ShowModelSelectionMenu(playerid, weaps, "Selecciona un Objeto");
		        case 7: ShowModelSelectionMenu(playerid, other, "Selecciona un Objeto");
		    }
		}
		return 1;
	}
	if(dialogid == DIALOG_OBJECTSELECTION+2)
	{
	    if(response)
	    {
	        switch(listitem)
	        {
	            case 0:
	            {
	                if(!IsPlayerAttachedObjectSlotUsed(playerid, 0)) return CallRemoteFunction("OnPlayerCommandText", "is", playerid, "/aoedit");
	                EditAttachedObject(playerid, 0);
	            }
	            case 1:
	            {
	                if(!IsPlayerAttachedObjectSlotUsed(playerid, 1)) return CallRemoteFunction("OnPlayerCommandText", "is", playerid, "/aoedit");
	                EditAttachedObject(playerid, 1);
	            }
	            case 2:
	            {
	                if(!IsPlayerAttachedObjectSlotUsed(playerid, 2)) return CallRemoteFunction("OnPlayerCommandText", "is", playerid, "/aoedit");
	                EditAttachedObject(playerid, 2);
	            }
	            case 3:
	            {
	                if(!IsPlayerAttachedObjectSlotUsed(playerid, 3)) return CallRemoteFunction("OnPlayerCommandText", "is", playerid, "/aoedit");
	                EditAttachedObject(playerid, 3);
	            }
	            case 4:
	            {
	                if(!IsPlayerAttachedObjectSlotUsed(playerid, 4)) return CallRemoteFunction("OnPlayerCommandText", "is", playerid, "/aoedit");
	                EditAttachedObject(playerid, 4);
	            }
	            case 5:
	            {
	                if(!IsPlayerAttachedObjectSlotUsed(playerid, 5)) return CallRemoteFunction("OnPlayerCommandText", "is", playerid, "/aoedit");
	                EditAttachedObject(playerid, 5);
	            }
	            case 6:
	            {
	                if(!IsPlayerAttachedObjectSlotUsed(playerid, 6)) return CallRemoteFunction("OnPlayerCommandText", "is", playerid, "/aoedit");
	                EditAttachedObject(playerid, 6);
	            }
	            case 7:
	            {
	                if(!IsPlayerAttachedObjectSlotUsed(playerid, 7)) return CallRemoteFunction("OnPlayerCommandText", "is", playerid, "/aoedit");
	                EditAttachedObject(playerid, 7);
	            }
	            case 8:
	            {
	                if(!IsPlayerAttachedObjectSlotUsed(playerid, 8)) return CallRemoteFunction("OnPlayerCommandText", "is", playerid, "/aoedit");
	                EditAttachedObject(playerid, 8);
	            }
	            case 9:
	            {
	                if(!IsPlayerAttachedObjectSlotUsed(playerid, 9)) return CallRemoteFunction("OnPlayerCommandText", "is", playerid, "/aoedit");
	                EditAttachedObject(playerid, 9);
	            }
	        }
	    }
	    return 1;
	}
	if(dialogid == MENU_EVENTOS_CONFIG)
	{
		if(!response) return SendClientMessage(playerid,red,"[Pura Joda] Has cancelado");
		else
		{
			switch(listitem)
			{
				case 0:
				{
					if(Evento[Creado]) return SendClientMessage(playerid, VERMELHO, "[Pura Joda] Otro administrador inició el evento, terminelo para comenzar otro.");
					SetPlayerVirtualWorld(playerid, 10);
					Evento[VirtualWorld] = GetPlayerVirtualWorld(playerid);
					Evento[Interior] = GetPlayerInterior(playerid);
					new Nombre[MAX_PLAYER_NAME];
					new string[125];
					GetPlayerName(playerid, Nombre, sizeof(Nombre));
					PlayerSoundForAll(1057);
					format(string, 125,"Administrador %s ha creado un evento, en segundos abrirá.", Nombre);
					SendClientMessageToAll(blue,string);
					Evento[Creado] = true;
					Evento[Cerrado] = true;
				}
				case 1:
				{
					if(!Evento[Creado]) return SendClientMessage(playerid,red,"[Error]: No hay eventos en progreso");
					Evento[PosicionEvento] = true;
					GetPlayerPos(playerid, Evento[x1], Evento[y2], Evento[z3]);
					SendClientMessage(playerid,red,"{FFFF00}[Pura Joda] "W"Has escogido la posición del evento aquí.");
				}
				case 2:
				{
					ShowPlayerDialog(playerid,MENU_EVENTOS_CONFIG+1,DIALOG_STYLE_LIST,"Configurar el evento.","Desarmar a todos en el evento\nVida y Chaleco Evento\nArmas evento\nAutos evento\nActivar comandos\nDesactivar Comandos\nCongelar evento\nDescongelar evento","Seleccionar","Atras");
				}
				case 3:
				{
					if(!Evento[Creado]) return SendClientMessage(playerid, VERMELHO, "[ERROR] No existe un evento creado!");
					if(Evento[Cerrado]) return SendClientMessage(playerid, VERMELHO, "[ERROR] El evento yá está cerrado!");
					Evento[Cerrado] = true;
					new Nombre[MAX_PLAYER_NAME];
			        new string[125];
			        GetPlayerName(playerid, Nombre, sizeof(Nombre));
			        PlayerSoundForAll(1057);
			        format(string, 125,"[Pura Joda] Administrador %s ha cerrado el evento.", Nombre);
			        SendClientMessageToAll(blue,string);
				}
				case 4:
				{
					if(!Evento[Creado]) return SendClientMessage(playerid, VERMELHO, "[ERROR] No hay un evento Creado");
					Evento[Creado] = false;
					new Nombre[MAX_PLAYER_NAME];
					new string[125];
					GetPlayerName(playerid, Nombre, sizeof(Nombre));
					format(string, 125,"[Pura Joda] Administrador %s terminó el evento.", Nombre);
					Evento[PosicionEvento] = false;
					congelado = 0;
					SendClientMessageToAll(blue,string);
					for(new i, p = GetMaxPlayers(); i < p; i ++)
					{
						if(!FueraDeEvento[i]) continue;
						SetPlayerPos(i, Pos[i][0], Pos[i][1], Pos[i][2]);
						SetPlayerFacingAngle(i, Pos[i][3]);
						SetCameraBehindPlayer(i);
						SinComandos[i] = 0;
						SetPlayerInterior(i, Int[i]);
						SetPlayerVirtualWorld(i, VW[i]);

						SetPlayerSkin(i, Skin[i]);
						FueraDeEvento[i] = false;
						SendClientMessage(i,blue,"[Pura Joda] Has regresado a tu posición anterior.");
					}
					for(new i = 0; i < sizeof Cars; i++) { DestroyVehicle(Cars[i]); }
				}
				case 5:
				{
					if(!Evento[Creado]) return SendClientMessage(playerid, VERMELHO, "[ERROR] No existe un evento creado!");
					if(Evento[Cerrado]) return SendClientMessage(playerid,red,"[ERROR]: No puedes Anunciar el evento esta CERRADO");
					new string[125];
					new Nombre[MPN];
					format(string, 125,"[Pura Joda] ¡Evento abierto!, usa /IREVENTO para ir.", Nombre);
					SendClientMessageToAll(blue,string);
					SendClientMessageToAll(LIGHTGREEN,"[Pura Joda] ¡EVENTO ABIERTO! /IrEvento");
					PlayerSoundForAll(1057);
				}
				case 6:
				{
					new strc[900];
					strcat(strc,"{FFFF00}[Pura Joda] Consejos ~ LA DIVERSIÓN LA HACE USTED.\n");
					strcat(strc,"{FFFF00}Respeta las reglas estipuladas y no abuses de él comando.\n");

					ShowPlayerDialog(playerid,DIALOG_OTROS,DIALOG_STYLE_MSGBOX,"Consejos de Evento",strc,"Aceptar","");
				}
				case 7:
				{
					if(!Evento[Creado]) return SendClientMessage(playerid, VERMELHO, "[ERROR] No hay evento en progreso");
					if(!Evento[Cerrado]) return SendClientMessage(playerid, VERMELHO, "[ERROR] El evento ya esta abierto");
					if(!Evento[PosicionEvento]) return SendClientMessage(playerid,VERMELHO,"[ERROR]: Por favor seleccione una pocision para el evento");
					Evento[Cerrado] = false;
					new Nombre[MPN];
					new string[125];
					GetPlayerName(playerid, Nombre, sizeof(Nombre));
					format(string, 125,"[Pura Joda] Administrador %s abrió el evento, usa /IREVENTO para entrar!", Nombre);
					SendClientMessageToAll(blue,string);
					PlayerSoundForAll(1057);
				}
			}
		}
		return 1;
	}
	//Configuracion de eventos
	if(dialogid == MENU_EVENTOS_CONFIG+1)
	{
		if(!response) return dcmd_menueventos(playerid, inputtext);
		else
		{
			switch(listitem)
			{
				case 0:
				{
					if(!Evento[Creado]) return SendClientMessage(playerid,red,"[ERROR]: No hay un evento en progreso");
					new Nombre[MAX_PLAYER_NAME];
					new string[125];
					GetPlayerName(playerid, Nombre, sizeof(Nombre));
					format(string, 125,"[Pura Joda] Administrador %s ha desarmado a todos del evento.", Nombre);
					SendClientMessageToAll(blue,string);
					PlayerSoundForAll(1057);
					for(new i, p = GetMaxPlayers(); i < p; i ++)
					{
						if(!FueraDeEvento[i]) continue;
						ResetPlayerWeapons(i);
					}
				}
				case 1:
				{
					if(!Evento[Creado]) return SendClientMessage(playerid,red,"[Error]: No hay un evento  en progreso");
					new Nombre[256];
					new string[256];
					GetPlayerName(playerid, Nombre, sizeof(Nombre));
					format(string, 256,"[Pura Joda] Administrador %s restauró vida y chaleco en un evento!", Nombre);
					SendClientMessageToAll(blue,string);
					PlayerSoundForAll(1057);
					for(new i, p = GetMaxPlayers(); i < p; i ++)
					{
						if(!FueraDeEvento[i]) continue;
						SetPlayerHealth(i, 100);
						SetPlayerArmour(i, 100);
					}
				}
				case 2:
				{
					SendClientMessage(playerid,red,"Por favor usa /ArmasEvento [ID/NAME]");
					//if(!Evento[Creado]) return SendClientMessage(playerid,red,"[ERROR]: No hay un evento en progreso");
					//ShowPlayerDialog(playerid,Dialogs+2,1,"Armas Evento","Pr favor introdusca el nombre o id del arma","Dar","Regresar");
				}
				case 3:
				{
					SendClientMessage(playerid,red,"Por favor usa /AutosEvento [ID/NAME]");
					//if(!Evento[Creado]) return SendClientMessage(playerid,red,"[ERROR]: No hay un evento en progreso");
					//ShowPlayerDialog(playerid,Dialogs+1,1,"Autos evento","Por favor intrudusca el nombre o id del auto","Crear","Regresar");
				}
				case 4:
				{
					if(!Evento[Creado]) return SendClientMessage(playerid,red,"[ERROR]: No hay un evento en progreso");
					new Nombre[MPN];
					new string[125];
					GetPlayerName(playerid, Nombre, sizeof(Nombre));
					format(string, 125,"Administrador %s activó los comandos en el evento", Nombre);
					SendClientMessageToAll(blue,string);
					PlayerSoundForAll(1057);
					for(new i, p = GetMaxPlayers(); i < p; i ++)
					{
						if(!FueraDeEvento[i]) continue;
						SinComandos[i] = 0;
					}
				}
				case 5:
				{
					if(!Evento[Creado]) return SendClientMessage(playerid,red,"[Error]: No hay un evento en progreso");
					new Nombre[MPN];
					new string[125];
					GetPlayerName(playerid, Nombre, sizeof(Nombre));
					format(string, 125,"[Pura Joda] Administrador %s desactivó los comandos en el evento", Nombre);
					SendClientMessageToAll(blue,string);
					for(new i, p = GetMaxPlayers(); i < p; i ++)
					{
						if(!FueraDeEvento[i]) continue;
						SinComandos[i] = 1;
					}
				}
				case 6:
				{
					if(!Evento[Creado]) return SendClientMessage(playerid,red,"[ERROR]: No hay un evento en progreso");
					new Nombre[MPN];
					new string[125];
					GetPlayerName(playerid, Nombre, sizeof(Nombre));
					format(string, 125,"[Pura Joda] Administrador %s congeló a todos en el evento", Nombre);
					congelado = 1;
					SendClientMessageToAll(blue,string);
					PlayerSoundForAll(1057);
					for(new i, p = GetMaxPlayers(); i < p; i ++)
					{
						if(!FueraDeEvento[i]) continue;
						TogglePlayerControllable(i, 0);
					}
				}
				case 7:
				{
					if(!Evento[Creado]) return SendClientMessage(playerid,red,"[ERROR]: No hay un evento en progreso");
					new Nombre[MPN];
					new string[125];
					GetPlayerName(playerid, Nombre, sizeof(Nombre));
					format(string, 125,"[Pura Joda] Administrador %s descongeló a todos en el evento.", Nombre);
					SendClientMessageToAll(red,string);
					PlayerSoundForAll(1057);
					congelado = 0;
					for(new i, p = GetMaxPlayers(); i < p; i ++)
					{
						if(!FueraDeEvento[i]) continue;
						TogglePlayerControllable(i, 1);
					}
				}
				case 8:
				{
					SendClientMessage(playerid,red,"USE: /SkinEvento");
				}
			}
		}
		return 1;
	}
	//Sensual Login por dialogo askjdh
	if(dialogid == DIALOG_INGRESO)
	{
	    if(response)
	    {
		    if (strlen(inputtext)==0) return SendClientMessage(playerid,red,"CUENTA: Uso correcto: '/login [contraseña]'"), Kick(playerid);
		    udb_query(result, "SELECT `pPass`, `pIP` FROM `user` WHERE `pName` = '%s' LIMIT 1", DB_Escape(udb_encode(PlayerName2(playerid))));
		    new field[30];
		    db_get_field_assoc(result, "pPass", field, sizeof(field));
		    if (strval(field) == udb_hash(inputtext))
			{
				new tmp3[100], string[128];
		   		GetPlayerIp(playerid,tmp3,100);
		   		if((!strcmp(tmp3, field, true))) SendClientMessage(playerid, COLOR_RED, "[Pura Joda]: {FFFFFF}Has entrado con una IP diferente a la anterior");
		   		db_free_result(result);
				LoginPlayer(playerid);
				PlayerInfo[playerid][TimeON] = gettime();
				PlayerPlaySound(playerid,1057,0.0,0.0,0.0);
				Readyd[playerid] = true;
				if(PlayerInfo[playerid][Level] > 0)
				{
					format(string,sizeof(string),"«» Bievenido de nuevo, Administrador (%d) autenticado con éxito, recuerde hacer eventos.", PlayerInfo[playerid][Level] );
					return SendClientMessage(playerid,green,string);
	        	} else return SendClientMessage(playerid, green, "Bievenido de nuevo, te has autenticado con éxito.");
			}
			else
			{
				PlayerInfo[playerid][FailLogin]++;
				printf("LOGIN: %s no ha podido iniciar sesión, Contraseña incorrecta (%s) intento (%d)", PlayerName2(playerid), inputtext, PlayerInfo[playerid][FailLogin] );
				if(PlayerInfo[playerid][FailLogin] == MAX_FAIL_LOGINS)
				{
					new string[128]; format(string, sizeof(string), "%s Has sido kickeado (Logins incorrectos)", PlayerName2(playerid) );
					SendClientMessageToAll(grey, string);
					print(string);
					Kick(playerid);
				}
				return ShowPlayerDialog(playerid, DIALOG_INGRESO, DIALOG_STYLE_PASSWORD, "Ingresar", "{FF0000}Contraseña incorrecta!", "Ingresar", "Salir");
			}
		}
		else
		{
		    SendClientMessage(playerid, red, "CUENTA: Has sido kikeado por no loguearte!");
			Kick(playerid);
		}
	}

	if(dialogid == DIALOG_REGISTRO)
	{
	    if(response)
	    {
		    if (strlen(inputtext) == 0) return ShowPlayerDialog(playerid, DIALOG_REGISTRO, DIALOG_STYLE_PASSWORD, "Registrar", "Ingresa almenos 4 caracteres!", "Ingresar", "Salir");
		    if (strlen(inputtext) < 4 || strlen(inputtext) > 20) return ShowPlayerDialog(playerid, DIALOG_REGISTRO, DIALOG_STYLE_PASSWORD, "Registrar", "Ingresa almenos 4 caracteres pero no mas de 20!", "Ingresar", "Salir");
	    	new tmp3[20], strdate[20], year,month,day;	getdate(year, month, day);
	     	GetPlayerIp(playerid,tmp3,100); format(strdate, sizeof(strdate), "%d/%d/%d",day,month,year);
			udb_query(result, "INSERT INTO `user` (`pName`, `pPass`, `pLoggedIn`, `pIP`, `pRegistered`, `pRegisteredDate`) VALUES ('%s','%d','%d','%s','%d','%s')", DB_Escape(udb_encode(PlayerName2(playerid))), udb_hash(inputtext), 1, tmp3, 1, strdate);
			db_free_result(result);
			ChangeLoggedIn(playerid, 1, tmp3);
		    PlayerInfo[playerid][LoggedIn] = 1;
		    PlayerInfo[playerid][Registered] = 1;
		    SendClientMessage(playerid, green, "CUENTA: Usted está actualmente registrado, y te has logueado automáticamente");
			PlayerPlaySound(playerid,1057,0.0,0.0,0.0);
		}
		else
		{
			SendClientMessage(playerid, red, "CUENTA: Has sido kikeado por no registrarte!");
			Kick(playerid);
		}
	}


	return 0;
} /* FIN */
/* Sistema de Objetos By 43z */
public OnPlayerModelSelection(playerid, response, listid, modelid)
{
    if(listid == vehlist)
    {
        if(response)
        {
        GetPlayerPos(playerid, cX, cY, cZ);
        GetPlayerFacingAngle(playerid, cAngle);
		CreateVehicleEx(playerid, modelid, cX, cY, cZ+2.0, cAngle, random(126), random(126), -1);

		}
        else SendClientMessage(playerid, 0xFF0000FF, "[Pura Joda] Has cancelado.");
		return 1;
    }
    if(listid == planelist)
    {
        if(response)
        {
        GetPlayerPos(playerid, cX, cY, cZ);
        GetPlayerFacingAngle(playerid, cAngle);
		CreateVehicleEx(playerid, modelid, cX, cY, cZ+2.0, cAngle, random(126), random(126), -1);
		}
        else SendClientMessage(playerid, 0xFF0000FF, "[Pura Joda] Has cancelado.");
		return 1;
    }
    if(listid == boatlist)
    {
        if(response)
        {
        GetPlayerPos(playerid, cX, cY, cZ);
        GetPlayerFacingAngle(playerid, cAngle);
		CreateVehicleEx(playerid, modelid, cX, cY, cZ+2.0, cAngle, random(126), random(126), -1);
		}
        else SendClientMessage(playerid, 0xFF0000FF, "[Pura Joda] Has cancelado.");
		return 1;
    }
	if(listid == accesorios)
	{
	    if(response)
	    {
	        if(!IsSlotUsed(playerid)) return SendClientMessage(playerid, 0xFF0000FF, "Error: Tienes los 10 slot ocupados. Use {FFFFFF}/eoremove (0-9) {FF0000}para borrar un objeto");
	        new Index = IsFreeSlotUsed(playerid);
	        SetPlayerAttachedObject(playerid, Index, modelid, ParteDelCuerpo[playerid]);
	        Slot[playerid][Index] = modelid;
	        EditAttachedObject(playerid, Index);
	    } else return ShowPlayerDialog(playerid, DIALOG_OBJECTSELECTION+1, DIALOG_STYLE_LIST, "Selecciona que quieres ponerte", "Accesorios\nAuto Partes\nGorros Y Cascos\nNavidad\nTelefonos\nObjetos de Policias\nArmas\nOtros", "Ok", "");
	}
	if(listid == autoparts)
	{
	    if(response)
	    {
	        if(!IsSlotUsed(playerid)) return SendClientMessage(playerid, 0xFF0000FF, "Error: Tienes los 10 slot ocupados. Use {FFFFFF}/eoremove (0-9) {FF0000}para borrar un objeto");
	        new Index = IsFreeSlotUsed(playerid);
	        SetPlayerAttachedObject(playerid, Index, modelid, ParteDelCuerpo[playerid]);
	        Slot[playerid][Index] = modelid;
	        EditAttachedObject(playerid, Index);
	    } else return ShowPlayerDialog(playerid, DIALOG_OBJECTSELECTION+1, DIALOG_STYLE_LIST, "Selecciona que quieres ponerte", "Accesorios\nAuto Partes\nGorros Y Cascos\nNavidad\nTelefonos\nObjetos de Policias\nArmas\nOtros", "Ok", "");
	}
	if(listid == gorrosycascos)
	{
	    if(response)
	    {
	        if(!IsSlotUsed(playerid)) return SendClientMessage(playerid, 0xFF0000FF, "Error: Tienes los 10 slot ocupados. Use {FFFFFF}/eoremove (0-9) {FF0000}para borrar un objeto");
	        new Index = IsFreeSlotUsed(playerid);
	        SetPlayerAttachedObject(playerid, Index, modelid, ParteDelCuerpo[playerid]);
	        Slot[playerid][Index] = modelid;
	        EditAttachedObject(playerid, Index);
	    } else return ShowPlayerDialog(playerid, DIALOG_OBJECTSELECTION+1, DIALOG_STYLE_LIST, "Selecciona que quieres ponerte", "Accesorios\nAuto Partes\nGorros Y Cascos\nNavidad\nTelefonos\nObjetos de Policias\nArmas\nOtros", "Ok", "");
	}
	if(listid == navidad)
	{
	    if(response)
	    {
	        if(!IsSlotUsed(playerid)) return SendClientMessage(playerid, 0xFF0000FF, "Error: Tienes los 10 slot ocupados. Use {FFFFFF}/eoremove (0-9) {FF0000}para borrar un objeto");
	        new Index = IsFreeSlotUsed(playerid);
	        SetPlayerAttachedObject(playerid, Index, modelid, ParteDelCuerpo[playerid]);
	        Slot[playerid][Index] = modelid;
	        EditAttachedObject(playerid, Index);
	    } else return ShowPlayerDialog(playerid, DIALOG_OBJECTSELECTION+1, DIALOG_STYLE_LIST, "Selecciona que quieres ponerte", "Accesorios\nAuto Partes\nGorros Y Cascos\nNavidad\nTelefonos\nObjetos de Policias\nArmas\nOtros", "Ok", "");
	}
	if(listid == phones)
	{
	    if(response)
	    {
	        if(!IsSlotUsed(playerid)) return SendClientMessage(playerid, 0xFF0000FF, "Error: Tienes los 10 slot ocupados. Use {FFFFFF}/eoremove (0-9) {FF0000}para borrar un objeto");
	        new Index = IsFreeSlotUsed(playerid);
	        SetPlayerAttachedObject(playerid, Index, modelid, ParteDelCuerpo[playerid]);
	        Slot[playerid][Index] = modelid;
	        EditAttachedObject(playerid, Index);
	    } else return ShowPlayerDialog(playerid, DIALOG_OBJECTSELECTION+1, DIALOG_STYLE_LIST, "Selecciona que quieres ponerte", "Accesorios\nAuto Partes\nGorros Y Cascos\nNavidad\nTelefonos\nObjetos de Policias\nArmas\nOtros", "Ok", "");
	}
	if(listid == policeobjects)
	{
	    if(response)
	    {
	        if(!IsSlotUsed(playerid)) return SendClientMessage(playerid, 0xFF0000FF, "Error: Tienes los 10 slot ocupados. Use {FFFFFF}/eoremove (0-9) {FF0000}para borrar un objeto");
	        new Index = IsFreeSlotUsed(playerid);
	        SetPlayerAttachedObject(playerid, Index, modelid, ParteDelCuerpo[playerid]);
	        Slot[playerid][Index] = modelid;
	        EditAttachedObject(playerid, Index);
	    } else return ShowPlayerDialog(playerid, DIALOG_OBJECTSELECTION+1, DIALOG_STYLE_LIST, "Selecciona que quieres ponerte", "Accesorios\nAuto Partes\nGorros Y Cascos\nNavidad\nTelefonos\nObjetos de Policias\nArmas\nOtros", "Ok", "");
	}
	if(listid == weaps)
	{
	    if(response)
	    {
	        if(!IsSlotUsed(playerid)) return SendClientMessage(playerid, 0xFF0000FF, "Error: Tienes los 10 slot ocupados. Use {FFFFFF}/eoremove (0-9) {FF0000}para borrar un objeto");
	        new Index = IsFreeSlotUsed(playerid);
	        SetPlayerAttachedObject(playerid, Index, modelid, ParteDelCuerpo[playerid]);
	        Slot[playerid][Index] = modelid;
	        EditAttachedObject(playerid, Index);
	    } else return ShowPlayerDialog(playerid, DIALOG_OBJECTSELECTION+1, DIALOG_STYLE_LIST, "Selecciona que quieres ponerte", "Accesorios\nAuto Partes\nGorros Y Cascos\nNavidad\nTelefonos\nObjetos de Policias\nArmas\nOtros", "Ok", "");
	}
	if(listid == other)
	{
	    if(response)
	    {
	        if(!IsSlotUsed(playerid)) return SendClientMessage(playerid, 0xFF0000FF, "Error: Tienes los 10 slot ocupados. Use {FFFFFF}/eoremove (0-9) {FF0000}para borrar un objeto");
	        new Index = IsFreeSlotUsed(playerid);
	        SetPlayerAttachedObject(playerid, Index, modelid, ParteDelCuerpo[playerid]);
	        Slot[playerid][Index] = modelid;
	        EditAttachedObject(playerid, Index);
	    } else return ShowPlayerDialog(playerid, DIALOG_OBJECTSELECTION+1, DIALOG_STYLE_LIST, "Selecciona que quieres ponerte", "Accesorios\nAuto Partes\nGorros Y Cascos\nNavidad\nTelefonos\nObjetos de Policias\nArmas\nOtros", "Ok", "");
	}
	return 0;
}
public OnPlayerEditAttachedObject(playerid, response, index, modelid, boneid, Float:fOffsetX, Float:fOffsetY, Float:fOffsetZ, Float:fRotX, Float:fRotY, Float:fRotZ, Float:fScaleX, Float:fScaleY, Float:fScaleZ)
{
    if(response)
    {
		ao[playerid][index][ao_model] = modelid;
		ao[playerid][index][ao_bone] = boneid;
        ao[playerid][index][ao_x] = fOffsetX;
        ao[playerid][index][ao_y] = fOffsetY;
        ao[playerid][index][ao_z] = fOffsetZ;
        ao[playerid][index][ao_rx] = fRotX;
        ao[playerid][index][ao_ry] = fRotY;
        ao[playerid][index][ao_rz] = fRotZ;
        ao[playerid][index][ao_sx] = fScaleX;
        ao[playerid][index][ao_sy] = fScaleY;
        ao[playerid][index][ao_sz] = fScaleZ;
        new i = index;
        SetPlayerAttachedObject(playerid, index, modelid, boneid, ao[playerid][i][ao_x], ao[playerid][i][ao_y], ao[playerid][i][ao_z], ao[playerid][i][ao_rx], ao[playerid][i][ao_ry], ao[playerid][i][ao_rz], ao[playerid][i][ao_sx], ao[playerid][i][ao_sy], ao[playerid][i][ao_sz]);

    }

    return 1;
}
stock IsSlotUsed(playerid)
{
	new Index = 0;
    for(new i = 0; i <= 9; i++)
	{
	    if(!IsPlayerAttachedObjectSlotUsed(playerid, i)) Index++;
	}
	return Index;
}

stock IsFreeSlotUsed(playerid)
{
    for(new i = 0; i <= 9; i++)
	{
	    if(!IsPlayerAttachedObjectSlotUsed(playerid, i)) return i;
	}
	return 0;
}

stock DestroyAllAttachObject(playerid)
{
	for(new i = 0; i <= 9; i++)
	{
	    RemovePlayerAttachedObject(playerid, i);
	    Slot[playerid][i] = -1;
	}
	return 1;
} /* FIN */

stock StartTuneSound(playerid)
{
    PlayerPlaySound(playerid,1133,0.0,0.0,0.0);
    return 1;
}
public OnPlayerRequestSpawn(playerid)
{
    //SetPlayerPos(playerid, Pos_x,Pos_y,Pos_z);
	if(ServerInfo[MustLogin] == 1 && PlayerInfo[playerid][Registered] == 1 && PlayerInfo[playerid][LoggedIn] == 0)
	{
		GameTextForPlayer(playerid,"~r~~h~Debes loguearte antes de jugar!~n~~w~/login contrasena",4000,3);
		SendClientMessage(playerid, COLOR_GREEN1, "USO: /LOGIN [CONTRASEÑA] si no lo haces no entrarás.");
		return 0;
	}

    if(ServerInfo[MustRegister] == 1 && PlayerInfo[playerid][Registered] == 0)
	{
		GameTextForPlayer(playerid,"~r~~h~Debes registrarte antes de jugar!",4000,3);
		return 0;
	}
	return 1;
}
COMMAND:gcolor(playerid, params[])
{
	if(GetPVarInt(playerid, "PREMIUM") <= 2) return SendClientMessage(playerid, red, "[Pura Joda] Necesita como mínimo nivel 3 Premium");
	if(PlayerInfo[playerid][fColor] == -1){
	new tmp[32 * sizeof(colores)], tmp2[32];
	for(new i=0; i<sizeof(colores); i++)
	{
		format(tmp2, sizeof(tmp2),
                       "{%06x}%s\n", colores[i][colorHex] >>> 8/*de rgba a rgb*/, colores[i][colorNombre]);
		strcat(tmp, tmp2);
	}
	ShowPlayerDialog(playerid, DIALOG_COLOR, DIALOG_STYLE_LIST, "Colores", tmp, "Aceptar", "");
	}
	else {
	PlayerInfo[playerid][fColor] = -1;
	SendClientMessage(playerid, red, "[Pura Joda] Has desactivado el guardado de color");
	}
	return 1;
}
/*CMD:regalo(playerid, params[]){
if(Navidad[playerid]) return SendClientMessage(playerid, RED, "[Pura Joda] Ya abrió su regalo");
new number = random(20);
switch(number){
case 0:{


}


}

return 1;
}
function SendM(playerid, text[]){
new text2[145];
format(text2, sizeof(text2), ""G"[Pura Joda] %s", text);
SendClientMessage(playerid, -1, text);
return 1;
}*/
/*
CMD:setscore(playerid, params[])
{
    if(PlayerInfo[playerid][Level] <= 5) return SendClientMessage(playerid, red, "[Pura Joda] No tiene suficientes privilegios.");
	new string[128], pName[MAX_PLAYER_NAME], name[MAX_PLAYER_NAME], pID, score;
	if(sscanf(params, "ud", pID, score)) return SendClientMessage(playerid, -1, "[Pura Joda] /Setscore [ID] [Score]");
	if(pID == INVALID_PLAYER_ID) return SendClientMessage(playerid, -1, "This player is not connected");
	GetPlayerName(playerid, name, sizeof(name));
 	GetPlayerName(pID, pName, sizeof(pName));
	format(string, sizeof(string), "%s has given you %d score",PlayerName2(playerid), score);
	SendClientMessage(pID, -1, string);
	format(string, sizeof(string), "You have given %d score to %s", score, PlayerName2(player1));
	SendClientMessage(playerid, -1, string);
	SetPlayerScore(pID, score);
	SetPVarInt(playerid, "Score", score);
	return 1;
}*/
function Start(){
	LoadRaceNames();
	LoadAutoRace(RaceNames[rProgress]);
return 1;

}CMD:buildrace(playerid, params[])
{
	if(!IsPlayerAdmin(playerid)) return SendClientMessage(playerid, RED, "[Pura Joda] Sólo administradores RCON!");
	if(BuildRace != 0) return SendClientMessage(playerid, RED, "[Pura Joda] Alguien está construyendo una carrera aquí!");
	if(RaceBusy == 0x01) return SendClientMessage(playerid, RED, "[Pura Joda] Porfavor espere a que termine la carrera!");
	if(IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid, RED, "[Pura Joda] Sálgase de su vehículo primero!");
	BuildRace = playerid+1;
	ShowDialog(playerid, 9000);
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
	if(GetPVarInt(playerid, "MINION")) return SendClientMessage(playerid, RED, "[Pura Joda] Está en un minijuego.");
	DisableRemoteVehicleCollisions(playerid,1);
	new Float:xe, Float:y, Float:z;
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
        DisableRemoteVehicleCollisions(playerid,0);
		JoinCount--;
	//	contador--;
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
CMD:saltos(playerid, params[]){

if(!Jump[playerid]){
	Jump[playerid] = 1;
	SendClientMessage(playerid, LIGHTGREEN, "[Pura Joda] Ha activado los saltos con 'H'");
	}
	else{
	Jump[playerid] = 0;
	SendClientMessage(playerid, LIGHTGREEN, "[Pura Joda] Ha desactivado los saltos con 'H'");
	}
return 1;
}
	CMD:salir(playerid, params[]){
	if(ViendoDuelo[playerid] == -1) return SendClientMessage(playerid, RED, "[Pura Joda] Usted no está viendo a nadie.");
	TogglePlayerSpectating(playerid, 0);
	ViendoDuelo[playerid] = -1;
	KillTimer(Dueled[playerid]);
	return 1;
	}

CMD:menuautos(playerid, params[]){
if(GetPVarInt(playerid, "MINION") || GetPVarInt(playerid, "RACE")) return 0;
ShowModelSelectionMenu(playerid, vehlist, "Vehiculos");
return 1;
}
CMD:check(playerid, params[]){
if(strlen(params) == 0) return SendClientMessage(playerid, -1, "/Check [ID]");
if(!IsNumeric(params)) return SendClientMessage(playerid, -1, "Únicamente números.");
if(!IsPlayerConnected(strval(params))) return SendClientMessage(playerid, -1, "Jugador no conectado.");
if(Buy[strval(params)]) return SendClientMessage(playerid, LIGHTGREEN, "[Pura Joda] El jugador compró en Ammunation.");
else return SendClientMessage(playerid, LIGHTGREEN, "[Pura Joda] El jugador NO compró en Ammunation.");
}

forward KickPublic(playerid);
public KickPublic(playerid) return Kick(playerid);

stock KickWithMessage(playerid, color, message[])
{
    SendClientMessage(playerid, color, message);
    SetTimerEx("KickPublic", 4000, 0, "d", playerid); 	//Tarda 1 segundo en ser expulsado desde que aparece el mensaje
}
forward vidatimer(playerid);
public vidatimer(playerid)
{
   if(IsPlayerConnected(playerid))
   {
       if(vida[playerid] == 1)
       {
         vida[playerid] = 0;
       }
   }
}
forward granadastimer(playerid);
public granadastimer(playerid)
{
   if(IsPlayerConnected(playerid))
   {
       if(granadas[playerid] == 1)
       {
         granadas[playerid] = 0;
       }
   }
}
forward pdietimer(playerid);
public pdietimer(playerid)
{
   if(IsPlayerConnected(playerid))
   {
       if(pdie[playerid] == 1)
       {
         pdie[playerid] = 0;
       }
   }
}
forward chalecotimer(playerid);
public chalecotimer(playerid)
{
   if(IsPlayerConnected(playerid))
   {
       if(chaleco[playerid] == 1)
       {
         chaleco[playerid] = 0;
       }
   }
}



forward UpdateJarvisIronman(playerid);
public UpdateJarvisIronman(playerid) {
	if(GetPlayerState(playerid)!=PLAYER_STATE_ONFOOT) return false;
	static teclasjarvis[3], Float:PosicionJarvis[2][3];
	GetPlayerKeys(playerid,teclasjarvis[0],teclasjarvis[1],teclasjarvis[2]);
	if(teclasjarvis[0] & KEY_SPRINT && Ironman[playerid][ActivarIronman] == true) {
		GetPlayerCameraPos(playerid, PosicionJarvis[1][0],PosicionJarvis[1][1],PosicionJarvis[1][2]);
		GetPlayerCameraFrontVector(playerid, PosicionJarvis[0][0],PosicionJarvis[0][1],PosicionJarvis[0][2]);
		SetPlayerToFacePos(playerid, PosicionJarvis[0][0] + PosicionJarvis[1][0], PosicionJarvis[0][1]+PosicionJarvis[1][1]);
		SetPlayerVelocity(playerid, PosicionJarvis[0][0]*Ironman[playerid][TurbinasIronman], PosicionJarvis[0][1]*Ironman[playerid][TurbinasIronman], PosicionJarvis[0][2]*Ironman[playerid][TurbinasIronman]);
		ApplyAnimation(playerid,"PARACHUTE","FALL_SkyDive_Accel",4.1,1,1,1,1,0);
		if(Ironman[playerid][IronmanVolando]==false) {
			Ironman[playerid][IronmanVolando]=true;
			for(new index=0; index<6; index++) { RemovePlayerAttachedObject(playerid,index); }
			SetPlayerAttachedObject(playerid,0,18693,5,-1.506999,-0.032999,-0.153000,0.000000,85.599983,18.500005,1.000000,1.000000,1.000000,0xFFEEEEEE);
			SetPlayerAttachedObject(playerid,1,18693,6,-1.267001,-0.454000,0.636999,33.200012,119.699867,-67.900016,1.000000,1.000000,1.000000,0xFFEEEEEE);
			SetPlayerAttachedObject(playerid,2,18693,9,-1.418004,0.019999,0.076999,-61.300003,89.999954,-2.700009,1.000000,1.000000,1.000000,0xFFEEEEEE);
			SetPlayerAttachedObject(playerid,3,18693,10,-1.418004,0.019999,0.076999,-61.300003,89.999954,-2.700009,1.000000,1.000000,1.000000,0xFFEEEEEE);
			SetPlayerAttachedObject(playerid,4,18730,5,-1.506999,-0.032999,-0.153000,0.000000,85.599983,18.500005,1.000000,1.000000,1.000000,0xFFEEEEEE);
			SetPlayerAttachedObject(playerid,5,18730,6,-1.267001,-0.454000,0.636999,33.200012,119.699867,-67.900016,1.000000,1.000000,1.000000,0xFFEEEEEE);
		}
	} else {
		if(Ironman[playerid][IronmanVolando]==true) {
			for(new index=0; index<6; index++) { RemovePlayerAttachedObject(playerid,index); }
			Ironman[playerid][IronmanVolando]=false;
			SetPlayerVelocity(playerid, 0, 0, 0);
			ApplyAnimation(playerid,"CARRY","crry_prtial",4.0,0,0,0,0,0);
		}
	}
	return true;
}

forward Float:SetPlayerToFacePos(playerid, Float:X, Float:Y);
public Float:SetPlayerToFacePos(playerid, Float:X, Float:Y){
    new Float:pX, Float:pY, Float:pZ, Float:ang;
    if(!IsPlayerConnected(playerid)) return 0.0;
    GetPlayerPos(playerid, pX, pY, pZ);
    if( Y > pY ) ang = (-acos((X - pX) / floatsqroot((X - pX)*(X - pX) + (Y - pY)*(Y - pY))) - 90.0);
    else if( Y < pY && X < pX ) ang = (acos((X - pX) / floatsqroot((X - pX)*(X - pX) + (Y - pY)*(Y - pY))) - 450.0);
    else if( Y < pY ) ang = (acos((X - pX) / floatsqroot((X - pX)*(X - pX) + (Y - pY)*(Y - pY))) - 90.0);
    if(X > pX) ang = (floatabs(floatabs(ang) + 180.0));
    else ang = (floatabs(ang) - 180.0);
    ang += 180.0;
    SetPlayerFacingAngle(playerid, ang);
    return ang;
}
forward Cargarobjetos(playerid);
public Cargarobjetos(playerid)
{
    TogglePlayerControllable(playerid,1);
	return 1;
}

/*forward UpDateTopRankingPlayer();
public UpDateTopRankingPlayer() {
    new DBResult:r = db_query(LadminDB, "SELECT `ID`, `pName`, `pKills` FROM `user` ORDER BY `pKills` desc LIMIT 10");
    new string[1000];
	for(new top = 0; top != db_num_rows(r); ++top)
	{
	    new field[30], playerkill; db_get_field_assoc(r, "pKills", field, 30); playerkill = strval(field); db_get_field_assoc(r, "pName", field, 30);
	    new str2[200]; format(str2, sizeof(str2), "~n~~r~%d. ~w~%s ~r~- ~p~%d", top+1, udb_decode(field), playerkill); strcat(string, str2);
	    db_next_row(r);
	}
	db_free_result(r);
	TextDrawSetString(TD_RANKINGSCORE[1], string);
	return 1;
}
*/
stock ChangeLoggedIn(playerid, loggedin = 1, pIP[], level = 0, premium = 0, banned = 0)
{
	udb_query(result3, "UPDATE `user` SET `pLevel` = '%d', `pPremium` = '%d', `pLoggedIn` = '%d', `pIP` = '%s', `pBanned` = '%d' WHERE `pName` = '%s'", level, premium, loggedin, DB_Escape(pIP), banned, DB_Escape(udb_encode(PlayerName2(playerid))));
	db_free_result(result3);
}

/*stock PasarASQL(playerid)
{
	new file[256]; format(file,sizeof(file),"/ladmin/users/%s.sav",udb_encode(PlayerName2(playerid)));
	GameTextForPlayer(playerid, "~w~Espere mientras su cuenta es buscada en nuestra~n~~r~Base de Datos", 1000, 5);
	new query[1000], data[460];
	strcat(query, "INSERT INTO `user`(`pName`, `pPass`, `pLevel`, `pPremium`, `pMoney`, `pKills`, `pDeath`, `pHours`, `pMinutes`, `pSeconds`, `pWeap1`, `pWeap2`, `pWeap3`, `pWeap4`, `pWeap5`, `pWeap6`, `pWeap1Ammo`, `pWeap2Ammo`, `pWeap3Ammo`, `pWeap4Ammo`, `pWeap5Ammo`, `pWeap6Ammo`, `pLastOn`, `pRconAprovado`, `pPreDia`, `pPreMes`, `pPreAno`, `pIP`, `pRegistered`, `pRegisteredDate`, `pBanned`) VALUES (");
	format(data, sizeof(data), "'%s','%d','%d','%d','%d','%d','%d','%d','%d',",DB_Escape(udb_encode(PlayerName2(playerid))),(dUserINT(PlayerName2(playerid)).("password_hash")),(dUserINT(PlayerName2(playerid)).("level")),(dUserINT(PlayerName2(playerid)).("Premiun")),(dUserINT(PlayerName2(playerid)).("money")),(dUserINT(PlayerName2(playerid)).("kills")),(dUserINT(PlayerName2(playerid)).("deaths")),(dUserINT(PlayerName2(playerid)).("hours")),(dUserINT(PlayerName2(playerid)).("minutes")));
	strcat(query, data);
	format(data, sizeof(data), "'%d','%d','%d','%d','%d',",(dUserINT(PlayerName2(playerid)).("seconds")),(dUserINT(PlayerName2(playerid)).("weap1")),(dUserINT(PlayerName2(playerid)).("weap2")),(dUserINT(PlayerName2(playerid)).("weap3")),(dUserINT(PlayerName2(playerid)).("weap4")));
	strcat(query, data);
	format(data, sizeof(data), "'%d','%d','%d','%d','%d','%d','%d','%d',",(dUserINT(PlayerName2(playerid)).("weap5")),(dUserINT(PlayerName2(playerid)).("weap6")),(dUserINT(PlayerName2(playerid)).("weap1ammo")),(dUserINT(PlayerName2(playerid)).("weap2ammo")),(dUserINT(PlayerName2(playerid)).("weap3ammo")),(dUserINT(PlayerName2(playerid)).("weap4ammo")),(dUserINT(PlayerName2(playerid)).("weap5ammo")),(dUserINT(PlayerName2(playerid)).("weap6ammo")));
	strcat(query, data);
	format(data, sizeof(data), "'%s','%d','%d','%d','%d','%s','1','%s','%d')",DB_Escape(dini_Get(file,"LastOn")),(dUserINT(PlayerName2(playerid)).("RconAprovado")),(dUserINT(PlayerName2(playerid)).("PreDia")),(dUserINT(PlayerName2(playerid)).("PreMes")),(dUserINT(PlayerName2(playerid)).("PreAno")),DB_Escape(dini_Get(file, "ip")),DB_Escape(dini_Get(file, "RegisteredDate")),(dUserINT(PlayerName2(playerid)).("banned")));
	strcat(query, data);
	format(file, sizeof(file), "/ladmin/users/%s.sav", udb_encode(PlayerName2(playerid)));
	if(!fremove(file)) return Kick(playerid);
	db_free_result(db_query(LadminDB, query));
	return 1;
}
*/
stock DB_Escape(text[])
{
	new
		ret[80 * 2],
		ch,
		i,
		j;
	while ((ch = text[i++]) && j < sizeof (ret))
	{
		if (ch == '\'')
		{
			if (j < sizeof (ret) - 2)
			{
				ret[j++] = '\'';
				ret[j++] = '\'';
			}
		}
		else if (j < sizeof (ret))
		{
			ret[j++] = ch;
		}
		else
		{
			j++;
		}
	}
	ret[sizeof (ret) - 1] = '\0';
	return ret;
}

stock GetTimeON(playerid, &h=0, &m=0, &s=0)
{
	new ctime = gettime() - PlayerInfo[playerid][TimeON];
	new oldctime = ctime;
	if(ctime >= 3600)
	{
		while(ctime < 3600)
		{
		    h++;
		    ctime =- 3600;
		}
	} else if(ctime >= 60)
	{
	    while(ctime < 60)
	    {
	        m++;
	        ctime =- 60;
	    }
	}
	s = ctime;
	return oldctime;
}
forward antifloodreset(playerid);
public antifloodreset(playerid)
{
   if(IsPlayerConnected(playerid))
   {
       if(antiflood[playerid] == 1)
       {
         antiflood[playerid] = 0;
         TogglePlayerControllable(playerid, true);
       }
   }
}
function LuzVerde(playerid)
{
ammude[playerid] = false;
return 1;
}

function CargandoMapa(playerid)
{
    TogglePlayerControllable(playerid, false);
    PlayerPlaySound(playerid, 1056, 0.0, 0.0, 0.0);
    SetTimerEx("MapaCargado", 3000, 0,"e",playerid);
    return 1;
}


function MapaCargado(playerid)
{
    new string[255];
    format(string, sizeof(string), "~n~~n~~n~~n~~n~~n~~n~~w~Mapa Cargado!");
    TogglePlayerControllable(playerid, true);
    GameTextForPlayer(playerid, string, 3000, 5);
    PlayerPlaySound(playerid, 1056, 0.0, 0.0, 0.0);

    return 1;
}


public GetVehicleModelIDFromName(vname[])
{
	for(new i = 0; i < 211; i++)
	{
		if ( strfind(VehicleNames[i], vname, true) != -1 )
			return i + 400;
	}
	return -1;
}
stock DestruirVehiculos()
{
for(new i; i < MAX_PLAYERS; i++){
if(!IsPlayerConnected(i)) continue;
if(GetPlayerState(i) == PLAYER_STATE_ONFOOT){
DestroyVehicle(CurrentSpawnedVehicle[i]);
DestroyVehicle(PlayerInfo[i][pCar]);
}
}
return 1;
}
stock CreateVehicleEx(playerid, modelid, Float:posX, Float:posY, Float:posZ, Float:angle, Colour1, Colour2, respawn_delay)
{
  	new world = GetPlayerVirtualWorld(playerid);
  	new interior = GetPlayerInterior(playerid);
  	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
  	{
 		DestroyVehicle(GetPlayerVehicleID(playerid));
 		GetPlayerPos(playerid, posX, posY, posZ);
 		GetPlayerFacingAngle(playerid, angle);
 		CurrentSpawnedVehicle[playerid] = CreateVehicle(modelid, posX, posY, posZ, angle, Colour1, Colour2, respawn_delay);
        LinkVehicleToInterior(CurrentSpawnedVehicle[playerid], interior);
    	SetVehicleVirtualWorld(CurrentSpawnedVehicle[playerid], world);
    	SetVehicleZAngle(CurrentSpawnedVehicle[playerid], angle);
   		PutPlayerInVehicle(playerid, CurrentSpawnedVehicle[playerid], 0);
   		SetPlayerInterior(playerid, interior);
  	}
  	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
  	{
        if(IsVehicleOccupied(CurrentSpawnedVehicle[playerid])) {} else DestroyVehicle(CurrentSpawnedVehicle[playerid]);
    	GetPlayerPos(playerid, posX, posY, posZ);
    	GetPlayerFacingAngle(playerid, angle);
   		CurrentSpawnedVehicle[playerid] = CreateVehicle(modelid, posX, posY, posZ, angle, Colour1, Colour2, respawn_delay);
    	LinkVehicleToInterior(CurrentSpawnedVehicle[playerid], interior);
    	SetVehicleVirtualWorld(CurrentSpawnedVehicle[playerid], world);
    	SetVehicleZAngle(CurrentSpawnedVehicle[playerid], angle);
    	PutPlayerInVehicle(playerid, CurrentSpawnedVehicle[playerid], 0);
    	SetPlayerInterior(playerid, interior);
  	}
	return 1;
}
stock IsVehicleOccupied(vehicleid)
{
 Loop(i, MAX_PLAYER)
 {
 if(GetPlayerState(i) == PLAYER_STATE_DRIVER || GetPlayerState(i) == PLAYER_STATE_PASSENGER)
 {if(GetPlayerVehicleID(i) == vehicleid){return 1;	}}	}return 0;}
function PNovel(playerid){
		new iString[2000];

		strcat(iString, "{FFFFFF}Bievenido a Pura Joda\n\n");
		strcat(iString, "{FFFFFF}El server registra cierto tiempo de actualización y mejoras \n");
		strcat(iString, "{FFFFFF}para la comodidad de todos, si tienes sugerencias envialas. \n\n");

    	strcat(iString, "{FFFFFF}1. Ahora podrás reparar el vehículo más fácil con '2'\n");
		strcat(iString, "{FFFFFF}2. Se ha corregido el error de Ammunation.\n");
		strcat(iString, "{FFFFFF}3. Reinicio parcial de las casas.\n");
		strcat(iString, "{FFFFFF}4. Solución del problemas y mejoras de desempeño.\n");
		strcat(iString, "{FFFFFF}5. Se ha restablecido el comando /Bomba\n");
		strcat(iString, "{FFFFFF}6. Se han renovado todos los minijuegos.\n");
    	strcat(iString, "{FFFFFF}7. Se añadió /pHighlight para premiums lvl 3 o superior.\n");
    	strcat(iString, "{FFFFFF}8. Limpieza de scripts en general.\n");
    	strcat(iString, "{FFFFFF}9. Se ha mejorado la radio, ¡Hay nuevos géneros!\n");
    	strcat(iString, "{FFFFFF}10. El spreekill ahora dará cada vez más score y PJCoin.\n");
    	strcat(iString, "{FFFFFF}11. Ligeras mejoras en el sistema de adminsitración.\n");
    	strcat(iString, "{FFFFFF}12. Para mayor efectividad los administradores +5 lvls podrán dar score con /darscore.\n");
    	strcat(iString, "{FFFFFF}13. Los money hack fueron pulverizados.\n");
        strcat(iString, "{FFFFFF}14. Se ha añadido la posibilidad de desactivar /Velocidad & /Saltos.\n");
        strcat(iString, "{FFFFFF}15. Se restableció el velocímetro clásico de Pura Joda.\n");
        strcat(iString, "{FFFFFF}16. Se renovó el contador de posiciones y progreso en las carreras.\n");
        strcat(iString, "{FFFFFF}17. Ahora podrás devolverte de checkpoint con 'Q', los vehículos no colosionarán.\n");
        strcat(iString, "{FFFFFF}18. Limpieza general de objetos.\n");
  		strcat(iString, "{FFFFFF}19. Se restableció el sistema de saltos Jump & drift antiguo de Pura Joda.\n");
    	strcat(iString, "{FFFFFF}20. Nuevo Interior: Luxury Interior, se ha recuperado CuevaDelTerror.\n");
        strcat(iString, "{FFFFFF}21. ¡Nuevo minijuego: /Mojados!\n");
        strcat(iString, "{FFFFFF}22. Ahora puedes guardar tu color preferido: /gColor\n");
		strcat(iString, "{FFFFFF}23. Se añadió Top Drivers para las carreras.");
		ShowPlayerDialog(playerid,DIALOG_OTROS,DIALOG_STYLE_MSGBOX, "{00FF00} Novedades de {FF0000}Pura Joda.",iString,"Cerrar","");
  		PlayerPlaySound(playerid,1139,0.0,0.0,0.0);
return 1;
		  }

new string98[32], string23[32], string3[10], Float:vhealth;

public Speedometer(playerid)
{
	if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 0) return 1;
			format(string98, sizeof(string98), "~r~~h~%s", VehicleNames[GetVehicleModel(GetPlayerVehicleID(playerid))-400]);
			PlayerTextDrawSetString(playerid,VehicleName[playerid], string98);

			format(string23, sizeof(string23), "%d", GetPlayerSpeed(playerid, 0));
			PlayerTextDrawSetString(playerid,VehicleSpeed[playerid], string23);

			GetVehicleHealth(GetPlayerVehicleID(playerid), vhealth);
			format(string3, sizeof(string3), "~%s~~h~%.0f.0", DamageColor(vhealth), vhealth);
			PlayerTextDrawSetString(playerid,VehicleHealth[playerid], string3);

	return 1;
}

stock DamageColor(Float: health)
{
	new Ve[5];
	if (health <= VehicleHealthRed)
		format(Ve, sizeof(Ve), "r");
	else if (health < VehicleHealthYellow)
	    format(Ve, sizeof(Ve), "y");
	else
	    format(Ve, sizeof(Ve), "g");
	return Ve;
}

stock GetPlayerSpeed(playerid, get3d)
{
	new Float:x, Float:y, Float:z;
	if(IsPlayerInAnyVehicle(playerid))
	    GetVehicleVelocity(GetPlayerVehicleID(playerid), x, y, z);
	else
	    GetPlayerVelocity(playerid, x, y, z);

	return SpeedCheck(x, y, z, 100.0, get3d);
}
public OnPlayerEnterRaceCheckpoint(playerid)
{
	if(Niuly[playerid]) return 1;
	if(CPProgess[playerid] == TotalCP -1)
	{
		new
		    TimeStampe,
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
		TimeStampe = GetTickCount();
		TotalRaceTime = TimeStampe - RaceTick;
		ConvertTime(var, TotalRaceTime, rTime[0], rTime[1], rTime[2]);
		if(contador>6){
		switch(Position)
		{
		    case 1: {
			Prize[0] = (random(random(5000)) + 10000), Prize[1] = 10;
			if(GetPVarInt(playerid, "PREMIUM")>3)SetPVarInt(playerid,"COIN",GetPVarInt(playerid, "COIN")+2);
			else SetPVarInt(playerid, "COIN", GetPVarInt(playerid, "COIN")+1);}
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
			Prize[0] = (random(random(1000)) + 6000), Prize[1] = 4;}
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
		if(GetPVarInt(playerid, "PREMIUM")>3)
		format(string, sizeof(string), "    - Premio: \"$%d y +%d score +2 PJCoin (X2 Premium 4)\".", Prize[0]*2, Prize[1]*2);
		else format(string, sizeof(string), "    - Premio: \"$%d y +%d score\".", Prize[0], Prize[1]);
		SendClientMessageToAll(WHITE, string);
		}
		else if(Position == 1 && contador < 6){
		format(string, sizeof(string), "[Pura Joda] \"%s\" terminó la carrera en la posición %d.", pName, Position);
  		SendClientMessageToAll(LIGHTGREEN, string);

		format(string, sizeof(string), "    - Tiempo: \"%d:%d.%d\".", rTime[0], rTime[1], rTime[2]);
		SendClientMessageToAll(WHITE, string);
		if(GetPVarInt(playerid, "PREMIUM")>3)
		format(string, sizeof(string), "    - Premio: \"$%d y +%d score (X2 Premium 4)\".", Prize[0]*2, Prize[1]*2);
		else format(string, sizeof(string), "    - Premio: \"$%d y +%d score \".", Prize[0], Prize[1]);
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
               // DentroCS[playerid] = 0;
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
        if(GetPVarInt(playerid, "PREMIUM")>3)
		GivePlayerMoneyEx(playerid, Prize[0]*2);
		else GivePlayerMoneyEx(playerid, Prize[0]);
		if(GetPVarInt(playerid, "PREMIUM")>3)
		SetPVarInt(playerid, "Score", GetPVarInt(playerid,"Score")+Prize[1]*2);
		else SetPVarInt(playerid, "Score", GetPVarInt(playerid,"Score")+Prize[1]);
		DisablePlayerRaceCheckpoint(playerid);
		CPProgess[playerid]++;
		SetPVarInt(playerid, "RACE", 0);	//SpawnPlayer(playerid);
		DestroyVehicle(CreatedRaceVeh[playerid]);
	    DisablePlayerRaceCheckpoint(playerid);
    	TextDrawHideForPlayer(playerid, TopDriver);
		TextDrawHideForPlayer(playerid, TopDriver2);
        PlayerTextDrawHide(playerid, Info[playerid]);
        PlayerTextDrawHide(playerid, Race0[playerid]);
        PlayerTextDrawHide(playerid, Info2[playerid]);
		cmd_exitrace(playerid, "");
		if(FinishCount >= JoinCount) return StopRace();
        DisableRemoteVehicleCollisions(playerid,1);
		SpawnPlayer(playerid);
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
        new  Float:Xx, Float:Yx, Float:Zx, Float:xAngle;

function SetCPEx(playerid, PrevCP)
{
	if(PrevCP == -1) return 1;
    new cartype = GetPlayerVehicleID(playerid);
    new VehicleID;
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
new VehicleID;
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
	rProgress++;
	format(rNameFile, sizeof(rNameFile), "/rRaceSystem/RaceNames/RaceNames.txt");
	TotalRaces = dini_Int(rNameFile, "TotalRaces");

	Loop(x, TotalRaces)
	{
	    format(string, sizeof(string), "Race_%d", x), strmid(RaceNames[x], dini_Get(rNameFile, string), 0, 20, sizeof(RaceNames));
	  //  printf(">> Loaded Races: %s", RaceNames[x]);
	}
	if(TotalRaces == rProgress) rProgress = 0;
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
	//DentroCS[playerid] = 1;
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
			ForEach(i, MAX_PLAYERS){
			if(!Joined[i]) continue;
			TogglePlayerControllable(i, 1);
			}
		}
		case 1: {
		ForEach(i, MAX_PLAYERS){
			if(!Joined[i]) continue;
			TogglePlayerControllable(i, 0);


			}
			}
	    case 2..9:{
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
			format(string, sizeof(string), ""G"| CARRERAS | "W"%d "G"segundos para que la carrera "W"%s "G"comience, útilice "W"/Entrar", CountAmount, RaceName);
			SendClientMessageToAll(LIGHTBLUE, string);
			GameTextForAll("~r~~h~/ENTRAR", 6000, 3);

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
			SetCP(i, CPProgess[i], CPProgess[i]+1, TotalCP, RaceType);
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
	contador = 0;
    TimeProgress = 0;
	ForEach(i, MAX_PLAYERS)
	{
	    if(Joined[i] == true)
	    {
	        DisableRemoteVehicleCollisions(i,1);
	    	DisablePlayerRaceCheckpoint(i);
	    	DestroyVehicle(CreatedRaceVeh[i]);
	    	Joined[i] = false;
			
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
	SendClientMessageToAll(YELLOW, ""G"[Pura Joda] En "W" 1 "G"minuto iniciará una nueva "W"carrera.");
	contador = 0;
	SetTimer("Start",RANDOM_TIME_RACE,false);
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

function ShowDialog(playerid, dialogid)
{
	switch(dialogid)
	{
		case 9000: ShowPlayerDialog(playerid, dialogid, DIALOG_STYLE_LIST, CreateCaption("Build New Race"), "\
		Normal Race\n\
		Air Race", "Next", "Exit");

	    case 9001: ShowPlayerDialog(playerid, dialogid, DIALOG_STYLE_INPUT, CreateCaption("Build New Race (Step 1/4)"), "\
		Step 1:\n\
		********\n\
 		Welcome to wizard 'Build New Race'.\n\
		Before getting started, I need to know the name (e.g. SFRace) of the to save it under.\n\n\
		>> Give the NAME below and press 'Next' to continue.", "Next", "Back");

	    case 9002: ShowPlayerDialog(playerid, dialogid, DIALOG_STYLE_INPUT, CreateCaption("Build New Race (Step 1/4)"), "\
	    ERROR: Name too short or too long! (min. 1 - max. 20)\n\n\n\
		Step 1:\n\
		********\n\
 		Welcome to wizard 'Build New Race'.\n\
		Before getting started, I need to know the name (e.g. SFRace) of the to save it under.\n\n\
		>> Give the NAME below and press 'Next' to continue.", "Next", "Back");

		case 9003: ShowPlayerDialog(playerid, dialogid, DIALOG_STYLE_INPUT, CreateCaption("Build New Race (Step 2/4)"), "\
		Step 2:\n\
		********\n\
		Please give the ID or NAME of the vehicle that's going to be used in the race you are creating now.\n\n\
		>> Give the ID or NAME of the vehicle below and press 'Next' to continue. 'Back' to change something.", "Next", "Back");

		case 9004: ShowPlayerDialog(playerid, dialogid, DIALOG_STYLE_INPUT, CreateCaption("Build New Race (Step 2/4)"), "\
		ERROR: Invalid Vehilce ID/Name\n\n\n\
		Step 2:\n\
		********\n\
		Please give the ID or NAME of the vehicle that's going to be used in the race you are creating now.\n\n\
		>> Give the ID or NAME of the vehicle below and press 'Next' to continue. 'Back' to change something.", "Next", "Back");

		case 9005: ShowPlayerDialog(playerid, dialogid, DIALOG_STYLE_MSGBOX, CreateCaption("Build New Race (Step 3/4)"),
		"\
		Step 3:\n\
		********\n\
		We are almost done! Now go to the start line where the first and second car should stand.\n\
		Note: When you click 'OK' you will be free. Use 'KEY_FIRE' to set the first position and second position.\n\
		Note: After you got these positions you will automaticly see a dialog to continue the wizard.\n\n\
		>> Press 'OK' to do the things above. 'Back' to change something.", "OK", "Back");

		case 9006: ShowPlayerDialog(playerid, dialogid, DIALOG_STYLE_MSGBOX, CreateCaption("Build New Race (Step 4/4)"),
		"\
		Step 4:\n\
		********\n\
		Welcome to the last stap. In this stap you have to set the checkpoints; so if you click 'OK' you can set the checkpoints.\n\
		You can set the checkpoints with 'KEY_FIRE'. Each checkpoint you set will save.\n\
		You have to press 'ENTER' button when you're done with everything. You race is aviable then!\n\n\
		>> Press 'OK' to do the things above. 'Back' to change something.", "OK", "Back");

		case 9007: ShowPlayerDialog(playerid, dialogid, DIALOG_STYLE_MSGBOX, CreateCaption("Build New Race (Done)"),
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

forward SetDuel(id1,id2,armas,arena);
public SetDuel(id1,id2,armas,arena)
{
	ResetPlayerWeapons(id1);
	ResetPlayerWeapons(id2);
	SetPlayerHealth(id1,100);
	SetPlayerHealth(id2,100);
	SetPlayerArmour(id1,100);
	SetPlayerArmour(id2,100);
	SetPVarInt(id2, "MINION", 1);
	SetPVarInt(id1,"MINION",1);
	TogglePlayerControllable(id2,0);
	TogglePlayerControllable(id1,0);
	SetCameraBehindPlayer(id1);
	SetCameraBehindPlayer(id2);
	new Float:xe, Float:y, Float:z;
	if(IsPlayerInAnyVehicle(id1)) {
	GetPlayerPos(id1,xe,y,z); SetPlayerPos(id1,xe,y,z+5); PlayerPlaySound(id1,1190,0.0,0.0,0.0);

	}
	if(IsPlayerInAnyVehicle(id2)) {
	GetPlayerPos(id2,xe,y,z); SetPlayerPos(id2,xe,y,z+5); PlayerPlaySound(id2,1190,0.0,0.0,0.0);
}
	switch (arena)
	{
	  case 1: {SetPlayerPos(id1,2646.0796,1232.5236,26.9182); SetPlayerFacingAngle(id1,180.4801); SetPlayerPos(id2,2646.4988,1189.6237,26.9182); SetPlayerFacingAngle(id2,1.9051); SetObjectPos(p1duelo1, 2646.205811, 1230.074219, 26.962353); SetObjectPos(p2duelo1, 2646.165771, 1191.811157, 26.957216);}
	  case 2:
	  {
	  SetPlayerPos(id1,1411.3734, -6.8248, 1000.8316);
	  SetPlayerFacingAngle(id1,-55.0000);
	  SetPlayerPos(id2,1371.3505, -38.8526, 1000.8316);
	  SetPlayerFacingAngle(id2,135.0000);
	  SetPlayerInterior(id1, 1);
	  SetPlayerInterior(id2, 1);
	  }
  	  case 3: {SetPlayerPos(id1,1362.6705,2117.3650,14.1503); SetPlayerFacingAngle(id1,89.6487); SetPlayerPos(id2,1334.4459,2117.9766,14.1503); SetPlayerFacingAngle(id2,269.6487); /*SetObjectPos(p1duelo1, 2646.205811, 1230.074219, 26.962353); SetObjectPos(p2duelo1, 2646.165771, 1191.811157, 26.957216);*/}
  	  case 4: {SetPlayerPos(id1,2815.0596,-1429.7235,16.2500); SetPlayerFacingAngle(id1,139.7597); SetPlayerPos(id2,2791.1196,-1464.7419,16.2500); SetPlayerFacingAngle(id2,317.1080); /*SetObjectPos(p1duelo1, 2646.205811, 1230.074219, 26.962353); SetObjectPos(p2duelo1, 2646.165771, 1191.811157, 26.957216);*/}
  	  case 5: {SetPlayerPos(id1,80.5510, 1949.9753, 17.9495); SetPlayerFacingAngle(id1,-69); SetPlayerPos(id2,68.8591, 1947.9408, 17.9495); SetPlayerFacingAngle(id2,100.23);}
  	  case 6: {SetPlayerPos(id1,-376.2493, 2224.4590, 42.1395); SetPlayerFacingAngle(id1,182); SetPlayerPos(id2,-391.8515, 2221.4329, 42.1395); SetPlayerFacingAngle(id2,-4);}
  	  case 7: {SetPlayerPos(id1,2134.8887, 1466.6361, 10.7514); SetPlayerFacingAngle(id1,178); SetPlayerPos(id2,2134.8887, 1466.6361, 10.7514); SetPlayerFacingAngle(id2,-4);}
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


	forward CheckDuel(playerid, spected);
	public CheckDuel(playerid, spected){
	PlayerSpectatePlayer(playerid, spected);
	return 1;
	}

stock GivePlayerMoneyEx(playerid, const value)
{
SetPlayerVarMoney(playerid, GetPlayerVarMoney(playerid)+value);
return 1;
}
forward SyncPlayer(playerid);
public SyncPlayer(playerid)
{
Sync[playerid] = true;
virt[playerid] = GetPlayerVirtualWorld(playerid);
interiori[playerid] = GetPlayerInterior(playerid);
skinneg[playerid] = GetPlayerSkin(playerid);
GetPlayerArmour(playerid,APP[playerid]);
GetPlayerHealth(playerid,PlayerHPP[playerid]);
GetPlayerFacingAngle(playerid,FaceAngle[playerid]);
GetPlayerPos(playerid,xx[playerid],yy[playerid],zz[playerid]);
GetPlayerWeaponData(playerid,1,gun[1][playerid],ammoo[1][playerid]);
GetPlayerWeaponData(playerid,2,gun[2][playerid],ammoo[2][playerid]);
GetPlayerWeaponData(playerid,3,gun[3][playerid],ammoo[3][playerid]);
GetPlayerWeaponData(playerid,4,gun[4][playerid],ammoo[4][playerid]);
GetPlayerWeaponData(playerid,5,gun[5][playerid],ammoo[5][playerid]);
GetPlayerWeaponData(playerid,6,gun[6][playerid],ammoo[6][playerid]);
GetPlayerWeaponData(playerid,7,gun[7][playerid],ammoo[7][playerid]);
GetPlayerWeaponData(playerid,8,gun[8][playerid],ammoo[8][playerid]);
GetPlayerWeaponData(playerid,9,gun[9][playerid],ammoo[9][playerid]);
GetPlayerWeaponData(playerid,10,gun[10][playerid],ammoo[10][playerid]);
GetPlayerWeaponData(playerid,11,gun[11][playerid],ammoo[11][playerid]);
GetPlayerWeaponData(playerid,12,gun[12][playerid],ammoo[12][playerid]);
if(IsPlayerInAnyVehicle(playerid))
{
vehicledd[playerid] = 1;
VehicleIDD[playerid] = GetPlayerVehicleID(playerid);
}
SpawnPlayer(playerid);
SetTimerEx("Devuelto", 400, false,"i", playerid);
return 1;
}
forward Devuelto(playerid);
public Devuelto(playerid){
Sync[playerid] = false;
SetPlayerPos(playerid,xx[playerid],yy[playerid],zz[playerid]);
SetPlayerFacingAngle(playerid,FaceAngle[playerid]);
SetPlayerHealth(playerid,PlayerHPP[playerid]);
SetPlayerVirtualWorld(playerid,virt[playerid]);
SetPlayerInterior(playerid,interiori[playerid]);
SetPlayerSkin(playerid,skinneg[playerid]);
SetPlayerArmour(playerid,APP[playerid]);
ResetPlayerWeapons(playerid);
for(new i; i < 9; i++){
if( IsValidWeapon(gun[i][playerid]) ) {
GivePlayerWeapon(playerid,gun[i][playerid],ammoo[i][playerid]);
}
}//GivePlayerWeapon(playerid,gun[9][playerid],ammoo[9][playerid]);
//GivePlayerWeapon(playerid,gun[10][playerid],ammoo[10][playerid]);
//GivePlayerWeapon(playerid,gun[11][playerid],ammoo[11][playerid]);
//GivePlayerWeapon(playerid,gun[12][playerid],ammoo[12][playerid]);
//if(vehicledd[playerid] == 1) { PutPlayerInVehicle(playerid,VehicleIDD[playerid],1); vehicledd[playerid] = 0; }
return 1;
}


forward ResetPlayerMoneyEx(playerid);
public ResetPlayerMoneyEx(playerid)
{
	MoneyEx[playerid] = 0;
	return 1;
}
public SetPlayerVarMoneyE(playerid, value)
{
	MoneyEx[playerid] = value;
	return 1;
}

public GetPlayerVarMoneyE(playerid)
	return MoneyEx[playerid];

COMMAND:tban(playerid, params[])
{
	if(IsPlayerConnected(playerid)){
	 SendClientMessage(playerid, -1, "CMD DESACTIVADO POR GustavoFuentes");
	 return 1;
	 }
	if (PlayerInfo[playerid][Level] >= 3)
	{
	    new
	        Indexe,
     		numdays,

	        giveplayerid,
	        string[128];

		new Index, giveplayeride[256], numdayse[256], reason[256]; giveplayeride = strtok(params,Indexe), numdayse = strtok(params,Indexe), reason = strtok(params,Indexe);

		if(!strlen(giveplayeride) || !strlen(numdayse) || !strlen(reason)) return SendClientMessage(playerid, ORANGE, "USAGE: /tempban [id] [days] [reason]");
		if(!IsNumeric(numdayse)) return SendClientMessage(playerid, ORANGE, "USAGE: /tempban [id] [days] [reason]");
	
		numdays = strval(numdayse);
		giveplayerid = strval(giveplayeride);
		if(PlayerInfo[playerid][Level] < PlayerInfo[giveplayerid][Level]) return SendClientMessage(playerid,red,"ERROR: You cannot use this command on this admin");

		if(IsPlayerConnected(giveplayerid))
		{
			new
				ip[15];
			GetPlayerIp(giveplayerid, ip, 15);
			new File:tempban = fopen("TempBans.ban", io_append);
			if (tempban)
			{
   				new year,month,day;
			    getdate(year, month, day);
			    day += numdays;

		    	if (IsMonth31(month))
		    	{
       				if (day > 31)
		        	{
           				month += 1;
			            if (month > 12)
			            {
               				year += 1;
			                while(day > 31) day -= 31;
			            }
			            else while(day > 31) day -= 31;
			        }
			    }
			    else if (!IsMonth31(month))
			    {
       				if (day > 30)
			        {
           				month += 1;
			            if (month > 12)
			            {
               				year += 1;
			                while(day > 30) day -= 30;
			            }
			            else while(day > 30) day -= 30;
			        }
			    }
			    else if (!IsMonth31(month) && IsMonth29(year) && month == 2)
			    {
       				if (day > 29)
			        {
           				month += 1;
		            	if (month > 12)
			            {
               				year += 1;
		                	while(day > 29) day -= 29;
			            }
			            else while(day > 29) day -= 29;
			        }
			    }
			    else if (!IsMonth31(month) && !IsMonth29(year) && month == 2)
			    {
       				if (day > 28)
			        {
           				month += 1;
			            if (month > 12)
			            {
               				year += 1;
			                while(day > 28) day -= 28;
			            }
			            else while(day > 28) day -= 28;
			        }
			    }
			    format(string, sizeof string, "%d|%d|%d|%s\n", day, month, year, ip);
				SendClientMessageToAll(-1, string);
			    fwrite(tempban, string);
			    fclose(tempban);
			}
			format(string,128,"Administrator %s baneo temporalmente a %s por %d dia(s). [Razón: %s]",PlayerName2(playerid),PlayerName2(giveplayerid),numdays,reason);
			CMDMessageToAdmins(playerid, "TBAN");
			SendClientMessageToAll(ADMIN_RED,string);
			SetTimerEx("Kickeate", 2000, 0, "i",giveplayerid);
		}
		else SendClientMessage(playerid, RED, "Player not found!");
	}
	else SendClientMessage(playerid, RED, "You are not an admin.");
	return true;
}

function Kickeate(giveplayerid){
return Kick(giveplayerid);}

function KickeateX(playerid, ban_day,ban_month, ban_year){
				if(!IsPlayerConnected(playerid)) return 1;
				new str[128];
    			format(str, sizeof str, "***Info: usted fue {FFFFFF}Baneado temporalmente{FF0000} en el servidor: hasta el {FFFFFF}%d/%d/%d{FF0000} ", ban_day, ban_month, ban_year);
	    	    SendClientMessage(playerid, ADMIN_RED, str);
				SendClientMessage(playerid, COLOR_SYSTEM, "Sí cree que fue un error repórtelo a www.facebook.com/PuraJodaFreeroam");
                GameTextForPlayer(playerid,"~r~~h~Estas Baneado Temporalmente",30000,3);
                Adentro[playerid] = 52;
                SetTimerEx("Kickeate", 2000, 0, "i", playerid);

return 1;
}






