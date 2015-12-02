void main()
{
object oPc = GetItemActivator();

    object oWeaponL = GetItemInSlot (INVENTORY_SLOT_LEFTHAND, oPc);
    object oWeaponR = GetItemInSlot (INVENTORY_SLOT_RIGHTHAND, oPc);
    object oHead = GetItemInSlot (INVENTORY_SLOT_HEAD, oPc);
    object oBelt = GetItemInSlot (INVENTORY_SLOT_BELT, oPc);
    object oBolts = GetItemInSlot (INVENTORY_SLOT_BOLTS, oPc);
    object oBoots = GetItemInSlot (INVENTORY_SLOT_BOOTS, oPc);
    object oArms = GetItemInSlot (INVENTORY_SLOT_ARMS, oPc);
    object oArrows = GetItemInSlot (INVENTORY_SLOT_ARROWS, oPc);
    object oBullets = GetItemInSlot (INVENTORY_SLOT_BULLETS, oPc);
    object oChest = GetItemInSlot (INVENTORY_SLOT_CHEST, oPc);
    object oCloak = GetItemInSlot (INVENTORY_SLOT_CLOAK, oPc);
    object oLRing = GetItemInSlot (INVENTORY_SLOT_LEFTRING, oPc);
    object oRRing = GetItemInSlot (INVENTORY_SLOT_RIGHTRING, oPc);
    object oAmulet = GetItemInSlot (INVENTORY_SLOT_NECK, oPc);
    AssignCommand(oPc, ActionEquipItem(oWeaponL, INVENTORY_SLOT_LEFTHAND));
    AssignCommand(oPc, ActionEquipItem(oWeaponR, INVENTORY_SLOT_RIGHTHAND));
    AssignCommand(oPc, ActionEquipItem(oHead, INVENTORY_SLOT_HEAD));
    AssignCommand(oPc, ActionEquipItem(oBelt, INVENTORY_SLOT_BELT));
    AssignCommand(oPc, ActionEquipItem(oBolts, INVENTORY_SLOT_BOLTS));
    AssignCommand(oPc, ActionEquipItem(oBoots, INVENTORY_SLOT_BOOTS));
    AssignCommand(oPc, ActionEquipItem(oArms, INVENTORY_SLOT_ARMS));
    AssignCommand(oPc, ActionEquipItem(oArrows, INVENTORY_SLOT_ARROWS));
    AssignCommand(oPc, ActionEquipItem(oBullets, INVENTORY_SLOT_BULLETS));
    AssignCommand(oPc, ActionEquipItem(oChest, INVENTORY_SLOT_CHEST));
    AssignCommand(oPc, ActionEquipItem(oCloak, INVENTORY_SLOT_CLOAK));
    AssignCommand(oPc, ActionEquipItem(oLRing, INVENTORY_SLOT_LEFTRING));
    AssignCommand(oPc, ActionEquipItem(oRRing, INVENTORY_SLOT_RIGHTRING));
    AssignCommand(oPc, ActionEquipItem(oAmulet, INVENTORY_SLOT_NECK));
}
