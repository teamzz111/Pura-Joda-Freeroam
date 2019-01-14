/**
* © Coffeely, 2014.
* Please leave author's credits.

* This work is licensed under the Creative
* Commons Attribution-NonCommercial-NoDerivs 3.0 Unported License.
* To view a copy of this license,
* visit http://creativecommons.org/licenses/by-nc-nd/3.0/.

* I'd advice you not to change anything unless you are sure of what you are doing.
                                                                                                                                                                                                                                                                                                                                                                                                    **/
#include <a_samp>
#pragma tabsize 0
#define FILTERSCRIPT

#if defined FILTERSCRIPT

#define VehicleHealthYellow 700
#define VehicleHealthRed 400

#define SpeedCheck(%0,%1,%2,%3,%4) floatround(floatsqroot(%4?(%0*%0+%1*%1+%2*%2):(%0*%0+%1*%1)) *%3*1.6)

forward Speedometer(playerid);

new PlayerText:VehicleName[MAX_PLAYERS]= {PlayerText:INVALID_TEXT_DRAW, ...}, PlayerText:VehicleHealth[MAX_PLAYERS]= {PlayerText:INVALID_TEXT_DRAW, ...}, PlayerText:VehicleSpeed[MAX_PLAYERS]= {PlayerText:INVALID_TEXT_DRAW, ...}, Text:Title= Text:INVALID_TEXT_DRAW, Text:Underline =Text:INVALID_TEXT_DRAW, Text:KMH = Text:INVALID_TEXT_DRAW;

new VehicleNames[][] =
{
    "Landstalker", "Bravura", "Buffalo", "Linerunner", "Perrenial", "Sentinel", "Dumper", "Firetruck",
	"Trashmaster", "Stretch", "Manana", "Infernus", "Voodoo", "Pony", "Mule", "Cheetah",
    "Ambulance", "Leviathan", "Moonbeam", "Esperanto", "Taxi", "Washington", "Bobcat", "Mr Whoopee",
    "BF Injection", "Hunter", "Premier", "Enforcer", "Securicar", "Banshee", "Predator", "Bus",
    "Rhino", "Barracks", "Hotknife", "Article Trailer", "Previon", "Coach", "Cabbie", "Stallion",
    "Rumpo", "RC Bandit", "Romero", "Packer", "Monster", "Admiral", "Squallo", "Seasparrow",
    "Pizzaboy", "Tram", "Article Trailer 2", "Turismo", "Speeder", "Reefer", "Tropic", "Flatbed",
    "Yankee", "Caddy", "Solair", "Berkley's RC Van", "Skimmer", "PCJ-600", "Faggio", "Freeway",
    "RC Baron", "RC Raider", "Glendale", "Oceanic", "Sanchez", "Sparrow", "Patriot", "Quad",
    "Coastguard", "Dinghy", "Hermes", "Sabre", "Rustler", "ZR-350", "Walton", "Regina",
    "Comet", "BMX", "Burrito", "Camper", "Marquis", "Baggage", "Dozer", "Maverick",
    "SAN News Maverick", "Rancher", "FBI Rancher", "Virgo", "Greenwood", "Jetmax", "Hotring Racer", "Sandking",
    "Blista Compact", "Police Maverick", "Boxville", "Banson", "Mesa", "RC Goblin", "Hotring Racer", "Hotring Racer",
    "Bloodring Banger", "Rancher", "Super GT", "Elegant", "Journey", "Bike", "Mountain Bike", "Beagle",
    "Cropduster", "Stuntplane", "Tanker", "Roadtrain", "Nebula", "Majestic", "Buccaneer", "Shamal",
    "Hydra", "FCR-900", "NRG-500", "HPV1000", "Cement Truck", "Towtruck", "Fortune", "Cadrona",
    "FBI Truck", "Willard", "Forklift", "Tractor", "Combine Harvester", "Feltzer", "Remington", "Slamvan",
    "Blade", "Freight (Train)", "Brownstreak (Train)", "Vortex", "Vincent", "Bullet", "Clover", "Sadler",
    "Firetruck LA", "Hustler", "Intruder", "Primo", "Cargobob", "Tampa", "Sunrise", "Merit",
    "Utility Van", "Nevada", "Yosemite", "Windsor", "Monster A", "Monster B", "Uranus", "Jester",
    "Sultan", "Stratum", "Elegy", "Raindance", "RC Tiger", "Flash", "Tahoma", "Savanna",
    "Bandito", "Freight Flat Trailer", "Brownstreak Trailer", "Kart", "Mower", "Dune", "Sweeper", "Broadway",
    "Tornado", "AT400", "DFT-30", "Huntley", "Stafford", "BF-400", "Newsvan", "Tug",
    "Petrol Trailer", "Emperor", "Wayfarer", "Euros", "Hotdog", "Club", "Freight Box Trailer", "Article Trailer 3",
    "Andromada", "Dodo", "RC Cam", "Launch", "Police Cruiser (LSPD)", "Police Cruiser (SFPD)", "Police Cruiser (LVPD)", "Police Ranger",
    "Picador", "S.W.A.T", "Alpha", "Phoenix", "Glendale Shit", "Sadler Shit", "Baggage Trailer A", "Baggage Trailer B",
    "Tug Stairs Trailer", "Boxville", "Farm Trailer", "Utility Trailer"
};

