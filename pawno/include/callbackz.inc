/*
|===============================================================================|
|                                                               Callbackz                                       |
|Description:                                                                   |
|       This include adds new callbacks and functions to your script.               |
|                                                                               |
|Current Callbacks                                                              |
|       OnPlayerPause(playerid)                                                         |
|       OnPlayerAFK(playerid)                                                           |
|       OnPlayerWeaponChange(playerid, newweaponid, oldweaponid)                        |
|       OnPlayerVirtualWorldChange(playerid, newworldid, oldworldid)                    |
|       OnPlayerEnterWater(playerid)                                                    |
|       OnPlayerExitWater(playerid)                                                     |
|       OnPlayerHealthChange(playerid, Float:newhealth, Float:oldhealth)                |
|       OnPlayerArmourChange(playerid, Float:newarmour, Float:oldarmour)                |
|       OnPlayerMoneyChange(playerid, newmoney, oldmoney)                                                       |
|       OnPlayerUseVendingMachine(playerid)                                             |
|       OnPlayerPlayAnimation(playerid, Lib[], Name[])                                                          |
|       OnPlayerScoreChange(playerid, newscore, oldscore)                                                       |
|       OnVehicleCreate(vehicleid)                                                                                                      |
|       OnVehicleDestroy(vehicleid)                                                                                                     |
|   OnPlayerStartDriveby(playerid, ispassenger)                                 |
|   OnPlayerEndDriveby(playerid)                                                |
|                                                                               |
|Current Functions:                                                             |
|       Player Functions:                                                               |
|           Single Player:                                                              |
|                       SetPlayerAFK(playerid, bool:afk)                                        |
|                       IsPlayerAFK(playerid)                                                   |
|                       IsPlayerPaused(playerid)                                                |
|                       IsPlayerInWater(playerid)                                               |
|                       IsPlayerParachuting(playerid)                                           |
|                       IsPlayerUsingMachine(playerid)                                          |
|                       EnablePlayerDriveBy(playerid, bool:enable)                              |
|                       EnablePlayerInteriorDamage(playerid, bool:enable)                       |
|                       CrashPlayer(playerid)                                                   |
|                       GetPlayerFPS(playerid)                                                  |
|                       Reconnect(playerid)                                                     |
|                       ReconnectEx(playerid, time)                                             |
|                       EnableVendingMachinesForPlayer(playerid, bool:enable)                   |
|                       EnableCapsForPlayer(playerid, bool:enable)                              |
|                       GivePlayerScore(playerid, score)                                        |
|           SetPlayerFacingPos(playerid, Float:X, Float:Y)                      |
|                                                                               |
|               All Players:                                                            |
|                       EnableDriveBy(bool:enable)                                              |
|                       EnableInteriorDamage(bool:enable)                                       |
|                       EnableUseVendingMachines(bool:enable)                                   |
|                       EnableCapsLock(bool:enable)                                             |
|                                                                               |
|       Vehicle Functions:                                                              |
|           Single Vehicle:                                                             |
|                       GetVehiclePlate(vehicleid, Plate[], size)                               |
|                       GetVehicleColor(vehicleid, &color1, &color2)                            |
|                       GetVehicleInterior(vehicleid)                                           |
|                       GetVehicleIDFromPlate(Plate[])                                          |
|                       IsVehicleCreated(vehicleid)                                             |
|                       EnableTiresDamageForVehicle(vehicleid, bool:enable)                     |
|                       GetVehicleType(model)                                                   |
|           GetVehicleRot(vehicleid, Float:X, Float:Y, Float:Z)                 |
|                                                                               |
|               All Vehicles:                                                           |
|                   EnableTiresDamage(bool:enable)                                      |
|                                                                               |
|       Extra:                                                                          |
|               GetOnlinePlayers(bool:CountNPC)                                         |
|               AddForbidenNick(nick[])                                                 |
|               AddForbidenWord(word[])                                                 |
|       GetMiddle2D(Float:x1, Float:y1, Float:x2, Float:y2, Float:rX, Float:rY) |
|       GetMiddle3D(Float:x1, Float:y1, Float:z1, Float:x2, Float:y2, Float:z2, Float:rX, Float:rY, Float:rZ)|
|                                                                               |
|ChangeLog:                                                                     |
|   17/08/2011:                                                                 |
|               *First Release (Beta).                                                  |
|   18/08/2011:                                                                 |
|       *Fixed AddStaticVehicle bub.                                            |
|       *Fixed AddStaticVehicleEx bug.                                          |
|       *Fixed CreteVehicle bug.                                                |
|   22/08/2011:                                                                 |
|       *Fixed OnPlayerPause false positive bug.                                |
|       *Fixed IsPlayerParachuting false positive bug.                          |
|               *OnPlayerUseMachine is now OnPlayerUseVendingMachine.                   |
|       *Added new callbacks:                                                   |
|                       **OnPlayerPlayAnimation                                             |
|                       **OnPlayerScoreChange                                               |
|       Added new functions:                                                    |
|                       **EnableVendingMachines                                             |
|                       **EnableVendingMachinesForPlayer                                                                        |
|                       **EnableCapsLock                                                    |
|                       **EnableCapsLockForPlayer                                                                                       |
|                       **GivePlayerScore                                                                                                       |
|                       **GetOnlinePlayers                                                      |
|   06/09/2011:                                                                 |
|       *Rewrited OnPlayerShotPlayer (wups method).                             |
|       *Rewrited part of the code, now more efficient.                         |
|       *Added the posivility to remove functions and callbacks.                |
|       *Added new functions:                                                   |
|           **AddForbidenNick                                                   |
|           **AddForbidenWord                                                   |
|           **EnableTiresDamage                                                 |
|           **EnableTiresDamageForVehicle                                       |
|           **GetVehicleType                                                    |
|   09/09/2011:                                                                 |
|       *Documented All the include.                                            |
|       *EnablePlayerDriveBy is now EnableDriveByForPlayer.                     |
|       *EnablePlayerInteriorDamage is now EnableInteriorDamageForPlayer.       |
|   12/09/2011:                                                                 |
|       *EnableCapsLock is now EnableCaps.                                      |
|               *Added new callbacks:                                                   |
|           **OnPlayerStartDriveBy                                              |
|                       **OnPlayerEndDriveBy                                                |
|       *Added new functions:                                                   |
|           **GetMiddle2D                                                       |
|           **GetMiddle3D                                                       |
|                       **SetPlayerFacingPos                                                |
|           **GetVehicleRot                                                     |
|   16/09/2011:                                                                 |
|       *Added plate[] param to vehicle creation functions                      |
|   18/09/2011:                                                                 |
|       *Removed OnPlayerShotPlayr                                              |
|                                                                               |
|Extra:                                                                         |
|       You can enable or disable some callbacks/functions by comenting some            |
|       macros on the config. This will reduce the amx size, and increase the       |
|       speed of the script.                                                                                    |
|                                                                               |
|   Config Line:    =>  187                                                     |
|                                                                               |
|Credits:                                                                       |
|       JernejL                 =>      GetPlayerFPS & Reconnect method, & encode_tires Function|
|   Stepashka       =>  GetVehicleRot Function                                  |
|       Y_Less                  =>      YSI                                                                                                             |
|       The Chaoz               =>      Scripting                                               |
|                                                                               |
|===============================================================================|*/

#if !defined _CBz_INCLUDED
        #define _CBz_INCLUDED
