//:://////////////////////////////////////////////
//:: Antiworld Items Editing functions
//:: stx_inc_craft
//:://////////////////////////////////////////////
/*
    Additions to the original Bioware scripts:
    - Ability to edit all equippables items
    - Renaming your Items
    - Change the appearance of items
    - Counters the 'double item' exploit !

    Uses the complete dyeset made by android79
    - http://nwvault.ign.com/Files/prefabs/data/1070781839104.shtml
    And the enhanced crafting system Created By:
    SartriX - http://nwvault.ign.com/Files/scripts/data/1071920548260.shtml


    This system has been made primairly for:
    Antiworld,
    - http://antiworld.biz
    */
//:://////////////////////////////////////////////
//:: Created By: Antiworld
//:: Created On: August 2006
//:: Updated On: August 2006
//:://////////////////////////////////////////////


#include "x2_inc_craft"

// Set to FALSE to disable the requirement of the proper placeable to be near the PC
const int    STX_CR_REQUIRE_PLACEABLE = TRUE;
// Maximum distance to a crafting placeable
const string STX_CR_PLACEABLE_TAG = "stx_cr_craftplace";
// Maximum distance to a crafting placeable
const float  STX_CR_REQUIRED_DISTANCE = 4.0f;

// Set to FALSE to disable the requirement and use of dyes when recolouring
const int    STX_CR_REQUIRE_DYES      = TRUE;

// Maximum cost in percent of the item's original valie at all times regardless of any other settings
const int    STX_CR_MAXCOST           = 1;
// Percentage of cost for each part of a weapon (3 parts max) or a helmet/shield (1 part max)
const int    STX_CR_PARTCOST          = 1;
// Added percentage of cost for dye changes by NPC
const int    STX_CR_NPCDYECOST        = 1;
// Percentage it costs to craft one self compared to what a NPC would ask for the same
// NPC cost is always 100% of the CraftCost in des_crft_aparts.2da
const int    STX_CR_SELFCRAFT         = 0;
// The DC that's added to craft magical items. This DC is added for each magical property it has
const int    STX_CR_DCADD             = 1;


//Return true if is an OLD ammo maker
int GetIsOldAmmoMaker(object oItem);

int GetIsAmmoMaker(object oItem);


// Tag of the backup container
// One is supplied as custom placeable (custom -> special -> custom5 -> stx_cr_backup)
// and should be placed on a preferrably inaccessible location. If the container can not be found,
// the backup item will be added to the PC's inventory, it won't break the entire script.

// this is also defined in item_enhancement to remove the need to include this file,
//if this is changed please also edit that value

const string STX_CR_BACKUP_PLACEABLE  = "stx_cr_backup";

int StX_GetIsWeapon(object oWeapon);

// Internal constants, do not touch!
const int    STX_CR_DONE_SUCCESS = 1;
const int    STX_CR_DONE_FAILED  = 2;
const int    STX_CR_DONE_NOGOLD  = 3;
const int    STX_CR_DONE_NODYE   = 4;

const int    STX_CR_PART_NEXT  = 0;
const int    STX_CR_PART_PREV  = 1;
const int    STX_CR_COLOR_NEXT = 3;
const int    STX_CR_COLOR_PREV = 4;

const int    STX_CR_TOKENBASE = 20000;

const int    STX_CR_HELMET = 8888;
const int    STX_CR_SHIELD = 8889;
const int    STX_CR_PART_BELT = 8890;
const int    STX_CR_PART_BRACER = 8891;
const int    STX_CR_PART_GLOVES = 8892;
const int    STX_CR_PART_NECK = 8893;
const int    STX_CR_PART_CLOAK = 8894;
const int    STX_CR_PART_RRING  = 8895;
const int    STX_CR_PART_LRING  = 8896;
const int    STX_CR_PART_ARROWS  = 8897;
const int    STX_CR_PART_BOLTS  = 8898;
const int    STX_CR_PART_BULLETS  = 8899;

// - End of constants - //


// Sets up everything for oPC to start crafting on oItem
void StX_StartCraft(object oPC, object oItem);

// Tries to let oPC perform the crafting of his current item
// Will set the localvar STX_CR_DONE on success or fail with one
// of the following values to check with a conditional script:
//    STX_CR_DONE_SUCCESS
//    STX_CR_DONE_FAILED
//    STX_CR_DONE_NOGOLD
//    STX_CR_DONE_NODYE
void StX_AttemptCraft(object oPC);

// Stops crafting and cleans up everything set by the crafting script
// When nExecute is FALSE, it will abort the craft,
// when it's TRUE, it will replace the old item with the new one.
void StX_StopCraft(object oPC, int nExecute=FALSE);

// Sets the current part oPC is working on
// It accepts all 4 partseries ITEM_APPR_ARMOR_MODEL_*,
// ITEM_APPR_WEAPON_MODEL_*, ITEM_APPR_ARMOR_COLOR_*, ITEM_APPR_WEAPON_COLOR_*
// as long as the proper item has been set to craft on
// Focusses the camery on the selected part (if applicable)
void StX_SetPart(object oPC, int nPart, int nStrRef);

// Gets the cost to modify oItem into oNew
// Calls the default bioware routines for this, edit this function to override
int StX_GetModificationCost(object oItem, object oNew, int nNPC=FALSE);

// Gets the DC to modify oItem into oNew
// Calls the default bioware routines for this, edit this function to override
int StX_GetModificationDC(object oItem, object oNew, int nNPC=FALSE);

// Remakes and equips the item oPC is working, having the currently set part
// cycled either forward or backward
// nMode: STX_CR_PART_NEXT - cycle forward
// nMode: STX_CR_PART_PREV - cycle backward
void StX_RemakeItem(object oPC, int nMode);

// Remakes and equips the item oPC is working, having the currently set color
// cycled either forward or backward
// nMode: STX_CR_COLOR_NEXT - cycle forward
// nMode: STX_CR_COLOR_PREV - cycle backward
void StX_RecolorItem(object oPC, int nMode);

object MatchItem(object oItem, object oPC, int nType, int nIndex);
// - Implementation - //


object MatchItem(object oItem, object oPC, int nType, int nIndex)
{
    int nValue = GetItemAppearance(oPC,nType,nIndex);
    object oNew = CopyItemAndModify(oItem,nType,nIndex,nValue);

    DestroyObject(oItem);
    return oNew;
}

// Sets up everything for oPC to start crafting on oItem
void StX_StartCraft(object oPC, object oItem) {
    // Immobilize player while crafting
    effect eImmob = EffectCutsceneImmobilize();
    eImmob = ExtraordinaryEffect(eImmob);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT,eImmob,oPC);

    // Make the camera float near the PC
    StoreCameraFacing();
    float fFacing  = GetFacing(oPC) + 180.0;
    if (fFacing >= 360.0) fFacing -=360.0;
    SetCameraFacing(fFacing, 3.5f, 75.0, CAMERA_TRANSITION_TYPE_FAST);

    // Make backup
    object oBackup = CopyItem(oItem, GetObjectByTag(STX_CR_BACKUP_PLACEABLE), TRUE);

    SetLocalObject(oPC, "STX_CR_BACKUP", oBackup);

    // Mark temporary item
    SetStolenFlag(oItem, TRUE);
    SetLocalInt(oItem, "STX_CR_TEMPITEM", TRUE);
    SetLocalInt(oItem,"isCopy",1);
    SetLocalObject(oPC, "STX_CR_ITEM", oItem);

    // Preset settings
    SetLocalInt(oPC, "STX_CR_STARTED", 1);
    SetLocalInt(oPC, "STX_CR_COST", 0);
    SetLocalInt(oPC, "STX_CR_DC", 0);
    SetLocalInt(oPC, "STX_CR_DONE", 0);
    SetLocalInt(oPC, "STX_CR_CHANGED", FALSE);
    SetCustomToken(STX_CR_TOKENBASE,   "");
    SetCustomToken(STX_CR_TOKENBASE+1, "0");
    SetCustomToken(STX_CR_TOKENBASE+2, "0");
    SetCustomToken(STX_CR_TOKENBASE+3, "");
}

