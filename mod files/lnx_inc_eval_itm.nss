/* This script will evaluate a single item for sharpness, durability, material
    and tiers. This script will also apply default values for virgin items. lol. */
#include "_inc_armor_utils"
#include "__mat_constants"
#include "zep_inc_main"

////////////////////////////////////////////////////////////////////////////////
// This function will return a cost value number (existing level of an item
//  property's potency) based on specific property requests.
////////////////////////////////////////////////////////////////////////////////
int GetExistingCostValue(object oItem, int iPropertyType, int iPropertySubType, string sRemove);
int GetExistingCostValue(object oItem, int iPropertyType, int iPropertySubType, string sRemove)
    {
    int iCostValue;
    itemproperty iTemporary = GetFirstItemProperty(oItem);
    // Loop through properties, find any match
    while (GetIsItemPropertyValid(iTemporary) == TRUE)
        {
        // Only want permanent bonuses
        if (GetItemPropertyDurationType(iTemporary) == DURATION_TYPE_PERMANENT)
            {
            // Check against our criteria
            if ((GetItemPropertyType(iTemporary) == iPropertyType && GetItemPropertySubType(iTemporary) == iPropertySubType) || (GetItemPropertyType(iTemporary) == iPropertyType && GetItemPropertySubType(iTemporary) == 0 ))
                {
                // We have an existing match, record its cost value
                iCostValue = GetItemPropertyCostTableValue(iTemporary);
                // If we opted to remove, take it out now
                if (sRemove == "YES")
                    {
                    RemoveItemProperty(oItem, iTemporary);
                    }
                }
            }
        iTemporary = GetNextItemProperty(oItem);
        }
    return iCostValue;
    }

