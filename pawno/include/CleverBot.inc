 
/*
CleverBot - An Unuseful Include By Fj0rtizFredde!
Credits:
Fj0rtizFredde = Creator Of This Shit!
The guy who made the PHP API that I made some edits to!
Sa-Mp Team for the HTTP functions!
Post any suggestions at the sa-mp forums :)
*/

#include <a_http>
#define CleverHost "bfsamp.hostei.com/servercleverbot/test.php" //Location to the test.php file! (Without HTTP://)

forward MyHttpResponse(index, response_code, data[]);

stock SendPlayerMessageToCleverbot(playerid, message[])
{
	new szString[128];
    format(szString,128,"?text=%s",message);
    HTTP(playerid, HTTP_GET, CleverHost, szString, "MyHttpResponse");
	return 1;
}

public MyHttpResponse(index, response_code, data[])
{
    // In this callback "index" would normally be called "playerid" ( if you didn't get it already :) )
    new buffer[128];
    if(response_code == 200) //Did the request succeed?
    {
        //Yes!
        format(buffer, sizeof(buffer), "%s", data);
        SendClientMessage(index, 0xFFFFFFFF, buffer);
    }
    else
    {
        //No!
        format(buffer, sizeof(buffer), "The request failed! The response code was: %d", response_code);
        SendClientMessage(index, 0xFFFFFFFF, buffer);
    }
}

