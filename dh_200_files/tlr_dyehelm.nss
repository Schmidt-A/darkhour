//::///////////////////////////////////////////////
//:: Tailoring - Dye Helmet
//:: tlr_dyehelm.nss
//:://////////////////////////////////////////////
/*
    Dye the helmet.
*/
//:://////////////////////////////////////////////
//:: Created By: Stacy L. Ropella
//:: from Mandragon's mil_tailor
//:://////////////////////////////////////////////

void main()
{
    object oPC = OBJECT_SELF;

    int iMaterialToDye = GetLocalInt(oPC, "MaterialToDye");
    int iColorGroup = GetLocalInt(oPC, "ColorGroup");
    int iColorToDye = GetLocalInt(oPC, "ColorToDye");

    int iColor = (iColorGroup * 8) + iColorToDye;
    object oItem = GetItemInSlot(INVENTORY_SLOT_HEAD, oPC);

    if (GetIsObjectValid(oItem)) {
        // Dye the item
        object oDyedItem = CopyItemAndModify(oItem, ITEM_APPR_TYPE_ARMOR_COLOR, iMaterialToDye, iColor, TRUE);
        DestroyObject(oItem);

        // Equip the armor
       DelayCommand(0.5f, AssignCommand(oPC, ActionEquipItem(oDyedItem, INVENTORY_SLOT_HEAD)));
    }
}