#else
        #endinput
#endif

#include <YSI\y_hooks>

#tryinclude <foreach>

#define PUBLIC:%0(%1)   \
        forward %0(%1); public %0(%1)

#if !defined PRESSED
        #define PRESSED(%0) \
                (((newkeys & (%0)) == (%0)) && ((oldkeys & (%0)) != (%0)))
#endif
#if !defined RELEASED
    #define RELEASED(%0)        \
                (((newkeys & (%0)) != (%0)) && ((oldkeys & (%0)) == (%0)))
#endif

#if !defined LOWER
        #define LOWER(%0)       \
                for(new index; index<strlen(%0); index++)if(%0[index]>64 && %0[index]<91)%0[index] += 32
#endif

#if !defined foreach
        #define foreach(%1,%2) for(new %2; %2<GetMaxPlayers(); %2++) if(IsPlayerConnected(%2))
        #define __SSCANF_FOREACH__
#endif

#define INVALID_VEHICLE_TYPE        (-1)
#define VEHICLE_TYPE_AIRPLANE       (0)
#define VEHICLE_TYPE_HELICOPTER     (1)
#define VEHICLE_TYPE_BIKE           (2)
#define VEHICLE_TYPE_CONVERTIBLE    (3)
#define VEHICLE_TYPE_INDUSTRIAL     (4)
#define VEHICLE_TYPE_LOWRIDER       (5)
#define VEHICLE_TYPE_OFFROAD        (6)
#define VEHICLE_TYPE_PUBLICSERV     (7)
#define VEHICLE_TYPE_SALOON         (8)
#define VEHICLE_TYPE_SPORT          (9)
#define VEHICLE_TYPE_STATION        (10)
#define VEHICLE_TYPE_BOAT           (11)
#define VEHICLE_TYPE_TRAILER        (12)
#define VEHICLE_TYPE_UNIQUE         (13)
#define VEHICLE_TYPE_RC             (14)

#define PAUSE_TIME                                      (5)

//==================================CONFIG=================================
#define AFK_TIME                                (30)
#define INTERVAL                                (350)
#define MAX_BWORDS                                      (400)
#define MAX_BNAMES                                      (100)
#define ENGLISH                         //comment this line to use spanish languaje on messajes
#define USE_VEHICLE_DATA        //coment this line to disable vehicle callbacks & functions
//=========================================================================

enum _I{
        bool:pAFK,
        bool:pPaused,
        bool:pInWater,
        bool:pParachuting,
        bool:pMachine,
        bool:pDriveBy,
        bool:pIntDamage,
        bool:pReconnect,
        bool:pUseMachine,
        bool:pPlayingAnim,
        bool:pCaps,
        bool:pVend,
        bool:pDBing,
        Float:pP[4],
        pTimer,
        pTime[2],
        pWeap,
        pVWorld,
        Float:pHealth,
        Float:pArmour,
        pMoney,
        pScore,
        pWeaps[13],
        pAmmo[13],
        pFPS,
        pDrk,
        pIP[16],
};

#if defined USE_VEHICLE_DATA
        enum _V{
                bool:vCreated,
                bool:vTires,
            vColor[2],
            vPlate[32],
            vInterior,
        };
#endif

enum _S{
        bool:sDriveby=true,
        bool:sCaps=true,
        bool:sVending=true,
        bool:sIntDamage=true
};

new I[MAX_PLAYERS][_I], S[_S], File:Fhnd,
    #if defined USE_VEHICLE_DATA
                V[MAX_VEHICLES+1][_V],
        #endif
        bWordsC, bWords[MAX_BWORDS][16],
        bNamesC, bNames[MAX_BNAMES][MAX_PLAYER_NAME];

forward OnPlayerPause(playerid);
forward OnPlayerAFK(playerid);
forward OnPlayerWeaponChange(playerid, newweaponid, oldweaponid);
forward OnPlayerVirtualWorldChange(playerid, newworldid, oldworldid);
forward OnPlayerEnterWater(playerid);
forward OnPlayerExitWater(playerid);
forward OnPlayerHealthChange(playerid, Float:newhealth, Float:oldhealth);
forward OnPlayerArmourChange(playerid, Float:newarmour, Float:oldarmour);
forward OnPlayerMoneyChange(playerid, newmoney, oldmoney);
forward OnPlayerUseVendingMachine(playerid);
forward OnPlayerPlayAnimation(playerid, Lib[], Name[]);
forward OnPlayerScoreChange(playerid, newscore, oldscore);
forward OnPlayerStartDriveBy(playerid, ispassenger);
forward OnPlayerEndDriveBy(playerid);
#if defined USE_VEHICLE_DATA
        forward OnVehicleCreate(vehicleid);
        forward OnVehicleDestroy(vehicleid);
#endif

/*==============================
Function:
        SetPlayerAFK

Params:
        playerid => ID of the player.
        afk => true/false (true Player is now afk, otherwise false)

Return:
        1 if success

Related Functions:
        IsPlayerAFK

Related Callbacks:
        OnPlayerAFK

Extra:
        -
==============================*/
stock SetPlayerAFK(playerid, bool:afk)
{
        I[playerid][pAFK] = afk;
        return 1;
}

/*==============================
Function:
        IsPlayerAFK

Params:
        playerid => ID of the player.

Return:
        true if the player is afk, otherwise false.

Related Fctunions:
        SetPlayerAFK

Related Callbacks:
        OnPlayerAFK

Extra:
        -
==============================*/
stock IsPlayerAFK(playerid)
        return I[playerid][pAFK];

/*==============================
Function:
        IsPlayerPaused

Params:
        playerid => ID of the player

Return:
        true if the player is paused, otherwise false.

Related Functions:
        -
Related Callbacks:
        OnPlayerPause

Extra:
        -
==============================*/
stock IsPlayerPaused(playerid)
        return I[playerid][pPaused];

/*==============================
Function:
        IsPlayerInWater

Params:
        playerid => ID of the player

Return:
        true if the player is on water, otherwise false.

Related Functions:
        -

Related Callbacks:
        OnPlayerEnterWater
        OnPlayerExitWater

Extra:
        -
==============================*/
stock IsPlayerInWater(playerid)
        return I[playerid][pInWater];

/*==============================
Function:
        IsPlayerParachuting

Params:
        playerid => ID of the player

Return:
        true if the player is falling with a parachute, otherwise false.

Related Functions:
        -

Related Callbacks:
        -

Extra:
        -
==============================*/
stock IsPlayerParachuting(playerid)
        return I[playerid][pParachuting];

/*==============================
Function:
        IsPlayerUsingMachine

Params:
        playerid => ID of the player

Return:
        true if the player is using a vending machine, otherwise false.

Related Functions:
        -

Related Callbacks:
        OnPlayerUseVendingMachine

Extra:
        -
==============================*/
stock IsPlayerUsingMachine(playerid)
        return I[playerid][pMachine];

/*==============================
Function:
        EnableDriveByForPlayer

Params:
        playerid => ID of the player
        enable => true/false (true will allow the player drive by, otherwise false)

Return:
        1 if success

Related Functions:
        EnableDriveBy

Related Callbacks:
        -

Extra:
        -
==============================*/
stock EnablerDriveByForPlayer(playerid, bool:enable)
{
        I[playerid][pDriveBy] = enable;
        return 1;
}