// - private -
// Checks if the color for nIndex has changed, if not returns TRUE
// if it has, checks if oPC has the new dye and returns TRUE when he has
// returns FALSE and sets CUSTOM20003 when the required dye is not present
int StX_ColorCheck(object oPC, object oItem, object oBackup, int nType, int nIndex) {
    // if required dyes are disabled, always return TRUE
    if (!STX_CR_REQUIRE_DYES) return TRUE;

    // get new color
    int nColor = GetItemAppearance(oItem, nType, nIndex);
    SendMessageToPC(oPC,"Color: "+IntToString(nColor));
    string sDyeTag = "Dye";

    if (nColor != GetItemAppearance(oBackup, nType, nIndex)) {
        // color has changed, build the tag for the required dye
        if (nType == ITEM_APPR_TYPE_ARMOR_COLOR) {
            switch(nIndex) {
                case ITEM_APPR_ARMOR_COLOR_CLOTH1:
                case ITEM_APPR_ARMOR_COLOR_CLOTH2:   sDyeTag+= "C"; break;
                case ITEM_APPR_ARMOR_COLOR_LEATHER1:
                case ITEM_APPR_ARMOR_COLOR_LEATHER2: sDyeTag+= "L"; break;
                case ITEM_APPR_ARMOR_COLOR_METAL1:
                case ITEM_APPR_ARMOR_COLOR_METAL2:   sDyeTag+= "M";
                    if (nColor>55 && nColor<60) nColor-=4; break; // translate missing/double metal colors
            }
            if (nColor<10) sDyeTag+= "0";
            sDyeTag+= IntToString(nColor);
        } else {
            switch (nColor) {
                case 1: sDyeTag+= "M01"; break; // Steel
                case 2: sDyeTag+= "M13"; break; // Gold
                case 3: sDyeTag+= "M21"; break; // Copper
                case 4: sDyeTag+= "M02"; break; // Dark Steel
            }
        }
        if (GetIsObjectValid(GetItemPossessedBy(oPC, sDyeTag))) {
            // oPC has the dye, so this color is alright
            SetLocalString(oPC, "STX_CR_DYES", GetLocalString(oPC, "STX_CR_DYES") + sDyeTag + ":");
            return TRUE;
        } else {
            // oPC does not have the dye, tell which dye is missing
            if (GetName(GetObjectByTag(sDyeTag))=="") SpeakString("Missing dye/name: "+sDyeTag);
            SetCustomToken(STX_CR_TOKENBASE+3, GetName(GetObjectByTag(sDyeTag)));
            return FALSE;
        }
    }
    return TRUE;
}

// Tries to let oPC perform the crafting of his current item
// Will set the localvar STX_CR_DONE on success or fail with one
// of the following values to check with a conditional script:
//    STX_CR_DONE_SUCCESS
//    STX_CR_DONE_FAILED
//    STX_CR_DONE_NOGOLD
//    STX_CR_DONE_NODYE
void StX_AttemptCraft(object oPC) {
    // don't reattempt a previously craftattempt
    if (GetLocalInt(oPC, "STX_CR_DONE")>0) return;

    // get current item and backup
    object oItem = GetLocalObject(oPC, "STX_CR_ITEM");
    object oBackup = GetLocalObject(oPC, "STX_CR_BACKUP");
    int nNPC = GetIsObjectValid(GetLocalObject(oPC, "STX_CR_NPC"));
    int nCost = StX_GetModificationCost(oBackup, oItem, nNPC);
    int nDC   = StX_GetModificationDC(oBackup, oItem, nNPC);
    int nSkill;

    if (GetGold(oPC)<nCost) {
        // player has insufficent gold, cancel
        SetLocalInt(oPC, "STX_CR_DONE", STX_CR_DONE_NOGOLD);
        return;
    }
    // check if all dyes are present and set the skill to be used
    if (GetBaseItemType(oItem)==BASE_ITEM_ARMOR || GetBaseItemType(oItem)==BASE_ITEM_HELMET) {

        nSkill = SKILL_CRAFT_ARMOR;
    } else {

        nSkill = SKILL_CRAFT_WEAPON;
    }

    // take gold
    TakeGoldFromCreature(nCost, oPC, TRUE);
    // take dyes
    string sDyes = GetLocalString(oPC, "STX_CR_DYES");
    string sDyeTag;
    int nLen = GetStringLength(sDyes);
    int n;
    while (sDyes!="") {
        n = FindSubString(sDyes, ":");
        sDyeTag = GetSubString(sDyes, 0, n);
        sDyes = GetSubString(sDyes, n+1, nLen);
        DestroyObject(GetItemPossessedBy(oPC, sDyeTag));
    }
    // roll DC
    /* if (nNPC || GetIsSkillSuccessful(oPC, nSkill, nDC)) {    */
        SetLocalInt(oPC, "STX_CR_DONE", STX_CR_DONE_SUCCESS);
        return;
    /*}
    SetLocalInt(oPC, "STX_CR_DONE", STX_CR_DONE_FAILED); */
}

// Stops crafting and cleans up everything set by the crafting script
// When nExecute is FALSE, it will abort the craft,
// when it's TRUE, it will replace the old item with the new one.
void StX_StopCraft(object oPC, int nExecute) {
    // Get and equip correct  item (backup when not successfull or cancelled)
    object oItem = GetLocalObject(oPC, "STX_CR_ITEM");
    object oBackup = GetLocalObject(oPC, "STX_CR_BACKUP");
    if (nExecute) {
        DestroyObject(oBackup);
        SetStolenFlag(oItem, FALSE);
        DeleteLocalInt(oItem, "STX_CR_TEMPITEM");
        DeleteLocalInt(oItem,"isCopy");
    } else {
        DestroyObject(oItem);
        oItem = CopyItem(oBackup, oPC, TRUE);
        DestroyObject(oBackup);
    }
    AssignCommand(oPC, ClearAllActions(TRUE));
    if (GetLocalInt(oPC,"nSlot"))     AssignCommand(oPC, ActionEquipItem(oItem, GetLocalInt(oPC,"nSlot")));
    else
     {
        if (GetBaseItemType(oItem)==BASE_ITEM_ARMOR) {
            AssignCommand(oPC, ActionEquipItem(oItem, INVENTORY_SLOT_CHEST));
        } else if (GetBaseItemType(oItem)==BASE_ITEM_HELMET) {
            AssignCommand(oPC, ActionEquipItem(oItem, INVENTORY_SLOT_HEAD));
        } else if (GetBaseItemType(oItem)==BASE_ITEM_LARGESHIELD || GetBaseItemType(oItem)==BASE_ITEM_TOWERSHIELD  || GetBaseItemType(oItem)==BASE_ITEM_SMALLSHIELD ||GetBaseItemType(oItem)==BASE_ITEM_TORCH) {
            AssignCommand(oPC, ActionEquipItem(oItem, INVENTORY_SLOT_LEFTHAND));
        } else if (GetBaseItemType(oItem)==BASE_ITEM_BOOTS) {
            AssignCommand(oPC, ActionEquipItem(oItem, INVENTORY_SLOT_BOOTS));
         } else if (GetBaseItemType(oItem)==BASE_ITEM_BRACER || GetBaseItemType(oItem)==BASE_ITEM_GLOVES) {
            AssignCommand(oPC, ActionEquipItem(oItem, INVENTORY_SLOT_ARMS));
        } else if (GetBaseItemType(oItem)==BASE_ITEM_AMULET ) {
            AssignCommand(oPC, ActionEquipItem(oItem, INVENTORY_SLOT_NECK));
         } else if (GetBaseItemType(oItem)==BASE_ITEM_RING ) {
            AssignCommand(oPC, ActionEquipItem(oItem, INVENTORY_SLOT_RIGHTRING));
         } else if (GetBaseItemType(oItem)==BASE_ITEM_CLOAK ) {
            AssignCommand(oPC, ActionEquipItem(oItem, INVENTORY_SLOT_CLOAK));
         } else if (GetBaseItemType(oItem)==BASE_ITEM_BELT ) {
            AssignCommand(oPC, ActionEquipItem(oItem, INVENTORY_SLOT_BELT));
          } else if (GetBaseItemType(oItem)==BASE_ITEM_BULLET ) {
            AssignCommand(oPC, ActionEquipItem(oItem, INVENTORY_SLOT_BULLETS));
          } else if (GetBaseItemType(oItem)==BASE_ITEM_ARROW ) {
            AssignCommand(oPC, ActionEquipItem(oItem, INVENTORY_SLOT_ARROWS));
          }  else if   (StX_GetIsWeapon(oItem)) {
            AssignCommand(oPC, ActionEquipItem(oItem, INVENTORY_SLOT_RIGHTHAND));
        }
    }
    // Postclean settings
    DeleteLocalInt(oPC, "STX_CR_COST");
    DeleteLocalInt(oPC, "STX_CR_DC");
    DeleteLocalInt(oPC, "STX_CR_PART");
    DeleteLocalInt(oPC, "STX_CR_DONE");
    DeleteLocalInt(oPC, "STX_CR_CHANGED");
    DeleteLocalObject(oPC, "STX_CR_ITEM");
    DeleteLocalObject(oPC, "STX_CR_BACKUP");
    DeleteLocalObject(oPC, "STX_CR_NPC");
    DeleteLocalObject(oPC, "STX_CR_PLACEABLE");
    DeleteLocalInt(oPC,"nSlot");

    // Remove custscene immobilize and light from player
    effect eEff = GetFirstEffect(oPC);
    while (GetIsEffectValid(eEff)) {
        if (GetEffectType(eEff) == EFFECT_TYPE_CUTSCENEIMMOBILIZE)
            RemoveEffect(oPC,eEff);
        eEff = GetNextEffect(oPC);
    }
    RestoreCameraFacing();
}

