/*======================================================================================================*
* This Weapon-Drop Include is made by Jeffry!                                                      		*
*                                                                                                       *
*                                                                                                       *
* Made in April 2011.                                                                                 	*
*                                                                                                       *
* Your Rights:                                                                                          *
*                                                                                                       *
* -You are allowed to modify this Include, aslong as you DO NOT remove credits or re-upload it.			*
*                                                                                                       *
* -You are NOT allowed to re-upload this Include.                                                  		*
* -You are NOT allowed to claim this as your own.                                                       *
* -You are NOT allowed to remove any credits.                                                           *
*                                                                                                       *
* Thank you.                                                                                            *
* Have fun. I would be happy if you give me /credits.  :D                                               *
* 			                                                                                            *
*=======================================================================================================*/
#include <a_samp>
//===============================================================================================================================================
//-------------------------Definitions that you may change---------------------------------------------------------------------------------------
//-----------------------------------------------------------------------------------------------------------------------------------------------
#define WEAPON_RESPAWN_TIME 30          	  // After this time the pickups get destroyed if not picked up.
#define MONEY_BAG_MONEY		 0         	 	 // -1 = Money bag ON with all player-money   0 = Money bag OFF   1+ = Money bag ON with given amount
#define MONEY_BAG_MODE       0              // 1 = Money comes from the killed player     0 = Money comes from the server
new ForbiddenWeapons[]= { 38, 44, 45 };    // Here you add the weapon IDs that you do not want to be created.
//-----------------------------------------------------------------------------------------------------------------------------------------------
//-------------------------End of the Definitions------------------------------------------------------------------------------------------------
//===============================================================================================================================================

//Variables
new WeaponDrop[MAX_PLAYERS][14];
new WeaponData[MAX_PLAYERS][14][2];
new WeaponTimer[MAX_PLAYERS];
new BagMoney = MONEY_BAG_MONEY;
new BagMode = MONEY_BAG_MODE;

//=============The Functions====================================================
stock OnWeaponDropInit()
{
	for(new i=0; i<MAX_PLAYERS; i++)
	{
		for(new a=0; a<14; a++)
		{
		    WeaponDrop[i][a] = -1;
		    WeaponData[i][a][0] = -1;
		    WeaponData[i][a][1] = -1;
		}
		WeaponTimer[i] = -1;
	}
	print("\n---------------------------------------");
	print("[INC] WeaponDrop v1.0 by Jeffry loaded!");
	print("---------------------------------------\n");
	return 1;
}

stock OnWeaponDropPickup(playerid, pickupid)
{
	for(new i=0; i<MAX_PLAYERS; i++)
	{
		for(new a=0; a<13; a++)
		{
		    if(WeaponDrop[i][a] == pickupid)
		    {
		        WeaponDrop[i][a] = -1;
		        DestroyPickup(pickupid);
		        GivePlayerWeapon(playerid, WeaponData[i][a][0], WeaponData[i][a][1]);
		    	WeaponData[i][a][0] = -1;
		    	WeaponData[i][a][1] = -1;
		    }
		}
		if(WeaponDrop[i][13] == pickupid)
		{
	        WeaponDrop[i][13] = -1;
	        DestroyPickup(pickupid);
		    GivePlayerMoney(playerid, WeaponData[i][13][0]);
	    	WeaponData[i][13][0] = -1;
	    	WeaponData[i][13][1] = -1;
		}
	}

	return 1;
}