////////////////////////////////////////////////////////////////////////////////
// This function will determine a max sharp/durable value based on material.
////////////////////////////////////////////////////////////////////////////////
int GetMaxMaterialValue(object oItem);
int GetMaxMaterialValue(object oItem)
    {
    int iMaterial = GetLocalInt(oItem, "MATERIAL");
    int iValue;
    switch (iMaterial)
        {
        case MAT_Adamantine:
            iValue = 200;
            break;
        case MAT_Bone:
            iValue = 30;
            break;
        case MAT_Brass:
            iValue = 35;
            break;
        case MAT_Bronze:
            iValue = 40;
            break;
        case MAT_Cloth:
            iValue = 20;
            break;
        case MAT_Cold_Iron:
            iValue = 60;
            break;
        case MAT_Copper:
            iValue = 25;
            break;
        case MAT_Cotton:
            iValue = 20;
            break;
        case MAT_Darksteel:
            iValue = 120;
            break;
        case MAT_Gem_Alexandrite:
            iValue = 80;
            break;
        case MAT_Gem_Amethyst:
            iValue = 80;
            break;
        case MAT_Gem_Aventurine:
            iValue = 80;
            break;
        case MAT_Gem_Beljuril:
            iValue = 80;
            break;
        case MAT_Gem_Bloodstone:
            iValue = 80;
            break;
        case MAT_Gem_Blue_Diamond:
            iValue = 175;
            break;
        case MAT_Gem_Canary_Diamond:
            iValue = 175;
            break;
        case MAT_Gem_Crystal_Deep:
            iValue = 100;
            break;
        case MAT_Gem_Crystal_Mundane:
            iValue = 60;
            break;
        case MAT_Gem_Diamond:
            iValue = 175;
            break;
        case MAT_Gem_Emerald:
            iValue = 80;
            break;
        case MAT_Gem_Fire_Agate:
            iValue = 80;
            break;
        case MAT_Gem_Fire_Opal:
            iValue = 80;
            break;
        case MAT_Gem_Flourspar:
            iValue = 80;
            break;
        case MAT_Gem_Garnet:
            iValue = 80;
            break;
        case MAT_Gem_Greenstone:
            iValue = 80;
            break;
        case MAT_Gem_Jacinth:
            iValue = 80;
            break;
        case MAT_Gem_Kings_Tear:
            iValue = 150;
            break;
        case MAT_Gem_Malachite:
            iValue = 80;
            break;
        case MAT_Gem_Obsidian:
            iValue = 120;
            break;
        case MAT_Gem_Phenalope:
            iValue = 80;
            break;
        case MAT_Gem_Rogue_Stone:
            iValue = 80;
            break;
        case MAT_Gem_Ruby:
            iValue = 80;
            break;
        case MAT_Gem_Sapphire:
            iValue = 80;
            break;
        case MAT_Gem_Star_Sapphire:
            iValue = 80;
            break;
        case MAT_Gem_Topaz:
            iValue = 80;
            break;
        case MAT_Gold:
            iValue = 25;
            break;
        case MAT_Hide_Dragon_Black:
            iValue = 230;
            break;
        case MAT_Hide_Dragon_Blue:
            iValue = 230;
            break;
        case MAT_Hide_Dragon_Brass:
            iValue = 230;
            break;
        case MAT_Hide_Dragon_Bronze:
            iValue = 230;
            break;
        case MAT_Hide_Dragon_Copper:
            iValue = 230;
            break;
        case MAT_Hide_Dragon_Gold:
            iValue = 230;
            break;
        case MAT_Hide_Dragon_Green:
            iValue = 230;
            break;
        case MAT_Hide_Dragon_Red:
            iValue = 230;
            break;
        case MAT_Hide_Dragon_Silver:
            iValue = 230;
            break;
        case MAT_Hide_Dragon_White:
            iValue = 230;
            break;
        case MAT_Hide_Wyvern:
            iValue = 80;
            break;
        case MAT_Iron:
            iValue = 50;
            break;
        case MAT_Lead:
            iValue = 30;
            break;
        case MAT_Leather:
            iValue = 40;
            break;
        case MAT_Mithral:
            iValue = 200;
            break;
        case MAT_Platinum:
            iValue = 100;
            break;
        case MAT_Scale:
            iValue = 45;
            break;
        case MAT_Silk:
            iValue = 10;
            break;
        case MAT_Silver:
            iValue = 25;
            break;
        case MAT_Steel:
            iValue = 75;
            break;
        case MAT_Wood:
            iValue = 25;
            break;
        case MAT_Wood_Ash:
            iValue = 25;
            break;
        case MAT_Wood_Cedar:
            iValue = 30;
            break;
        case MAT_Wood_Darkwood_Zalantar:
            iValue = 25;
            break;
        case MAT_Wood_Duskwood:
            iValue = 25;
            break;
        case MAT_Wood_Ironwood:
            iValue = 50;
            break;
        case MAT_Wood_Oak:
            iValue = 25;
            break;
        case MAT_Wood_Pine:
            iValue = 25;
            break;
        case MAT_Wood_Yew:
            iValue = 25;
            break;
        case MAT_Wool:
            iValue = 20;
            break;
        default:
            iValue = 50;
        }
    return iValue;
    }