// - private -
void StX_SetColorToken(int nIndex, int nColor) {
    string sDyeTag = "Dye";
    switch(nIndex) {
        case ITEM_APPR_ARMOR_COLOR_CLOTH1:
        case ITEM_APPR_ARMOR_COLOR_CLOTH2:   sDyeTag+= "C"; break;
        case ITEM_APPR_ARMOR_COLOR_LEATHER1:
        case ITEM_APPR_ARMOR_COLOR_LEATHER2: sDyeTag+= "L"; break;
        case ITEM_APPR_ARMOR_COLOR_METAL1:
        case ITEM_APPR_ARMOR_COLOR_METAL2:   sDyeTag+= "M";
            if (nColor>55 && nColor<60) nColor-=4; break; // translate missing/double metal colors
    }
    if (nColor<10) sDyeTag+= "0";
    sDyeTag+= IntToString(nColor);
    SetCustomToken(STX_CR_TOKENBASE+3, GetName(GetObjectByTag(sDyeTag)));
}

// Sets the current part oPC is working on
// It accepts all 4 partseries ITEM_APPR_ARMOR_MODEL_*,
// ITEM_APPR_WEAPON_MODEL_*, ITEM_APPR_ARMOR_COLOR_*, ITEM_APPR_WEAPON_COLOR_*
// as long as the proper item has been set to craft on
// Focusses the camery on the selected part (if applicable)
void StX_SetPart(object oPC, int nPart, int nStrRef) {
    SetLocalInt(oPC, "STX_CR_PART", nPart);
    object oItem = GetLocalObject(oPC, "STX_CR_ITEM");

    // * Make the camera float near the PC
    float fFacing  = GetFacing(oPC) + 180.0;
    float fPitch   = 75.0;
    float fDistance= 3.5;

    if (GetBaseItemType(oItem)==BASE_ITEM_ARMOR) {
        switch (nPart) {
            case ITEM_APPR_ARMOR_MODEL_LBICEP:
            case ITEM_APPR_ARMOR_MODEL_LFOREARM:
            case ITEM_APPR_ARMOR_MODEL_LHAND:
            case ITEM_APPR_ARMOR_MODEL_LSHOULDER:
            case ITEM_APPR_ARMOR_MODEL_LTHIGH:
            case ITEM_APPR_ARMOR_MODEL_LSHIN:
            case ITEM_APPR_ARMOR_MODEL_LFOOT: fFacing += 60.0; break;
            case ITEM_APPR_ARMOR_MODEL_RBICEP:
            case ITEM_APPR_ARMOR_MODEL_RFOREARM:
            case ITEM_APPR_ARMOR_MODEL_RHAND:
            case ITEM_APPR_ARMOR_MODEL_RSHOULDER:
            case ITEM_APPR_ARMOR_MODEL_RTHIGH:
            case ITEM_APPR_ARMOR_MODEL_RSHIN:
            case ITEM_APPR_ARMOR_MODEL_RFOOT: fFacing -= 60.0; break;
        }
        switch (nPart) {
            case ITEM_APPR_ARMOR_MODEL_LBICEP:
            case ITEM_APPR_ARMOR_MODEL_RBICEP:
            case ITEM_APPR_ARMOR_MODEL_LFOOT:
            case ITEM_APPR_ARMOR_MODEL_RFOOT: fDistance = 3.5; fPitch = 47.0; break;
            case ITEM_APPR_ARMOR_MODEL_LFOREARM:
            case ITEM_APPR_ARMOR_MODEL_RFOREARM:
            case ITEM_APPR_ARMOR_MODEL_LHAND:
            case ITEM_APPR_ARMOR_MODEL_RHAND: fDistance = 2.0; fPitch = 60.0; break;
            case ITEM_APPR_ARMOR_MODEL_LSHIN:
            case ITEM_APPR_ARMOR_MODEL_RSHIN: fDistance = 3.5; fPitch = 95.0; break;
            case ITEM_APPR_ARMOR_MODEL_LSHOULDER:
            case ITEM_APPR_ARMOR_MODEL_RSHOULDER: fDistance = 3.0; fPitch = 50.0; break;
            case ITEM_APPR_ARMOR_MODEL_LTHIGH:
            case ITEM_APPR_ARMOR_MODEL_RTHIGH: fDistance = 2.5; fPitch = 65.0; break;
            case ITEM_APPR_ARMOR_MODEL_NECK: fPitch = 90.0; break;
            case ITEM_APPR_ARMOR_MODEL_BELT:
            case ITEM_APPR_ARMOR_MODEL_PELVIS: fDistance = 2.0; break;
        }
    } else if (nPart==STX_CR_HELMET) {
        fDistance = 2.5;
        fPitch = 85.0;
    } else if (nPart==STX_CR_SHIELD) {
        fFacing += 60.0;
        fDistance = 3.0;
        fPitch = 65.0;
    } else {
        fFacing -= 60.0;
        fDistance = 3.0;
        fPitch = 65.0;
    }
    if (fFacing >= 360.0) fFacing -=360.0;
    if (GetRacialType(oPC) == RACIAL_TYPE_HALFORC) fDistance += 1.0f;
    SetCameraFacing(fFacing, fDistance, fPitch, CAMERA_TRANSITION_TYPE_VERY_FAST);

    int nCost = GetLocalInt(oPC, "STX_CR_COST");
    int nDC   = GetLocalInt(oPC, "STX_CR_DC");
    SetCustomToken(STX_CR_TOKENBASE, GetStringByStrRef(nStrRef));
    SetCustomToken(STX_CR_TOKENBASE+1, IntToString(nCost));
    SetCustomToken(STX_CR_TOKENBASE+2, IntToString(nDC));
    StX_SetColorToken(nPart, GetItemAppearance(oItem, ITEM_APPR_TYPE_ARMOR_COLOR, nPart));

}

