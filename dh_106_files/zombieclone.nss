//::///////////////////////////////////////////////
//:: Name act_q2bmirror_4
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Spawn in the Clone of the PC and attack
    MODIFIED BY MHADLEY TO CREATE A ZOMBIE CLONE
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Warner
//:: Created On: Sept 10/03
//:://////////////////////////////////////////////
#include "nw_i0_generic"
void CloneFight()
{
    DetermineCombatRound();
    if ((GetCurrentAction() == ACTION_INVALID) && (GetLocalInt(OBJECT_SELF,"feeding") == 0))
    {
        ClearAllActions();
        ActionRandomWalk();
    }
    DelayCommand(6.0, CloneFight());
}
void CreateClone(location lMirror)
{

    object oPC = OBJECT_SELF;
    object oCopy1 = CopyObject(oPC, lMirror, OBJECT_INVALID, "PlayerZombie");

    //Empty all items from copy 1's inventory
    object oCorpse = CreateObject(OBJECT_TYPE_PLACEABLE,"playergear",lMirror);
    object oItem = GetFirstItemInInventory(oCopy1);
    while (GetIsObjectValid(oItem))
    {
        if (GetItemCursedFlag(oItem) == TRUE)
        {
            DestroyObject(oItem);
        }
        else
        {
            AssignCommand(oCorpse,ActionTakeItem(oItem,oCopy1));
        }
        oItem = GetNextItemInInventory(oCopy1);
    }
    AssignCommand(oCorpse,TakeGoldFromCreature(GetGold(oCopy1),oCopy1));

    object oGear = GetItemInSlot(INVENTORY_SLOT_ARMS, oCopy1);

    if(GetIsObjectValid(oGear))
    {
        SetDroppableFlag(oGear, TRUE);
    }
    oGear = GetItemInSlot(INVENTORY_SLOT_ARROWS, oCopy1);
    if(GetIsObjectValid(oGear))
    {
        SetDroppableFlag(oGear, TRUE);
    }
    oGear = GetItemInSlot(INVENTORY_SLOT_BELT, oCopy1);
    if(GetIsObjectValid(oGear))
    {
        AssignCommand(oCorpse,ActionTakeItem(oGear,oCopy1));
    }
    oGear = GetItemInSlot(INVENTORY_SLOT_BOLTS, oCopy1);
    if(GetIsObjectValid(oGear))
    {
         if (GetItemCursedFlag(oGear) == TRUE)
         {
             DestroyObject(oGear);
         }
         else
         {
             SetDroppableFlag(oGear, TRUE);
         }
    }
    oGear = GetItemInSlot(INVENTORY_SLOT_BOOTS, oCopy1);
    if(GetIsObjectValid(oGear))
    {
        SetDroppableFlag(oGear, FALSE);
    }
    oGear = GetItemInSlot(INVENTORY_SLOT_BULLETS, oCopy1);
    if(GetIsObjectValid(oGear))
    {
         if (GetItemCursedFlag(oGear) == TRUE)
         {
             DestroyObject(oGear);
         }
         else
         {
             SetDroppableFlag(oGear, TRUE);
         }
    }
    oGear = GetItemInSlot(INVENTORY_SLOT_CHEST, oCopy1);
    if(GetIsObjectValid(oGear))
    {
        SetDroppableFlag(oGear, TRUE);
    }
    oGear = GetItemInSlot(INVENTORY_SLOT_CLOAK, oCopy1);
    if(GetIsObjectValid(oGear))
    {
         SetDroppableFlag(oGear, FALSE);
    }
    oGear = GetItemInSlot(INVENTORY_SLOT_HEAD, oCopy1);
    if(GetIsObjectValid(oGear))
    {
        SetDroppableFlag(oGear, TRUE);
    }
    oGear = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oCopy1);
    if(GetIsObjectValid(oGear))
    {
         if (GetItemCursedFlag(oGear) == TRUE)
         {
             DestroyObject(oGear);
         }
         else
         {
             AssignCommand(oCorpse,ActionTakeItem(oGear,oCopy1));
         }
    }
    oGear = GetItemInSlot(INVENTORY_SLOT_LEFTRING, oCopy1);
    if(GetIsObjectValid(oGear))
    {
        SetDroppableFlag(oGear, TRUE);
    }
    oGear = GetItemInSlot(INVENTORY_SLOT_NECK, oCopy1);
    if(GetIsObjectValid(oGear))
    {
        SetDroppableFlag(oGear, TRUE);
    }
    oGear = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oCopy1);
    if(GetIsObjectValid(oGear))
    {
         if (GetItemCursedFlag(oGear) == TRUE)
         {
             DestroyObject(oGear);
         }
         else
         {
             AssignCommand(oCorpse,ActionTakeItem(oGear,oCopy1));
         }
    }
    oGear = GetItemInSlot(INVENTORY_SLOT_RIGHTRING, oCopy1);
    if(GetIsObjectValid(oGear))
    {
         SetDroppableFlag(oGear, TRUE);
    }

    // MHADLEY -- Create zombie gear
    object oG1 = CreateItemOnObject("ZombieCloneBelt",oCopy1);
    DelayCommand(0.2,SetDroppableFlag(oG1, FALSE));
    DelayCommand(0.2,AssignCommand(oCopy1,ActionEquipItem(oG1,INVENTORY_SLOT_BELT)));
    object oG2 = CreateItemOnObject("it_crewps004",oCopy1);
    DelayCommand(0.4,SetDroppableFlag(oG2, FALSE));
    DelayCommand(0.4,AssignCommand(oCopy1,ActionEquipItem(oG2,INVENTORY_SLOT_CWEAPON_B)));
    object oG3 = CreateItemOnObject("nw_it_creitemunf001",oCopy1);
    DelayCommand(0.6,SetDroppableFlag(oG3, FALSE));
    DelayCommand(0.6,AssignCommand(oCopy1,ActionEquipItem(oG3,INVENTORY_SLOT_CARMOUR)));
    ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectMovementSpeedDecrease(75),oCopy1);
    int nLevel = LevelUpHenchman(oCopy1,CLASS_TYPE_UNDEAD);

    ChangeToStandardFaction(oCopy1, STANDARD_FACTION_HOSTILE);

    AssignCommand(oCopy1, ClearAllActions());
    DelayCommand(2.0, AssignCommand(oCopy1, CloneFight()));
    ExecuteScript("zombie_feed",oCopy1);
}

void main()
{
    object oPC = OBJECT_SELF;
    location lMirror = GetLocation(oPC);

    DelayCommand(0.5,CreateClone(lMirror));
}