/*==============================
Function:
        EnableDriveBy

Params:
        enable => true/false (true will allow the player drive by, otherwise false)

Return:
        1 if success

Related Functions:
        EnableDriveByForPlayer

Related Callbacks:
        -

Extra:
        -
==============================*/
stock EnableDriveBy(bool:enable)
{
        foreach(Player, i)I[i][pDriveBy] = enable;
        S[sDriveBy] = enable;
        return 1;
}

/*==============================
Function:
        EnableInteriorDamageForPlayer

Params:
        playerid => ID of the player
        enable => true/false (true will allow the player to shot on interiors, otherwise false)

Return:
        1 if success

Related Functions:
        EnableInteriorDamage

Related Callbacks:
        -

Extra:
        -
==============================*/
stock EnableInteriorDamageForPlayer(playerid, bool:enable)
{
    I[playerid][pIntDamage] = enable;
    return 1;
}

/*==============================
Function:
        EnableInteriorDamage

Params:
        enable => true/false (true will allow the player to shot on interiors, otherwise false)

Return:
        1 if success

Related Functions:
        EnableInteriorDamageForPlayer

Related Callbacks:
        -

Extra:
        -
==============================*/
stock EnableInteriorDamage(bool:enable)
{
        foreach(Player, i)I[i][pIntDamage] = enable;
        sIntDamage = enable;
        return 1;
}

/*==============================
Function:
        EnableVendingMachinesForPlayer

Params:
        playerid => ID of the player
        enable => true/false (true will allow the player to use vending machines, otherwise false)

Return:
        1 if success

Related Functions:
        EanbleVendingMachines

Related Callbacks:
        OnPlayerUseVendingMachine

Extra:
        -
==============================*/
stock EnableVendingMachinesForPlayer(playerid, bool:enable)
{
        I[playerid][pUseMachine] = enable;
        return 1;
}

/*==============================
Function:
        EnableUseVendingMachines

Params:


Return:
        1 is success

Related Functions:
        EnableVendingMachinesForPlayer

Related Callbacks:
        OnPlayerUseVendingMachine

Extra:
        -
==============================*/
stock EnableUseVendingMachines(bool:enable)
{
        foreach(Player, i)I[i][pUseMachine] = enable;
        S[sVending] = enable;
        return 1;
}

/*==============================
Function:
        EnableCapsForPlayer

Params:
        playerid => ID of the player
        enable => true/false (true will allow the player to use caps, otherwise false)

Return:
        1 if success

Related Functions:
        EnableCaps

Related Callbacks:
        -

Extra:
        -
==============================*/
stock EnableCapsForPlayer(playerid, bool:enable)
{
        I[playerid][pCaps] = enable;
        return 1;
}

/*==============================
Function:
        EanbleCaps

Params:
        enable => true/false (true will allow the player to use caps, otherwise false)

Return:
        1 if success

Related Functions:
        EnableCapsForPlayer

Related Callbacks:
        -

Extra:
        -
==============================*/
stock EnableCaps(bool:enable)
{
        foreach(Player, i)I[i][pCaps] = enable;
        S[sCaps] = enable;
        return 1;
}

/*==============================
Function:
        CrashPlayer

Params:
        playerid => ID of the player

Return:
        -

Related Functions:
        -

Related Callbacks:
        -

Extra:
        -
==============================*/
stock CrashPlayer(playerid)
        return ApplyAnimation(playerid, "INVALID", "INVALID", 1, 0, 0, 0, 0, 0);

/*==============================
Function:
        GetPlayerFPS

Params:
        playerid => ID of the player

Return:
        Player's FPS

Related Functions:
        -

Related Callbacks:
        -

Extra:
        -
==============================*/
stock GetPlayerFPS(playerid)
        return I[playerid][pFPS];

/*==============================
Function:
        Reconnect

Params:
        playerid => ID of the player

Return:
        1 if success

Related Functions:
        ReconnectEx

Related Callbacks:
        -

Extra:
        -
==============================*/
stock Reconnect(playerid)
{
        static cmdstr[23];
        GetPlayerIp(playerid, I[playerid][pIP], 16);
        format(cmdstr, 23, "banip %s", I[playerid][pIP]);
        I[playerid][pReconnect] = true;
        return SendRconCommand(cmdstr);
}

/*==============================
Function:
        ReconnectEx

Params:
        playerid => ID of the player
        time => The time to wait before reconnect the player

Return:
        -

Related Functions:
        Reconnect

Related Callbacks:
        -

Extra:
        -
==============================*/
stock ReconnectEx(playerid, time)
        return SetTimerEx("ForceReconnect", time, false, "i", playerid);

/*==============================
Function:
        GivePlayerScore

Params:
        playerid => ID of the player
        score => amount of the score to increase the player's score

Return:
        1 if success

Related Functions:
        -

Related Callbacks:
        -

Extra:
        -
==============================*/
stock GivePlayerScore(playerid, score)
{
        I[playerid][pScore] += score;
        return SetPlayerScore(playerid, I[playerid][pScore]);
}

/*==============================
Function:
        SetPlayerFacingPos

Params:
        playerid => ID of the player
        Float:x => The x coordinate of the position the player will face.
        Float:y => The y coordinate of the position the player will face.

Return:
        1 if success

Related Functions:
        -

Related Callbacks:
        -

Extra:
        -
==============================*/
stock SetPlayerFacingPos(playerid, Float:x, Float:y)
{
        if(!floatcmp(x, 0.0) && !floatcmp(y, 0.0))return 0;
        static Float:p[3];
        GetPlayerPos(playerid, p[0], p[1], p[2]);
        p[2] = atan2((y-p[1]), (x-p[0])) + 270;
        if(p[2]>360)p[2]-=360;
        return SetPlayerFacingAngle(playerid, p[2]);
}

