// This is a comment
// uncomment the line below if you want to write a filterscript
#define FILTERSCRIPT

#include <a_samp>
#include <lethaldudb2>//LethaL

native WP_Hash(buffer[], len, const str[]); //Y_Less' Whirlpool
#if defined FILTERSCRIPT
new DB:LadminDB;
new DB:ladmin;
public OnFilterScriptInit()
{
	print("\n--------------------------------------");
	print(" Blank Filterscript by your name here");
	print("--------------------------------------\n");
	LadminDB = db_open("lUser.db");
	ladmin = db_open("DataServer.db");
	return 1;
}

public OnFilterScriptExit()
{
	return 1;
}

#else

main()
{
	print("\n----------------------------------");
	print(" Blank Gamemode by your name here");
	print("----------------------------------\n");
	new string[500],field[40],data[10],name[24],pass[50];
	format(string, 500, "SELECT * FROM user");
	new DBResult:r = db_query(LadminDB, string), DBResult:e;
	do{
	db_get_field_assoc(r, "pName", name, 24);
    format(string, 500, "SELECT username FROM users WHERE username = '%s'",name);
	e = db_query(ladmin, string);
	if(db_num_rows(e)){
	db_get_field_assoc(r, "pMoney", field, 40);
	data[0] = strval(field);
	db_get_field_assoc(r, "pDeath", field, 40);
	data[1] = strval(field);
	db_get_field_assoc(r, "pKills", field, 40);
	data[2] = strval(field);
	db_get_field_assoc(r, "pPass", field, 40);
	data[2] = strval(field);
	format(string, 500, "UPDATE username SET score = '%d', money = '%d', deaths = '%d' WHERE username = '%s'", data[2],data[0],data[1],name);
	db_free_result(db_query(ladmin, string));
	}
	else {
		format(string, sizeof(string),
		"INSERT INTO `config` (`username`,`expnivel`,`nombreanterior`, `exp`, `configlogin`, `autofix`, `autospawn`, `ateleports`, `armaspreterminadas`, `barrastats`,`raceswin`, `raceslose`, `scoreevento`, `cartefactos`, `headshots`, `crecompensas`, `cdamage`, `killsdm`, `puntosdm`, `kicks`, `pnivel`, `nivel`, `combos`,`velocidad`,`saltos`,`wduelos`,`lloduelos`,`genero`,`vflip`,`pospawn`,`noclan`) VALUES ('%s',0,'Ninguno',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,1)",name);
		format(string, sizeof(string),
				"INSERT INTO `users` (`username`, `IP`, `joindate`, `password`, `description`, `admin`, `helper`, `vip`, `expirevip`, `kills`, `deaths`, `math`, `mb`, `cp`, `react`, `score`, `money`, `hours`, `minutes`, `seconds`, `premiumpoints`, `muted`, `mutesec`, `cmuted`, `cmutesec`, `warnings`, `jail`, `jailsec`, `rated`, `hs`, `sskin`, `uskin`, `wet`,`monedas`) VALUES ('%s','0.0.0.0','11/02/2017','%s','Pura Joda Freeroam Forever',0,0,0,0,0,0,0,0,0,0,%d,%d,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0)",\
					name,
			
				
					hashpass,
					PlayerInfoSQL[playerid][accountScore],
					PlayerInfoSQL[playerid][accountCash]
			 	);
			 	format(PlayerInfoSQL[playerid][accountDescp], 100, "Jugador de Pura Joda Freeroam");
			 	db_query(Database, query);
	}

	 }while(db_next_row(r));
}

#endif

public OnGameModeInit()
{
	// Don't use these lines if it's a filterscript
	SetGameModeText("Blank Script");
	AddPlayerClass(0, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	return 1;
}

public OnGameModeExit()
{
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
	SetPlayerPos(playerid, 1958.3783, 1343.1572, 15.3746);
	SetPlayerCameraPos(playerid, 1958.3783, 1343.1572, 15.3746);
	SetPlayerCameraLookAt(playerid, 1958.3783, 1343.1572, 15.3746);
	return 1;
}

public OnPlayerConnect(playerid)
{
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	return 1;
}

public OnPlayerSpawn(playerid)
{
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	return 1;
}

public OnVehicleSpawn(vehicleid)
{
	return 1;
}

public OnVehicleDeath(vehicleid, killerid)
{
	return 1;
}

public OnPlayerText(playerid, text[])
{
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	if (strcmp("/mycommand", cmdtext, true, 10) == 0)
	{
		// Do something here
		return 1;
	}
	return 0;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	return 1;
}

public OnPlayerEnterCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveCheckpoint(playerid)
{
	return 1;
}

public OnPlayerEnterRaceCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveRaceCheckpoint(playerid)
{
	return 1;
}

public OnRconCommand(cmd[])
{
	return 1;
}

public OnPlayerRequestSpawn(playerid)
{
	return 1;
}

public OnObjectMoved(objectid)
{
	return 1;
}

public OnPlayerObjectMoved(playerid, objectid)
{
	return 1;
}

public OnPlayerPickUpPickup(playerid, pickupid)
{
	return 1;
}

public OnVehicleMod(playerid, vehicleid, componentid)
{
	return 1;
}

public OnVehiclePaintjob(playerid, vehicleid, paintjobid)
{
	return 1;
}

public OnVehicleRespray(playerid, vehicleid, color1, color2)
{
	return 1;
}

public OnPlayerSelectedMenuRow(playerid, row)
{
	return 1;
}

public OnPlayerExitedMenu(playerid)
{
	return 1;
}

public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid)
{
	return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	return 1;
}

public OnRconLoginAttempt(ip[], password[], success)
{
	return 1;
}

public OnPlayerUpdate(playerid)
{
	return 1;
}

public OnPlayerStreamIn(playerid, forplayerid)
{
	return 1;
}

public OnPlayerStreamOut(playerid, forplayerid)
{
	return 1;
}

public OnVehicleStreamIn(vehicleid, forplayerid)
{
	return 1;
}

public OnVehicleStreamOut(vehicleid, forplayerid)
{
	return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	return 1;
}

public OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
	return 1;
}