////////////////////////////////////////////////////////////////////////////////
// This function will determine if an item is a "WEAPON" or "ARMOR" or "OTHER"
////////////////////////////////////////////////////////////////////////////////
string GetItemType(object oItem);
string GetItemType(object oItem)
    {
    string sType;
    int iType = GetBaseItemType(oItem);
    // Determine base item type
    if (iType == BASE_ITEM_ARMOR
        || iType == BASE_ITEM_SMALLSHIELD
        || iType == BASE_ITEM_TOWERSHIELD
        || iType == BASE_ITEM_LARGESHIELD
        || iType == BASE_ITEM_HELMET)
        {
        sType = "ARMOR";
        }
    else if (iType == BASE_ITEM_BASTARDSWORD
            || iType == BASE_ITEM_BATTLEAXE
            || iType == BASE_ITEM_CBLUDGWEAPON
            || iType == BASE_ITEM_CLUB
            || iType == BASE_ITEM_DAGGER
            || iType == BASE_ITEM_DAGGERASSASSIN
            || iType == BASE_ITEM_DIREMACE
            || iType == BASE_ITEM_DOUBLEAXE
            || iType == BASE_ITEM_DOUBLESCIMITAR
            || iType == BASE_ITEM_DWARVENWARAXE
            || iType == BASE_ITEM_FALCHION1
            || iType == BASE_ITEM_FALCHION2
            || iType == BASE_ITEM_GOAD
            || iType == BASE_ITEM_GREATAXE
            || iType == BASE_ITEM_GREATSWORD
            || iType == BASE_ITEM_HALBERD
            || iType == BASE_ITEM_HANDAXE
            || iType == BASE_ITEM_HEAVYFLAIL
            || iType == BASE_ITEM_HEAVYMACE
            || iType == BASE_ITEM_HEAVYPICK
            || iType == BASE_ITEM_KAMA
            || iType == BASE_ITEM_KATANA
            || iType == BASE_ITEM_KATAR
            || iType == BASE_ITEM_KUKRI
            || iType == BASE_ITEM_KUKRI2
            || iType == BASE_ITEM_LIGHTFLAIL
            || iType == BASE_ITEM_LIGHTHAMMER
            || iType == BASE_ITEM_LIGHTMACE
            || iType == BASE_ITEM_LIGHTMACE2
            || iType == BASE_ITEM_LIGHTPICK
            || iType == BASE_ITEM_LONGSWORD
            || iType == BASE_ITEM_MAUL
            || iType == BASE_ITEM_MERCURIALGREATSWORD
            || iType == BASE_ITEM_MERCURIALLONGSWORD
            || iType == BASE_ITEM_MORNINGSTAR
            || iType == BASE_ITEM_NUNCHAKU
            || iType == BASE_ITEM_QUARTERSTAFF
            || iType == BASE_ITEM_RAPIER
            || iType == BASE_ITEM_SAI
            || iType == BASE_ITEM_SAP
            || iType == BASE_ITEM_SCIMITAR
            || iType == BASE_ITEM_SCYTHE
            || iType == BASE_ITEM_SHORTSPEAR
            || iType == BASE_ITEM_SHORTSWORD
            || iType == BASE_ITEM_SICKLE
            || iType == BASE_ITEM_TRIDENT
            || iType == BASE_ITEM_TRIDENT_1H
            || iType == BASE_ITEM_TWOBLADEDSWORD
            || iType == BASE_ITEM_WARHAMMER
            || iType == BASE_ITEM_WHIP
            || iType == BASE_ITEM_WINDFIREWHEEL)
            {
            sType = "WEAPON";
            }
        else
            {
            sType = "OTHER";
            }
    return sType;
    }

////////////////////////////////////////////////////////////////////////////////
// This function will modify or create a sharpness/durability label upon the
//  item based on tier.
////////////////////////////////////////////////////////////////////////////////
void EvaluateName(object oItem);
void EvaluateName(object oItem)
    {
    // Start by determining a new label via tier
    int iTier = GetLocalInt(oItem, "TIER");
    string sType = GetItemType(oItem);
    string sTier;
    switch (iTier)
        {
        case 2:
            sTier = " [Broken]";
            break;
        case 3:
            sTier = " [Damaged]";
            break;
        case 4:
            if (sType == "WEAPON")
                {
                sTier = " [Dull]";
                }
            else
                {
                sTier = " [Worn]";
                }
            break;
        case 5:
            if (sType == "WEAPON")
                {
                sTier = " [Sharp]";
                }
            else
                {
                sTier = " [Polished]";
                }
            break;
        case 6:
            if (sType == "WEAPON")
                {
                sTier = " [Honed]";
                }
            else
                {
                sTier = " [Reinforced]";
                }
        }
    // Parse the item name and reset its tier label
    // Start with the name
    string sName = GetName(oItem);
    string sNewName;
    int iStart = FindSubString(sName, "[");
    // Set the new name
    if (iStart != -1)
        {
        // If a previous label was found, replace it
        sNewName = GetStringLeft(sName, iStart - 1) + sTier;
        }
    else
        {
        // If no label is found, create it
        sNewName = sName + sTier;
        }
    SetName(oItem, sNewName);
    }