// - private -
// Gets the cost to modify oItem into oNew
int StX_GetModificationCost(object oItem, object oNew, int nNPC=FALSE) {
    int nCost = 0;
    int nChanges = -1;
    int nPart;
    float fFactor;

    // Find and count changes
    if (GetBaseItemType(oItem)==BASE_ITEM_ARMOR) {
        for (nPart = 0; nPart<=ITEM_APPR_ARMOR_MODEL_ROBE; nPart++) {
            if (GetItemAppearance(oItem, ITEM_APPR_TYPE_ARMOR_MODEL, nPart) != GetItemAppearance(oNew, ITEM_APPR_TYPE_ARMOR_MODEL, nPart)) {
                // Part changed, add price factor
               nCost += StringToInt(Get2DAString("des_crft_aparts", "CraftCost", nPart));
                //nCost += StringToInt(Get2DAString("des_crft_appear", "CraftCost", nPart));
                nChanges++;
            }
        }
    } else {
        for (nPart = 0; nPart<3; nPart++) {
            if (GetItemAppearance(oItem, ITEM_APPR_TYPE_WEAPON_MODEL, nPart) != GetItemAppearance(oNew, ITEM_APPR_TYPE_WEAPON_MODEL, nPart)) {
                // Part changed, add price factor
                nCost += STX_CR_PARTCOST;
                nChanges++;
            }
        }
        nChanges *= 5;
    }
    // More as 1 part changed, give a 'discount'
    if (nChanges>0) nCost -= nChanges;
    // Reworked item may not cost more as 90% of a brand new one
    if (nCost>STX_CR_MAXCOST) nCost = STX_CR_MAXCOST;
    if (nNPC) {
        // If made by a NPC, charge for the dyes
        if (GetBaseItemType(oItem)==BASE_ITEM_ARMOR) {
            for (nPart = 0; nPart<=ITEM_APPR_ARMOR_MODEL_ROBE; nPart++) {
                if (GetItemAppearance(oItem, ITEM_APPR_TYPE_ARMOR_COLOR, nPart) != GetItemAppearance(oNew, ITEM_APPR_TYPE_ARMOR_COLOR, nPart)) {
                    // Part changed, add price factor
                    nCost += STX_CR_NPCDYECOST;
                }
            }
        } else {
            for (nPart = 0; nPart<3; nPart++) {
                if (GetItemAppearance(oItem, ITEM_APPR_TYPE_WEAPON_COLOR, nPart) != GetItemAppearance(oNew, ITEM_APPR_TYPE_WEAPON_COLOR, nPart)) {
                    // Part changed, add price factor
                    nCost += STX_CR_NPCDYECOST;
                }
            }
        }
        fFactor = IntToFloat(nCost) / 100.0;
    } else {
        // If made by the PC himself, the price is 70% of what an NPC would ask him
        fFactor = IntToFloat(nCost * STX_CR_SELFCRAFT) / 10000.0;
    }
    // Calculate and return final cost
    nCost = FloatToInt(IntToFloat(GetGoldPieceValue(oItem)) * fFactor);
    if (nCost<1) nCost=1;
    return 1; //nCost;
}

// - private -
// Gets the DC to modify oItem into oNew
int StX_GetModificationDC(object oItem, object oNew, int nNPC=FALSE) {
    if (nNPC) return 0;
    int nDC;
    int nChanges = -1;
    int nPart;
    float fFactor;

    // Find and count changes
    if (GetBaseItemType(oItem)==BASE_ITEM_ARMOR) {
        for (nPart = 0; nPart<=ITEM_APPR_ARMOR_MODEL_ROBE; nPart++) {
            if (GetItemAppearance(oItem, ITEM_APPR_TYPE_ARMOR_MODEL, nPart) != GetItemAppearance(oNew, ITEM_APPR_TYPE_ARMOR_MODEL, nPart)) {
                // Part changed, add DC factor
               nDC += StringToInt(Get2DAString("des_crft_aparts", "CraftDC", nPart));
                //nDC += StringToInt(Get2DAString("des_crft_appear", "CraftDC", nPart));
                nChanges++;
            }
        }
    } else {
        for (nPart = 0; nPart<3; nPart++) {
            if (GetItemAppearance(oItem, ITEM_APPR_TYPE_WEAPON_MODEL, nPart) != GetItemAppearance(oNew, ITEM_APPR_TYPE_WEAPON_MODEL, nPart)) {
                // Part changed, add DC factor
                nDC += 6;
                nChanges++;
            }
        }
        nChanges *= 2;
    }
    // More as 1 part changed, give a 'discount'
    if (nChanges>0) nDC -= nChanges;
    itemproperty iP = GetFirstItemProperty(oItem);
    while (GetIsItemPropertyValid(iP)) {
        nDC += STX_CR_DCADD;
        iP = GetNextItemProperty(oItem);
    }
    return 1; //nDC; //made dc always 0
}

// - private -
// Reverses a : seperated stringlist
string StX_ListReverse(string s) {
    string sCache;
    int n;
    int l = GetStringLength(s);
    s = GetSubString(s, 1, l);
    while (s!="") {
        // take string upto next seperator and put this in front of cache
        n = FindSubString(s, ":")+1;
        sCache = GetStringLeft(s, n) + sCache;
        s = GetSubString(s, n, l);
    }
    return ":"+sCache;
}

// - private -
// Prereads the parts_chest.2da-file for sAC and puts all used ID's in a : seperated stringlist
string StX_PreReadArmorACList(string sAC) {
    // pick the right 2da to read the parts from
    string s2DA = "parts_chest";
    string sCache= ":";
    string sLine;
    // get the maxID used (not the amount of ID's !!!)
    int nMax = IPGetNumberOfArmorAppearances(ITEM_APPR_ARMOR_MODEL_TORSO);
    int n=1;
    sAC = GetStringLeft(sAC, 1);
    while (n<=nMax) {
        // Verify validity of the ID and add to the list
        sLine = Get2DAString(s2DA, "ACBONUS", n);
        if (GetStringLeft(sLine, 1)==sAC) {
            sCache+= IntToString(n)+":";
        }
        n++;
    }
    // Store the list in a modulestring, once normal, once reversed, both with ID 0 added as first index for cycling
    SetLocalString(GetModule(), "StX_IDPreReadAC_"+GetStringLeft(sAC,1), sCache);
    SetLocalString(GetModule(), "StX_IDPreReadACR_"+GetStringLeft(sAC,1), StX_ListReverse(sCache));
//    SpeakString("PreRead: "+sAC+" - "+sCache);
    return sCache;
}

// - private -
// Prereads the 2da-file for nPart and puts all used ID's in a : seperated stringlist
string StX_PreReadArmorPartList(int nPart) {
    // pick the right 2da to read the parts from
    string s2DA = "parts_";
    switch (nPart) {
        case ITEM_APPR_ARMOR_MODEL_LBICEP:
        case ITEM_APPR_ARMOR_MODEL_RBICEP: s2DA+= "bicep"; break;
        case ITEM_APPR_ARMOR_MODEL_LFOOT:
        case ITEM_APPR_ARMOR_MODEL_RFOOT: s2DA+= "foot"; break;
        case ITEM_APPR_ARMOR_MODEL_LFOREARM:
        case ITEM_APPR_ARMOR_MODEL_RFOREARM: s2DA+= "forearm"; break;
        case ITEM_APPR_ARMOR_MODEL_LHAND:
        case ITEM_APPR_ARMOR_MODEL_RHAND: s2DA+= "hand"; break;
        case ITEM_APPR_ARMOR_MODEL_LSHIN:
        case ITEM_APPR_ARMOR_MODEL_RSHIN: s2DA+= "shin"; break;
        case ITEM_APPR_ARMOR_MODEL_LSHOULDER:
        case ITEM_APPR_ARMOR_MODEL_RSHOULDER: s2DA+= "shoulder"; break;
        case ITEM_APPR_ARMOR_MODEL_LTHIGH:
        case ITEM_APPR_ARMOR_MODEL_RTHIGH: s2DA+= "belt"; break;
        case ITEM_APPR_ARMOR_MODEL_NECK: s2DA+= "neck"; break;
        case ITEM_APPR_ARMOR_MODEL_BELT: s2DA+= "belt"; break;
        case ITEM_APPR_ARMOR_MODEL_PELVIS: s2DA+= "pelvis"; break;
        case ITEM_APPR_ARMOR_MODEL_ROBE: s2DA+= "robe"; break;
    }

    string sCache= ":";
    string sLine;
    // get the maxID used (not the amount of ID's !!!)
     int nMax = StringToInt(Get2DAString("des_crft_aparts", "NumParts", nPart));
    // int nMax = StringToInt(Get2DAString("des_crft_appear", "NumParts", nPart));
    int n=1;
    while (n<=nMax) {
        // Verify validity of the ID and add to the list
        sLine = Get2DAString(s2DA, "ACBONUS", n);
        if (sLine!="") {
            sCache+= IntToString(n)+":";
        }
        n++;
    }
    // Store the list in a modulestring, once normal, once reversed, both with ID 0 added as first index for cycling
    SetLocalString(GetModule(), "StX_IDPreRead_"+IntToString(nPart), ":0"+sCache);
    SetLocalString(GetModule(), "StX_IDPreReadR_"+IntToString(nPart), ":0"+StX_ListReverse(sCache));
   // SpeakString("PreRead: "+IntToString(nPart)+s2DA+" - "+sCache);
    return sCache;
}

