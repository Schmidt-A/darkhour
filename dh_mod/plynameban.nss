void main()
{
object oBanned = GetLocalObject(GetPCSpeaker(),"BanWandTarget");
string sPLAYERNAME = GetPCPlayerName(oBanned);
SetCampaignInt(sPLAYERNAME+"_BANNED",sPLAYERNAME,TRUE);
BootPC(oBanned);
}