////////////////////////////////////////////////////////////////////////////////
// This function will set a new material value to a virgin item, apply its
// default sharpness/durability and a random tier.
////////////////////////////////////////////////////////////////////////////////
void SetupNewItem(object oItem, string sType);
void SetupNewItem(object oItem, string sType)
    {
    int iMaterial = GetLocalInt(oItem, "MATERIAL");
    // First we need to determine if this item has a material property, and
    //  if so connvert its value into upon the item variable.
    itemproperty iProp = GetFirstItemProperty(oItem);
    while (GetIsItemPropertyValid(iProp) == TRUE && iMaterial == 0)
        {
        if (GetItemPropertyType(iProp) == 85)
            {
            iMaterial = GetItemPropertySubType(iProp);
            }
        else
            {
            iProp = GetNextItemProperty(oItem);
            }
        }
    // We cycled our properties, so we need to see if we found a
    //  material or not. If not, make one from scratch.
    if (iMaterial == 0)
        {
        // If it's a weapon, we assume metallic.
        if (sType == "WEAPON")
            {
            int iRandom = d3();
            switch (iRandom)
                {
                case 1:
                    iMaterial = MAT_Lead;
                    break;
                case 2:
                    iMaterial = MAT_Steel;
                    break;
                case 3:
                    iMaterial = MAT_Iron;
                    break;
                default:
                    iMaterial = MAT_Iron;
                    break;
                }
            }
        // If it's armor, we determine its proficiency type
        else if (sType == "ARMOR")
            {
            int iRandom = d3();
            switch (GetItemArmorType(oItem))
                {
                case ARMOR_TYPE_CLOTH:
                    switch (iRandom)
                        {
                        case 1:
                            iMaterial = MAT_Cotton;
                            break;
                        case 2:
                            iMaterial = MAT_Silk;
                            break;
                        case 3:
                            iMaterial = MAT_Cloth;
                            break;
                        default:
                            iMaterial = MAT_Cloth;
                            break;
                        }
                    break;
                case ARMOR_TYPE_LIGHT:
                    iMaterial = MAT_Leather;
                    break;
                case ARMOR_TYPE_MEDIUM:
                    switch (iRandom)
                        {
                        case 1:
                            iMaterial = MAT_Copper;
                            break;
                        case 2:
                            iMaterial = MAT_Brass;
                            break;
                        case 3:
                            iMaterial = MAT_Scale;
                            break;
                        default:
                            iMaterial = MAT_Scale;
                            break;
                        }
                    break;
                case ARMOR_TYPE_HEAVY:
                    switch (iRandom)
                        {
                        case 1:
                            iMaterial = MAT_Lead;
                            break;
                        case 2:
                            iMaterial = MAT_Steel;
                            break;
                        case 3:
                            iMaterial = MAT_Iron;
                            break;
                        default:
                            iMaterial = MAT_Iron;
                            break;
                        }
                    break;
                // If none of the above, assume a shield or helmet
                default:
                    iMaterial = MAT_Iron;
                }
            }
        }
    // Now that we have the material, we want to apply the default
    //  sharpness or durability and the material property.
    AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyMaterial(iMaterial), oItem);

    int iValue = GetMaxMaterialValue(oItem);
    // Now that we have a value based on material, we need to apply a random
    //  tier between very dull and sharp (3 to 5.)
    int iRandomTier = d3() + 2;
    // Record our values upon the virgin item
    if (sType == "ARMOR")
        {
        SetLocalInt(oItem, "DURABILITY", iValue);
        }
    else
        {
        SetLocalInt(oItem, "SHARPNESS", iValue);
        }
    SetLocalInt(oItem, "TIER", iRandomTier);
    SetLocalInt(oItem, "MATERIAL", iMaterial);
    // Now we setup it's new label
    EvaluateName(oItem);
    }

