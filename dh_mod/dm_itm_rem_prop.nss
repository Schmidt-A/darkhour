//::///////////////////////////////////////////////
//::
//:: DM_Itm_Rem_Prop
//::
//:: dm_itm_rem_prop.nss
//::
//:: Written for the persistant world of Bryansaar
//:: visit us at http://brynsaar.com/
//::
//:://////////////////////////////////////////////
//::
//:: This script is is used to remove the selected
//:: property from the item previously selected.
//::
//:://////////////////////////////////////////////
//::
//:: Created By: Nordavind
//::         On: June 4, 2004
//::
//:://////////////////////////////////////////////


void main()
{
    object oPC = GetPCSpeaker();
    object oItem = GetLocalObject(oPC, "TARGETED_ITEM");
    object oOwner = GetItemPossessor(oItem);
    itemproperty ipProperty = GetFirstItemProperty(oItem);
    int nCounter = 1;
    int nPropertySelected = GetLocalInt(oPC, "SELECTED_PROPERTY");

    while(GetIsItemPropertyValid(ipProperty) == TRUE && nPropertySelected != nCounter)
    {
        ipProperty = GetNextItemProperty(oItem);
        nCounter ++;
    }

    effect eVis = EffectVisualEffect(VFX_COM_BLOOD_SPARK_LARGE);
    RemoveItemProperty(oItem, ipProperty);

    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oOwner);
    if(GetIsObjectValid(oOwner) == FALSE)
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis, GetLocation(oItem));
}
