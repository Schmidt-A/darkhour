void main()
{
object oBanned = GetLocalObject(GetPCSpeaker(),"BanWandTarget");
string sCDKEY = GetPCPublicCDKey(oBanned);
SetCampaignInt(sCDKEY+"_BANNED",sCDKEY,TRUE);
BootPC(oBanned);
}
