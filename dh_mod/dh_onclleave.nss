void main()
{
object oPC = GetExitingObject();
location lLocation = GetLocation(oPC);
string sModName = GetName(GetModule());
SetCampaignLocation(sModName, "lastlocation", lLocation, oPC);
}