// Remakes and equips the item oPC is working, having the currently set part
// cycled either forward or backward
// nMode: STX_CR_PART_NEXT - cycle forward
// nMode: STX_CR_PART_PREV - cycle backward
void StX_RemakeItem(object oPC, int nMode) {
    SetLocalInt(oPC, "STX_CR_CHANGED", TRUE);
    object oItem = GetLocalObject(oPC, "STX_CR_ITEM");
    int nPart    = GetLocalInt(oPC, "STX_CR_PART");
    int nCurrApp, nSlot, nCost, nDC;
    string sPreRead;
    object oNew;

    if (GetBaseItemType(oItem)==BASE_ITEM_ARMOR) {
        // Handle Armor change
        nCurrApp = GetItemAppearance(oItem, ITEM_APPR_TYPE_ARMOR_MODEL, nPart);

        if (nPart == ITEM_APPR_ARMOR_MODEL_TORSO) {
            string sAC = Get2DAString("parts_chest", "ACBONUS", nCurrApp);
            // Fetch the stringlist that holds the ID's for this part
            sPreRead = GetLocalString(GetModule(), "StX_IDPreReadAC_"+GetStringLeft(sAC,1));
            if (sPreRead=="") // list didn't exist yet, so generate it
                sPreRead = StX_PreReadArmorACList(sAC);
            if (nMode==STX_CR_PART_PREV)
                sPreRead = GetLocalString(GetModule(), "StX_IDPreReadACR_"+GetStringLeft(sAC,1));
        } else {
            // Fetch the stringlist that holds the ID's for this part
            sPreRead = GetLocalString(GetModule(), "StX_IDPreRead_"+IntToString(nPart));
            if (sPreRead=="") // list didn't exist yet, so generate it
                sPreRead = StX_PreReadArmorPartList(nPart);
            if (nMode==STX_CR_PART_PREV) sPreRead = GetLocalString(GetModule(), "StX_IDPreReadR_"+IntToString(nPart));
        }

        // Find the current ID in the stringlist and pick the one coming after that
        string sID;
        string sCurrApp = IntToString(nCurrApp);
        int n = FindSubString(sPreRead, ":"+sCurrApp+":");
        sID = GetSubString(sPreRead, n+GetStringLength(sCurrApp)+2, 5);
        n = FindSubString(sID, ":");
        sID = GetStringLeft(sID, n);
        if (sID=="" && nPart == ITEM_APPR_ARMOR_MODEL_TORSO) {
            sID = GetSubString(sPreRead, 1, 5);
            n = FindSubString(sID, ":");
            sID = GetStringLeft(sID, n);
        }
//        SpeakString("Old: "+IntToString(nCurrApp)+", New: "+sID);
        nCurrApp = StringToInt(sID);

        oNew = CopyItemAndModify(oItem, ITEM_APPR_TYPE_ARMOR_MODEL, nPart, nCurrApp, TRUE);
        nSlot = INVENTORY_SLOT_CHEST;

    } else if (nPart == STX_CR_HELMET) {
        // Handle Helmet change
        nCurrApp = GetItemAppearance(oItem, ITEM_APPR_TYPE_ARMOR_MODEL, 0);
        int nMin = 1;
        int nMax = StringToInt(Get2DAString("baseitems", "MaxRange", BASE_ITEM_HELMET));

        if (nMode == STX_CR_PART_NEXT) {
            if (++nCurrApp>nMax) nCurrApp = nMin;
        } else {
            if (--nCurrApp<nMin) nCurrApp = nMax;
        }
//        SpeakString("New: "+IntToString(nCurrApp));

        oNew = CopyItemAndModify(oItem, ITEM_APPR_TYPE_ARMOR_MODEL, 0, nCurrApp, TRUE);
        nSlot = INVENTORY_SLOT_HEAD;

 } else if (nPart == STX_CR_PART_BELT) {
        // Handle Belt change
        nCurrApp = GetItemAppearance(oItem, ITEM_APPR_TYPE_SIMPLE_MODEL, 0);
        int nMin = 1;
        int nMax = StringToInt(Get2DAString("baseitems", "MaxRange", BASE_ITEM_BELT));
        if (nMode == STX_CR_PART_NEXT) {
            if (++nCurrApp>nMax) nCurrApp = nMin;
        } else {
            if (--nCurrApp<nMin) nCurrApp = nMax;
        }
        oNew = CopyItemAndModify(oItem, ITEM_APPR_TYPE_SIMPLE_MODEL, 0, nCurrApp, TRUE);
        nSlot = INVENTORY_SLOT_BELT;

 } else if (nPart == STX_CR_PART_BRACER) {
        // Handle Bracer change
        nCurrApp = GetItemAppearance(oItem, ITEM_APPR_TYPE_SIMPLE_MODEL, 0);
        int nMin = 1;
        int nMax = StringToInt(Get2DAString("baseitems", "MaxRange", BASE_ITEM_BRACER));
        if (nMode == STX_CR_PART_NEXT) {
            if (++nCurrApp>nMax) nCurrApp = nMin;
        } else {
            if (--nCurrApp<nMin) nCurrApp = nMax;
        }
        oNew = CopyItemAndModify(oItem, ITEM_APPR_TYPE_SIMPLE_MODEL, 0, nCurrApp, TRUE);
        nSlot = INVENTORY_SLOT_ARMS;

   } else if (nPart == STX_CR_PART_GLOVES) {
        // Handle Gloves change
        nCurrApp = GetItemAppearance(oItem, ITEM_APPR_TYPE_SIMPLE_MODEL, 0);
        int nMin = 1;
        int nMax = StringToInt(Get2DAString("baseitems", "MaxRange", BASE_ITEM_GLOVES));
        if (nMode == STX_CR_PART_NEXT) {
            if (++nCurrApp>nMax) nCurrApp = nMin;
        } else {
            if (--nCurrApp<nMin) nCurrApp = nMax;
        }
        oNew = CopyItemAndModify(oItem, ITEM_APPR_TYPE_SIMPLE_MODEL, 0, nCurrApp, TRUE);
        nSlot = INVENTORY_SLOT_ARMS;


 } else if (nPart == STX_CR_PART_NECK) {
        // Handle NECKLACE change
        nCurrApp = GetItemAppearance(oItem, ITEM_APPR_TYPE_SIMPLE_MODEL, 0);
        int nMin = 1;
        int nMax = StringToInt(Get2DAString("baseitems", "MaxRange", BASE_ITEM_AMULET));
        if (nMode == STX_CR_PART_NEXT) {
            if (++nCurrApp>nMax) nCurrApp = nMin;
        } else {
            if (--nCurrApp<nMin) nCurrApp = nMax;
        }
        oNew = CopyItemAndModify(oItem, ITEM_APPR_TYPE_SIMPLE_MODEL, 0, nCurrApp, TRUE);
        nSlot = INVENTORY_SLOT_NECK;

 } else if (nPart == STX_CR_PART_CLOAK) {
 // we need to get new items by their resref to change their appearance
        // Handle NECK-CLOAK change
        nCurrApp = GetItemAppearance(oItem,ITEM_APPR_TYPE_SIMPLE_MODEL, 0);
        SendMessageToPC(oPC,"Current Appearance: "+IntToString(nCurrApp));
        int nMin = 1;
        int nMax =  StringToInt(Get2DAString("baseitems", "MaxRange", BASE_ITEM_CLOAK));;  // 80 cloak
        if (nMode == STX_CR_PART_NEXT) {
            if (++nCurrApp>nMax) nCurrApp = nMin;
        } else {
            if (--nCurrApp<nMin) nCurrApp = nMax;
        }

        oNew = CreateItemOnObject("cloak" + IntToString(nCurrApp),oPC);
        oNew = MatchItem(oNew,oItem,ITEM_APPR_TYPE_ARMOR_COLOR,ITEM_APPR_ARMOR_COLOR_CLOTH1);
        oNew = MatchItem(oNew,oItem,ITEM_APPR_TYPE_ARMOR_COLOR,ITEM_APPR_ARMOR_COLOR_CLOTH2);
        oNew = MatchItem(oNew,oItem,ITEM_APPR_TYPE_ARMOR_COLOR,ITEM_APPR_ARMOR_COLOR_LEATHER1);
        oNew = MatchItem(oNew,oItem,ITEM_APPR_TYPE_ARMOR_COLOR,ITEM_APPR_ARMOR_COLOR_LEATHER2);
        oNew = MatchItem(oNew,oItem,ITEM_APPR_TYPE_ARMOR_COLOR,ITEM_APPR_ARMOR_COLOR_METAL1);
        oNew = MatchItem(oNew,oItem,ITEM_APPR_TYPE_ARMOR_COLOR,ITEM_APPR_ARMOR_COLOR_METAL2);
        itemproperty iProp = GetFirstItemProperty(oItem);

        while (GetIsItemPropertyValid(iProp))
            {
            if (GetItemPropertyDurationType(iProp) == DURATION_TYPE_PERMANENT)
                {
                AddItemProperty(DURATION_TYPE_PERMANENT,iProp,oNew);
                iProp = GetNextItemProperty(oItem);
                }
            }

        SetName(oNew,GetName(oItem));
       // ? SetItemCursedFlag(oNew,TRUE);


       // oNew = CopyItemAndModify(oItem, ITEM_APPR_TYPE_ARMOR_MODEL, 0, nCurrApp, TRUE);
        nSlot = INVENTORY_SLOT_CLOAK;

       } else if (nPart ==   STX_CR_PART_LRING) {
        // Handle LRING change
        nCurrApp = GetItemAppearance(oItem, ITEM_APPR_TYPE_SIMPLE_MODEL, 0);
        int nMin = 1;
        int nMax = StringToInt(Get2DAString("baseitems", "MaxRange", BASE_ITEM_RING));
        if (nMode == STX_CR_PART_NEXT) {
            if (++nCurrApp>nMax) nCurrApp = nMin;
        } else {
            if (--nCurrApp<nMin) nCurrApp = nMax;
        }
        oNew = CopyItemAndModify(oItem, ITEM_APPR_TYPE_SIMPLE_MODEL, 0, nCurrApp, TRUE);
        nSlot = INVENTORY_SLOT_LEFTRING;

          } else if (nPart ==   STX_CR_PART_RRING) {
        // Handle RRing change
        nCurrApp = GetItemAppearance(oItem, ITEM_APPR_TYPE_SIMPLE_MODEL, 0);
        int nMin = 1;
        int nMax = StringToInt(Get2DAString("baseitems", "MaxRange", BASE_ITEM_RING));
        if (nMode == STX_CR_PART_NEXT) {
            if (++nCurrApp>nMax) nCurrApp = nMin;
        } else {
            if (--nCurrApp<nMin) nCurrApp = nMax;
        }
        oNew = CopyItemAndModify(oItem, ITEM_APPR_TYPE_SIMPLE_MODEL, 0, nCurrApp, TRUE);
        nSlot = INVENTORY_SLOT_RIGHTRING;

   } else if (nPart ==  STX_CR_PART_ARROWS) {
        // Handle ARROWS change
        nCurrApp = GetItemAppearance(oItem, ITEM_APPR_TYPE_WEAPON_MODEL, 0);
        int nMin = 1;
        int nMax = StringToInt(Get2DAString("baseitems", "MaxRange", BASE_ITEM_ARROW));
        if (nMode == STX_CR_PART_NEXT) {
            if (++nCurrApp>nMax) nCurrApp = nMin;
        } else {
            if (--nCurrApp<nMin) nCurrApp = nMax;
        }
        oNew = CopyItemAndModify(oItem, ITEM_APPR_TYPE_SIMPLE_MODEL, 0, nCurrApp, TRUE);
        nSlot = INVENTORY_SLOT_ARROWS;

   } else if (nPart ==   STX_CR_PART_BOLTS) {
        // Handle BOLTS change
        nCurrApp = GetItemAppearance(oItem, ITEM_APPR_TYPE_WEAPON_MODEL, 0);

        int nMin = 1;
        int nMax = StringToInt(Get2DAString("baseitems", "MaxRange", BASE_ITEM_BOLT));
        if (nMode == STX_CR_PART_NEXT) {
            if (++nCurrApp>nMax) nCurrApp = nMin;
        } else {
            if (--nCurrApp<nMin) nCurrApp = nMax;
        }
        SpeakString("New: "+IntToString(nCurrApp));
        oNew = CopyItemAndModify(oItem, ITEM_APPR_TYPE_SIMPLE_MODEL, 0, nCurrApp, TRUE);
        nSlot = INVENTORY_SLOT_BOLTS;

  } else if (nPart ==   STX_CR_PART_BULLETS) {
        // Handle BULLETS change
         nCurrApp = GetItemAppearance(oItem, ITEM_APPR_TYPE_SIMPLE_MODEL, 0);
        int nBaseType = GetBaseItemType(oItem);
        int nMod = nCurrApp % 10;
        nCurrApp -= nMod;
        int nMin = 11;
        int nMax = StringToInt(Get2DAString("baseitems", "MaxRange", BASE_ITEM_BULLET));

        if (nMode == STX_CR_PART_NEXT) {
            nMod+=1;
        } else {
            nMod-=1;
        }
        if (nMod >= 4) nCurrApp += 7;
        if (nMod <= 0) nCurrApp -= 7;
        nCurrApp += nMod;

        if (nCurrApp > nMax) nCurrApp = nMin;
        if (nCurrApp < nMin) nCurrApp = nMax;

       SpeakString("New: "+IntToString(nCurrApp));

        oNew = CopyItemAndModify(oItem, ITEM_APPR_TYPE_SIMPLE_MODEL, 0, nCurrApp, TRUE);
        nSlot = INVENTORY_SLOT_BULLETS;

    } else if (nPart == STX_CR_SHIELD) {
        // Handle Shield change
        nCurrApp = GetItemAppearance(oItem, ITEM_APPR_TYPE_SIMPLE_MODEL, 0);

        int nBaseType = GetBaseItemType(oItem);
        int nMod = (nCurrApp/10)*10;
        nCurrApp-= nMod;
        int nMin = StringToInt(Get2DAString("baseitems", "MinRange", nBaseType));
        int nMax = (StringToInt(Get2DAString("baseitems", "MaxRange", nBaseType)) /10)*10;

        if (nMode == STX_CR_PART_NEXT) {
            nMod+=10;
            if (nMod>nMax) nMod = nMin;
        } else {
            nMod-=10;
            if (nMod<nMin) nMod = nMax;
        }
        nCurrApp += nMod;
       // SpeakString("New: "+IntToString(nCurrApp));
      SendMessageToPC(oPC,"New: "+IntToString( nCurrApp));
        oNew = CopyItemAndModify(oItem, ITEM_APPR_TYPE_SIMPLE_MODEL, 0, nCurrApp, TRUE);
        nSlot = INVENTORY_SLOT_LEFTHAND;

      } else if  ( GetBaseItemType(oItem) ==   BASE_ITEM_SHURIKEN  || GetBaseItemType(oItem) == BASE_ITEM_DART ) {
        // Handle SURIKENS change
        nCurrApp = GetItemAppearance(oItem, ITEM_APPR_TYPE_SIMPLE_MODEL, 1);
        int nBaseType = GetBaseItemType(oItem);
        int nMod = nCurrApp % 10;
        nCurrApp -= nMod;
        int nMin = 11;
        int nMax = 63;

        if (nMode == STX_CR_PART_NEXT) {
            nMod+=1;
        } else {
            nMod-=1;
        }
        if (nMod >= 4) nCurrApp += 7;
        if (nMod <= 0) nCurrApp -= 7;
        nCurrApp += nMod;

        if (nCurrApp > nMax) nCurrApp = nMin;
        if (nCurrApp < nMin) nCurrApp = nMax;

       // SpeakString("New: "+IntToString(nCurrApp));
         SendMessageToPC(oPC,"New: "+IntToString( nCurrApp));

        oNew = CopyItemAndModify(oItem, ITEM_APPR_TYPE_SIMPLE_MODEL, 0, nCurrApp, TRUE);
        nSlot = INVENTORY_SLOT_LEFTHAND;
    }   else {
            // Handle Weapon change
        nCurrApp = GetItemAppearance(oItem, ITEM_APPR_TYPE_WEAPON_MODEL, nPart);
        int nBaseType = GetBaseItemType(oItem);
        int nMin = StringToInt(Get2DAString("baseitems", "MinRange", nBaseType)) /10;
        int nMax = StringToInt(Get2DAString("baseitems", "MaxRange", nBaseType)) /10;

        if (nMode == STX_CR_PART_NEXT) {
            if (++nCurrApp>nMax) nCurrApp = nMin;
        } else {
            if (--nCurrApp<nMin) nCurrApp = nMax;
        }
      // SendMessageToPC(oPC,"New: "+IntToString( nCurrApp));


        oNew = CopyItemAndModify(oItem, ITEM_APPR_TYPE_WEAPON_MODEL, nPart, nCurrApp, TRUE);
        nSlot = GetLocalInt(oPC,"nSlot");
        if (!nSlot) nSlot = INVENTORY_SLOT_RIGHTHAND;
    }

    if (GetIsObjectValid(oNew)) {
        // new object is valid
        // get cost and DC
        int nNPC = GetIsObjectValid(GetLocalObject(oPC, "STX_CR_NPC"));
        object oBackup = GetLocalObject(oPC, "STX_CR_BACKUP");
        nCost = StX_GetModificationCost(oBackup, oNew, nNPC);
        nDC   = StX_GetModificationDC(oBackup, oNew, nNPC);
        SetLocalInt(oPC, "STX_CR_COST", nCost);
        SetLocalInt(oPC, "STX_CR_DC", nDC);
        SetCustomToken(STX_CR_TOKENBASE+1, IntToString(nCost));
        SetCustomToken(STX_CR_TOKENBASE+2, IntToString(nDC));

        // replace old current object with new one
        DestroyObject(oItem);
        oItem = oNew;
        SetLocalObject(oPC, "STX_CR_ITEM", oItem);
        AssignCommand(oPC, ClearAllActions(TRUE));
        AssignCommand(oPC, ActionEquipItem(oItem, nSlot));
    }
}