////////////////////////////////////////////////////////////////////////////////
// This function will remove tier properties from prior bonuses.
////////////////////////////////////////////////////////////////////////////////
void RemoveTierProps(object oItem);
void RemoveTierProps(object oItem)
    {
    // First we must evaluate what kind of item this is
    string sType;
    int iType = GetBaseItemType(oItem);
    int iCostValue;
    int iTier = GetLocalInt(oItem, "TIER");
    // Determine base item type
    if (iType == BASE_ITEM_ARMOR)
        {
        sType = "ARMOR";
        }
    else if (iType == BASE_ITEM_SMALLSHIELD
        || iType == BASE_ITEM_TOWERSHIELD
        || iType == BASE_ITEM_LARGESHIELD)
        {
        sType = "SHIELD";
        }
    else if (iType == BASE_ITEM_HELMET)
        {
        sType = "HELMET";
        }
    else
        {
        sType = "WEAPON";
        }
    // Now, depending on tier, we remove corrosponding properties
    // Broken = -2 property
    if (iTier == 2)
        {
        // Determine item type
        if (sType == "ARMOR")
            {
            iCostValue = GetExistingCostValue(oItem, 28, 2, "YES");
            // We removed the existing property above, we need to check cost
            if (iCostValue > 2)
                {
                AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyDecreaseAC(2, iCostValue - 2), oItem);
                }
            }
        else if (sType == "SHIELD")
            {
            iCostValue = GetExistingCostValue(oItem, 28, 3, "YES");
            // We removed the existing property above, we need to check cost
            if (iCostValue > 2)
                {
                AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyDecreaseAC(3, iCostValue - 2), oItem);
                }
            }
        else if (sType == "HELMET")
            {
            iCostValue = GetExistingCostValue(oItem, 28, 4, "YES");
            // We removed the existing property above, we need to check cost
            if (iCostValue > 2)
                {
                AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyDecreaseAC(4, iCostValue - 2), oItem);
                }
            }
        else
            {
            iCostValue = GetExistingCostValue(oItem, 10, -1, "YES");
            // We removed the existing property above, we need to check cost
            if (iCostValue > 2)
                {
                AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyEnhancementPenalty(iCostValue - 2), oItem);
                }
            }
        }
    // Damaged = -1 property
    else if (iTier == 3)
        {
        // Determine item type
        if (sType == "ARMOR")
            {
            iCostValue = GetExistingCostValue(oItem, 28, 2, "YES");
            // We removed the existing property above, we need to check cost
            if (iCostValue > 1)
                {
                AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyDecreaseAC(2, iCostValue - 1), oItem);
                }
            }
        else if (sType == "SHIELD")
            {
            iCostValue = GetExistingCostValue(oItem, 28, 3, "YES");
            // We removed the existing property above, we need to check cost
            if (iCostValue > 1)
                {
                AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyDecreaseAC(3, iCostValue - 1), oItem);
                }
            }
        else if (sType == "HELMET")
            {
            iCostValue = GetExistingCostValue(oItem, 28, 4, "YES");
            // We removed the existing property above, we need to check cost
            if (iCostValue > 1)
                {
                AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyDecreaseAC(4, iCostValue - 1), oItem);
                }
            }
        else
            {
            iCostValue = GetExistingCostValue(oItem, 10, -1, "YES");
            // We removed the existing property above, we need to check cost
            if (iCostValue > 1)
                {
                AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyEnhancementPenalty(iCostValue - 1), oItem);
                }
            }
        }
    // Honed/Reinforced = +1 property
    else if (iTier == 6)
        {
        // Determine item type
        if (sType == "ARMOR" || sType == "SHIELD" || sType == "HELMET")
            {
            iCostValue = GetExistingCostValue(oItem, 1, 0, "YES");
            // We removed the existing property above, we need to check cost
            if (iCostValue > 1)
                {
                AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyACBonus(iCostValue - 1), oItem);
                }
            }
        else
            {
            iCostValue = GetExistingCostValue(oItem, 6, -1, "YES");
            // We removed the existing property above, we need to check cost
            if (iCostValue > 1)
                {
                AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyEnhancementBonus(iCostValue - 1), oItem);
                }
            }
        }
    }