public OnFilterScriptInit()
{
    print("\n Coffeely's Speedometer loading...");
	print("\n \t cSpeedometer Loaded.");

//	SetTimer("Speedometer", 200, true);
	
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
	

    return 1;
}
public OnFilterScriptExit()
{
    print("\n Coffeely's Speedometer unloading...");
	print("\n \t cSpeedometer Unloaded.");
	
	TextDrawHideForAll(Underline);
	TextDrawDestroy(Underline);
	TextDrawHideForAll(Title);
	TextDrawDestroy(Title);
	TextDrawHideForAll(KMH);
	TextDrawDestroy(KMH);
	
/*	for(new i = 0; i < GetMaxPlayers(); i++)
	{
		PlayerTextDrawDestroy(VehicleName[i]);
		PlayerTextDrawDestroy(VehicleHealth[i]);
		PlayerTextDrawDestroy(VehicleSpeed[i]);
	}*/
	return 1;
}
public OnPlayerConnect(playerid){

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

return 1;
}
new ea[MAX_PLAYERS];
public OnPlayerStateChange(playerid, newstate, oldstate)
{
	if(newstate == PLAYER_STATE_DRIVER || newstate == PLAYER_STATE_PASSENGER)
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
	   // }
	}
	else if(oldstate == PLAYER_STATE_DRIVER || oldstate == PLAYER_STATE_PASSENGER)
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
}
new string[32], string2[32], string3[10], Float:vhealth;

public Speedometer(playerid)
{
	if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 0) return 1;
			format(string, sizeof(string), "~r~~h~%s", VehicleNames[GetVehicleModel(GetPlayerVehicleID(playerid))-400]);
			PlayerTextDrawSetString(playerid,VehicleName[playerid], string);
			
			format(string2, sizeof(string2), "%d", GetPlayerSpeed(playerid, 0));
			PlayerTextDrawSetString(playerid,VehicleSpeed[playerid], string2);
			
			GetVehicleHealth(GetPlayerVehicleID(playerid), vhealth);
			format(string3, sizeof(string3), "~%s~~h~%.0f.0", DamageColor(vhealth), vhealth);
			PlayerTextDrawSetString(playerid,VehicleHealth[playerid], string3);

	return 1;
}

stock DamageColor(Float: health)
{
	new string[5];
	if (health <= VehicleHealthRed)
		format(string, sizeof(string), "r");
	else if (health < VehicleHealthYellow)
	    format(string, sizeof(string), "y");
	else
	    format(string, sizeof(string), "g");
	return string;
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

#endif
