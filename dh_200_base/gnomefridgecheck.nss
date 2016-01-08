void main()
{
int iTime = (GetCampaignInt(GetName(GetModule()), "fridgetimeleft", GetNearestObjectByTag("GnomishRefrigerator")) / 60);
SendMessageToPC(GetPCSpeaker(), "There are " + IntToString(iTime) + " hours worth of refrigerant remaining.");
}
