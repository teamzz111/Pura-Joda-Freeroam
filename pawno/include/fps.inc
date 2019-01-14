#include <a_samp>
#pragma tabsize 0
/*
native GetPlayerFPS(playerid)
*/
enum _I{
	pFPS,
	pDrk,
	pIPp[16],
};
new I[MAX_PLAYERS][_I];

public OnPlayerUpdate(playerid)
{
    static tmp[2];
	if(tmp[0] < 200)SetPlayerDrunkLevel(playerid, 2000);
	else if(I[playerid][pDrk] != tmp[0]){
	    tmp[1] = I[playerid][pDrk] - tmp[0];
	    if(0 < tmp[1] < 200)I[playerid][pFPS] = tmp[1];
	    I[playerid][pDrk] = tmp[0];
    }
return 1;
}

stock GetPlayerFPS(playerid)
	return I[playerid][pFPS];