#if defined USE_VEHICLE_DATA
        /*==============================
        Function:
                GetVehiclePlate

        Params:
                vehicleid => ID of the vehicle
                Plate => array to store the plate of the vehicle
                size => size of the array

        Return:
                1 if success

        Related Functions:
                GetVehicleColor
                GetVehicleInterior

        Related Callbacks:
                -

        Extra:
                -
        ==============================*/
        stock GetVehiclePlate(vehicleid, Plate[], size)
        {
                format(Plate, size, "%s", V[vehicleid][vPlate]);
                return 1;
        }

        /*==============================
        Function:
                GetVehicleColor

        Params:
                vehicleid => ID of the vehicle
                color1 => variable to store the 1º color
                color2 => variable to store the 2º color

        Return:
                1 if success

        Related Functions:
                GetVehiclePlate
                GetVehicleInterior

        Related Callbacks:
                -

        Extra:
                -
        ==============================*/
        stock GetVehicleColor(vehicleid, &color1, &color2)
        {
                color1 = V[vehicleid][vColor][0];
                color2 = V[vehicleid][vColor][1];
                return 1;
        }

        /*==============================
        Function:
                GetVehicleInterior

        Params:
                vehicleid => ID of the vehicle

        Return:
                The vehicle's interior

        Related Functions:
                GetVehiclePlate
                GetVehicleColor

        Related Callbacks:
                -

        Extra:
                -
        ==============================*/
        stock GetVehicleInterior(vehicleid)
                return V[vehicleid][vInterior];

        /*==============================
        Function:
                GetVehicleIDFromPlate

        Params:
                Plate => Plate to search for

        Return:
                -1 if no vehicle was found, otherwise the ID of the vehicle.

        Related Functions:
                -

        Related Callbacks:
                -

        Extra:
                -
        ==============================*/
        stock GetVehicleIDFromPlate(Plate[])
        {
                static i;
                for(i=1; i<=MAX_VEHICLES; i++)if(V[i][vCreated] && !strcmp(V[i][vPlate], Plate))break;
                if(!V[i][vCreated] || strcmp(V[i][vPlate], Plate))i=-1;
                return i;
        }

    /*==============================
        Function:
            IsVehicleCreated

        Params:
                vehicleid => ID of the vehicle

        Return:
                true if the vehicle is created, otherwise fase

        Related Functions:
                -

        Related Callbacks:
                -

        Extra:
                -
        ==============================*/
        stock IsVehicleCreated(vehicleid)
                return V[vehicleid][vCreated];

    /*==============================
        Function:
            EnableTiresDamageForVehicle

        Params:
                vehicleid => ID of the vehicle
                enable => true/false (true will disable the vehicle tires of being damage, otherwise false)

        Return:
                1 if success

        Related Functions:
                EnableTiresDamage

        Related Callbacks:
                -

        Extra:
                -
        ==============================*/
        stock EnableTiresDamageForVehicle(vehicleid, bool:enable)
        {
                V[vehicleid][vTires] = enable;
                return 1;
        }

    /*==============================
        Function:
            EnableTiresDamage

        Params:
                enable => true/false (true will disable the vehicle tires of being damage, otherwise false)

        Return:
                1 if success

        Related Functions:
                EnableTiresDamageForVehicle

        Related Callbacks:
                -

        Extra:
                -
        ==============================*/
        stock EnableTiresDamage(bool:enable)
        {
                for(static i=1; i<=2000; i++)V[i][vTires] = enable;
                return 1;
        }

    /*==============================
        Function:
            GetVehicleType

        Params:
                model => vehicle model

        Return:
                Vehicle TIPE (see line: )

        Related Functions:
                -

        Related Callbacks:
                -

        Extra:
                -
        ==============================*/
        stock GetVehicleType(model)
        {
                switch(model){
                    case 460, 476, 511, 512, 519, 520, 553, 577, 592, 593:return VEHICLE_TYPE_AIRPLANE;
                    case 417, 425, 447, 469 ,487, 488, 497, 548, 563:return VEHICLE_TYPE_HELICOPTER;
                    case 448, 461 .. 463, 468, 471, 481, 509, 510, 521 .. 523, 581, 586:return VEHICLE_TYPE_BIKE;
                    case 439, 480, 533, 555:return VEHICLE_TYPE_CONVERTIBLE;
                    case 403, 408, 413, 414, 422, 440, 443, 455, 456, 459, 478, 482, 498, 499, 514, 515, 524, 531, 543, 552, 554, 578, 582, 600, 605, 609:return VEHICLE_TYPE_INDUSTRIAL;
                    case 412, 534 .. 536, 566, 567, 575, 576:return VEHICLE_TYPE_LOWRIDER;
                    case 400, 424, 444, 470, 489, 495, 500, 505, 556, 557, 568, 573, 579:return VEHICLE_TYPE_OFFROAD;
                    case 407, 416, 420, 427, 431, 432, 433, 437, 438, 490, 528, 544, 596 .. 599, 601:return VEHICLE_TYPE_PUBLICSERV;
                    case 401, 405, 410, 419, 421, 426, 436, 445, 466, 467, 474, 491, 492, 504, 507, 516, 517, 518, 526, 527, 529, 540, 542, 546, 547, 549, 550, 551, 560, 562, 580, 585, 604:return VEHICLE_TYPE_SALOON;
                    case 402, 411, 415, 429, 451, 475, 477, 494, 496, 541, 502, 503, 506, 558, 559, 565, 587, 589, 602, 603:return VEHICLE_TYPE_SPORT;
                    case 404, 418, 458, 479, 561:return VEHICLE_TYPE_STATION;
                    case 430, 446, 452, 453, 454, 472, 473, 484, 493, 595:return VEHICLE_TYPE_BOAT;
                    case 435, 450, 569, 570, 584, 590, 591, 606, 607, 608, 610, 611:return VEHICLE_TYPE_TRAILER;
                    case 406, 409, 423, 428, 434, 442, 449, 457, 483, 485, 486, 508, 525, 530, 532, 537 .. 539, 545, 571, 572, 574, 583, 588:return VEHICLE_TYPE_UNIQUE;
                    case 441, 464, 465, 501, 564, 594:return VEHICLE_TYPE_RC;
                }return INVALID_VEHICLE_TYPE;
        }

        /*==============================
        Function:
            GetVehicleRot

        Params:
                vehicleid => ID of the vehicle
                Float:x => variable to store the X rotation
                Float:y => variable to store the Y rotation
                Float:z => variable to store the Z rotation

        Return:
                1 if success

        Related Functions:
                -

        Related Callbacks:
                -

        Extra:
                -
        ==============================*/
        stock GetVehicleRot(vehicleid, &Float:x, &Float:y, &Float:z)
        {
            static Float:qW, Float:qX, Float:qY, Float:qZ;
                GetVehicleRotationQuat(vehicleid, qW, qX, qY, qZ);
            x = atan2(2*((quat_x*quat_y)+(quat_w+quat_z)),(quat_w*quat_w)+(quat_x*quat_x)-(quat_y*quat_y)-(quat_z*quat_z));
            y = atan2(2*((quat_y*quat_z)+(quat_w*quat_x)),(quat_w*quat_w)-(quat_x*quat_x)-(quat_y*quat_y)+(quat_z*quat_z));
            z = asin(-2*((quat_x*quat_z)+(quat_w*quat_y)));
            return 1;
        }
#endif

/*==============================
Function:
        GetOnlinePlayers

Params:
        CountNPC => true/false (true will count the npc bots, otherwise false)

Return:
        Number of connected players

Related Functions:
        -

Related Callbacks:
        -

Extra:
        -
==============================*/
stock GetOnlinePlayers(bool:CountNPC)
{
        static c;
    if(CountNPC)foreach(Player, i)c++;
    else foreach(Player, i)if(!IsPlayerNPC(i))c++;
        return c;
}

/*==============================
Function:
        AddForbidenNick

Params:
        nick => nick to add in the nick's blacklist

Return:
        1 if success

Related Functions:
        -

Related Callbacks:
        -

Extra:
        -
==============================*/
stock AddForbidenNick(nick[])
{
        for(new j; j<bNamesC; j++)if(!strcmp(nick, bNames[j], true))return 0;
        if(bNamesC == MAX_BNAMES-1)return 0;
        format(bNames[bNamesC], MAX_PLAYER_NAME, "%s", nick);
        bNamesC++;
        return 1;
}

/*==============================
Function:
        AddForbidenWord

Params:
        word => word to add in the word's blacklist

Return:
        1 if success

Related Functions:
        -

Related Callbacks:
        -

Extra:
        -
==============================*/
stock AddForbidenWord(word[])
{
        for(new j; j<bWordsC; j++)if(!strcmp(word, bWords[j], true))return 0;
        if(bWordsC == MAX_BWORDS-1)return 0;
        format(bWords[bWordsC], 16, "%s", word);
        bWordsC++;
        return 1;
}

