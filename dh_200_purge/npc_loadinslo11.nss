void main()
{
object oPC = GetPCSpeaker();
object oNPC = RetrieveCampaignObject("NPC_STORAGE","11",GetLocalLocation(oPC,"NPC_Location"));
TakeGoldFromCreature(GetGold(oNPC),oNPC,TRUE);
SendMessageToPC(oPC,GetName(oNPC)+" in Slot 11 was loaded Successfully");
}
