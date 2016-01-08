//::///////////////////////////////////////////////
//:: Name hx_inc_ring
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
     This will create the "ring vision" when a PC
     equips the ring that guides them through Hell.
     It will make the area dark, and will create a
     bunch of glowing arrows pointing in the
     direction the PC needs to go.

     Removing the ring will destroy the "ring
     vision".

     There are other useful functions in here,
     explained below.
*/
//:://////////////////////////////////////////////
//:: Created By: Brad Prince
//:: Created On: July 23, 2003
//:://////////////////////////////////////////////
#include "x2_inc_cutscene"
#include "nw_i0_plot"
// This will set the area enter for areas.
void HXAreaEnter(object oPC);
// This will damage the player every hearbeat for being in the cold.
void HXDoColdDamage(int iDamage = 0);
// Get the first PC (if any) in the area.
object GetAreaPC(object oArea);
// Do cold damage to PC and associates.
void DoDamage(object oPC, int iDamage);

// This will do cold damage on the party, unless they made a fire recently.
void HXDoColdDamage(int iDamage = 0)
{
    object oPC = GetFirstPC();
    int iFire = GetLocalInt(oPC, "HX_FIRETYPE");
    int iSafeTime = GetLocalInt(oPC, "HX_FIRETYPE_SAFE");
    int iTime = 0;
    int iTimeOut = 0;
    int iCut;
    object oTorch = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oPC);

    if(iFire == 1)
    {
        iTime = 6;
        iTimeOut = 1;
        if(iSafeTime == 0)
        {
            SetLocalInt(oPC, "HX_FIRETYPE_SAFE", iTime);
        }
    }
    else if(iFire == 2)
    {
        iTime = 15;
        iTimeOut = 2;
        if(iSafeTime == 0)
        {
            SetLocalInt(oPC, "HX_FIRETYPE_SAFE", iTime);
        }
    }
    else if(iFire == 3)
    {
        iTime = 30;
        iTimeOut = 2;
        if(iSafeTime == 0)
        {
            SetLocalInt(oPC, "HX_FIRETYPE_SAFE", iTime);
        }
    }

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
                    if(GetLocalInt(oPC, "HX_PC_STARTED_FIRE") != 1 && GetLocalInt(oPC, "HX_PC_STANDING_NEAR") != 1)
                    {
                        if(iSafeTime == iTime/2)
                        {
                        }
                        else if(iSafeTime == iTimeOut)
                        {
                        }
                        SetLocalInt(oPC, "HX_FIRETYPE_SAFE", iSafeTime - 1);
                        if(GetLocalInt(oPC, "HX_FIRETYPE_SAFE") <= 0)
                        {
                            SetLocalInt(oPC, "HX_FIRETYPE", 0);
                        }
                    }
                }
            }
        }
        oPC = GetNextPC();
    }
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
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(iDamage, DAMAGE_TYPE_ACID), oPC);

    }
    // Damage any associates.
    if(GetIsObjectValid(oHench1))
    {
        oTorch = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oHench1);
        if(GetTag(oTorch) != "hx_berry_torch")
        {
            ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(iDamage, DAMAGE_TYPE_ACID), oHench1);

        }
    }
    if(GetIsObjectValid(oHench2))
    {
        oTorch = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oHench2);
        if(GetTag(oTorch) != "hx_berry_torch")
        {
            ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(iDamage, DAMAGE_TYPE_ACID), oHench2);

        }
    }
    if(GetIsObjectValid(oHench3))
    {
        oTorch = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oHench3);
        if(GetTag(oTorch) != "hx_berry_torch")
        {
            ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(iDamage, DAMAGE_TYPE_ACID), oHench3);

        }
    }
    if(GetIsObjectValid(oSummoned))
    {
        oTorch = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oSummoned);
        if(GetTag(oTorch) != "hx_berry_torch")
        {
            ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(iDamage, DAMAGE_TYPE_ACID), oSummoned);

        }
    }
    if(GetIsObjectValid(oDominated))
    {
        oTorch = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oDominated);
        if(GetTag(oTorch) != "hx_berry_torch")
        {
            ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(iDamage, DAMAGE_TYPE_ACID), oDominated);

        }
    }
    if(GetIsObjectValid(oAnimal))
    {
        oTorch = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oAnimal);
        if(GetTag(oTorch) != "hx_berry_torch")
        {
            ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(iDamage, DAMAGE_TYPE_ACID), oAnimal);

        }
    }
    if(GetIsObjectValid(oFamiliar))
    {
        oTorch = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oFamiliar);
        if(GetTag(oTorch) != "hx_berry_torch")
        {
            ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(iDamage, DAMAGE_TYPE_ACID), oFamiliar);

        }
    }
}
//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::



















