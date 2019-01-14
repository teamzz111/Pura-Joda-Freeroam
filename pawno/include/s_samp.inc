/*Proyecto iniciado el 08/02/2015 a las 04:32am
Varias de estas funciones fueron recopiladas de algunos FS y post de pawnoscript y samp.forums,creditos a sus creadores.
Tambien algunas funciones fueron creadas por mi.
*/


stock CreateVehicleToPlayer(playerid, vehicleid)//by enzomtlc,modificada por smoke
{
new Float:PosX, Float:PosY, Float:PosZ, Float:Angulo;
GetPlayerPos(playerid, PosX, PosY, PosZ);
GetPlayerFacingAngle(playerid, Angulo); 
CreateVehicle(vehicleid, PosX, PosY, PosZ, Angulo, -1, -1, -1); 
PutPlayerInVehicle(playerid, vehicleid, 0);
return 1;
}

stock GivePlayerScore(playerid, score)//by dx2
{
    SetPlayerScore(playerid, GetPlayerScore(playerid) + score);
}

stock RemovePlayerScore(playerid, score)// by dx2
{
    SetPlayerScore(playerid, GetPlayerScore(playerid) - score);
}


stock TeleportPlayer(playerid, Float:x,Float:y,Float:z)//Creditos desconocidos,si alguien conoce quien la creo originalmente que me lo diga
{
    new cartype = GetPlayerVehicleID(playerid);
    new State=GetPlayerState(playerid);
    if(State!=PLAYER_STATE_DRIVER)
    {
        SetPlayerPos(playerid,x,y,z);
    }
    else if(IsPlayerInVehicle(playerid, cartype) == 1)
    {
        SetVehiclePos(cartype,x,y,z);
    }
    else
    {
        SetPlayerPos(playerid,x,y,z);
    }
}

stock CrashPlayer(playerid)//Creditos Dan_Barocu ,modificado por smoke.
	{
	ApplyAnimation(playerid,"pawnoscript", "M_smkasdf_loop_", 4.0, 1, 0, 0, 0, 0);
	ApplyAnimation(playerid,"offdad", "M_sasfloop_", 4.0, 1, 0, 0, 0, 0);
	ApplyAnimation(playerid,"byesxd", "sdgsdf_", 4.0, 1, 0, 0, 0, 0);
	GameTextForPlayer(playerid, "븻때!$$%&'()*+,-./01~!@#$^&*()_-+={[}]:;'<,>.?/", 1000, 0);
 	GameTextForPlayer(playerid, "븻때!$$%&'()*+,-./01~!@#$^&*()_-+={[}]:;'<,>.?/", 2000, 1);
  	GameTextForPlayer(playerid, "븻때!$$%&'()*+,-./01~!@#$^&*()_-+={[}]:;'<,>.?/", 3000, 2);
  	GameTextForPlayer(playerid, "븻때!$$%&'()*+,-./01~!@#$^&*()_-+={[}]:;'<,>.?/", 4000, 3);
  	GameTextForPlayer(playerid, "븻때!$$%&'()*+,-./01~!@#$^&*()_-+={[}]:;'<,>.?/", 5000, 4);
  	GameTextForPlayer(playerid, "븻때!$$%&'()*+,-./01~!@#$^&*()_-+={[}]:;'<,>.?/", 6000, 5);
  	GameTextForPlayer(playerid, "븻때!$$%&'()*+,-./01~!@#$^&*()_-+={[}]:;'<,>.?/", 7000, 6);
	ApplyAnimation(playerid,"crasheandoxdwdq", "M_smkleafds_", 4.0, 1, 0, 0, 0, 0);
	}
	
	stock PlayerInBike(playerid)//Creado por mi
{
	if(IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	{
		if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 481 || GetVehicleModel(GetPlayerVehicleID(playerid)) == 509 || GetVehicleModel(GetPlayerVehicleID(playerid)) == 510) return 1;
	}
	return 0;
}

stock PlayerSoundForAll(SoundID)//Creditos desconocidos
{
	for(new i = 0; i < MAX_PLAYERS; i++) PlayerPlaySound(i, SoundID, 0.0, 0.0, 0.0);
}

