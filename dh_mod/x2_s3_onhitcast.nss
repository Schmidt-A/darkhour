//::///////////////////////////////////////////////
//:: User Defined OnHitCastSpell code
//:: x2_s3_onhitcast
//:: Copyright (c) 2003 Bioware Corp.
//:://////////////////////////////////////////////
/*
    This file can hold your module specific
    OnHitCastSpell definitions

    How to use:
    - Add the Item Property OnHitCastSpell: UniquePower (OnHit)
    - Add code to this spellscript (see below)

   WARNING!
   This item property can be a major performance hog when used
   extensively in a multi player module. Especially in higher
   levels, with each player having multiple attacks, having numerous
   of OnHitCastSpell items in your module this can be a problem.

   It is always a good idea to keep any code in this script as
   optimized as possible.


*/
//:://////////////////////////////////////////////
//:: Created By: Georg Zoeller
//:: Created On: 2003-07-22
//:://////////////////////////////////////////////

#include "x2_inc_switches"
#include "lnx_inc_eval_itm"

void main()
{

   object oItem;        // The item casting triggering this spellscript
   object oSpellTarget; // On a weapon: The one being hit. On an armor: The one hitting the armor
   object oSpellOrigin; // On a weapon: The one wielding the weapon. On an armor: The one wearing an armor

   // fill the variables
   oSpellOrigin = OBJECT_SELF;
   oSpellTarget = GetSpellTargetObject();
   oItem        =  GetSpellCastItem();

    // Including degredation -- Lynx
    object oArmor = GetItemInSlot(INVENTORY_SLOT_CHEST, oSpellTarget);
    object oHelmet = GetItemInSlot(INVENTORY_SLOT_HEAD, oSpellTarget);
    object oShield = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oSpellTarget);
    int iArmor = GetLocalInt(oArmor, "DURABILITY");
    int iHelmet = GetLocalInt(oArmor, "DURABILITY");
    if (GetItemType(oShield) == "ARMOR")
        {
        int iShield = GetLocalInt(oArmor, "DURABILITY");
        SetLocalInt(oShield, "DURABILITY", iShield - 1);
        EvaluateTiers(oShield, "DURABILITY");
        }
    SetLocalInt(oArmor, "DURABILITY", iArmor - 1);
    EvaluateTiers(oArmor, "ARMOR");
    SetLocalInt(oHelmet, "SHARPNESS", iHelmet - 1);
    EvaluateTiers(oHelmet, "ARMOR");

   //New famine bringer script
   if(GetTag(oItem) == "axe_famine")
        {
        if(GetIsPC(oSpellTarget) == FALSE)
            {
            return;
            }
        int iRand = Random(100) + 1;
        if(iRand <= 15)
            {
            int nIsHungry = GetLocalInt(oSpellTarget, "IsHungry") + 1;
            SetLocalInt(oSpellTarget, "IsHungry", nIsHungry);
            int nIsHungry2 = GetLocalInt(oSpellOrigin, "IsHungry") - 1;
            SetLocalInt(oSpellOrigin, "IsHungry", nIsHungry2);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_PWSTUN), oSpellTarget);
            SendMessageToPC(oSpellOrigin, "You have drained " + GetName(oSpellTarget) + " of sustenance.");
            SendMessageToPC(oSpellTarget, "You have been drained of sustenance!");
            }
        }
   else
    {
   if ((GetIsObjectValid(oItem)) && (GetIsPC(oSpellTarget)) && (GetIsPossessedFamiliar(oSpellTarget) == FALSE))
   {
     // * Generic Item Script Execution Code
     // * If MODULE_SWITCH_EXECUTE_TAGBASED_SCRIPTS is set to TRUE on the module,
     // * it will execute a script that has the same name as the item's tag
     // * inside this script you can manage scripts for all events by checking against
     // * GetUserDefinedItemEventNumber(). See x2_it_example.nss
//     if (GetModuleSwitchValue(MODULE_SWITCH_ENABLE_TAGBASED_SCRIPTS) == TRUE)
//     {
//        SetUserDefinedItemEventNumber(X2_ITEM_EVENT_ONHITCAST);
//        int nRet =   ExecuteScriptAndReturnInt(GetUserDefinedItemEventScriptName(oItem),OBJECT_SELF);
//        if (nRet == X2_EXECUTE_SCRIPT_END)
//        {
//           return;
//        }
//     }

       int nSanct = FALSE;
       effect eCheck = GetFirstEffect(oSpellTarget);
       while (GetEffectType(eCheck) != EFFECT_TYPE_INVALIDEFFECT)
       {
           if (GetEffectType(eCheck) == EFFECT_TYPE_SANCTUARY)
           {
               nSanct = TRUE;
           }
           eCheck = GetNextEffect(oSpellTarget);
       }
       if (nSanct == FALSE)
       {
           if (GetLevelByClass(CLASS_TYPE_PALADIN,oSpellTarget) < 1)
           {
               if (FortitudeSave(oSpellTarget,9,SAVING_THROW_TYPE_DISEASE) == 0)
               {
                   ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_IMP_DISEASE_S),oSpellTarget);
                   CreateItemOnObject("zombiedisease",oSpellTarget);
                   FloatingTextStringOnCreature("You have been diseased!",oSpellTarget,FALSE);
               }
           }
           if (GetLevelByClass(CLASS_TYPE_MONK,oSpellTarget) < 1)
           {
               if (FortitudeSave(oSpellTarget,7) == 0)
               {
                   ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_IMP_SLOW),oSpellTarget);
                   ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectMovementSpeedDecrease(50),oSpellTarget,15.0);
               }
           }
       }
   }
    }
}