////////////////////////////////////////////////////////////////////////////////
// This function will add tier properties from new bonuses.
////////////////////////////////////////////////////////////////////////////////
void AddTierProps(object oItem);
void AddTierProps(object oItem)
    {
    // First we must evaluate what kind of item this is
    string sType;
    int iType = GetBaseItemType(oItem);
    int iCostValue;
    int iTier = GetLocalInt(oItem, "TIER");
    // Determine base item type
    if (iType == BASE_ITEM_ARMOR)
        {
        sType = "ARMOR";
        }
    else if (iType == BASE_ITEM_SMALLSHIELD
        || iType == BASE_ITEM_TOWERSHIELD
        || iType == BASE_ITEM_LARGESHIELD)
        {
        sType = "SHIELD";
        }
    else if (iType == BASE_ITEM_HELMET)
        {
        sType = "HELMET";
        }
    else
        {
        sType = "WEAPON";
        }
    // Now, depending on tier, we remove corrosponding properties
    // Broken = -2 property
    if (iTier == 2)
        {
        // Determine item type
        if (sType == "ARMOR")
            {
            iCostValue = GetExistingCostValue(oItem, 28, 2, "YES");
            // We removed the existing property above, we need to check cost
            AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyDecreaseAC(2, iCostValue + 2), oItem);
            }
        else if (sType == "SHIELD")
            {
            iCostValue = GetExistingCostValue(oItem, 28, 3, "YES");
            // We removed the existing property above, we need to check cost
            AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyDecreaseAC(3, iCostValue + 2), oItem);
            }
        else if (sType == "HELMET")
            {
            iCostValue = GetExistingCostValue(oItem, 28, 4, "YES");
            // We removed the existing property above, we need to check cost
            AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyDecreaseAC(4, iCostValue + 2), oItem);
            }
        else
            {
            iCostValue = GetExistingCostValue(oItem, 10, -1, "YES");
            // We removed the existing property above, we need to check cost
            AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyEnhancementPenalty(iCostValue + 2), oItem);
            }
        }
    // Damaged = -1 property
    else if (iTier == 3)
        {
        // Determine item type
        if (sType == "ARMOR")
            {
            iCostValue = GetExistingCostValue(oItem, 28, 2, "YES");
            // We removed the existing property above, we need to check cost
            AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyDecreaseAC(2, iCostValue + 1), oItem);
            }
        else if (sType == "SHIELD")
            {
            iCostValue = GetExistingCostValue(oItem, 28, 3, "YES");
            // We removed the existing property above, we need to check cost
            AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyDecreaseAC(3, iCostValue + 1), oItem);
            }
        else if (sType == "HELMET")
            {
            iCostValue = GetExistingCostValue(oItem, 28, 4, "YES");
            // We removed the existing property above, we need to check cost
            AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyDecreaseAC(4, iCostValue + 1), oItem);
            }
        else
            {
            iCostValue = GetExistingCostValue(oItem, 10, -1, "YES");
            // We removed the existing property above, we need to check cost
            AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyEnhancementPenalty(iCostValue + 1), oItem);
            }
        }
    // Honed/Reinforced = +1 property
    else if (iTier == 6)
        {
        // Determine item type
        if (sType == "ARMOR" || sType == "SHIELD" || sType == "HELMET")
            {
            iCostValue = GetExistingCostValue(oItem, 1, 0, "YES");
            // We removed the existing property above, we need to check cost
            AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyACBonus(iCostValue + 1), oItem);
            }
        else
            {
            iCostValue = GetExistingCostValue(oItem, 6, -1, "YES");
            // We removed the existing property above, we need to check cost
            AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyEnhancementBonus(iCostValue + 1), oItem);
            }
        }
    }

