//::///////////////////////////////////////////////
//:: Negative Energy Ray
//:: NW_S0_NegRay
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Fires a bolt of negative energy at the target
    doing 1d6 damage.  Does an additional 1d6
    damage for 2 levels after level 1 (3,5,7,9) to
    a maximum of 5d6 at level 9.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Sept 13, 2001
//:://////////////////////////////////////////////

#include "NW_I0_SPELLS"
#include "x2_inc_spellhook"
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

void CreateClone(location lMirror, object oPC)
{

    object oCopy1 = CopyObject(oPC, lMirror, OBJECT_INVALID, "PlayerZombie");

    //Empty all items from copy 1's inventory
    object oItem = GetFirstItemInInventory(oCopy1);
    while (GetIsObjectValid(oItem))
    {
        if (GetItemCursedFlag(oItem) == TRUE)
        {
            DestroyObject(oItem);
        }
        else
        {
            DestroyObject(oItem);
        }
        oItem = GetNextItemInInventory(oCopy1);
    }
    AssignCommand(oCopy1,TakeGoldFromCreature(GetGold(oCopy1),oCopy1,TRUE));

    object oGear = GetItemInSlot(INVENTORY_SLOT_ARMS, oCopy1);

    if(GetIsObjectValid(oGear))
    {
        SetDroppableFlag(oGear, FALSE);
    }
    oGear = GetItemInSlot(INVENTORY_SLOT_ARROWS, oCopy1);
    if(GetIsObjectValid(oGear))
    {
        SetDroppableFlag(oGear, FALSE);
    }
    oGear = GetItemInSlot(INVENTORY_SLOT_BELT, oCopy1);
    if(GetIsObjectValid(oGear))
    {
       DestroyObject(oGear);
    }
    oGear = GetItemInSlot(INVENTORY_SLOT_BOLTS, oCopy1);
    if(GetIsObjectValid(oGear))
    {
         if (GetItemCursedFlag(oGear) == FALSE)
         {
             DestroyObject(oGear);
         }
         else
         {
             SetDroppableFlag(oGear, FALSE);
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
             SetDroppableFlag(oGear, FALSE);
         }
    }
    oGear = GetItemInSlot(INVENTORY_SLOT_CHEST, oCopy1);
    if(GetIsObjectValid(oGear))
    {
        SetDroppableFlag(oGear, FALSE);
    }
    oGear = GetItemInSlot(INVENTORY_SLOT_CLOAK, oCopy1);
    if(GetIsObjectValid(oGear))
    {
         SetDroppableFlag(oGear, FALSE);
    }
    oGear = GetItemInSlot(INVENTORY_SLOT_HEAD, oCopy1);
    if(GetIsObjectValid(oGear))
    {
        SetDroppableFlag(oGear, FALSE);
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
             DestroyObject(oGear);
         }
    }
    oGear = GetItemInSlot(INVENTORY_SLOT_LEFTRING, oCopy1);
    if(GetIsObjectValid(oGear))
    {
        SetDroppableFlag(oGear, FALSE);
    }
    oGear = GetItemInSlot(INVENTORY_SLOT_NECK, oCopy1);
    if(GetIsObjectValid(oGear))
    {
        SetDroppableFlag(oGear, FALSE);
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
             DestroyObject(oGear);
         }
    }
    oGear = GetItemInSlot(INVENTORY_SLOT_RIGHTRING, oCopy1);
    if(GetIsObjectValid(oGear))
    {
         SetDroppableFlag(oGear, FALSE);
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

/*
  Spellcast Hook Code
  Added 2003-06-23 by GeorgZ
  If you want to make changes to all spells,
  check x2_inc_spellhook.nss to find out more

*/

    if (!X2PreSpellCastCode())
    {
    // If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }

// End of Spell Cast Hook


    //Declare major variables
    object oTarget = GetSpellTargetObject();
    int nCasterLevel = GetCasterLevel(OBJECT_SELF);
    int nMetaMagic = GetMetaMagicFeat();
    if(GetTag(OBJECT_SELF)=="ZN_ZOMBIEL")
    {
        location lMirror = GetLocation(OBJECT_SELF);
        DelayCommand(0.5,CreateClone(lMirror,oTarget));
    }
    if(nCasterLevel > 9)
    {
        nCasterLevel = 9;
    }
    nCasterLevel = (nCasterLevel + 1) / 2;
    int nDamage = d6(nCasterLevel);

    //Enter Metamagic conditions
    if (nMetaMagic == METAMAGIC_MAXIMIZE)
    {
        nDamage = 6 * nCasterLevel;//Damage is at max
    }
    else if (nMetaMagic == METAMAGIC_EMPOWER)
    {
        nDamage = nDamage + (nDamage/2); //Damage/Healing is +50%
    }
    effect eVis = EffectVisualEffect(VFX_IMP_NEGATIVE_ENERGY);
    effect eVisHeal = EffectVisualEffect(VFX_IMP_HEALING_M);
    effect eRay;
    if(GetRacialType(oTarget) != RACIAL_TYPE_UNDEAD)
    {
        if(!GetIsReactionTypeFriendly(oTarget))
        {
            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_NEGATIVE_ENERGY_RAY));
            eRay = EffectBeam(VFX_BEAM_EVIL, OBJECT_SELF, BODY_NODE_HAND);
            if (!MyResistSpell(OBJECT_SELF, oTarget))
            {
                //Make a saving throw check
                if(/*Will Save*/ MySavingThrow(SAVING_THROW_WILL, oTarget, GetSpellSaveDC(), SAVING_THROW_TYPE_NEGATIVE))
                {
                    nDamage /= 2;
                }
                effect eDam = EffectDamage(nDamage, DAMAGE_TYPE_NEGATIVE);
                //Apply the VFX impact and effects
                //DelayCommand(0.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                DelayCommand(0.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget);
            }
        }
    }
    else
    {
        //Fire cast spell at event for the specified target
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_NEGATIVE_ENERGY_RAY, FALSE));
        eRay = EffectBeam(VFX_BEAM_EVIL, OBJECT_SELF, BODY_NODE_HAND);
        effect eHeal = EffectHeal(nDamage);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisHeal, oTarget);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oTarget);
    }
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRay, oTarget, 1.7);
}
