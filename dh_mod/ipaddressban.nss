void main()
{
object oBanned = GetLocalObject(GetPCSpeaker(),"BanWandTarget");
string sIPADDRESS = GetPCIPAddress(oBanned);
SetCampaignInt(sIPADDRESS+"_BANNED",sIPADDRESS,TRUE);
BootPC(oBanned);
}
