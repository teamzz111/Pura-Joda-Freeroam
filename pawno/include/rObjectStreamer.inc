/*
	RyDeR`s Object Streamer v0.1b
*/

#if defined _INC_rObjectStreamer
	#endinput
#endif

#define _INC_rObjectStreamer

forward OnStreamedObjectMoved(objectid);

stock IsValidStreamedObject(objectid)
{
	return CallRemoteFunction("IsValidStreamedObject", "i", objectid);
}

stock CreateStreamedObject(modelid, Float: x, Float: y, Float: z, Float: rx, Float: ry, Float: rz, virtualworld = -1, interior = -1, playerid = -1, Float: drawdistance = 0.0)
{
	return CallRemoteFunction("CreateStreamedObject", "iffffffiiif", modelid, x, y, z, rx, ry, rz, virtualworld, interior, playerid, drawdistance);
}

stock DestroyStreamedObject(objectid)
{
	return CallRemoteFunction("DestroyStreamedObject", "i", objectid);
}

stock MoveStreamedObject(objectid, Float: x, Float: y, Float: z, Float: speed)
{
	return CallRemoteFunction("MoveStreamedObject", "iffff", objectid, x, y, z, speed);
}

stock StopStreamedObject(objectid)
{
	return CallRemoteFunction("StopStreamedObject", "i", objectid);
}

stock SetStreamedObjectPos(objectid, Float: x, Float: y, Float: z)
{
	return CallRemoteFunction("SetStreamedObjectPos", "ifff", objectid, x, y, z);
}

stock GetStreamedObjectPos(objectid, &Float: x, &Float: y, &Float: z)
{
	if(IsValidStreamedObject(objectid))
	{
		CallRemoteFunction("UpdateMovingXYZ", "i", objectid);
		x = Float: CallRemoteFunction("GetStreamedObjectPos", "ii", objectid, 0);
		y = Float: CallRemoteFunction("GetStreamedObjectPos", "ii", objectid, 1);
		z = Float: CallRemoteFunction("GetStreamedObjectPos", "ii", objectid, 2);
		return 1;
	}
	return 0;
}

stock SetStreamedObjectRot(objectid, Float: rx, Float: ry, Float: rz)
{
	return CallRemoteFunction("SetStreamedObjectRot", "ifff", objectid, rx, ry, rz);
}

stock GetStreamedObjectRot(objectid, &Float: rx, &Float: ry, &Float: rz)
{
	if(IsValidStreamedObject(objectid))
	{
		rx = Float: CallRemoteFunction("GetStreamedObjectRot", "ii", objectid, 0);
		ry = Float: CallRemoteFunction("GetStreamedObjectRot", "ii", objectid, 1);
		rz = Float: CallRemoteFunction("GetStreamedObjectRot", "ii", objectid, 2);
		return 1;
	}
	return 0;
}

stock __SetPlayerPos(playerid, Float: x, Float: y, Float: z)
{
	return CallRemoteFunction("__SetPlayerPos", "ifff", playerid, x, y, z);
}

#define SetPlayerPos \
	__SetPlayerPos

stock __SetVehiclePos(vehicleid, Float: x, Float: y, Float: z)
{
	return CallRemoteFunction("__SetVehiclePos", "ifff", vehicleid, x, y, z);
}

#define SetVehiclePos \
	__SetVehiclePos