/*==============================
Function:
        GetMiddle2D

Params:
        Float:x1 => x coordinate of the 1º position
        Float:y1 => y coordenate of the 1º position
        Float:x2 => x coordinate of the 2º position
        Float:y2 => y coordinate of the 2º position
        Float:rX => variable to store the X coordinate of the middle position between the 2 postions given.
        Float:rY => variable to store the Y coordinate of the middle position between the 2 postions given.

Return:
        1 if success

Related Functions:
        -

Related Callbacks:
        -

Extra:
        -
==============================*/
stock GetMiddle2D(Float:x1, Float:y1, Float:x2, Float:y2, Float:rX, Float:rY)
{
        rX = floatdiv(floatadd(x1, x2), 2);
        rY = floatdiv(floatadd(y1, y2), 2);
        return 1;
}

/*==============================
Function:
        GetMiddle3D

Params:
        Float:x1 => x coordinate of the 1º position
        Float:y1 => y coordenate of the 1º position
        Float:z1 => z coordinate of the 1º position
        Float:x2 => x coordinate of the 2º position
        Float:y2 => y coordinate of the 2º position
        Float:z2 => z coordinate of the 2º position
        Float:rX => variable to store the X coordinate of the middle position between the 2 postions given.
        Float:rY => variable to store the Y coordinate of the middle position between the 2 postions given.
        Float:rZ => variable to store the Z coordinate of the middle position between the 2 postions given.

Return:
        1 if success

Related Functions:
        -

Related Callbacks:
        -

Extra:
        -
==============================*/
stock GetMiddle3D(Float:x1, Float:y1, Float:z1, Float:x2, Float:y2, Float:z2, Float:rX, Float:rY, Float:rZ)
{
        rX = floatdiv(floatadd(x1, x2), 2);
        rY = floatdiv(floatadd(y1, y2), 2);
        rZ = floatdiv(floatadd(z1, y2), 2);
        return 1;
}

#if defined FILTERSCRIPT
    Hook:CBz_OnFilterScriptInit()
    {
        if(fexist("ForbidenNames.cfg")){
                    static line[64];
                    Fhnd = fopen("ForbidenNames.cfg", io_read);
                    while(fread(Fhnd, line)){
                        for(new i; i<strlen(line); i++)if(line[i] == '\r' || line[i] == '\n')line[i] = '\0';
                        if(strlen(line)){
                                format(bNames[bNamesC], MAX_PLAYER_NAME, "%s", line);
                                bNamesC++;
                                }
                    }
                }
        if(fexist("ForbidenWords.cfg")){
                    static line[64];
                    Fhnd = fopen("ForbidenWords.cfg", io_read);
                    while(fread(Fhnd, line)){
                        for(new i; i<strlen(line); i++)if(line[i] == '\r' || line[i] == '\n')line[i] = '\0';
                        if(strlen(line)){
                                format(bWords[bWordsC], MAX_PLAYER_NAME, "%s", line);
                                bWordsC++;
                                }
                    }
                }
                static str[128];
        foreach(Player, i){
                        if(!IsPlayerNPC(i)){
                                if(!IsPlayerAdmin(i)){
                                GetPlayerName(i, str, MAX_PLAYER_NAME);
                                for(new j; j<bNamesC; j++){
                                    if(!strcmp(str, bNames[j], true)){
                                                        #if defined ENGLISH
                                                                format(str, 128, "%s(%i) has been automaticaly kicked. [Reason: Forbiden nick]", str, i);
                                                                SendClientMessage(i, 0xFF0000FF, "Forbiden nick.");
                                                        #else
                                                                format(str, 128, "%s(%i) fue kickeado automaticamente. [Reason: Nick prohibido]", str, i);
                                                                SendClientMessage(i, 0xFF0000FF, "Nick prohibido.");
                                                        #endif
                                            Kick(i);
                                            return SendClientMessageToAll(0xA6A6A6FF, str);
                                    }
                                }
                                }
                                ResetPlayer(i);
                                I[i][pTime][1] = GetTickCount();
                                GetPlayerHealth(i, I[i][pHealth]);
                                GetPlayerArmour(i, I[i][pArmour]);
                                I[i][pWeap] = GetPlayerWeapon(i);
                                I[i][pMoney] = GetPlayerMoney(i);
                                I[i][pTimer] = SetTimerEx("Check", INTERVAL, true, "i", i);
                        }
        }
        return 1;
    }

    Hook:CBz_OnFilterScriptExit()
    {
                foreach(Player, i){
                        if(!IsPlayerNPC(i)){
                                if(I[i][pTimer])KillTimer(I[i][pTimer]);
                                if(I[i][pReconnect]){
                                    static cmdstr[25];
                                    format(cmdstr, 23, "unbanip %s", I[i][pIP]);
                                    SendRconCommand(cmdstr);
                                    SendRconCommand("reloadbans");
                                }
                        }
                }
                Fhnd = fopen("ForbidenNames.cfg", io_write);
                for(new j; j<bNamesC; j++){
                    fwrite(Fhnd, bNames[j]);
                    fwrite(Fhnd, "\r\n");
                }
                fclose(Fhnd);
                Fhnd = fopen("ForbidenWords.cfg", io_write);
                for(new j; j<bWordsC; j++){
                    fwrite(Fhnd, bWords[j]);
                    fwrite(Fhnd, "\r\n");
                }
                fclose(Fhnd);
                return 1;
    }
#else
    Hook:CBz_OnGameModeInit()
    {
        if(fexist("ForbidenNames.cfg")){
                    static line[64];
                    Fhnd = fopen("ForbidenNames.cfg", io_read);
                    while(fread(Fhnd, line)){
                        for(new i; i<strlen(line); i++)if(line[i] == '\r' || line[i] == '\n')line[i] = '\0';
                        if(strlen(line)){
                                format(bNames[bNamesC], MAX_PLAYER_NAME, "%s", line);
                                bNamesC++;
                                }
                    }
                }
        if(fexist("ForbidenWords.cfg")){
                    static line[64];
                    Fhnd = fopen("ForbidenWords.cfg", io_read);
                    while(fread(Fhnd, line)){
                        for(new i; i<strlen(line); i++)if(line[i] == '\r' || line[i] == '\n')line[i] = '\0';
                        if(strlen(line)){
                                format(bWords[bWordsC], MAX_PLAYER_NAME, "%s", line);
                                bWordsC++;
                                }
                    }
                }
                static str[128];
        foreach(Player, i){
                        if(!IsPlayerNPC(i)){
                                if(!IsPlayerAdmin(i)){
                                GetPlayerName(i, str, MAX_PLAYER_NAME);
                                for(new j; j<bNamesC; j++){
                                    if(!strcmp(str, bNames[j], true)){
                                                        #if defined ENGLISH
                                                                format(str, 128, "%s(%i) has been automaticaly kicked. [Reason: Forbiden nick]", str, i);
                                                                SendClientMessage(i, 0xFF0000FF, "Forbiden nick.");
                                                        #else
                                                                format(str, 128, "%s(%i) fue kickeado automaticamente. [Reason: Nick prohibido]", str, i);
                                                                SendClientMessage(i, 0xFF0000FF, "Nick prohibido.");
                                                        #endif
                                            Kick(i);
                                            return SendClientMessageToAll(0xA6A6A6FF, str);
                                    }
                                }
                                }
                                ResetPlayer(i);
                                I[i][pTime][1] = GetTickCount();
                                GetPlayerHealth(i, I[i][pHealth]);
                                GetPlayerArmour(i, I[i][pArmour]);
                                I[i][pWeap] = GetPlayerWeapon(i);
                                I[i][pMoney] = GetPlayerMoney(i);
                                I[i][pTimer] = SetTimerEx("Check", INTERVAL, true, "i", i);
                        }
        }
        return 1;
    }

    Hook:CBz_OnGameModeExit()
    {
                foreach(Player, i){
                        if(!IsPlayerNPC(i)){
                                if(I[i][pTimer])KillTimer(I[i][pTimer]);
                                if(I[i][pReconnect]){
                                    static cmdstr[25];
                                    format(cmdstr, 23, "unbanip %s", I[i][pIP]);
                                    SendRconCommand(cmdstr);
                                    SendRconCommand("reloadbans");
                                }
                        }
                }
                Fhnd = fopen("ForbidenNames.cfg", io_write);
                for(new j; j<bNamesC; j++){
                    fwrite(Fhnd, bNames[j]);
                    fwrite(Fhnd, "\r\n");
                }
                fclose(Fhnd);
                Fhnd = fopen("ForbidenWords.cfg", io_write);
                for(new j; j<bWordsC; j++){
                    fwrite(Fhnd, bWords[j]);
                    fwrite(Fhnd, "\r\n");
                }
                fclose(Fhnd);
                return 1;
    }
