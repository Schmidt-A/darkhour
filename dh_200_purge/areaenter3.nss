void DestroyAllYourStuff(object oPC)
{
    object oItem = GetFirstItemInInventory(oPC);
    while (oItem != OBJECT_INVALID)
    {
        if ((GetTag(oItem)!="DeathToken") && (GetTag(oItem)!="scavenger") && (GetTag(oItem)!="dmfi_pc_dicebag") && (GetTag(oItem)!="ZombieKill") && (GetTag(oItem)!="FrenzyKill") && (GetTag(oItem)!="SurvivalTime") && (GetTag(oItem)!="ZK10") && (GetTag(oItem)!="ZKHUNDRED") && (GetTag(oItem)!="FK10") && (GetTag(oItem)!="ST10") && (GetTag(oItem)!="SanctuaryToken") && (GetTag(oItem)!="ZombieDisease") && (GetStringLeft(GetTag(oItem),5)!="badge"))
        {
            DestroyObject(oItem);
        }
        oItem = GetNextItemInInventory(oPC);
    }
}

void main()
{
    object oPC = GetEnteringObject();
    if (GetIsDM(oPC) == FALSE)
    {
        object oItem = GetItemInSlot(INVENTORY_SLOT_ARMS,oPC);
        ActionUnequipItem(oItem);
        oItem = GetItemInSlot(INVENTORY_SLOT_ARROWS,oPC);
        ActionUnequipItem(oItem);
        oItem = GetItemInSlot(INVENTORY_SLOT_BELT,oPC);
        ActionUnequipItem(oItem);
        oItem = GetItemInSlot(INVENTORY_SLOT_BOLTS,oPC);
        ActionUnequipItem(oItem);
        oItem = GetItemInSlot(INVENTORY_SLOT_BOOTS,oPC);
        ActionUnequipItem(oItem);
        oItem = GetItemInSlot(INVENTORY_SLOT_BULLETS,oPC);
        ActionUnequipItem(oItem);
        oItem = GetItemInSlot(INVENTORY_SLOT_CHEST,oPC);
        ActionUnequipItem(oItem);
        oItem = GetItemInSlot(INVENTORY_SLOT_CLOAK,oPC);
        ActionUnequipItem(oItem);
        oItem = GetItemInSlot(INVENTORY_SLOT_HEAD,oPC);
        ActionUnequipItem(oItem);
        oItem = GetItemInSlot(INVENTORY_SLOT_LEFTHAND,oPC);
        ActionUnequipItem(oItem);
        oItem = GetItemInSlot(INVENTORY_SLOT_LEFTRING,oPC);
        ActionUnequipItem(oItem);
        oItem = GetItemInSlot(INVENTORY_SLOT_NECK,oPC);
        ActionUnequipItem(oItem);
        oItem = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oPC);
        ActionUnequipItem(oItem);
        oItem = GetItemInSlot(INVENTORY_SLOT_RIGHTRING,oPC);
        ActionUnequipItem(oItem);
        DelayCommand(0.5,DestroyAllYourStuff(oPC));
    }
}