stock OnWeaponDrop(playerid)
{
    RemovePickups(playerid);
	new Float:x, Float:y, Float:z, dropped;
	GetPlayerPos(playerid,x,y,z);
	for(new i=0; i<13; i++)
	{
	    new weapon, ammo;
	    GetPlayerWeaponData(playerid, i, weapon, ammo);
	    if((ammo > 0 || weapon == 1) && weapon != 0)
	    {
			new model = GetModel(weapon);
			if(model != -1)
			{
	        	WeaponData[playerid][i][0] = weapon;
	        	WeaponData[playerid][i][1] = ammo;
	        	dropped++;
			}
	    }
	}
	if(BagMoney != 0)
	{
	    if(BagMoney == -1 && GetPlayerMoney(playerid) > 0)
		{
			WeaponData[playerid][13][0] = GetPlayerMoney(playerid);
			if(BagMode) GivePlayerMoney(playerid, -WeaponData[playerid][13][0]);
			WeaponDrop[playerid][13] = CreatePickup(1550, 1, x, y, z);
			if(dropped <= 0) dropped=1;
		}
		if(BagMoney > 0)
		{
			WeaponData[playerid][13][0] = BagMoney;
			if(BagMode) GivePlayerMoney(playerid, -WeaponData[playerid][13][0]);
			WeaponDrop[playerid][13] = CreatePickup(1550, 1, x, y, z);
			if(dropped <= 0) dropped=1;
		}
	}
	if(dropped > 0)
	{
	    new radius;
	    if(dropped < 3) radius = 1;
		if(dropped < 6) radius = 2;             /*If you want another radius, change it here.*/
		if(dropped < 9) radius = 3;
		if(dropped > 8) radius = 4;
		new Float:degree, Float:tmp;
		degree = 360.0 / (float(dropped));
		tmp = degree;
		if(WeaponTimer[playerid] != -1) KillTimer(WeaponTimer[playerid]);
		WeaponTimer[playerid] = SetTimerEx("RemovePickups", WEAPON_RESPAWN_TIME*1000, 0, "d", playerid);
	    for(new i=0; i<13; i++)
		{
		    if((WeaponData[playerid][i][1] > 0 || WeaponData[playerid][i][0] == 1) && WeaponData[playerid][i][0] > 0)
		    {
				new model = GetModel(WeaponData[playerid][i][0]);
				if(model != -1)
				{
				    WeaponDrop[playerid][i] = CreatePickup(model, 1, x+(floatsin(degree, degrees)*radius), y+(floatcos(degree, degrees)*radius), z);
					degree = degree + tmp;
				}
		    }
		}
	}
	return 1;
}

stock GetModel(weaponid)
{
	for(new i=0; i<sizeof(ForbiddenWeapons); i++)
	{
		if(weaponid == ForbiddenWeapons[i])
		{
			return -1;
		}
	}
	switch(weaponid)
	{
	    case 1: return 331;
	    case 2: return 333;
	    case 3: return 334;
	    case 4: return 335;
	    case 5: return 336;
	    case 6: return 337;
	    case 7: return 338;
	    case 8: return 339;
	    case 9: return 341;
	    case 10: return 321;
	    case 11: return 322;
	    case 12: return 323;
	    case 13: return 324;
	    case 14: return 325;
	    case 15: return 326;
	    case 16: return 342;
	    case 17: return 343;
	    case 18: return 344;
	    case 22: return 346;
	    case 23: return 347;
	    case 24: return 348;
	    case 25: return 349;
	    case 26: return 350;
	    case 27: return 351;
	    case 28: return 352;
	    case 29: return 353;
	    case 30: return 355;
	    case 31: return 356;
	    case 32: return 372;
	    case 33: return 357;
	    case 34: return 358;
	    case 35: return 359;
	    case 36: return 360;
	    case 37: return 361;
	    case 38: return 362;
	    case 39: return 363;
	    case 40: return 364;
	    case 41: return 365;
	    case 42: return 366;
	    case 43: return 367;
	    case 44: return 368;
	    case 45: return 369;
	    case 46: return 371;
		default: return -1;
	}
	return -1;
}

forward RemovePickups(playerid);
public RemovePickups(playerid)
{
	if(WeaponTimer[playerid] != -1) KillTimer(WeaponTimer[playerid]);
	WeaponTimer[playerid] = -1;
	for(new a=0; a<14; a++)
	{
	    if(WeaponDrop[playerid][a] != -1)
	    {
	        DestroyPickup(WeaponDrop[playerid][a]);
	        WeaponDrop[playerid][a] = -1;
	 		WeaponData[playerid][a][0] = -1;
	    	WeaponData[playerid][a][1] = -1;
	    }
	}
	return 1;
}