#endif

Hook:CBz_OnPlayerConnect(playerid)
{
        if(IsPlayerNPC(playerid))return 1;
        ResetPlayer(playerid);
        I[playerid][pTimer] = SetTimerEx("Check", INTERVAL, true, "i", playerid);
        I[playerid][pTime][1] = GetTickCount();
    static str[128], name[MAX_PLAYER_NAME];
    GetPlayerName(playerid, name, MAX_PLAYER_NAME);
    for(new i; i<bNamesC; i++){
        if(!strcmp(name, bNames[i], true)){
                        #if defined ENGLISH
                                format(str, sizeof(str), "%s(%i) has been automaticaly kicked. [Reason: Forbiden nick]", name, playerid);
                                SendClientMessage(playerid, 0xFF0000FF, "Forbiden nick.");
                        #else
                                format(str, sizeof(str), "%s(%i) fue kickeado automaticamente. [Reason: Nick prohibido]", name, playerid);
                                SendClientMessage(playerid, 0xFF0000FF, "Nick prohibido.");
                        #endif
            Kick(playerid);
            return SendClientMessageToAll(0xA6A6A6FF, str);
        }
    }
        return 1;
}

Hook:CBz_OnPlayerDisconnect(playerid, reason)
{
        if(I[playerid][pTimer])KillTimer(I[playerid][pTimer]);
        if(I[playerid][pReconnect]){
            static cmdstr[25];
            I[playerid][pReconnect] = false;
            format(cmdstr, 23, "unbanip %s", I[playerid][pIP]);
            SendRconCommand(cmdstr);
            SendRconCommand("reloadbans");
        }
        return 1;
}

Hook:CBz_OnPlayerSpawn(playerid)
{
        I[playerid][pTime][0] = GetTickCount();
        I[playerid][pWeap] = GetPlayerWeapon(playerid);
        I[playerid][pVWorld] = GetPlayerVirtualWorld(playerid);
        _SetPlayerHealth(playerid, 100);
        SetTimerEx("GetWeaps", 500, false, "i", playerid);
        return 1;
}

Hook:CBz_OnPlayerDeath(playerid, killerid, reason)
{
    I[playerid][pTime][0] = GetTickCount();
    I[playerid][pHealth] = 0;
    return 1;
}

Hook:CBz_OnPlayerText(playerid, text[])
{
    I[playerid][pTime][1] = GetTickCount();
    I[playerid][pTime][0] = GetTickCount();
    if(!I[playerid][pCaps])LOWER(text);
    new pos;
    for(new i; i<bWordsC; i++){
                pos = strfind(text, bWords[i]);
        if(pos != -1)for(new j=pos; j<(pos+strlen(bWords[i])); j++)text[j] = '*';
        }
        return 1;
}

Hook:CBz_OnPlayerCommandText(playerid, cmdtext[])
{
    I[playerid][pTime][1] = GetTickCount();
    I[playerid][pTime][0] = GetTickCount();
        return 1;
}

Hook:OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid)
{
        if(!I[playerid][pIntDamage]){
                if(!newinteriorid)for(new i; i<13; i++)GivePlayerWeapon(playerid, I[playerid][pWeaps][i], I[playerid][pAmmo][i]);
                else{
                    for(new i; i<13; i++)GetPlayerWeaponData(playerid, i, I[playerid][pWeaps][i], I[playerid][pAmmo][i]);
                ResetPlayerWeapons(playerid);
                }
        }
        return 1;
}

Hook:CBz_OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    I[playerid][pTime][1] = GetTickCount();
        if(I[playerid][pDriveBy] && IsPlayerInAnyVehicle(playerid) && I[playerid][pWeap]){
                if(PRESSED(KEY_FIRE) || PRESSED(KEY_SECONDARY_ATTACK) || HOLDING(KEY_FIRE) || HOLDING(KEY_SECONDARY_ATTAK)){
                        switch(GetPlayerCameraMode(playerid)){
                            case 16, 18, 56:{
                                if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER){
                                        if(!I[playerid][pDBing]){
                                            I[playerid][pDBing] = true;
                                            CallLocalFunction("OnPlayerStartDriveBy", "ii", playerid, 0);
                                        }
                                        }
                            }
                            case 55:{
                                if(GetPlayerState(playerid) == PLAYER_STATE_PASSENGER){
                                        if(!I[playerid][pDBing]){
                                            I[playerid][pDBing] = true;
                                            CallLocalFunction("OnPlayerStartDriveBy", "ii", playerid, 1);
                                        }
                                        }
                            }
                            default:{
                                if(I[playerid][pDBing]){
                                    I[playerid][pDBing] = false;
                                    CallLocalFunction("OnPlayerEndDriveBy", "i", playerid);
                                }
                            }
                        }
                }
                else{
                        if(I[playerid][pDBing]){
                                I[playerid][pDBing] = false;
                                CallLocalFunction("OnPlayerEndDriveBy", "i", playerid);
                        }
                }
        }
        return 1;
}

Hook:CBz_OnPlayerStateChange(playerid, newstate, oldstate)
{
        static Float:rP[10], Float:HA[2];
    I[playerid][pTime][1] = GetTickCount();
    I[playerid][pTime][0] = GetTickCount();
    if(newstate == PLAYER_STATE_DRIVER){
        if(!I[playerid][pDriveBy]){
                    for(new i; i<13; i++)GetPlayerWeaponData(playerid, i, I[playerid][pWeaps][i], I[playerid][pAmmo][i]);
                ResetPlayerWeapons(playerid);
        }
    }
    else if(newstate == PLAYER_STATE_ONFOOT && oldstate == PLAYER_STATE_DRIVER && !I[playerid][pDriveBy])for(new i; i<13; i++)GivePlayerWeapon(playerid, I[playerid][pWeaps][i], I[playerid][pAmmo][i]);
        return 1;
}

