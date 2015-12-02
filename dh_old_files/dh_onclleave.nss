#include "_incl_xp"

void main()
{
	object oPC = GetExitingObject();
	location lLocation = GetLocation(oPC);
	string sModName = GetName(GetModule());
	SetCampaignLocation(sModName, "lastlocation", lLocation, oPC);

	//log their exp on logout
	WriteTimestampedLogEntry("EXIT: " + GetName(oPC) + " | " + GetPCPublicCDKey(oPC) + 
	                " | " + GetPCIPAddress(oPC) + " | " + GetXPDH(oPC));
}