stock SetPlayerMoney(playerid, money)//Creado por mi
{
	ResetPlayerMoney(playerid);
	GivePlayerMoney(playerid, money);
}

stock GivePlayerHealth(playerid, Float:health)//creado por mi
{
    new Float:playerhealth;
    GetPlayerHealth(playerid, playerhealth);
	SetPlayerHealth(playerid, playerhealth+health);
}

stock ClearChat(playerid, lines)//by farbod
{
	for(new i = 0; i < lines; i++)
	{
		SendClientMessage(playerid, 0xFFFFFFFF, "");
	}
}

stock ClearChatForAll(lines) //by farbod
{
	for(new i = 0; i < lines; i++)
	{
		SendClientMessageToAll(0xFFFFFFFF, "");
	}
}

stock IsVehicleMoving(vehicleid) { //by Emmet
	static
	    Float:fVelocity[3];

	GetVehicleVelocity(vehicleid, fVelocity[0], fVelocity[1], fVelocity[2]);
	return (floatcmp(fVelocity[0], 0.0) != 0 || floatcmp(fVelocity[1], 0.0) != 0 || floatcmp(fVelocity[2], 0.0) != 0);
}



stock RestartServer()//Creado por mi
{
SendRconCommand("gmx");
return 1;
}

stock CreateObjectForAllPlayer(modelid, Float:X, Float:Y, Float:Z, Float:rX, Float:rY, Float:rZ, Float:DrawDistance = 0.0)//by newbie scripter
{
    for(new i =0; i < MAX_PLAYERS; i++)
    {
        if(IsPlayerConnected(i) && i !=INVALID_PLAYER_ID)
        {
            if(modelid != INVALID_OBJECT_ID)
            {
                CreatePlayerObject(playerid, modelid, Float:X, Float:Y, Float:Z, Float:rX, Float:rY, Float:rZ, Float:DrawDistance = 0.0);
            } else return 0;
        }
    }
}

stock VehiclesNotNitro()// by cristiantdj
{
	new veh; GetVehicleModel(veh);
	new VehNitroNo[14] = {
		509, 481, 510, 462, 448, 581, 522,
		461, 521, 523, 463, 586, 468, 471
	};

	for (new i = 0; i < 14; i++)
	{
	    if (veh == VehNitroNo[i]) return 1;
	}
	return 0;
}

stock GetPlayerCity(playerid) // by the chaoz
{
	if(IsPlayerInArea(playerid, 2977.858, -840.807, 2989.536, 513.8265))return 0;
	else if(IsPlayerInArea(playerid, -759.0619, -3188.06, 2954.502, -3258.127))return 1;
	else if(IsPlayerInArea(playerid, 2954.502, -618.9274, 537.1823, -3293.161))return 2;
	else return -1;
}
/*
0	Las Venturas
1	San Fierro
2	Los Santos
-1	Agua
*/

stock PlayerInRangeOfObject(playerid, objectid, rango) // by admantis
{
    new Float:fOX, Float:fOY, Float:fOZ;
    GetObjectPos(objectid, fOX, fOY, fOZ);
    if (IsPlayerInRangeOfPoint(playerid, rango, fOX, fOY, fOZ)) return 1;
    return 0;
}

stock ConvertNemesis(playerid)// by smoke
{
SetPlayerHealth(playerid,10000);
GivePlayerWeapon(playerid,35,100);
SetPlayerSkin(playerid,57);
return 1;
}

stock GetClosestVehicle(playerid, Float:range)// by CrossOver,OBTENER LA ID DEL VEHICULO MAS CERCANO AL JUGADOR
{
    new     Float:p_X;
    new     Float:p_Y;
    new     Float:p_Z;

    new     Float:Distance;
    new     Float:PretendentDistance = range +1;
    new     Pretendent;

    GetPlayerPos(playerid, p_X, p_Y, p_Z);

    for(new vehicleid=1; vehicleid < MAX_VEHICLES; vehicleid++)
    {
        Distance = GetVehicleDistanceFromPoint(vehicleid, p_X, p_Y, p_Z);

        if(Distance <= range && Distance <= PretendentDistance)
        {
            Pretendent = vehicleid;
            PretendentDistance = Distance;
        }
    }

    return Pretendent;
}