// Remakes and equips the item oPC is working, having the currently set color
// cycled either forward or backward
// nMode: STX_CR_COLOR_NEXT - cycle forward
// nMode: STX_CR_COLOR_PREV - cycle backward
void StX_RecolorItem(object oPC, int nMode) {
    SetLocalInt(oPC, "STX_CR_CHANGED", TRUE);
    object oItem = GetLocalObject(oPC, "STX_CR_ITEM");
    int nPart    = GetLocalInt(oPC, "STX_CR_PART");
    int nCurrApp, nSlot, nCost, nDC;
    object oNew;


    if (GetBaseItemType(oItem)==BASE_ITEM_ARMOR || GetBaseItemType(oItem)==BASE_ITEM_HELMET) {
        // Handle Armor change
        int nBaseType = GetBaseItemType(oItem);
        nCurrApp = GetItemAppearance(oItem, ITEM_APPR_TYPE_ARMOR_COLOR, nPart);
        int nMin = 0;
        int nMax = (StringToInt(Get2DAString("baseitems", "MaxRange", nBaseType)) /10)*10;

        if (nMode == STX_CR_COLOR_NEXT) {
            if (++nCurrApp>nMax) nCurrApp = nMin;
        } else {
            if (--nCurrApp<nMin) nCurrApp = nMax;
        }
//       SpeakString("New: "+IntToString(nCurrApp));
         SendMessageToPC(oPC,"Color: "+IntToString( nCurrApp));

        StX_SetColorToken(nPart, nCurrApp);
        oNew  = CopyItemAndModify(oItem, ITEM_APPR_TYPE_ARMOR_COLOR, nPart, nCurrApp, TRUE);
        nSlot = INVENTORY_SLOT_CHEST;
        if (GetBaseItemType(oItem)==BASE_ITEM_HELMET)
            nSlot = INVENTORY_SLOT_HEAD;

    } else if (nPart == STX_CR_SHIELD) {
        // Handle shield change
        int nBaseType = GetBaseItemType(oItem);
        nCurrApp = GetItemAppearance(oItem, ITEM_APPR_TYPE_SIMPLE_MODEL, 0);
        int nMod = (nCurrApp/10)*10;
        nCurrApp-= nMod;
        int nMin = 1;
        int nMax = (StringToInt(Get2DAString("baseitems", "MaxRange", nBaseType)) /10)*10;

        if (nMode == STX_CR_COLOR_NEXT) {
            if (++nCurrApp>nMax) nCurrApp = nMin;
        } else {
            if (--nCurrApp<nMin) nCurrApp = nMax;
        }
        nCurrApp += nMod;
        SendMessageToPC(oPC,"Color: "+IntToString( nCurrApp));
//        SpeakString("New: "+IntToString(nCurrApp));

        oNew = CopyItemAndModify(oItem, ITEM_APPR_TYPE_SIMPLE_MODEL, 0, nCurrApp, TRUE);
        nSlot = INVENTORY_SLOT_LEFTHAND;

    } else if ( GetBaseItemType(oItem) ==   BASE_ITEM_SHURIKEN  || GetBaseItemType(oItem) == BASE_ITEM_DART) {
        // Handle SURIKENS / Darts change
        nCurrApp = GetItemAppearance(oItem, ITEM_APPR_TYPE_SIMPLE_MODEL, 0);
        int nBaseType = GetBaseItemType(oItem);
        int nMod = (nCurrApp);
        nCurrApp-= nMod;
        int nMin = StringToInt(Get2DAString("baseitems", "MinRange", nBaseType));
        int nMax = StringToInt(Get2DAString("baseitems", "MaxRange", nBaseType));

         if (nMode == STX_CR_COLOR_NEXT) {
            if (++nCurrApp>nMax) nCurrApp = nMin;
        } else {
            if (--nCurrApp<nMin) nCurrApp = nMax;
        }
        nCurrApp += nMod;
        SendMessageToPC(oPC,"New: "+IntToString( nCurrApp));
        oNew = CopyItemAndModify(oItem, ITEM_APPR_TYPE_SIMPLE_MODEL, 0, nCurrApp, TRUE);
        nSlot = INVENTORY_SLOT_RIGHTHAND;
        }
    else {
        // Handle Weapon change
        nCurrApp = GetItemAppearance(oItem, ITEM_APPR_TYPE_WEAPON_COLOR, nPart);
        int nMin = 1;
        int nMax = 4;

        if (nMode == STX_CR_COLOR_NEXT) {
            if (++nCurrApp>nMax) nCurrApp = nMin;
        } else {
            if (--nCurrApp<nMin) nCurrApp = nMax;
        }
//        SpeakString("New: "+IntToString(nCurrApp));

        oNew = CopyItemAndModify(oItem, ITEM_APPR_TYPE_WEAPON_COLOR, nPart, nCurrApp, TRUE);
        nSlot = GetLocalInt(oPC,"nSlot");
        if (!nSlot) nSlot = INVENTORY_SLOT_RIGHTHAND;
    }

    if (GetIsObjectValid(oNew)) {
        // new object is valid
        // get cost and DC
        int nNPC = GetIsObjectValid(GetLocalObject(oPC, "STX_CR_NPC"));
        object oBackup = GetLocalObject(oPC, "STX_CR_BACKUP");
        nCost = StX_GetModificationCost(oBackup, oNew, nNPC);
        nDC   = StX_GetModificationDC(oBackup, oNew, nNPC);
        SetLocalInt(oPC, "STX_CR_COST", nCost);
        SetLocalInt(oPC, "STX_CR_DC", nDC);
        SetCustomToken(STX_CR_TOKENBASE+1, IntToString(nCost));
        SetCustomToken(STX_CR_TOKENBASE+2, IntToString(nDC));

        // replace old current object with new one
        DestroyObject(oItem);
        oItem = oNew;
        SetLocalObject(oPC, "STX_CR_ITEM", oItem);
        AssignCommand(oPC, ClearAllActions(TRUE));
        AssignCommand(oPC, ActionEquipItem(oItem, nSlot));
    }
}