Hook:CBz_OnPlayerUpdate(playerid)
{
    static Float:rP[10], tmp[2];
    GetPlayerPos(playerid, rP[0], rP[1], rP[2]);
    GetPlayerFacingAngle(playerid, rP[3]);
        tmp[0] = GetPlayerDrunkLevel(playerid);
    if(floatcmp(rP[0], I[playerid][pP][0]) && floatcmp(rP[1], I[playerid][pP][1]) && floatcmp(rP[2], I[playerid][pP][2]) && floatcmp(rP[3], I[playerid][pP][3])){
        GetPlayerPos(playerid, I[playerid][pP][0], I[playerid][pP][1], I[playerid][pP][2]);
                GetPlayerFacingAngle(playerid, I[playerid][pP][3]);
                I[playerid][pTime][1] = GetTickCount();
                I[playerid][pAFK] = false;
        }
        if(tmp[0] < 200)SetPlayerDrunkLevel(playerid, 2000);
        else if(I[playerid][pDrk] != tmp[0]){
            tmp[1] = I[playerid][pDrk] - tmp[0];
            if(0 < tmp[1] < 200)I[playerid][pFPS] = tmp[1];
            I[playerid][pDrk] = tmp[0];
    }
        I[playerid][pTime][0] = GetTickCount();
        if(I[playerid][pPaused])I[playerid][pPaused] = false;
        return 1;
}

#if defined USE_VEHICLE_DATA
        Hook:CBz_OnVehicleRespray(playerid, vehicleid, color1, color2)
        {
                V[vehicleid][vColor][0] = color1;
                V[vehicleid][vColor][1] = color2;
                return 1;
        }

        Hook:Cbz_OnVehicleDamageStatusUpdate(vehicleid, playerid)
        {
                if(V[vehicleid][vTires]){
                    static tmp[4];
                        GetVehicleDamageStatus(vehicleid, tmp[0], tmp[1], tmp[2], tmp[3]);
                        tmp[3] = encode_tires(0, 0, 0, 0);
                        UpdateVehicleDamageStatus(vehicleid, tmp[0], tmp[1], tmp[2], tmp[3]);
                }
                return 1;
        }
#endif

PUBLIC:Check(playerid)
{
        if(!I[playerid][pAFK]){
            if(!I[playerid][pPaused] && (GetTickCount()-I[playerid][pTime][0])>=(PAUSE_TIME*519)){
                I[playerid][pPaused] = true;
                CallLocalFunction("OnPlayerPause", "i", playerid);
            }
            if((GetTickCount()-I[playerid][pTime][1])>=(AFK_TIME*1000)){
                I[playerid][pAFK] = true;
                CallLocalFunction("OnPlayerAFK", "i", playerid);
            }
            if(!I[playerid][pPaused]){
                static tmp, Lib[2][32], Float:HA[2];
                        tmp = GetPlayerWeapon(playerid);
                        if(tmp != I[playerid][pWeap]){
                            CallLocalFunction("OnPlayerWeaponChange", "iii", playerid, tmp, I[playerid][pWeap]);
                            I[playerid][pWeap] = tmp;
                        }
                        tmp = GetPlayerVirtualWorld(playerid);
                        if(tmp != I[playerid][pVWorld]){
                            CallLocalFunction("OnPlayerVirtualWorldChange", "iii", playerid, tmp, I[playerid][pVWorld]);
                            I[playerid][pVWorld] = tmp;
                        }
                        tmp = GetPlayerAnimationIndex(playerid);
                        if(tmp){
                                GetAnimationName(tmp, Lib[0], 32, Lib[1], 32);
                                if(!I[playerid][pPlayingAnim])CallLocalFunction("OnPlayerPlayAnimation", "iss", playerid, Lib[0], Lib[1]);
                                if(!strcmp(Lib[0], "SWIM")){
                                        if(!I[playerid][pInWater]){
                                            I[playerid][pInWater] = true;
                                            CallLocalFunction("OnPlayerEnterWater", "i", playerid);
                                        }
                                }else if(I[playerid][pInWater]){
                                    I[playerid][pInWater] = false;
                                    CallLocalFunction("OnPlayerExitWater", "i", playerid);
                                }
                                I[playerid][pParachuting] = (!strcmp(Lib[0], "PARACHUTE") || (!strcmp(Lib[0], "ped") && !strcmp(Lib[1], "FALL_skyDive"))) ? (true) : (false);
                                if(!strcmp(Lib[0], "VENDING")){
                                    if(!I[playerid][pMachine]){
                                            if(I[playerid][pUseMachine]){
                                                    I[playerid][pMachine] = true;
                                                    CallLocalFunction("OnPlayerUseVendingMachine", "i", playerid);
                                                }
                                                else{
                                                    ClearAnimations(playerid, 1);
                                                    SetTimerEx("NoVend", 40, false, "d", playerid);
                                                    I[playerid][pVend] = true;
                                                }
                                        }
                                }else I[playerid][pMachine] = false;
                                I[playerid][pPlayingAnim] = true;
                        }else I[playerid][pPlayingAnim] = false;
                        if(!I[playerid][pVend]){
                            GetPlayerHealth(playerid, HA[0]);
                                if(floatcmp(HA[0], I[playerid][pHealth])){
                                    CallLocalFunction("OnPlayerHealthChange", "iff", playerid, HA[0], I[playerid][pHealth]);
                                    I[playerid][pHealth] = HA[0];
                                }
                                GetPlayerArmour(playerid, HA[1]);
                                if(floatcmp(HA[1], I[playerid][pArmour])){
                                    CallLocalFunction("OnPlayerArmourChange", "iff", playerid, HA[0], I[playerid][pArmour]);
                                    I[playerid][pArmour] = HA[1];
                                }
                                tmp = GetPlayerMoney(playerid);
                                if(tmp != I[playerid][pMoney]){
                                    CallLocalFunction("OnPlayerMoneyChange", "iii", playerid, tmp, I[playerid][pMoney]);
                                    I[playerid][pMoney] = tmp;
                                }
                                tmp = GetPlayerScore(playerid);
                                if(tmp != I[playerid][pScore]){
                                    CallLocalFunction("OnPlayerScoreChange", "iii", playerid, tmp, I[playerid][pScore]);
                                    I[playerid][pScore] = tmp;
                                }
                        }
            }
        }
}

PUBLIC:GetWeaps(playerid)for(new i; i<13; i++)GetPlayerWeaponData(playerid, i, I[playerid][pWeaps][i], I[playerid][pAmmo][i]);

PUBLIC:ForceReconnect(playerid)
{
        static cmdstr[23];
        GetPlayerIp(playerid, I[playerid][pIP], 16);
        format(cmdstr, 23, "banip %s", I[playerid][pIP]);
        I[playerid][pReconnect] = true;
        SendRconCommand(cmdstr);
}

PUBLIC:NoVend(playerid)
{
        _SetPlayerHealth(playerid, I[playerid][pHealth]);
        GivePlayerMoney(playerid, 1);
        I[playerid][pVend] = false;
}

