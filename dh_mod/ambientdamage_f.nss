#include "x2_inc_cutscene"
#include "nw_i0_plot"
void HXDoColdDamage(int iDamage = 0);
void DoDamage(object oPC, int iDamage);
// This will do cold damage on the party
void HXDoColdDamage(int iDamage = 0)
{
    object oPC = GetFirstPC();
    int iFire = GetLocalInt(oPC, "HX_FIRETYPE");
    int iSafeTime = GetLocalInt(oPC, "HX_FIRETYPE_SAFE");
    int iTime = 0;
    int iTimeOut = 0;
    int iCut;
    object oTorch = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oPC);
    // Do damage to everyone in the area.
    while(GetIsObjectValid(oPC))
    {
        // Don't do damage in a cutscene.
        iCut = CutGetActiveCutsceneForObject(oPC);
        if(iCut < 1)
        {
            if(GetArea(oPC) == OBJECT_SELF)
            {
                if(IsInConversation(oPC))
                {
                    return;
                }
                iSafeTime = GetLocalInt(oPC, "HX_FIRETYPE_SAFE");
                // Do visual if the player is damaged.
                if(iSafeTime <= 0 && GetLocalInt(oPC, "HX_PC_STARTED_FIRE") != 1 && GetLocalInt(oPC, "HX_PC_STANDING_NEAR") != 1)
                {
                    if(iDamage > 0)
                    {
                        DoDamage(oPC, iDamage);
                    }
                }
                else
                {
                 }
                }
            }
        }
        oPC = GetNextPC();
    }
// Get the first PC (if any) in the area.
object GetAreaPC(object oArea)
{
    object oPC = GetFirstPC();

    while(GetIsObjectValid(oPC))
    {
        if(GetArea(oPC) == oArea)
        {
            return oPC;
        }
        oPC = GetNextPC();
    }

    return OBJECT_INVALID;
}

// Do cold damage to PC and associates.
void DoDamage(object oPC, int iDamage)
{
    object oHench1 = GetAssociate(ASSOCIATE_TYPE_HENCHMAN, oPC, 1);
    object oHench2 = GetAssociate(ASSOCIATE_TYPE_HENCHMAN, oPC, 2);
    object oHench3 = GetAssociate(ASSOCIATE_TYPE_HENCHMAN, oPC, 3);
    object oSummoned = GetAssociate(ASSOCIATE_TYPE_SUMMONED, oPC, 1);
    object oDominated = GetAssociate(ASSOCIATE_TYPE_DOMINATED, oPC, 1);
    object oAnimal = GetAssociate(ASSOCIATE_TYPE_ANIMALCOMPANION, oPC, 1);
    object oFamiliar = GetAssociate(ASSOCIATE_TYPE_FAMILIAR, oPC, 1);
    object oTorch = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oPC);


    // Damage the PC
    if(GetTag(oTorch) != "hx_berry_torch")
    {
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(iDamage, DAMAGE_TYPE_FIRE), oPC);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_FLAME_S), oPC);
    }
    // Damage any associates.
    if(GetIsObjectValid(oHench1))
    {
        oTorch = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oHench1);
        if(GetTag(oTorch) != "hx_berry_torch")
        {
            ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(iDamage, DAMAGE_TYPE_FIRE), oHench1);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_FLAME_S), oHench1);
        }
    }
    if(GetIsObjectValid(oHench2))
    {
        oTorch = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oHench2);
        if(GetTag(oTorch) != "hx_berry_torch")
        {
            ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(iDamage, DAMAGE_TYPE_FIRE), oHench2);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_FLAME_S), oHench2);
        }
    }
    if(GetIsObjectValid(oHench3))
    {
        oTorch = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oHench3);
        if(GetTag(oTorch) != "hx_berry_torch")
        {
            ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(iDamage, DAMAGE_TYPE_FIRE), oHench3);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_FLAME_S), oHench3);
        }
    }
    if(GetIsObjectValid(oSummoned))
    {
        oTorch = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oSummoned);
        if(GetTag(oTorch) != "hx_berry_torch")
        {
            ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(iDamage, DAMAGE_TYPE_FIRE), oSummoned);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_FLAME_S), oSummoned);
        }
    }
    if(GetIsObjectValid(oDominated))
    {
        oTorch = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oDominated);
        if(GetTag(oTorch) != "hx_berry_torch")
        {
            ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(iDamage, DAMAGE_TYPE_FIRE), oDominated);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_FLAME_S), oDominated);
        }
    }
    if(GetIsObjectValid(oAnimal))
    {
        oTorch = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oAnimal);
        if(GetTag(oTorch) != "hx_berry_torch")
        {
            ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(iDamage, DAMAGE_TYPE_FIRE), oAnimal);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_FLAME_S), oAnimal);
        }
    }
    if(GetIsObjectValid(oFamiliar))
    {
        oTorch = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oFamiliar);
        if(GetTag(oTorch) != "hx_berry_torch")
        {
            ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(iDamage, DAMAGE_TYPE_FIRE), oFamiliar);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_FLAME_S), oFamiliar);
        }
    }
}