int StX_GetIsWeapon(object oWeapon) {
    int iType = GetBaseItemType(oWeapon);
    switch (iType) {
        case BASE_ITEM_BASTARDSWORD:
        case BASE_ITEM_BATTLEAXE:
        case BASE_ITEM_DAGGER:
        case BASE_ITEM_DIREMACE:
        case BASE_ITEM_DOUBLEAXE:
        case BASE_ITEM_DWARVENWARAXE:
        case BASE_ITEM_GREATAXE:
        case BASE_ITEM_GREATSWORD:
        case BASE_ITEM_HALBERD:
        case BASE_ITEM_HEAVYFLAIL:
        case BASE_ITEM_KAMA:
        case BASE_ITEM_KATANA:
        case BASE_ITEM_KUKRI:
        case BASE_ITEM_LIGHTFLAIL:
        case BASE_ITEM_LIGHTHAMMER:
        case BASE_ITEM_LIGHTMACE:
        case BASE_ITEM_LONGSWORD:
        case BASE_ITEM_MORNINGSTAR:
        case BASE_ITEM_RAPIER:
        case BASE_ITEM_SCIMITAR:
        case BASE_ITEM_SCYTHE:
        case BASE_ITEM_SHORTSPEAR:
        case BASE_ITEM_SHORTSWORD:
        case BASE_ITEM_SICKLE:
        case BASE_ITEM_THROWINGAXE:
        case BASE_ITEM_TWOBLADEDSWORD:
        case BASE_ITEM_WARHAMMER:
        case BASE_ITEM_CLUB:
        case BASE_ITEM_HEAVYCROSSBOW:
        case BASE_ITEM_LIGHTCROSSBOW:
        case BASE_ITEM_LONGBOW:
        case BASE_ITEM_MAGICSTAFF:
        case BASE_ITEM_QUARTERSTAFF:
        case BASE_ITEM_SHORTBOW:
        case BASE_ITEM_SLING:
        case BASE_ITEM_TRIDENT:
        case BASE_ITEM_WHIP: return TRUE;
    }
    return FALSE;
}


