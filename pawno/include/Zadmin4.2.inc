/*=======================
 < Zuc's admin include >             Working only with ZADMIN (from version 3.4)
============ Commands: ============
|1): IsAdminLevel(playerid,level) |
|2): IsNotAdmin(playerid)         |
|3): IsPlayerVIP(playerid,level)  |
|4): IsNotVIP(playerid)           |
|5): IsPlayerMuted(playerid)      |
|6): IsPlayerJailed(playerid)     |
|7): IsPlayerFreezed(playerid)    |
===================================
*/
#if defined _Zadmin_included
  #endinput
#endif
#define _Zadmin_included
#pragma library Zadmin
#pragma unused ret_memcpy

#include <a_samp>
#include <dudb>

#define COL_WHITE          "{FFFFFF}"
#define COL_BLACK          "{0E0101}"
#define COL_GREY           "{C3C3C3}"
#define COL_GREEN          "{6EF83C}"
#define COL_RED            "{F81414}"
#define COL_YELLOW         "{F3FF02}"
#define COL_ORANGE         "{FFAF00}"
#define COL_CYAN           "{00FFEE}"
#define COL_LIGHTBLUE      "{00C0FF}"
#define COL_BLUE           "{0049FF}"
#define COL_VIOLET         "{B700FF}"
#define COL_PINK           "{FF00EA}"
#define COL_MARONE         "{A90202}"

forward IsAdminLevel(playerid, level);
public IsAdminLevel(playerid, level){
  new tmp,tmp2;
  new xpname[24],xfile[128];
  GetPlayerName(playerid, xpname, sizeof(xpname));
  format(xfile, sizeof(xfile), "ZASystem/Users/%s.sav", xpname);
  tmp = dini_Int(xfile,"adminlevel");
  tmp2 = dini_Int(xfile,"loggedin");
  if( (IsPlayerConnected(playerid)) && (tmp >= level) && tmp2==1)
	return true;
  else return false;}

forward IsNotAdmin(playerid);
public IsNotAdmin(playerid){
  new tmp;
  new xpname[24],xfile[128];
  GetPlayerName(playerid, xpname, sizeof(xpname));
  format(xfile, sizeof(xfile), "ZASystem/Users/%s.sav", xpname);
  tmp = dini_Int(xfile,"adminlevel");
  if((IsPlayerConnected(playerid)) && tmp == 0)
	return true;
  else return false;}
  
forward IsPlayerVIP(playerid, level);
public IsPlayerVIP(playerid, level){
  new tmp,tmp2;
  new xpname[24],xfile[128];
  GetPlayerName(playerid, xpname, sizeof(xpname));
  format(xfile, sizeof(xfile), "ZASystem/Users/%s.sav", xpname);
  tmp = dini_Int(xfile,"VIP");
  tmp2 = dini_Int(xfile,"loggedin");
  if( (IsPlayerConnected(playerid)) && (tmp >= level) && tmp2==1)
	return true;
  else return false;}
  
forward IsNotVIP(playerid);
public IsNotVIP(playerid){
  new tmp;
  new xpname[24],xfile[128];
  GetPlayerName(playerid, xpname, sizeof(xpname));
  format(xfile, sizeof(xfile), "ZASystem/Users/%s.sav", xpname);
  tmp = dini_Int(xfile,"VIP");
  if((IsPlayerConnected(playerid)) && tmp == 0)
	return true;
  else return false;}
  
forward IsPlayerMuted(playerid);
public IsPlayerMuted(playerid){
  new tmp;
  new xpname[24],xfile[128];
  GetPlayerName(playerid, xpname, sizeof(xpname));
  format(xfile, sizeof(xfile), "ZASystem/Users/%s.sav", xpname);
  tmp = dini_Int(xfile,"muted");
  if((IsPlayerConnected(playerid)) && tmp == 1)
	return true;
  else return false;}
  
forward IsPlayerJailed(playerid);
public IsPlayerJailed(playerid){
  new tmp;
  new xpname[24],xfile[128];
  GetPlayerName(playerid, xpname, sizeof(xpname));
  format(xfile, sizeof(xfile), "ZASystem/Users/%s.sav", xpname);
  tmp = dini_Int(xfile,"jailed");
  if((IsPlayerConnected(playerid)) && tmp == 1)
	return true;
  else return false;}
  
forward IsPlayerFreezed(playerid);
public IsPlayerFreezed(playerid){
  new tmp;
  new xpname[24],xfile[128];
  GetPlayerName(playerid, xpname, sizeof(xpname));
  format(xfile, sizeof(xfile), "ZASystem/Users/%s.sav", xpname);
  tmp = dini_Int(xfile,"freezed");
  if((IsPlayerConnected(playerid)) && tmp == 1)
	return true;
  else return false;}
  
//****************************************************************************//
