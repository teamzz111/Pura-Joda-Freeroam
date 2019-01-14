/*
aDialog V2 fixed version.

ADRI1 INCLUDE**

FUNC: ShowTextDrawDialog(playerid, dialogid, info[], button1[], button2[], line1[]="", line2[]="", line3[]="", line4[]="", line5[]="", line6[]="", line7[]="", line8[]="", line9[]="", line10[]="", line11[]="")
PUBLIC: OnTextDrawDialogResponse(playerid, response, dialogid, listitem)

**Segundo include.
*/
#define MAX_TD_DIALOGS  10
#if !defined isnull
    #define isnull(%1) \
                ((!(%1[0])) || (((%1[0]) == '\1') && (!(%1[1]))))
#endif
new
	PlayerText:Normal_Texts[MAX_PLAYERS][MAX_TD_DIALOGS][5],
	PlayerText:Lines_Texts[MAX_PLAYERS][MAX_TD_DIALOGS][11];
forward OnTextDrawDialogResponse(playerid, response, dialogid, listitem);

stock ShowTextDrawDialog(playerid, dialogid, info[], button1[], button2[], line1[]="", line2[]="", line3[]="", line4[]="", line5[]="", line6[]="", line7[]="", line8[]="", line9[]="", line10[]="", line11[]="")
{
	if(GetPVarInt(playerid, "menu_active") >= 0) return 0;
	SetPVarInt(playerid, "menu_active", dialogid);
	Normal_Texts[playerid][dialogid][0] = CreatePlayerTextDraw(playerid,615.762756, 115.833366, "usebox");
	PlayerTextDrawLetterSize(playerid,Normal_Texts[playerid][dialogid][0], 0.000000, 30.403156);
	PlayerTextDrawTextSize(playerid,Normal_Texts[playerid][dialogid][0], 18.146411, 0.000000);
	PlayerTextDrawAlignment(playerid,Normal_Texts[playerid][dialogid][0], 1);
	PlayerTextDrawColor(playerid,Normal_Texts[playerid][dialogid][0], 0);
	PlayerTextDrawUseBox(playerid,Normal_Texts[playerid][dialogid][0], true);
	PlayerTextDrawBoxColor(playerid,Normal_Texts[playerid][dialogid][0], 102);
	PlayerTextDrawSetShadow(playerid,Normal_Texts[playerid][dialogid][0], 0);
	PlayerTextDrawSetOutline(playerid,Normal_Texts[playerid][dialogid][0], 0);
	PlayerTextDrawFont(playerid,Normal_Texts[playerid][dialogid][0], 0);

	Normal_Texts[playerid][dialogid][1] = CreatePlayerTextDraw(playerid,36.076484, 120.750000, info);
	PlayerTextDrawLetterSize(playerid,Normal_Texts[playerid][dialogid][1], 0.449999, 1.600000);
	PlayerTextDrawAlignment(playerid,Normal_Texts[playerid][dialogid][1], 1);
	PlayerTextDrawColor(playerid,Normal_Texts[playerid][dialogid][1], -1);
	PlayerTextDrawSetShadow(playerid,Normal_Texts[playerid][dialogid][1], 0);
	PlayerTextDrawSetOutline(playerid,Normal_Texts[playerid][dialogid][1], 1);
	PlayerTextDrawBackgroundColor(playerid,Normal_Texts[playerid][dialogid][1], 51);
	PlayerTextDrawFont(playerid,Normal_Texts[playerid][dialogid][1], 1);
	PlayerTextDrawSetProportional(playerid, Normal_Texts[playerid][dialogid][1], 1);

	Normal_Texts[playerid][dialogid][2] = CreatePlayerTextDraw(playerid,595.616088, 142.666671, "usebox");
	PlayerTextDrawLetterSize(playerid,Normal_Texts[playerid][dialogid][2], 0.000000, 24.042774);
	PlayerTextDrawTextSize(playerid,Normal_Texts[playerid][dialogid][2], 33.607612, 0.000000);
	PlayerTextDrawAlignment(playerid,Normal_Texts[playerid][dialogid][2], 1);
	PlayerTextDrawColor(playerid,Normal_Texts[playerid][dialogid][2], 0);
	PlayerTextDrawUseBox(playerid,Normal_Texts[playerid][dialogid][2], true);
	PlayerTextDrawBoxColor(playerid,Normal_Texts[playerid][dialogid][2], 254);
	PlayerTextDrawSetShadow(playerid,Normal_Texts[playerid][dialogid][2], 0);
	PlayerTextDrawSetOutline(playerid,Normal_Texts[playerid][dialogid][2], 0);
	PlayerTextDrawFont(playerid,Normal_Texts[playerid][dialogid][2], 0);
	if(isnull(button2))
	{
		Normal_Texts[playerid][dialogid][3] = CreatePlayerTextDraw(playerid,317.657592, 368.082977, button1);
		PlayerTextDrawLetterSize(playerid,Normal_Texts[playerid][dialogid][3], 0.449999, 1.600000);
		PlayerTextDrawTextSize(playerid,Normal_Texts[playerid][dialogid][3], 22.489015, 66.499992);
		PlayerTextDrawAlignment(playerid,Normal_Texts[playerid][dialogid][3], 2);
		PlayerTextDrawColor(playerid,Normal_Texts[playerid][dialogid][3], -1);
		PlayerTextDrawUseBox(playerid,Normal_Texts[playerid][dialogid][3], true);
		PlayerTextDrawBoxColor(playerid,Normal_Texts[playerid][dialogid][3], -2139062017);
		PlayerTextDrawSetShadow(playerid,Normal_Texts[playerid][dialogid][3], 0);
		PlayerTextDrawSetOutline(playerid,Normal_Texts[playerid][dialogid][3], 1);
		PlayerTextDrawBackgroundColor(playerid,Normal_Texts[playerid][dialogid][3], 255);
		PlayerTextDrawFont(playerid,Normal_Texts[playerid][dialogid][3], 1);
		PlayerTextDrawSetProportional(playerid, Normal_Texts[playerid][dialogid][3], 1);
		PlayerTextDrawSetSelectable(playerid, Normal_Texts[playerid][dialogid][3], true);
	}
	else
	{
		Normal_Texts[playerid][dialogid][3] = CreatePlayerTextDraw(playerid,274.084930, 368.082977, button1);
		PlayerTextDrawLetterSize(playerid,Normal_Texts[playerid][dialogid][3], 0.449999, 1.600000);
		PlayerTextDrawTextSize(playerid,Normal_Texts[playerid][dialogid][3], 22.489015, 66.499992);
		PlayerTextDrawAlignment(playerid,Normal_Texts[playerid][dialogid][3], 2);
		PlayerTextDrawColor(playerid,Normal_Texts[playerid][dialogid][3], -1);
		PlayerTextDrawUseBox(playerid,Normal_Texts[playerid][dialogid][3], true);
		PlayerTextDrawBoxColor(playerid,Normal_Texts[playerid][dialogid][3], -2139062017);
		PlayerTextDrawSetShadow(playerid,Normal_Texts[playerid][dialogid][3], 0);
		PlayerTextDrawSetOutline(playerid,Normal_Texts[playerid][dialogid][3], 1);
		PlayerTextDrawBackgroundColor(playerid,Normal_Texts[playerid][dialogid][3], 255);
		PlayerTextDrawFont(playerid,Normal_Texts[playerid][dialogid][3], 1);
		PlayerTextDrawSetProportional(playerid, Normal_Texts[playerid][dialogid][3], 1);
		PlayerTextDrawSetSelectable(playerid, Normal_Texts[playerid][dialogid][3], true);

		Normal_Texts[playerid][dialogid][4] = CreatePlayerTextDraw(playerid,353.796752, 368.082977, button2);
		PlayerTextDrawLetterSize(playerid,Normal_Texts[playerid][dialogid][4], 0.449999, 1.600000);
		PlayerTextDrawTextSize(playerid,Normal_Texts[playerid][dialogid][4], 22.489015, 66.499992);
		PlayerTextDrawAlignment(playerid,Normal_Texts[playerid][dialogid][4], 2);
		PlayerTextDrawColor(playerid,Normal_Texts[playerid][dialogid][4], -1);
		PlayerTextDrawUseBox(playerid,Normal_Texts[playerid][dialogid][4], true);
		PlayerTextDrawBoxColor(playerid,Normal_Texts[playerid][dialogid][4], -2139062017);
		PlayerTextDrawSetShadow(playerid,Normal_Texts[playerid][dialogid][4], 0);
		PlayerTextDrawSetOutline(playerid,Normal_Texts[playerid][dialogid][4], 1);
		PlayerTextDrawBackgroundColor(playerid,Normal_Texts[playerid][dialogid][4], 255);
		PlayerTextDrawFont(playerid,Normal_Texts[playerid][dialogid][4], 1);
		PlayerTextDrawSetProportional(playerid, Normal_Texts[playerid][dialogid][4], 1);
		PlayerTextDrawSetSelectable(playerid, Normal_Texts[playerid][dialogid][4], true);
	}

	//Lines
	Lines_Texts[playerid][dialogid][0] = CreatePlayerTextDraw(playerid,314.378082, 142.916778, line1);
	Lines_Texts[playerid][dialogid][1] = CreatePlayerTextDraw(playerid,314.378082, 142.916778+19.250107000000014, line2);
	Lines_Texts[playerid][dialogid][2] = CreatePlayerTextDraw(playerid,314.378082, 142.916778+19.250107000000014*2, line3);
	Lines_Texts[playerid][dialogid][3] = CreatePlayerTextDraw(playerid,314.378082, 142.916778+19.250107000000014*3, line4);
	Lines_Texts[playerid][dialogid][4] = CreatePlayerTextDraw(playerid,314.378082, 142.916778+19.250107000000014*4, line5);
	Lines_Texts[playerid][dialogid][5] = CreatePlayerTextDraw(playerid,314.378082, 142.916778+19.250107000000014*5, line6);
	Lines_Texts[playerid][dialogid][6] = CreatePlayerTextDraw(playerid,314.378082, 142.916778+19.250107000000014*6, line7);
	Lines_Texts[playerid][dialogid][7] = CreatePlayerTextDraw(playerid,314.378082, 142.916778+19.250107000000014*7, line8);
	Lines_Texts[playerid][dialogid][8] = CreatePlayerTextDraw(playerid,314.378082, 142.916778+19.250107000000014*8, line9);
	Lines_Texts[playerid][dialogid][9] = CreatePlayerTextDraw(playerid,314.378082, 142.916778+19.250107000000014*9, line10);
	Lines_Texts[playerid][dialogid][10] = CreatePlayerTextDraw(playerid,314.378082, 142.916778+19.250107000000014*10, line11);
    for(new i = 0; i < 11; i++)
	{
		PlayerTextDrawLetterSize(playerid,Lines_Texts[playerid][dialogid][i], 0.449999, 1.600000);
		PlayerTextDrawTextSize(playerid,Lines_Texts[playerid][dialogid][i], 15, 555);
		PlayerTextDrawAlignment(playerid,Lines_Texts[playerid][dialogid][i], 2);
		PlayerTextDrawColor(playerid,Lines_Texts[playerid][dialogid][i], -1);
		PlayerTextDrawUseBox(playerid,Lines_Texts[playerid][dialogid][i], true);
		PlayerTextDrawBoxColor(playerid,Lines_Texts[playerid][dialogid][i], -2139062017);
		PlayerTextDrawSetShadow(playerid,Lines_Texts[playerid][dialogid][i], 0);
		PlayerTextDrawSetOutline(playerid,Lines_Texts[playerid][dialogid][i], 1);
		PlayerTextDrawBackgroundColor(playerid,Lines_Texts[playerid][dialogid][i], 51);
		PlayerTextDrawFont(playerid,Lines_Texts[playerid][dialogid][i], 3);
		PlayerTextDrawSetProportional(playerid, Lines_Texts[playerid][dialogid][i], 1);
		PlayerTextDrawSetSelectable(playerid, Lines_Texts[playerid][dialogid][i], true);
	}
	PlayerTextDrawBoxColor(playerid,Lines_Texts[playerid][dialogid][0], 0x00CCFFFF);
	for(new i = 0; i < 5; i++) PlayerTextDrawShow(playerid, Normal_Texts[playerid][dialogid][i]);
	for(new i = 0; i < 11; i++) PlayerTextDrawShow(playerid, Lines_Texts[playerid][dialogid][i]);
	SelectTextDraw(playerid, 0x00FF00FF);
	SetPVarInt(playerid, "selected_on", 0);
	return 1;
}
stock DestroyTextDrawDialog(playerid, dialogid)
{
	for(new i = 0; i < 5; i++) PlayerTextDrawDestroy(playerid, Normal_Texts[playerid][dialogid][i]);
	for(new i = 0; i < 11; i++) PlayerTextDrawDestroy(playerid, Lines_Texts[playerid][dialogid][i]);
	CancelSelectTextDraw(playerid);
	return 1;
}

