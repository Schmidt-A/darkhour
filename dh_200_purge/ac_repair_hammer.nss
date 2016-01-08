/* This script will increase an armor durability and then evaluate if it has
    increased in tier. */

#include "lnx_inc_eval_itm"

void main()
    {
    object oPC = GetItemActivator();
    object oHammer = GetItemActivated();
    object oItem = GetItemActivatedTarget();
    int iDurability = GetLocalInt(oItem, "DURABILITY");
    int iCharges = GetLocalInt(oHammer, "CHARGES");
    int iSkill = GetSkillRank(SKILL_CRAFT_ARMOR, oPC);
    int iIncrease = 15 + d10() + 2 * iSkill;
    int iBreakChance = 50 + 2 * iSkill;
    int iTier = GetLocalInt(oItem, "TIER");
    int iCombined = iDurability + iIncrease;
    string sType = GetItemType(oItem);
    if (sType == "ARMOR")
        {
        if (iTier < 5)
            {
            SetLocalInt(oItem, "DURABILITY", iCombined);
            SendMessageToPC(oPC, "You successfully repair the " + GetName(oItem) + "!");
            EvaluateIncreasedTier(oItem, sType);
            }
        else if (iTier == 5)
            {
            if (iSkill < 12)
                {
                int iMax = GetMaxMaterialValue(oItem);
                if (iCombined == iMax)
                    {
                    SendMessageToPC(oPC, "You are not able to repair the " + GetName(oItem) + " any further.");
                    return;
                    }
                else if (iCombined > iMax)
                    {
                    iCombined = iMax;
                    SendMessageToPC(oPC, "You have repaired the " + GetName(oItem) + " to the maximum of your ability.");
                    }
                }
            SetLocalInt(oItem, "DURABILITY", iCombined);
            SendMessageToPC(oPC, "You successfully repair the " + GetName(oItem) + "!");
            EvaluateIncreasedTier(oItem, sType);
            }
        else if (iTier > 5)
            {
            if (iSkill < 12)
                {
                SendMessageToPC(oPC, "You are not able to repair the " + GetName(oItem) + " at this skill level.");
                return;
                }
            }
        if (Random(100) + 1 > iBreakChance)
            {
            if (iCharges > 1)
                {
                SendMessageToPC(oPC, "Your " + GetName(oHammer) + " has been damaged.");
                SetLocalInt(oHammer, "CHARGES", iCharges - 1);
                }
            else
                {
                SendMessageToPC(oPC, "Your " + GetName(oHammer) + " has become too damaged and has been destroyed.");
                DestroyObject(oHammer);
                }
            }
        }
    else
        {
        SendMessageToPC(oPC, "You cannot use this " + GetName(oHammer) + " on this object.");
        return;
        }
    }
