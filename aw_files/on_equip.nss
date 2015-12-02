#include "x2_inc_itemprop"

void main()
{
    object oItem = GetPCItemLastEquipped();
    if(GetBaseItemType(oItem) != BASE_ITEM_MAGICWAND && GetBaseItemType(oItem) != BASE_ITEM_ENCHANTED_WAND)
    {
    object oPlayer = GetPCItemLastEquippedBy();
    int nWisSorc = GetLevelByClass(CLASS_TYPE_WIZARD, oPlayer) + GetLevelByClass(CLASS_TYPE_SORCERER, oPlayer);
    int nCleric = GetLevelByClass(CLASS_TYPE_CLERIC, oPlayer);

    if (GetItemInSlot( INVENTORY_SLOT_LEFTHAND,oPlayer) == oItem)
        {
        SetLocalString(oPlayer,"weapon1",GetTag(oItem));
        }

    if (GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oPlayer) == oItem)
        {
        SetLocalString(oPlayer,"weapon2",GetTag(oItem));
        }

    int iCharge;
    iCharge = GetItemCharges(oItem);
    if (iCharge == 0){return;}

    int iClass;
    string sClass;

    if(iCharge < 24)  // Single class only item is 23 and lower...
        {
        switch (iCharge)
            {
            case 1: iClass = CLASS_TYPE_BARBARIAN; sClass = "Barbarian";break;
            case 2: iClass = CLASS_TYPE_BARD; sClass = "Bard";break;
            case 3: iClass = CLASS_TYPE_CLERIC; sClass = "Cleric";break;
            case 4: iClass = CLASS_TYPE_DRUID; sClass = "Druid";break;
            case 5: iClass = CLASS_TYPE_FIGHTER; sClass = "Fighter";break;
            case 6: iClass = CLASS_TYPE_MONK; sClass = "Monk";break;
            case 7: iClass = CLASS_TYPE_PALADIN; sClass = "Paladin";break;
            case 8: iClass = CLASS_TYPE_RANGER; sClass = "Ranger";break;
            case 9: iClass = CLASS_TYPE_ROGUE; sClass = "Rogue";break;
            case 10: iClass = CLASS_TYPE_SORCERER; sClass = "Sorcerer";break;
            case 11: iClass = CLASS_TYPE_WIZARD; sClass = "Wizard";break;
            case 12: iClass = CLASS_TYPE_SHADOWDANCER; sClass = "Shadowdancer";break;
            case 13: iClass = CLASS_TYPE_HARPER; sClass = "Harper scout";break;
            case 14: iClass = CLASS_TYPE_ARCANE_ARCHER; sClass = "Arcane archer";break;
            case 15: iClass = CLASS_TYPE_ASSASSIN; sClass = "Assasssin";break;
            case 16: iClass = CLASS_TYPE_BLACKGUARD; sClass = "Blackguard";break;
            case 17: iClass = CLASS_TYPE_DIVINECHAMPION; sClass = "Champion of torm";break;
            case 18: iClass = CLASS_TYPE_WEAPON_MASTER; sClass = "Weapon master";break;
            case 19: iClass = CLASS_TYPE_PALEMASTER; sClass = "Pale master";break;
            case 20: iClass = CLASS_TYPE_SHIFTER; sClass = "Shifter";break;
            case 21: iClass = CLASS_TYPE_DWARVENDEFENDER; sClass = "Dwarven defender";break;
            case 22: iClass = CLASS_TYPE_DRAGONDISCIPLE; sClass = "Red dragon disciple";break;
            case 23: iClass = CLASS_TYPE_PURPLE_DRAGON_KNIGHT; sClass = "Purple dragon knight";break;
            }

        if (GetLevelByClass(iClass, oPlayer) < 1)
            {
            DelayCommand(0.2, AssignCommand(oPlayer, ActionUnequipItem(oItem)));
            SendMessageToPC(oPlayer, "You must be a "+sClass+" to use this item.");
            }
        }
    else if(iCharge == 24)  //UMD 25 + No cleric level
        {
        if (nCleric < 1)
            {
            int nUMDRank;
            nUMDRank = GetSkillRank(SKILL_USE_MAGIC_DEVICE, oPlayer);
            if (nUMDRank < 25)
                {
                DelayCommand(0.2, AssignCommand(oPlayer, ActionUnequipItem(oItem)));
                SendMessageToPC(oPlayer, "You must have at least 25 UMD to use this item.");
                }
            }
        }
    else if(iCharge == 25)  //UMD 20 + No Wis/Sorc level
        {
        if (nWisSorc < 1)
            {
            int nUMDRank;
            nUMDRank = GetSkillRank(SKILL_USE_MAGIC_DEVICE, oPlayer);
            if (nUMDRank < 20)
                {
                DelayCommand(0.2, AssignCommand(oPlayer, ActionUnequipItem(oItem)));
                SendMessageToPC(oPlayer, "You must have at least 20 UMD to use this item.");
                }
            }
        }
    else if(iCharge == 26)  //Wis/Sorc only
        {
        if (nWisSorc < 1)
            {
            DelayCommand(0.2, AssignCommand(oPlayer, ActionUnequipItem(oItem)));
            SendMessageToPC(oPlayer, "You must be a mage to use this item.");
            }
        }
    else if(iCharge == 27)  //Fighter + Ranger + Barb
        {
        if ((GetLevelByClass(CLASS_TYPE_RANGER, oPlayer) < 1) &&
            (GetLevelByClass(CLASS_TYPE_FIGHTER, oPlayer) < 1) &&
            (GetLevelByClass(CLASS_TYPE_BARBARIAN, oPlayer) < 1))
            {
            DelayCommand(0.2, AssignCommand(oPlayer, ActionUnequipItem(oItem)));
            SendMessageToPC(oPlayer, "You must be a Fighter, Ranger or Barbarian to use this item.");
            }
        }
    else if(iCharge == 28)  //Bard + Ranger + Rogue + Assassin
        {
        if ((GetLevelByClass(CLASS_TYPE_BARD, oPlayer) < 1) &&
            (GetLevelByClass(CLASS_TYPE_RANGER, oPlayer) < 1) &&
            (GetLevelByClass(CLASS_TYPE_ROGUE, oPlayer) < 1) &&
            (GetLevelByClass(CLASS_TYPE_ASSASSIN, oPlayer) < 1))
            {
            DelayCommand(0.2, AssignCommand(oPlayer, ActionUnequipItem(oItem)));
            SendMessageToPC(oPlayer, "You must be a Bard, Ranger, Rogue, or Assassin to use this item.");
            }
        }
    else if(iCharge == 29)  //Paladin + CoT + Cleric
        {
        if ((GetLevelByClass(CLASS_TYPE_PALADIN, oPlayer) < 1) &&
            (GetLevelByClass(CLASS_TYPE_DIVINECHAMPION, oPlayer) < 1) &&
            (GetLevelByClass(CLASS_TYPE_CLERIC, oPlayer) < 1))
            {
            DelayCommand(0.2, AssignCommand(oPlayer, ActionUnequipItem(oItem)));
            SendMessageToPC(oPlayer, "You must be a Paladin, Champion of Torm or Cleric to use this item.");
            }
        }

    //AC system
    /*
    Level | AC
    10-13 | +4
    14-16 | +3
    17-20 | +2
    20-23 | +1
    24-40 | +0
    */
    else if((iCharge == 30) ||  //Dexer AC armor
            (iCharge == 31) ||
            (iCharge == 32) ||
            (iCharge == 33))
            {
            if(iCharge == 31)  //Ranger only
                {
                if (GetLevelByClass(CLASS_TYPE_RANGER, oPlayer) < 1)
                    {
                    DelayCommand(0.2, AssignCommand(oPlayer, ActionUnequipItem(oItem)));
                    SendMessageToPC(oPlayer, "You must be a Ranger to use this item.");
                    }
                }
            else if(iCharge == 32) //Bard only
                {
                if (GetLevelByClass(CLASS_TYPE_BARD, oPlayer) < 1)
                    {
                    DelayCommand(0.2, AssignCommand(oPlayer, ActionUnequipItem(oItem)));
                    SendMessageToPC(oPlayer, "You must be a Bard to use this item.");
                    }
                }
            else if(iCharge == 33) //Barbarian only
                {
                if (GetLevelByClass(CLASS_TYPE_BARBARIAN, oPlayer) < 1)
                    {
                    DelayCommand(0.2, AssignCommand(oPlayer, ActionUnequipItem(oItem)));
                    SendMessageToPC(oPlayer, "You must be a Barbarian to use this item.");
                    }
                }
            int iLevel;
            iLevel = GetHitDice(oPlayer);
            int iBonus;
            if(iLevel > 23){return;}
            else if(iLevel > 20)
                {
                iBonus = 1;
                }
            else if(iLevel > 16)
                {
                iBonus = 2;
                }
            else if(iLevel > 13)
                {
                iBonus = 3;
                }
            else if(iLevel > 9)
                {
                iBonus = 4;
                }

            ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(EffectACIncrease(iBonus,AC_DODGE_BONUS )) ,oPlayer);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY,SupernaturalEffect(EffectCutsceneParalyze()) ,oPlayer, 1.0f);
            SendMessageToPC(oPlayer, "Low level dexer AC bonus : +"+IntToString(iBonus));
            }
      }
}