int StX_GetIsAmmo(object oWeapon) {
    int iType = GetBaseItemType(oWeapon);
    switch (iType) {
        case BASE_ITEM_ARROW:
        case BASE_ITEM_BOLT:
        case BASE_ITEM_BULLET:
        case BASE_ITEM_DART:
        case BASE_ITEM_THROWINGAXE:
        case BASE_ITEM_SHURIKEN: return TRUE;
    }
    return FALSE;
}

int StX_GetIsMonkGlove(object oGlove)
{
    string tag = GetTag(oGlove);

    if (tag == "NW_IT_MGLOVE020")
    {
        return TRUE;
    }
    else if (tag == "JoonisDragonFists")
    {
        return TRUE;
    }
    else if (tag == "X2_IT_MGLOVE001")
    {
        return TRUE;
    }
    return FALSE;
}

int StX_GetIsShield(object oShield) {
    int iType = GetBaseItemType(oShield);
    if (iType==BASE_ITEM_SMALLSHIELD || iType==BASE_ITEM_LARGESHIELD || iType==BASE_ITEM_TOWERSHIELD)
        return TRUE;
    return FALSE;
}
  // Sets up everything for oPC to start renaming/changing appearance on all equippables oItems
  //actually nModify is 1 when they are renaming to skip the backup copy thing
  //
void aw_StartCraft(object oPC, object oItem,int nModify=0);
void aw_StartCraft(object oPC,object  oItem,int nModify=0)  {

    SetLocalObject(oPC, "STX_CR_ITEM", oItem);
    if (!nModify)
      {
       StX_StartCraft(oPC, oItem);
      }
}

void aw_StopCraft(object oPC,int nModify=0);
void aw_StopCraft(object oPC,int nModify=0) {

     if (!nModify)
     {
     StX_StopCraft(oPC,0);
     }
     else if( nModify == 2) ExecuteScript("ammo_abort",oPC);

    DeleteLocalObject(oPC, "STX_CR_ITEM");
    DeleteLocalString(oPC, "NewItemName");
    DeleteLocalInt(oPC, "nModify");

}

 //Return true if is an ammo maker
 //this function is duplicated in item_enhancement to reduce number of includes
int GetIsAmmoMaker(object oItem)
 {
 string sTag = GetStringLowerCase(GetTag(oItem));
if (sTag == "arrowmaker") return TRUE;
if (sTag == "axemaker")  return TRUE;
if (sTag == "boltmaker") return TRUE;
if (sTag == "bulletmaker") return TRUE;
if (sTag == "dartmaker") return TRUE;
if (sTag == "shurikenmaker") return TRUE;
else return FALSE;
  }

//Return true if is an OLD ammo maker
int GetIsOldAmmoMaker(object oItem)
 {
 string sTag = GetStringLowerCase(GetTag(oItem));
if (sTag == "acidarrowmaker")  return TRUE;
if (sTag == "bullet5maker") return TRUE;
if (sTag == "bullet4maker") return TRUE;
if (sTag == "bullet3maker") return TRUE;
if (sTag == "bullet2maker")return TRUE;
if (sTag == "bullet1maker") return TRUE;
if (sTag == "dart5maker") return TRUE;
if (sTag == "dart4maker") return TRUE;
if (sTag == "dart3maker") return TRUE;
if (sTag == "dart2maker")  return TRUE;
if (sTag == "dart1maker") return TRUE;
if (sTag == "shuriken5maker") return TRUE;
if (sTag == "shuriken4maker")  return TRUE;
if (sTag == "shuriken3maker") return TRUE;
if (sTag == "shuriken2maker") return TRUE;
if (sTag == "shuriken1maker")  return TRUE;
if (sTag == "piercbolt5maker")  return TRUE;
if (sTag == "piercbolt4maker")  return TRUE;
if (sTag == "piercbolt3maker")  return TRUE;
if (sTag == "piercbolt2maker") return TRUE;
if (sTag == "piercbolt1maker") return TRUE;
if (sTag == "throwinga5maker")return TRUE;
if (sTag == "throwinga4maker")  return TRUE;
if (sTag == "throwinga3maker") return TRUE;;
if (sTag == "throwinga2maker")  return TRUE;
if (sTag == "throwinga1maker") return TRUE;
if (sTag == "sonicarrowmaker") return TRUE;
if (sTag == "multiarrowmaker")  return TRUE;
if (sTag == "magicarrowmaker")  return TRUE;
if (sTag == "arrow5maker") return TRUE;
if (sTag == "arrow4maker")  return TRUE;
if (sTag == "arrow3maker")  return TRUE;
if (sTag == "arrow2maker") return TRUE;
if (sTag == "arrow1maker")  return TRUE;
if (sTag == "firearrowmaker") return TRUE;
if (sTag == "lightboltmaker") return TRUE;
if (sTag == "icearrowmaker") return TRUE;
if (sTag == "frostboltmaker") return TRUE;
if (sTag == "fireboltmaker")  return TRUE;
if (sTag == "acidarrowmaker") return TRUE;
if (sTag == "LordlyUpgrade" ) return TRUE;
else return FALSE;
  }