////////////////////////////////////////////////////////////////////////////////
// This function will determine if the item has ascended to a new tier. This
//  function will also reset the new tier and sharpness/durability.
////////////////////////////////////////////////////////////////////////////////
void EvaluateIncreasedTier(object oItem, string sType);
void EvaluateIncreasedTier(object oItem, string sType)
    {
    int iTier = GetLocalInt(oItem, "TIER");
    int iMaterial = GetLocalInt(oItem, "MATERIAL");
    int iTotal;
    // First we determine our sharpness/durability
    if (sType == "ARMOR")
        {
        iTotal = GetLocalInt(oItem, "DURABILITY");
        }
    else
        {
        iTotal = GetLocalInt(oItem, "SHARPNESS");
        }
    // Now we retrieve the max values for our material
    int iValue = GetMaxMaterialValue(oItem);
    // Now we compare our max value to our total sharpness/durability. If more
    //  we will update to a new tier.
    if (iTotal > iValue)
        {
        if (sType == "WEAPON")
            {
            SetLocalInt(oItem, "SHARPNESS", iTotal - iValue);
            // Only allowing to break 1 tier at a time.
            if (iTotal - iValue > iValue)
                {
                SetLocalInt(oItem, "SHARPNESS", iValue - 1);
                }
            }
        else
            {
            SetLocalInt(oItem, "DURABILITY", iTotal - iValue);
            // Only allowing to break 1 tier at a time.
            if (iTotal - iValue > iValue)
                {
                SetLocalInt(oItem, "DURABILITY", iValue - 1);
                }
            }
        iTier = iTier + 1;
        SendMessageToPC(GetItemPossessor(oItem), "Your " + GetName(oItem) + " has reached a new level of effectiveness.");
        RemoveTierProps(oItem);
        SetLocalInt(oItem, "TIER", iTier);
        AddTierProps(oItem);
        // Update item label
        EvaluateName(oItem);
        }
    }

////////////////////////////////////////////////////////////////////////////////
// This function will evaluate, remove or add tier properties to an item.
////////////////////////////////////////////////////////////////////////////////
void EvaluateTiers(object oItem, string sType);
void EvaluateTiers(object oItem, string sType)
    {
    int iTier = GetLocalInt(oItem, "TIER");
    int iValue;
    if (sType == "ARMOR")
        {
        iValue = GetLocalInt(oItem, "DURABILITY");
        }
    else
        {
        iValue = GetLocalInt(oItem, "SHARPNESS");
        }
    // If our value is 1, we need to break to a lower tier.
    if (iValue == 1)
        {
        // Drop tier, preserve old properties and remove tier properties.
        iTier = iTier - 1;
        // If Tier is now 1, destroy the item.
        if (iTier == 1)
            {
            SendMessageToPC(GetItemPossessor(oItem), "Your " + GetName(oItem) + " has become too damaged and has been destroyed.");
            DestroyObject(oItem);
            }
        else
            {
            SendMessageToPC(GetItemPossessor(oItem), "Your " + GetName(oItem) + " has become less effective");
            SetLocalInt(oItem, "TIER", iTier);
            }
        RemoveTierProps(oItem);
        SetLocalInt(oItem, "TIER", iTier);
        AddTierProps(oItem);
        // Update item label
        EvaluateName(oItem);
        }
    }

////////////////////////////////////////////////////////////////////////////////
// This function is the majority of the effort, and use the modular functions
//  to build upon logic.
////////////////////////////////////////////////////////////////////////////////
void EvaluateItem(object oItem);
void EvaluateItem(object oItem)
    {
    // We're going to need to know if this is a weapon or armor
    string sType = GetItemType(oItem);
    // If this isn't a weapon or armor, quit.
    if (sType == "OTHER")
        {
        return;
        }
    // Initial veriables
    int iMaterial = GetLocalInt(oItem, "MATERIAL");
    int iSharpness = GetLocalInt(oItem, "SHARPNESS");
    int iDurability = GetLocalInt(oItem, "DURABILITY");
    int iTier = GetLocalInt(oItem, "TIER");
    // If iMaterial is zero, it's a new item.
    if (iMaterial == 0 || iSharpness + iDurability == 0)
        {
        SetupNewItem(oItem, sType);
        EvaluateTiers(oItem, sType);
        AddTierProps(oItem);
        }
    }