public OnPlayerClickTextDraw(playerid, Text:clickedid)
{
	if(GetPVarInt(playerid, "menu_active") >= 0)
	{
	    //Escape
	    if(clickedid == Text:INVALID_TEXT_DRAW)
	    {
			CallLocalFunction("OnTextDrawDialogResponse", "dddd", playerid, 0, GetPVarInt(playerid, "menu_active"), -1);
		   	DestroyTextDrawDialog(playerid, GetPVarInt(playerid, "menu_active"));
		   	SetPVarInt(playerid, "menu_active", -1);
		   	SetPVarInt(playerid, "selected_on", -1);
		   	PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
	    }
	}
	return CallLocalFunction("AC_OPCTD", "ii", playerid, _:clickedid);
}
#if defined _ALS_OnPlayerClickTextDraw
	#undef OnPlayerClickTextDraw
#else
	#define _ALS_OnPlayerClickTextDraw
#endif
#define OnPlayerClickTextDraw AC_OPCTD
forward AC_OPCTD(playerid, Text:clickedid);

public OnPlayerClickPlayerTextDraw(playerid, PlayerText:playertextid)
{
	if(GetPVarInt(playerid, "menu_active") >= 0)
	{
		for(new i = 0; i < 11; i++)
		{
		    if(playertextid == Lines_Texts[playerid][GetPVarInt(playerid, "menu_active")][i])
		    {
		        PlayerTextDrawBoxColor(playerid, Lines_Texts[playerid][GetPVarInt(playerid, "menu_active")][0], -2139062017);
		        PlayerTextDrawBoxColor(playerid, Lines_Texts[playerid][GetPVarInt(playerid, "menu_active")][1], -2139062017);
		        PlayerTextDrawBoxColor(playerid, Lines_Texts[playerid][GetPVarInt(playerid, "menu_active")][2], -2139062017);
		        PlayerTextDrawBoxColor(playerid, Lines_Texts[playerid][GetPVarInt(playerid, "menu_active")][3], -2139062017);
		        PlayerTextDrawBoxColor(playerid, Lines_Texts[playerid][GetPVarInt(playerid, "menu_active")][4], -2139062017);
		        PlayerTextDrawBoxColor(playerid, Lines_Texts[playerid][GetPVarInt(playerid, "menu_active")][5], -2139062017);
		        PlayerTextDrawBoxColor(playerid, Lines_Texts[playerid][GetPVarInt(playerid, "menu_active")][6], -2139062017);
		        PlayerTextDrawBoxColor(playerid, Lines_Texts[playerid][GetPVarInt(playerid, "menu_active")][7], -2139062017);
		        PlayerTextDrawBoxColor(playerid, Lines_Texts[playerid][GetPVarInt(playerid, "menu_active")][8], -2139062017);
		        PlayerTextDrawBoxColor(playerid, Lines_Texts[playerid][GetPVarInt(playerid, "menu_active")][9], -2139062017);
		        PlayerTextDrawBoxColor(playerid, Lines_Texts[playerid][GetPVarInt(playerid, "menu_active")][10], -2139062017);
                PlayerTextDrawBoxColor(playerid, Lines_Texts[playerid][GetPVarInt(playerid, "menu_active")][i], 0x00CCFFFF);
                for(new d = 0; d < 11; d++) PlayerTextDrawShow(playerid, Lines_Texts[playerid][GetPVarInt(playerid, "menu_active")][d]);
                SetPVarInt(playerid, "selected_on", i);
                PlayerPlaySound(playerid,1083,0.0,0.0,0.0);
		    }
		}
		if(playertextid == Normal_Texts[playerid][GetPVarInt(playerid, "menu_active")][3]) //Button 1
		{
		    if(GetPVarInt(playerid, "selected_on") >= 0)
		    {
				CallLocalFunction("OnTextDrawDialogResponse", "dddd", playerid, 1, GetPVarInt(playerid, "menu_active"), GetPVarInt(playerid, "selected_on"));
			    DestroyTextDrawDialog(playerid, GetPVarInt(playerid, "menu_active"));
				SetPVarInt(playerid, "menu_active", -1);
				SetPVarInt(playerid, "selected_on", -1);
			   	PlayerPlaySound(playerid,1084,0.0,0.0,0.0);
		    }
		}
		if(playertextid == Normal_Texts[playerid][GetPVarInt(playerid, "menu_active")][4]) //Button 2
		{
  			if(GetPVarInt(playerid, "selected_on") >= 0)
		    {
				CallLocalFunction("OnTextDrawDialogResponse", "dddd", playerid, 0, GetPVarInt(playerid, "menu_active"), GetPVarInt(playerid, "selected_on"));
			    DestroyTextDrawDialog(playerid, GetPVarInt(playerid, "menu_active"));
				SetPVarInt(playerid, "menu_active", -1);
				SetPVarInt(playerid, "selected_on", -1);
			   	PlayerPlaySound(playerid,1084,0.0,0.0,0.0);
			}
		}
	}
	return CallLocalFunction("AC_OPCPTD", "ii", playerid, _:playertextid);
}
#if defined _ALS_OnPlayerClickPlayerTD
	#undef OnPlayerClickPlayerTextDraw
#else
	#define _ALS_OnPlayerClickPlayerTD
#endif
#define OnPlayerClickPlayerTextDraw AC_OPCPTD

forward AC_OPCPTD(playerid, PlayerText:playertextid);



public OnPlayerConnect(playerid){
SetPVarInt(playerid, "menu_active", -1);
SetPVarInt(playerid, "selected_on", -1);
return CallLocalFunction("AC_OPC", "i", playerid);
}
#if defined _ALS_OnPlayerConnect
	#undef OnPlayerConnect
#else
	#define _ALS_OnPlayerConnect
#endif
#define OnPlayerConnect AC_OPC
forward AC_OPC(playerid);

public OnPlayerDisconnect(playerid, reason)
{
    DeletePVar(playerid, "menu_active");
    DeletePVar(playerid, "selected_on");
	return CallLocalFunction("AC_OPDC", "ii", playerid, reason);
}
#if defined _ALS_OnPlayerDisconnect
	#undef OnPlayerDisconnect
#else
	#define _ALS_OnPlayerDisconnect
#endif
#define OnPlayerDisconnect AC_OPDC
forward AC_OPDC(playerid, reason);

