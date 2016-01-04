void main()
{
object oPC = GetPCSpeaker();
object oNPC = GetLocalObject(oPC,"NPC_Selected");
if(GetIsPC(oNPC))
{
object oItem = GetFirstItemInInventory(oNPC);
while(oItem!=OBJECT_INVALID)
    {
    SetDroppableFlag(oItem,FALSE);
    oItem = GetNextItemInInventory(oNPC);
    }
SetDroppableFlag(GetItemInSlot(INVENTORY_SLOT_ARMS,oNPC),FALSE);
SetDroppableFlag(GetItemInSlot(INVENTORY_SLOT_ARROWS,oNPC),FALSE);
SetDroppableFlag(GetItemInSlot(INVENTORY_SLOT_BELT,oNPC),FALSE);
SetDroppableFlag(GetItemInSlot(INVENTORY_SLOT_BOLTS,oNPC),FALSE);
SetDroppableFlag(GetItemInSlot(INVENTORY_SLOT_BOOTS,oNPC),FALSE);
SetDroppableFlag(GetItemInSlot(INVENTORY_SLOT_BULLETS,oNPC),FALSE);
SetDroppableFlag(GetItemInSlot(INVENTORY_SLOT_CLOAK,oNPC),FALSE);
SetDroppableFlag(GetItemInSlot(INVENTORY_SLOT_CHEST,oNPC),FALSE);
SetDroppableFlag(GetItemInSlot(INVENTORY_SLOT_HEAD,oNPC),FALSE);
SetDroppableFlag(GetItemInSlot(INVENTORY_SLOT_LEFTHAND,oNPC),FALSE);
SetDroppableFlag(GetItemInSlot(INVENTORY_SLOT_LEFTRING,oNPC),FALSE);
SetDroppableFlag(GetItemInSlot(INVENTORY_SLOT_NECK,oNPC),FALSE);
SetDroppableFlag(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oNPC),FALSE);
SetDroppableFlag(GetItemInSlot(INVENTORY_SLOT_RIGHTRING,oNPC),FALSE);
SetDroppableFlag(GetItemInSlot(INVENTORY_SLOT_CARMOUR,oNPC),FALSE);
SetDroppableFlag(GetItemInSlot(INVENTORY_SLOT_CWEAPON_B,oNPC),FALSE);
SetDroppableFlag(GetItemInSlot(INVENTORY_SLOT_CWEAPON_L,oNPC),FALSE);
SetDroppableFlag(GetItemInSlot(INVENTORY_SLOT_CWEAPON_R,oNPC),FALSE);
}
StoreCampaignObject("NPC_STORAGE","11",oNPC);
SetCampaignString("NPC_STORAGE_NAMES","11",GetName(oNPC));
SendMessageToPC(oPC,GetName(oNPC)+" was stored in Slot 11 Successfully");
}