stock ResetPlayer(playerid)
{
        new i;
        I[playerid][pAFK] = false;
        I[playerid][pPaused] = false;
        I[playerid][pInWater] = false;
        I[playerid][pParachuting] = false;
        I[playerid][pMachine] = false;
        I[playerid][pDriveBy] = S[sDriveby];
        I[playerid][pIntDamage] = S[sIntDamage];
        I[playerid][pReconnect] = false;
        I[playerid][pUseMachine] = S[sVending];
        I[playerid][pPlayingAnim] = false;
        I[playerid][pCaps] = S[sCaps];
        I[playerid][pVend] = false;
        I[playerid][pUpdatedHealth] = false;
        I[playerid][pDBing] = false;
        I[playerid][pTReleased] = 0;
        for(; i<4; i++)I[playerid][pP][i] = 0.0;
        I[playerid][pTimer] = -1;
        I[playerid][pTime][0] = GetTickCount();
        I[playerid][pTime][1] = 0;
        I[playerid][pWeap] = 0;
        I[playerid][pVWorld] = 0;
        I[playerid][pHealth] = 0.0;
        I[playerid][pArmour] = 0.0;
        I[playerid][pMoney] = 0;
        I[playerid][pScore] = 0;
        for(i=0; i<13; i++){
                I[playerid][pWeaps][i] = 0;
                I[playerid][pAmmo][i] = 0;
        }
        I[playerid][pFPS] = 0;
        I[playerid][pDrk] = 0;
}

#if defined USE_VEHICLE_DATA
        stock _AddStaticVehicle(modelid, Float:spawn_x, Float:spawn_y, Float:spawn_z, Float:z_angle, color1, color2, plate[]="XYZR 000")
        {
                static vID;
                if(color1 == -1)color1 = random(127);
                if(color2 == -1)color2 = random(127);
                vID = AddStaticVehicle(modelid, spawn_x, spawn_y, spawn_z, z_angle, color1, color2);
                if(strcmp(plate, "XYZR 000")){
                    SetVehicleNumberPlate(vID, plate);
                    SetVehicleToRespawn(vID);
                    SetVehiclePos(vID, x, y, z);
                }
            V[vID][vCreated] = true;
                V[vID][vColor][0] = color1;
                V[vID][vColor][1] = color2;
                format(V[vID][vPlate], 32, "%s", plate);
                CallLocalFunction("OnVehicleCreate", "i", vID);
                return vID;
        }

        stock _AddStaticVehicleEx(modelid, Float:spawn_x, Float:spawn_y, Float:spawn_z, Float:z_angle, color1, color2, respawn_delay, plate[]="XYZR 000")
        {
            static vID;
                if(color1 == -1)color1 = random(127);
                if(color2 == -1)color2 = random(127);
                vID = AddStaticVehicleEx(modelid, spawn_x, spawn_y, spawn_z, z_angle, color1, color2, respawn_delay);
                if(strcmp(plate, "XYZR 000")){
                    SetVehicleNumberPlate(vID, plate);
                    SetVehicleToRespawn(vID);
                    SetVehiclePos(vID, x, y, z);
                }
            V[vID][vCreated] = true;
                V[vID][vColor][0] = color1;
                V[vID][vColor][1] = color2;
                format(V[vID][vPlate], 32, "%s", plate);
                CallLocalFunction("OnVehicleCreate", "i", vID);
                return vID;
        }

        stock _CreateVehicle(vehicletype, Float:x, Float:y, Float:z, Float:rotation, color1, color2, respawn_delay, plate[]="XYZR 000")
        {
                if(color1 == -1)color1 = random(127);
                if(color2 == -1)color2 = random(127);
                static vID = CreateVehicle(vehicletype, x, y, z, rotation, color1, color2, respawn_delay);
                if(strcmp(plate, "XYZR 000")){
                    SetVehicleNumberPlate(vID, plate);
                    SetVehicleToRespawn(vID);
                    SetVehiclePos(vID, x, y, z);
                }
                V[vID][vCreated] = true;
                V[vID][vColor][0] = color1;
                V[vID][vColor][1] = color2;
                format(V[vID][vPlate], 32, "%s", plate);
                CallLocalFunction("OnVehicleCreate", "i", vID);
                return vID;
        }

        stock _DestroyVehicle(vehicleid)
        {
            V[vehicleid][vCreated] = false;
                CallLocalFunction("OnVehicleDestroy", "i", vehicleid);
                return DestroyVehicle(vehicleid);
        }

        stock _ChangeVehicleColor(vehicleid, color1, color2)
        {
                V[vehicleid][vColor][0] = color1;
                V[vehicleid][vColor][1] = color2;
                return ChangeVehicleColor(vehicleid, color1, color2);
        }

        stock _SetVehicleNumberPlate(vehicleid, numberplate[])
        {
                format(V[vehicleid][vPlate], 32, "%s", numberplate);
            return SetVehicleNumberPlate(vehicleid, numberplate[])
        }

                stock _LinkVehicleToInterior(vehicleid, interiorid)
        {
                V[vehicleid][vInterior] = interiorid;
            return LinkVehicleToInterior(vehicleid, interiorid);
        }

        stock encode_tires(tire1, tire2, tire3, tire4) return tire1 | (tire2 << 1) | (tire3 << 2) | (tire4 << 3);
#endif

stock _SetPlayerHealth(playerid, Float:health)
{
        I[playerid][pHealth] = health;
        I[playerid][pUpdatedHealth] = true;
        return SetPlayerHealth(playerid, health);
}

stock _GetPlayerHealth(playerid, &Float:health){
        health = I[playerid][pHealth];
        return 1;
}

stock _SetPlayerArmour(playerid, Float:armour)
{
        I[playerid][pArmour] = armour;
        I[playerid][pUpdatedHealth] = true;
        return SetPlayerArmour(playerid, armour);
}

stock _GetPlayerArmour(playerid, &Float:armour){
        armour = I[playerid][pArmour];
        return 1;
}

stock _SetPlayerMoney(playerid, amount)
{
    I[playerid][pMoney] = amount;
    return GivePlayerMoney(playerid, -GetPlayerMoney(playerid)+amount);
}

stock _GivePlayerMoney(playerid, amount)
{
    I[playerid][pMoney] += amount;
    return GivePlayerMoney(playerid, amount);
}

stock _GetPlayerMoney(playerid)
        return I[playerid][pMoney];

stock _SetPlayerScore(playerid, score)
{
        I[playerid][pScore] = score;
        return SetPlayerScore(playerid, score);
}

stock _SetPlayerName(playerid, name[])
{
        if(fexist("ForbidenNames.cfg")){
            static line[64];
            Fhnd = fopen("ForbidenNames.cfg", io_read);
            while(fread(Fhnd, line))if(!strcmp(line, name))return 0;
            fclose(Fhnd);
        }
        return SetPlayerName(playerid, nick);
}

stock pName(playerid)
{
        static n[MAX_PLAYER_NAME];
        GetPlayerName(playerid, n, MAX_PLAYER_NAME);
        return n;
}

#define SetPlayerHealth                 _SetPlayerHealth
#define SetPlayerArmour                 _SetPlayerArmour
#define SetPlayerMoney                  _SetPlayerMoney
#define GivePlayerMoney                 _GivePlayerMoney
#define SetPlayerScore          _SetPlayerScore
#define SetPlayerName           _SetPlayerName
#if defined USE_VEHICLE_DATA
        #define AddStaticVehicle                _AddStaticVehicle
        #define AddStaticVehicleEx              _AddStaticVehicleEx
        #define CreateVehicle           _CreateVehicle
        #define SetVehicleNumberPlate   _SetVehicleNumberPlate
        #define DestroyVehicle                  _DestroyVehicle
        #define ChangeVehicleColor              _ChangeVehicleColor
        #define LinkVehicleToInterior   _LinkVehicleToInterior
#endif
