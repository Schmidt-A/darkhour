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
void Liquid(object oPC, int iDamage);

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
                        Liquid(oPC, iDamage);
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
void Liquid(object oPC, int iDamage)
{
    object oHench1 = GetAssociate(ASSOCIATE_TYPE_HENCHMAN, oPC, 1);
    object oHench2 = GetAssociate(ASSOCIATE_TYPE_HENCHMAN, oPC, 2);
    object oHench3 = GetAssociate(ASSOCIATE_TYPE_HENCHMAN, oPC, 3);
    object oSummoned = GetAssociate(ASSOCIATE_TYPE_SUMMONED, oPC, 1);
    object oDominated = GetAssociate(ASSOCIATE_TYPE_DOMINATED, oPC, 1);
    object oAnimal = GetAssociate(ASSOCIATE_TYPE_ANIMALCOMPANION, oPC, 1);
    object oFamiliar = GetAssociate(ASSOCIATE_TYPE_FAMILIAR, oPC, 1);
    object oTorch = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oPC);
    int trueremaining;
    int nInt;
    effect eEffect2;
effect eEffect99;
string remaining;

    // Damage the PC
    if(GetTag(oTorch) != "hx_berry_torch")
    {
        nInt = GetLocalInt(oPC, "Breath");
        trueremaining=nInt-iDamage;
remaining = IntToString(trueremaining);
SetLocalInt(oPC, "Breath", nInt-iDamage);
FloatingTextStringOnCreature("Your lungs contain "+ remaining +"% oxygen", oPC);
if (GetLocalInt(oPC, "Breath")<= 0)
{
if (GetTag(GetItemInSlot(INVENTORY_SLOT_CARMOUR, oPC)) == "AquaticElfProperties")
   {
   }
   else
   {
   FloatingTextStringOnCreature("You have drowned", oPC);
   eEffect99 = EffectDeath();

   ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect99, oPC);

   }
}
else
   {
   nInt = GetLocalInt(oPC, "Breath");
if (GetTag(GetItemInSlot(INVENTORY_SLOT_CARMOUR, oPC)) == "AquaticElfProperties")
{
eEffect2 = EffectMovementSpeedDecrease(45);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect2, oPC);
}
else
{
eEffect2 = EffectMovementSpeedDecrease(75);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect2, oPC);
}
/////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////
    }
    // Damage any associates.
    if(GetIsObjectValid(oHench1))
    {
        oTorch = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oHench1);
        if(GetTag(oTorch) != "hx_berry_torch")
        {
        nInt = GetLocalInt(oHench1, "Breath");
        trueremaining=nInt-iDamage;
remaining = IntToString(trueremaining);
SetLocalInt(oHench1, "Breath", nInt-iDamage);
FloatingTextStringOnCreature("Your lungs contain "+ remaining +"% oxygen", oHench1);
if (GetLocalInt(oPC, "Breath")<= 0)
{
if (GetTag(GetItemInSlot(INVENTORY_SLOT_CARMOUR, oHench1)) == "AquaticElfProperties")
   {
   }
   else
   {
   FloatingTextStringOnCreature("You have drowned", oHench1);
   eEffect99 = EffectDeath();

   ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect99, oHench1);

   }
}
else
   {
   nInt = GetLocalInt(oPC, "Breath");
if (GetTag(GetItemInSlot(INVENTORY_SLOT_CARMOUR, oHench1)) == "AquaticElfProperties")
{
eEffect2 = EffectMovementSpeedDecrease(45);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect2, oHench1);
}
else
{
eEffect2 = EffectMovementSpeedDecrease(75);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect2, oHench1);
}
    }
            }
    }
    /////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////
    if(GetIsObjectValid(oHench2))
    {
        oTorch = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oHench2);
        if(GetTag(oTorch) != "hx_berry_torch")
        {
        nInt = GetLocalInt(oHench2, "Breath");
        trueremaining=nInt-iDamage;
remaining = IntToString(trueremaining);
SetLocalInt(oHench2, "Breath", nInt-iDamage);
FloatingTextStringOnCreature("Your lungs contain "+ remaining +"% oxygen", oHench2);
if (GetLocalInt(oPC, "Breath")<= 0)
{
if (GetTag(GetItemInSlot(INVENTORY_SLOT_CARMOUR, oHench2)) == "AquaticElfProperties")
   {
   }
   else
   {
   FloatingTextStringOnCreature("You have drowned", oHench2);
   eEffect99 = EffectDeath();

   ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect99, oHench2);

   }
}
else
   {
   nInt = GetLocalInt(oHench2, "Breath");
if (GetTag(GetItemInSlot(INVENTORY_SLOT_CARMOUR, oHench2)) == "AquaticElfProperties")
{
eEffect2 = EffectMovementSpeedDecrease(45);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect2, oHench2);
}
else
{
eEffect2 = EffectMovementSpeedDecrease(75);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect2, oHench2);
}
    }
            }
    }
    if(GetIsObjectValid(oHench3))
    {
        oTorch = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oHench3);
        if(GetTag(oTorch) != "hx_berry_torch")
        {
        nInt = GetLocalInt(oHench3, "Breath");
        trueremaining=nInt-iDamage;
remaining = IntToString(trueremaining);
SetLocalInt(oHench3, "Breath", nInt-iDamage);
FloatingTextStringOnCreature("Your lungs contain "+ remaining +"% oxygen", oHench3);
if (GetLocalInt(oHench3, "Breath")<= 0)
{
if (GetTag(GetItemInSlot(INVENTORY_SLOT_CARMOUR, oHench3)) == "AquaticElfProperties")
   {
   }
   else
   {
   FloatingTextStringOnCreature("You have drowned", oHench3);
   eEffect99 = EffectDeath();

   ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect99, oHench3);

   }
}
else
   {
   nInt = GetLocalInt(oHench3, "Breath");
if (GetTag(GetItemInSlot(INVENTORY_SLOT_CARMOUR, oHench3)) == "AquaticElfProperties")
{
eEffect2 = EffectMovementSpeedDecrease(45);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect2, oHench3);
}
else
{
eEffect2 = EffectMovementSpeedDecrease(75);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect2, oHench3);
}
    }
            }
    }
    if(GetIsObjectValid(oSummoned))
    {
        oTorch = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oSummoned);
        if(GetTag(oTorch) != "hx_berry_torch")
        {
        nInt = GetLocalInt(oSummoned, "Breath");
        trueremaining=nInt-iDamage;
remaining = IntToString(trueremaining);
SetLocalInt(oSummoned, "Breath", nInt-iDamage);
FloatingTextStringOnCreature("Your lungs contain "+ remaining +"% oxygen", oSummoned);
if (GetLocalInt(oSummoned, "Breath")<= 0)
{
if (GetTag(GetItemInSlot(INVENTORY_SLOT_CARMOUR, oSummoned)) == "AquaticElfProperties")
   {
   }
   else
   {
   FloatingTextStringOnCreature("You have drowned", oSummoned);
   eEffect99 = EffectDeath();

   ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect99, oSummoned);

   }
}
else
   {
   nInt = GetLocalInt(oSummoned, "Breath");
if (GetTag(GetItemInSlot(INVENTORY_SLOT_CARMOUR, oSummoned)) == "AquaticElfProperties")
{
eEffect2 = EffectMovementSpeedDecrease(45);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect2, oSummoned);
}
else
{
eEffect2 = EffectMovementSpeedDecrease(75);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect2, oSummoned);
}
    };
        }
    }
    if(GetIsObjectValid(oDominated))
    {
        oTorch = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oDominated);
        if(GetTag(oTorch) != "hx_berry_torch")
        {
        nInt = GetLocalInt(oDominated, "Breath");
        trueremaining=nInt-iDamage;
remaining = IntToString(trueremaining);
SetLocalInt(oDominated, "Breath", nInt-iDamage);
FloatingTextStringOnCreature("Your lungs contain "+ remaining +"% oxygen", oDominated);
if (GetLocalInt(oDominated, "Breath")<= 0)
{
if (GetTag(GetItemInSlot(INVENTORY_SLOT_CARMOUR, oDominated)) == "AquaticElfProperties")
   {
   }
   else
   {
   FloatingTextStringOnCreature("You have drowned", oDominated);
   eEffect99 = EffectDeath();

   ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect99, oDominated);

   }
}
else
   {
   nInt = GetLocalInt(oDominated, "Breath");
if (GetTag(GetItemInSlot(INVENTORY_SLOT_CARMOUR, oDominated)) == "AquaticElfProperties")
{
eEffect2 = EffectMovementSpeedDecrease(45);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect2, oDominated);
}
else
{
eEffect2 = EffectMovementSpeedDecrease(75);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect2, oDominated);
}
    }
            }
    }
    if(GetIsObjectValid(oAnimal))
    {
        oTorch = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oAnimal);
        if(GetTag(oTorch) != "hx_berry_torch")
        {
        nInt = GetLocalInt(oAnimal, "Breath");
        trueremaining=nInt-iDamage;
remaining = IntToString(trueremaining);
SetLocalInt(oAnimal, "Breath", nInt-iDamage);
FloatingTextStringOnCreature("Your lungs contain "+ remaining +"% oxygen", oAnimal);
if (GetLocalInt(oAnimal, "Breath")<= 0)
{
if (GetTag(GetItemInSlot(INVENTORY_SLOT_CARMOUR, oAnimal)) == "AquaticElfProperties")
   {
   }
   else
   {
   FloatingTextStringOnCreature("You have drowned", oAnimal);
   eEffect99 = EffectDeath();

   ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect99, oAnimal);

   }
}
else
   {
   nInt = GetLocalInt(oAnimal, "Breath");
if (GetTag(GetItemInSlot(INVENTORY_SLOT_CARMOUR, oAnimal)) == "AquaticElfProperties")
{
eEffect2 = EffectMovementSpeedDecrease(45);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect2, oAnimal);
}
else
{
eEffect2 = EffectMovementSpeedDecrease(75);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect2, oAnimal);
}
    }
            }
    }
    if(GetIsObjectValid(oFamiliar))
    {
        oTorch = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oFamiliar);
        if(GetTag(oTorch) != "hx_berry_torch")
        {
        nInt = GetLocalInt(oFamiliar, "Breath");
        trueremaining=nInt-iDamage;
remaining = IntToString(trueremaining);
SetLocalInt(oFamiliar, "Breath", nInt-iDamage);
FloatingTextStringOnCreature("Your lungs contain "+ remaining +"% oxygen", oFamiliar);
if (GetLocalInt(oFamiliar, "Breath")<= 0)
{
if (GetTag(GetItemInSlot(INVENTORY_SLOT_CARMOUR, oFamiliar)) == "AquaticElfProperties")
   {
   }
   else
   {
   FloatingTextStringOnCreature("You have drowned", oFamiliar);
   eEffect99 = EffectDeath();

   ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect99, oFamiliar);

   }
}
else
   {
   nInt = GetLocalInt(oFamiliar, "Breath");
if (GetTag(GetItemInSlot(INVENTORY_SLOT_CARMOUR, oFamiliar)) == "AquaticElfProperties")
{
eEffect2 = EffectMovementSpeedDecrease(45);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect2, oFamiliar);
}
else
{
eEffect2 = EffectMovementSpeedDecrease(75);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect2, oFamiliar);
}
}
}
}
}
}

