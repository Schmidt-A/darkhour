//////////////////////////////////////////////////////////////
// inc_rules :: Default Include file for rules implementation.
//////////////////////////////////////////////////////////////
// Created By: Brenon Holmes
// Created On: Jun/09/02
//
//
//merged inc_validate/inc_forbidden/inc_rules - riddler
//////////////////////////////////////////////////////////////

// Default initialization data

#include "item_enhancement"
//#include "stx_inc_craft"

int DEFAULT_ITEM_COST_RESTRICTION   = 1000000;
int DEFAULT_LEVEL_RESTRICTION       = 40;


// This is the amount of gold that a creature will
// get when entering the actual game if the
// setting is on no item cost limitation.
int DEFAULT_AMOUNT_OF_STARTING_GOLD = 15000;

float DEFAULT_COST_FACTOR_BARBARIAN   = 3.5f;
float DEFAULT_COST_FACTOR_BARD        = 4.0f;
float DEFAULT_COST_FACTOR_CLERIC      = 1.5f;
float DEFAULT_COST_FACTOR_DRUID       = 2.0f;
float DEFAULT_COST_FACTOR_FIGHTER     = 3.5f;
float DEFAULT_COST_FACTOR_MONK        = 2.5f;
float DEFAULT_COST_FACTOR_PALADIN     = 3.0f;
float DEFAULT_COST_FACTOR_RANGER      = 3.5f;
float DEFAULT_COST_FACTOR_ROGUE       = 3.0f;
float DEFAULT_COST_FACTOR_SORCERER    = 2.0f;
float DEFAULT_COST_FACTOR_WIZARD      = 2.0f;

// Constants for Level Restrictions
int LEVEL_LIMIT_NONE    = -1;

// Constants for Item Cost Limitations
int ITEM_COST_UNLIMITED = -1;
int GetTotalPlayerItemCost( object oPlayer );
int GetTotalPlayerLevel( object oPlayer );
int GetAllowedItemCostForPlayer( object oPlayer, int bBaseVale = FALSE );
int GetAllowedLevelForPlayer( object oPlayer, int bBaseValue = FALSE );

// Class Access functions
int GetPrimaryClass( object oPlayer );

// Xp Rules Functions
int GetXPRequiredForLevel( int nLevel );

//////////////////////////////////////////////////////////////
// GetTotalPlayerItemCost()
//////////////////////////////////////////////////////////////
// Created By: Brenon Holmes
// Created On: Jun/09/02
// Description: Calculates the total item cost on a specified
//              creature.
//Riddler! We need to find a way to calculate the ammo value -Aez
//////////////////////////////////////////////////////////////
int GetTotalPlayerItemCost( object oPlayer )
{
    int nCount, nTotalCost = 0;
    object oItem;

    // Calculate the total cost of items in the creature's
    // repository
    oItem = GetFirstItemInInventory(oPlayer);
    while ( GetIsObjectValid(oItem) == TRUE )
        {
        if (GetItemHasItemProperty(oItem, ITEM_PROPERTY_TRAP) == FALSE)
            {
            if (GetIsAmmoMaker(oItem) )
                {
                 GetAmmoMakerValue(oItem);
                }
                if(GetDroppableFlag(oItem) == TRUE)
                    {
                    nTotalCost += GetGoldPieceValue(oItem);
                    }
            }
        oItem = GetNextItemInInventory(oPlayer);
        //remove temporary effects
        IPRemoveAllItemProperties(oItem,  DURATION_TYPE_TEMPORARY);
        }

    // Now iterate through each inventory slot and compute
    // the cost of the item (if one exists in that slot)
    // - BKH - Jun/09/02
    for ( nCount = 0; nCount < NUM_INVENTORY_SLOTS; nCount++ )
    {
        oItem = GetItemInSlot(nCount,oPlayer);
        if ( GetIsObjectValid(oItem) )
        {
            nTotalCost += GetGoldPieceValue(oItem);
            //remove temporary effects
            IPRemoveAllItemProperties(oItem,  DURATION_TYPE_TEMPORARY);
        }
    }

    return nTotalCost;
}

//////////////////////////////////////////////////////////////
// GetTotalPlayerLevel()
//////////////////////////////////////////////////////////////
// Created By: Brenon Holmes
// Created On: Jun/09/02
// Description: Calculates the total levels of a specified
//              creature.
//////////////////////////////////////////////////////////////
int GetTotalPlayerLevel( object oPlayer )
{
    return GetHitDice(oPlayer);
}

//////////////////////////////////////////////////////////////
// GetAllowedItemCostForPlayer()
//////////////////////////////////////////////////////////////
// Created By: Brenon Holmes
// Created On: Jun/09/02
// Description: Calculates the scaled item cost for the specified
//              player.
//////////////////////////////////////////////////////////////
int GetAllowedItemCostForPlayer( object oPlayer, int bBaseValue )
{
    int nClass;
    int nAllowedCost;

    nAllowedCost = GetLocalInt(GetModule(),"m_nAllowedItemCost");

    if ( nAllowedCost == ITEM_COST_UNLIMITED &&
         bBaseValue == FALSE )
    {
        return 400000000;
    }
    else if ( nAllowedCost == ITEM_COST_UNLIMITED )
    {
        return ITEM_COST_UNLIMITED;
    }

    if ( bBaseValue == TRUE )
    {
        return nAllowedCost;
    }

    nClass = GetPrimaryClass(oPlayer);
    switch ( nClass )
    {
        case CLASS_TYPE_BARBARIAN:
            return FloatToInt(nAllowedCost * DEFAULT_COST_FACTOR_BARBARIAN);

        case CLASS_TYPE_BARD:
            return FloatToInt(nAllowedCost * DEFAULT_COST_FACTOR_BARD);

        case CLASS_TYPE_CLERIC:
            return FloatToInt(nAllowedCost * DEFAULT_COST_FACTOR_CLERIC);

        case CLASS_TYPE_DRUID:
            return FloatToInt(nAllowedCost * DEFAULT_COST_FACTOR_DRUID);

        case CLASS_TYPE_FIGHTER:
            return FloatToInt(nAllowedCost * DEFAULT_COST_FACTOR_FIGHTER);

        case CLASS_TYPE_MONK:
            return FloatToInt(nAllowedCost * DEFAULT_COST_FACTOR_MONK);

        case CLASS_TYPE_PALADIN:
            return FloatToInt(nAllowedCost * DEFAULT_COST_FACTOR_PALADIN);

        case CLASS_TYPE_RANGER:
            return FloatToInt(nAllowedCost * DEFAULT_COST_FACTOR_RANGER);

        case CLASS_TYPE_ROGUE:
            return FloatToInt(nAllowedCost * DEFAULT_COST_FACTOR_ROGUE);

        case CLASS_TYPE_SORCERER:
            return FloatToInt(nAllowedCost * DEFAULT_COST_FACTOR_SORCERER);

        case CLASS_TYPE_WIZARD:
            return FloatToInt(nAllowedCost * DEFAULT_COST_FACTOR_WIZARD);
    }

    return nAllowedCost;
}

//////////////////////////////////////////////////////////////
// GetAllowedLevelForPlayer()
//////////////////////////////////////////////////////////////
// Created By: Brenon Holmes
// Created On: Jun/09/02
// Description: Calculates the scaled level for the specified
//              player.
//////////////////////////////////////////////////////////////
int GetAllowedLevelForPlayer( object oPlayer, int bBaseValue )
{
    int nAllowedLevel;
    nAllowedLevel = GetLocalInt(GetModule(),"m_nAllowedLevel");

    if ( bBaseValue == TRUE )
    {
        return nAllowedLevel;
    }

    // We don't have any level scaling yet...
    // maybe we will in the future for some fun stuff.

    return nAllowedLevel;
}

//////////////////////////////////////////////////////////////
// GetPrimaryClass()
//////////////////////////////////////////////////////////////
// Created By: Brenon Holmes
// Created On: Jun/09/02
// Description: Returns the primary class of the specified
//              player.
//////////////////////////////////////////////////////////////
int GetPrimaryClass( object oPlayer )
{
    int nCount, nClass;
    int nClassLevel, nPrimaryClass;
    int nBestClass, nBestClassLevel;

    nBestClassLevel = 0;
    nPrimaryClass = CLASS_TYPE_INVALID;

    // Stupid 1 based indexes...
    for ( nCount = 1; nCount <= 3; nCount++ )
    {
        nClass = GetClassByPosition(nCount,oPlayer);
        if ( nClass != CLASS_TYPE_INVALID )
        {
            nClassLevel = GetLevelByClass(nClass,oPlayer);
            if ( nClassLevel > nBestClassLevel )
            {
                nBestClassLevel = nClassLevel;
                nPrimaryClass = nClass;
            }
        }
    }

    return nPrimaryClass;
}

//////////////////////////////////////////////////////////////
// GetXPRequiredForLevel()
//////////////////////////////////////////////////////////////
// Created By: Brenon Holmes
// Created On: Jun/09/02
// Description: Calculates the amount of experience required
//              for the specified level.
//////////////////////////////////////////////////////////////
   int GetXPRequiredForLevel( int nLevel )
{
    int nCount;
    int nRequiredXP = 0;
    for ( nCount = 1; nCount <= nLevel; nCount++ )
    {
        nRequiredXP += 1000 * (nCount - 1);
    }
    return nRequiredXP;
}

//////////////////////////////////////////////////////////////
// inc_validate :: Default Include file for the validation
//                  of creatures.
//////////////////////////////////////////////////////////////
// Created By: Brenon Holmes
// Created On: Jun/09/02
// Moved to inc_rules to reduce number of includes - riddler7
//////////////////////////////////////////////////////////////


// Constants for Player Validation
int VALIDATE_PLAYER_FAILED_ITEM_COST    = 0;
int VALIDATE_PLAYER_FAILED_HIGH_LEVEL   = 1;
int VALIDATE_PLAYER_FAILED_LOW_LEVEL    = 2;
int VALIDATE_PLAYER_SUCCESS             = 3;

int ValidatePlayer( object oPlayer );

//////////////////////////////////////////////////////////////
// ValidatePlayer()
//////////////////////////////////////////////////////////////
// Created By: Brenon Holmes
// Created On: Jun/09/02
// Description: Checks the module rules specifications to see
//              if the specified creature passes muster.
//              Then returns an error code based on which
//              portion of the validation fails.
// Modified By: Scott "Seira" Shepherd, and "Gyr"
//////////////////////////////////////////////////////////////
int ValidatePlayer( object oPlayer )
{
    int nAllowedItemCost, nTotalPlayerItemCost;
    int nAllowedLevel, nTotalPlayerLevel;
    //int nAllowedXP;

    // 1 - Check Item Cost restrictions on the module
    //nAllowedItemCost = GetAllowedItemCostForPlayer(oPlayer);
    //Calculate total winnings to include with class limit
    nAllowedItemCost = GetAllowedItemCostForPlayer(oPlayer)  + GetLocalInt(oPlayer,"m_nGoldwinnings");
    if ( nAllowedItemCost != ITEM_COST_UNLIMITED )
    {
        nTotalPlayerItemCost = GetTotalPlayerItemCost(oPlayer);
        if ( nTotalPlayerItemCost > nAllowedItemCost )
        {
            return VALIDATE_PLAYER_FAILED_ITEM_COST;
        }
    }

    // 2 - Check Level restrictions on the module
    nAllowedLevel = GetAllowedLevelForPlayer(oPlayer);
    if ( nAllowedLevel != LEVEL_LIMIT_NONE )
    {
        nTotalPlayerLevel = GetTotalPlayerLevel(oPlayer);
        if ( nTotalPlayerLevel > nAllowedLevel )
        {
            return VALIDATE_PLAYER_FAILED_HIGH_LEVEL;
        }
        else if ( nTotalPlayerLevel < nAllowedLevel )
        {
            return VALIDATE_PLAYER_FAILED_LOW_LEVEL;
        }
    }

 /*   // 3 - After checking the level, check the experience
    // if it's not correct... set it.
    nAllowedXP = GetXPRequiredForLevel(nAllowedLevel);
    if ( nAllowedXP != GetXP(oPlayer) )
    {
        SetXP(oPlayer,nAllowedXP);
    }    */

    return VALIDATE_PLAYER_SUCCESS;
}



/// New characters ////
//:: InitializeN00b
//::  if the player has zero xp
//::  removes any GM deity on newbyes players
//::  checks for invalid charname
//::  gives level 10 to players (and gold)
//:: check that player tag and resref is none (otherwise they hacked)BootPC
void InitializeN00b(object oPC);
void InitializeN00b(object oPC)
{
    if (GetXP(oPC) == 0)
    {
          //DEBUG
         FloatingTextStringOnCreature(" Initializing n00b player ",oPC);
         //being a noob will skip some checks.
         SetLocalInt(oPC,"n00b",1);

        if (GetDeity(oPC) == "GM")
        {
            SetDeity(oPC, " ");
        }
        if (GetTag(oPC) != "")
        {
            WriteTimestampedLogEntry(GetPCPlayerName(oPC)+ " " + GetName(oPC)+" entered with HACKED char, Tag: "+ GetTag(oPC));
            BootPC(oPC);
        }
        if (GetResRef(oPC) != "")
        {
             WriteTimestampedLogEntry(GetPCPlayerName(oPC)+ " " +GetName(oPC)+" entered with HACKED char, ResRef: "+ GetTag(oPC));
             BootPC(oPC);
        }

        if (GetPCPlayerName(oPC) == "" || GetPCPlayerName(oPC) == " ")
        {
            FloatingTextStringOnCreature("Nameless characters are not allowed. If you make a nameless character, it will be deleted.",oPC,FALSE);
            SetDeity(oPC,"eliminaCARATTERI");
            WriteTimestampedLogEntry("Ths char was autoflagged Deleted [eliminaCARATTERI] due to Nameless charname: "+ GetName(oPC)+" ["+ GetPCPlayerName(oPC)+"]");
            DelayCommand(5.0, BootPC(oPC));
        }
        else
        {
            int nNewXP = GetXPRequiredForLevel(10);
            GiveGoldToCreature (oPC, 44500);
            SetXP(oPC, nNewXP);  //XP are 45.000.
         }

        ///New character enter with wings:
        //FloatingTextStringOnCreature("You Should not Have wings or tail.",oPC,FALSE);
        //DelayCommand(5.0,RemoveWingsTailIfAny(oPC));

    }
}

//::///////////////////////////////////////////////
//:: inc_forbidden
//::
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Contains functions to check players for
    forbidden items.
*/
//:://////////////////////////////////////////////
//:: Created By: Erich Delcamp
//:: Created On: Jul/15/02
//:: Pwned by Jantima on 2004 and 2005
//:: Moved to inc_rules 7/1/2007 to reduce number of includes
//:://////////////////////////////////////////////

//:: nIPRemove=If FALSE the items are not stripped of their temporary powers
int GetTotalPlayerGOLD( object oPlayer , int nIPRemove=TRUE);

// this thing is running once at check number ( I dunno)
void    CheckItem(object oItem, object oPlayer);

//:: This is a very old function...
//:: What this does?
//:: remove items with FOM ( if someone crafted/got any?)
//:: Remove True Seeing Rod ( OMG )
//:: Remove Haste Armor (X_x)
//:: Remove Items With Immunities
//:: Remove Haste from items
void  RemoveAllForbiddenItems( object oPlayer);

void RefillGold(object oPC);

//all checks that we always need, always runs
void CheckDuping(object oItem, object oPlayer);
void CheckDuping(object oItem, object oPlayer)
{
  //Check to see if they have a duplicated item from crafting
    if (GetLocalInt(oItem,"isCopy") == 1)
    {
        DestroyObject(oItem);
        FloatingTextStringOnCreature("Please don't try cheating!!",oPlayer);
    }
    //Also include the check for the // stx_inc_craft // this one to change helmets appearance
    //wich is the same same Idea of the one above, we should merge them
    if (GetLocalInt(oItem, "STX_CR_TEMPITEM")) {
        PrintString("Destroyed: "+GetName(oItem));
        DestroyObject(oItem);
    }
    if (GetTag(oItem) == "halloweenparty" && GetLocalInt(GetModule(), "Halloween") != 1)   DestroyObject(oItem);

    //Temporary Double check on universal saves to see if we are missing some tags
    if(GetItemHasItemProperty(oItem,ITEM_PROPERTY_SAVING_THROW_BONUS))
                {
                 object oGM;
                    int i;
                    for (i = 0; i < 32; i++)
                    {
                        oGM = GetLocalObject(GetModule(), "GM" + IntToString(i));
                        if (GetIsObjectValid(oGM))
                        {
                            SendMessageToPC(oGM, "<cñµ>This Item : "+GetName(oItem)+", Has an Universal save bonus. Player: "+GetName(oPlayer)+"</c>");
                        }
                    }
                }
 }

 /// CHECK NUMBER 6 remove joonis gloves and Mysterious items
 // we also refund gold since they have been bugged so much : poor guys.
void CheckNumber6(object oPC);
void CheckNumber6(object oPC)
 {
        object oItem = GetFirstItemInInventory(oPC);
        while ( GetIsObjectValid(oItem) == TRUE )
        {
            //This will remove all jooni's gloves
             if (  StX_GetIsMonkGlove(oItem))
             {
                int Gold = GetGoldPieceValue(oItem);
                DestroyObject(oItem);
                GiveGoldToCreature(oPC,Gold);
                SendMessageToPC(oPC, "<cñµ>Buy New GLOVES and Customize them with the Crafting Conversation.</c>");
              }
              // I need a place to remove the old myst object on players who have more than one due to a bug
          if (GetTag(oItem) == "mysteriousobject" && oItem != GetLocalObject (oPC,"spelltracker")) DestroyObject(oItem);
          oItem = GetNextItemInInventory(oPC);
         }
        int nCount;
        //this goes THRU their Equipped items also
        for ( nCount = 0; nCount < NUM_INVENTORY_SLOTS; nCount++ )
        {
          oItem = GetItemInSlot(nCount,oPC);
          if (  StX_GetIsMonkGlove(oItem))
             {
                int Gold = GetGoldPieceValue(oItem);
                DestroyObject(oItem);
                GiveGoldToCreature(oPC,Gold);
                SendMessageToPC(oPC, "<cñµ>Buy New GLOVES and Customize them with the Crafting Conversation.</c>");
              }
        }
}

void RefillGold(object oPC)
{
         //Refund a little bit their missing gold (that happen once at check 6)
        int nPlayerGold = GetTotalPlayerGOLD(oPC)+ GetGold(oPC);
        int nXP = GetXP(oPC);
        if ( (nXP - nPlayerGold)   > 17000 )
            {
            GiveGoldToCreature(oPC,nXP - nPlayerGold);
            SendMessageToPC(oPC, "<cñµ>Your gold has been returned since it seems that you unfairly lost so much stuff.</c>");
            }
}

/// Check Number 7  Autofail disabled Items Revision
//Also running at check 8 but we added the check on the presence of universal save
void  AutoFailDiabledRevision(object oPC);
void  AutoFailDiabledRevision(object oPC)
{
        object oItem = GetFirstItemInInventory(oPC);
        while ( GetIsObjectValid(oItem) == TRUE )
        {
        object oMod = GetModule();
        string oTag = GetTag(oItem);
            //This will remove all old item with universal saves
             if ( oTag ==  "NW_MAARCL015" ||  oTag ==  "NW_MAARCL024" ||  oTag ==  "BloodHelmet" ||  oTag ==  "NW_CLOTH004" ||  oTag ==  "NW_ARMHE009" ||
                  oTag ==  "X0_MAARCL022" ||   oTag ==  "NW_IT_MBOOTS018" ||  oTag ==  "NW_IT_MBOOTS019" ||  oTag ==  "NW_IT_MBOOTS020" ||  oTag ==  "NW_IT_MBOOTS021" ||
                  oTag ==  "NW_IT_MBOOTS022" || oTag ==  "NW_MARRCL104" || oTag ==  "NW_MARRCL105" || oTag ==  "NW_MARRCL106" || oTag ==  "X0_MAARCL025" || oTag ==  "X0_MAARCL026" ||
                  oTag ==  "X0_MAARCL027" || oTag ==  "NW_IT_MNECK006" || oTag ==  "NW_IT_MNECK016" || oTag ==  "NW_IT_MNECK017" || oTag ==  "X0_IT_MRING009" || oTag ==  "NW_IT_MRING031" ||
                  oTag ==  "NW_IT_MRING032" ||  oTag ==  "NW_IT_MRING033" ||  oTag ==  "cloak9")
                  {
                 //debug to know that it catch the item
                    object oGM;
                    int i;
                    for (i = 0; i < 32; i++)
                    {
                        oGM = GetLocalObject(oMod, "GM" + IntToString(i));
                        if (GetIsObjectValid(oGM))
                        {
                            SendMessageToPC(oGM, "<cñµ>Inventory check: Old version of item found: "+GetName(oItem)+". Player: "+GetName(oPC)+"</c>");
                        }
                    }
                //check for universal save bonus
                if(GetItemHasItemProperty(oItem,ITEM_PROPERTY_SAVING_THROW_BONUS))
                {
                //debug to know that it catch the property
                    object oGM;
                    int i;
                    for (i = 0; i < 32; i++)
                    {
                        oGM = GetLocalObject(oMod, "GM" + IntToString(i));
                        if (GetIsObjectValid(oGM))
                        {
                            SendMessageToPC(oGM,"<cñµ>The item had the universal save property: "+GetName(oItem)+". Player: "+GetName(oPC)+"</c>");
                        }
                    }

                    int Gold = GetGoldPieceValue(oItem);
                    DestroyObject(oItem);
                    GiveGoldToCreature(oPC,Gold);
                    SendMessageToPC(oPC, "<cñµ>We removed universal saves bonus, please buy a new "+GetName(oItem)+".</c>");

                   //just say that it got deleted
                  FloatingTextStringOnCreature("<cñµ>The item: "+GetName(oItem)+" has been deleted on Player: "+GetName(oPC)+"</c>",oPC);

                 }
              }
              oItem = GetNextItemInInventory(oPC);
         }
        int nCount;
        //this goes THRU their Equipped items also
        for ( nCount = 0; nCount < NUM_INVENTORY_SLOTS; nCount++ )
        {
          object oMod = GetModule();
          oItem = GetItemInSlot(nCount,oPC);
          string oTag = GetTag(oItem);
          if ( oTag ==  "NW_MAARCL015" ||  oTag ==  "NW_MAARCL024" ||  oTag ==  "BloodHelmet" ||  oTag ==  "NW_CLOTH004" ||  oTag ==  "NW_ARMHE009" ||
                  oTag ==  "X0_MAARCL022" ||   oTag ==  "NW_IT_MBOOTS018" ||  oTag ==  "NW_IT_MBOOTS019" ||  oTag ==  "NW_IT_MBOOTS020" ||  oTag ==  "NW_IT_MBOOTS021" ||
                  oTag ==  "NW_IT_MBOOTS022" || oTag ==  "NW_MARRCL104" || oTag ==  "NW_MARRCL105" || oTag ==  "NW_MARRCL106" || oTag ==  "X0_MAARCL025" || oTag ==  "X0_MAARCL026" ||
                  oTag ==  "X0_MAARCL027" || oTag ==  "NW_IT_MNECK006" || oTag ==  "NW_IT_MNECK016" || oTag ==  "NW_IT_MNECK017" || oTag ==  "X0_IT_MRING009" || oTag ==  "NW_IT_MRING031" ||
                  oTag ==  "NW_IT_MRING032" ||  oTag ==  "NW_IT_MRING033" ||  oTag ==  "cloak9" )
             {
              //debug to know that it catch the item
                object oGM;
                    int i;
                    for (i = 0; i < 32; i++)
                    {
                        oGM = GetLocalObject(oMod, "GM" + IntToString(i));
                        if (GetIsObjectValid(oGM))
                        {
                            SendMessageToPC(oGM,"<cñµ> Equip Check: Old version of item found: "+GetName(oItem)+". Player: "+GetName(oPC)+"</c>");
                        }
                    }

                if(GetItemHasItemProperty(oItem,ITEM_PROPERTY_SAVING_THROW_BONUS))
                {
                  //debug to know that it catch the property
                        object oGM;
                    int i;
                    for (i = 0; i < 32; i++)
                    {
                        oGM = GetLocalObject(oMod, "GM" + IntToString(i));
                        if (GetIsObjectValid(oGM))
                        {
                            SendMessageToPC(oGM,"<cñµ>The item had the universal save property: "+GetName(oItem)+". Player: "+GetName(oPC)+"</c>");
                        }
                    }


                    int Gold = GetGoldPieceValue(oItem);
                    DestroyObject(oItem);
                    GiveGoldToCreature(oPC,Gold);
                    SendMessageToPC(oPC, "<cñµ>We removed universal saves bonus, please buy a new "+GetName(oItem)+".</c>");

                   //just say that it got deleted
                 FloatingTextStringOnCreature("<cñµ>The item: "+GetName(oItem)+" has been deleted on Player: "+GetName(oPC)+"</c>",oPC);

               }
             }
        }
}

// this thing is running once at check number ( I dunno)
void CheckItem(object oItem, object oPlayer)
{
 string sObjectTag = GetTag(oItem);

    // Identify the item first.
    if (GetIdentified(oItem) == FALSE)
    {
        SetIdentified(oItem, TRUE);
    }
//:: Since we have new Weapon enhancement system
//:: also allowing rename and changing appearance of everything
//:: we are removing all weapons and giving back the gold
//:: so they can buy new plain ones and customize them as they wish

 if ( StX_GetIsWeapon(oItem) || StX_GetIsAmmo(oItem) || StX_GetIsMonkGlove(oItem))
 {
 int Gold = GetGoldPieceValue(oItem);
        DestroyObject(oItem);
        GiveGoldToCreature(oPlayer,Gold);
        SendMessageToPC(oPlayer, "<cñµ>Buy New Weapons and Customize them with the Crafting Conversation.</c>");
 }

 // Also we have new ammo makers (or lordly upgrade)
 if ( GetIsOldAmmoMaker(oItem))
 {
        int Gold = GetGoldPieceValue(oItem);
        DestroyObject(oItem);
        GiveGoldToCreature(oPlayer,Gold);
        SendMessageToPC(oPlayer, "<cñµ>Buy New Ammo Makers and Customize them with the Crafting Conversation.</c>");
 }


    // Freedom of Movement negates the speed penalty for carrying the flag.
    // The item must go, or hasted monks with FoM will rule the game forever.
    if (GetItemHasItemProperty(oItem, ITEM_PROPERTY_FREEDOM_OF_MOVEMENT) == TRUE)
    {
        int Gold = GetGoldPieceValue(oItem);
        DestroyObject(oItem);
        GiveGoldToCreature(oPlayer,Gold);
        SendMessageToPC(oPlayer, "Freedom of Movement items are not allowed in this module.");
    }

    // Rod of true seeing is removed, and there is the Rod of Spotting. So remove the rod of true seeing from the player
    if (sObjectTag ==  "X0_WMGMRD007")
    {
        DestroyObject(oItem);
        SendMessageToPC(oPlayer, "Sorry, Rod of True Seeing is removed from the game.");
        GiveGoldToCreature(oPlayer,20251);
    }

       //harp of protection  NW_IT_MMIDMISC03
       //harp of superior war   NW_IT_MMIDMISC02
       //Harp of War  NW_IT_MMIDMISC01
       if (sObjectTag == "NW_IT_MMIDMISC03" || sObjectTag == "NW_IT_MMIDMISC02"  || sObjectTag == "NW_IT_MMIDMISC01")
       {
        int Gold = GetGoldPieceValue(oItem);
        SendMessageToPC(oPlayer, "Sorry, we removed Harps.");
        DestroyObject(oItem);
        GiveGoldToCreature(oPlayer,Gold);
        }


    if ( GetResRef(oItem) == "nw_waxmbt009")   //same as TS rod but i dunno why there are 2
    {
        SendMessageToPC(oPlayer, "Sorry, Sentinel +2 with Cast Truesight is removed from the game.");
        int Gold = GetGoldPieceValue(oItem);
        DestroyObject(oItem);
        GiveGoldToCreature(oPlayer,Gold);
        //CreateItemOnObject( "waxmbt010"  , oPlayer);   // O_o
    }
    if ( GetResRef(oItem) == "x2_it_mring029")   //Fort Ring + 10 #1
    {
        SendMessageToPC(oPlayer, "Sorry but you have to buy a new ring ");
        int Gold = GetGoldPieceValue(oItem);
        DestroyObject(oItem);
        GiveGoldToCreature(oPlayer,Gold);
    }
    if ( GetResRef(oItem) == "it_mring037")   //Fort Ring + 10 #2
    {
        SendMessageToPC(oPlayer, "Sorry but you have to buy a new ring ");
        int Gold = GetGoldPieceValue(oItem);
        DestroyObject(oItem);
        GiveGoldToCreature(oPlayer,Gold);
    }
    if ( GetResRef(oItem) == "it_mring039")   //Fort Ring + 10 #2
    {
        SendMessageToPC(oPlayer, "Sorry but you have to buy a new ring ");
        int Gold = GetGoldPieceValue(oItem);
        DestroyObject(oItem);
        GiveGoldToCreature(oPlayer,Gold);
    }
    // Immunity items are removed.
    if (GetItemHasItemProperty(oItem, ITEM_PROPERTY_IMMUNITY_MISCELLANEOUS))
    {
        int Gold = GetGoldPieceValue(oItem);
        DestroyObject(oItem);
        GiveGoldToCreature(oPlayer,Gold);
        SendMessageToPC(oPlayer, "Sorry, Immunity items are no longer allowed.");
    }

    if (GetItemHasItemProperty(oItem, ITEM_PROPERTY_IMMUNITY_DAMAGE_TYPE))
    {
        int Gold = GetGoldPieceValue(oItem);
        DestroyObject(oItem);
        GiveGoldToCreature(oPlayer,Gold);
        SendMessageToPC(oPlayer, "Sorry, Immunity items are no longer allowed.");
    }
   // Only a pure Paladin may use the Holy Avenger.
  //  if (GetItemHasItemProperty(oItem, ITEM_PROPERTY_HOLY_AVENGER) == TRUE /*&& GetItemPropertyDurationType(ITEM_PROPERTY_HOLY_AVENGER) == DURATION_TYPE_TEMPORARY */)
  /*  {
        if (!(GetClassByPosition(1, oPlayer) == CLASS_TYPE_PALADIN ||
              GetClassByPosition(2, oPlayer) == CLASS_TYPE_PALADIN ||
              GetClassByPosition(3, oPlayer) == CLASS_TYPE_PALADIN))
        {
            int Gold = GetGoldPieceValue(oItem);
            DestroyObject(oItem);
            GiveGoldToCreature(oPlayer,Gold);
            SendMessageToPC(oPlayer, "Only True Paladins may have a Holy Avenger.");
        }
    }      */
//    if (GetItemHasItemProperty(oItem, ITEM_PROPERTY_SAVING_THROW_BONUS))

// Haste items are removed.
    if (GetItemHasItemProperty(oItem, ITEM_PROPERTY_HASTE))
    {
        itemproperty oHaste = GetFirstItemProperty(oItem);
        while (GetIsItemPropertyValid(oHaste))
        {
            if (GetItemPropertyType(oHaste) == ITEM_PROPERTY_HASTE)
            {
                RemoveItemProperty(oItem,oHaste);
            }
            oHaste = GetNextItemProperty(oItem);
        }
        SendMessageToPC(oPlayer, "Sorry, Haste items are no longer allowed.");
    }

    if (GetItemHasItemProperty(oItem, ITEM_PROPERTY_ON_HIT_PROPERTIES))
    {
        itemproperty ipOnHit = GetFirstItemProperty(oItem);
        while (GetIsItemPropertyValid(ipOnHit))
        {
            if (GetItemPropertyType(ipOnHit) == ITEM_PROPERTY_ON_HIT_PROPERTIES)
            {
                RemoveItemProperty(oItem,ipOnHit);
            }
            ipOnHit = GetNextItemProperty(oItem);
        }
        //SendMessageToPC(oPlayer, "Sorry, OnHit items are no longer allowed.");
    }

}
void RemoveAllForbiddenItems(object oPlayer)
{
      //DEBUG
      FloatingTextStringOnCreature(" removing forbidden items ",oPlayer);
    object oItem = GetFirstItemInInventory(oPlayer);
    int nCount;

    while ( GetIsObjectValid(oItem) == TRUE )
    {
        CheckItem(oItem, oPlayer);
        oItem = GetNextItemInInventory(oPlayer);
    }

    for ( nCount = 0; nCount < NUM_INVENTORY_SLOTS; nCount++ )
    {
        oItem = GetItemInSlot(nCount,oPlayer);
        CheckItem(oItem, oPlayer);
    }
}


//::::::::::::: HUGE MERCHANTS AND ITEMS REVISION :::::::::::: //
//::                                                         :://
//::  Remove All items from the player ( except some maybe ) :://
//::  and give back the gold value                           :://
//::                                                         :://
/////////////////////////////////////////////////////////////////
void HugeMerchantsRevisions(object oPC);
void HugeMerchantsRevisions(object oPC)
{
    if ( GetLocalInt(GetItemPossessedBy(oPC,"itemsremoved1"),"item_updated") == 1 && GetIsDM(oPC) )
      {
      return;
      }
    else
    {
        //DEBUG
        FloatingTextStringOnCreature(" running Huge Merchants Revision ",oPC);
        object oItem = GetFirstItemInInventory(oPC);
        while(GetIsObjectValid(oItem))
        {
            //maybe we can make all non removable items Plot than do not remove plot items ^
            if(!GetPlotFlag(oItem) && GetBaseItemType(oItem) != BASE_ITEM_TORCH && GetBaseItemType(oItem) != BASE_ITEM_SCROLL )
            {
                int Gold = GetGoldPieceValue(oItem);
                DestroyObject(oItem);
                GiveGoldToCreature(oPC,Gold);
            }

            //Remove haste From all items is onAcquire //
            oItem = GetNextItemInInventory(oPC);
        }

        // Now iterate through each inventory slot and do the same
        int nCount;
        for ( nCount = 0; nCount < NUM_INVENTORY_SLOTS; nCount++ )
        {
                oItem = GetItemInSlot(nCount,oPC);
                if ( !GetPlotFlag(oItem) && GetBaseItemType(oItem) != BASE_ITEM_TORCH && GetBaseItemType(oItem) != BASE_ITEM_SCROLL )
                                {
                    int Gold = GetGoldPieceValue(oItem);
                    DestroyObject(oItem);
                    GiveGoldToCreature(oPC,Gold);
                }
        }
        DelayCommand(12.3,SendMessageToPC(oPC, "All your items have been stripped, please go to shopping now!."));
        //Then Create The Token !!!
        //CreateItemOnObject("itemsremoved1", oPC);
    }
    //New Hotkatudo's Armor
    // remove the old one and give the new one which have same ResRef but tag HotkatudosArmor1
    object oHotArmor = GetItemPossessedBy(oPC,"HotkatudosArmor");
    if (GetIsObjectValid(oHotArmor))
    {
        int Gold = GetGoldPieceValue(oHotArmor);
        DestroyObject(oHotArmor);
        //object oNewHotArmor = CreateItemOnObject("HotkatudosArmor",oPC,1);
        //GiveGoldToCreature(oPC,Gold - GetGoldPieceValue(oNewHotArmor));
        GiveGoldToCreature(oPC,Gold );
        SendMessageToPC(oPC, "Sorry but you have to buy a new armor.");
    }
  oHotArmor = GetItemPossessedBy(oPC,"HotkatudosArmor1");
    if (GetIsObjectValid(oHotArmor))
    {
        int Gold = GetGoldPieceValue(oHotArmor);
        DestroyObject(oHotArmor);
        //object oNewHotArmor = CreateItemOnObject("HotkatudosArmor",oPC,1);
        //GiveGoldToCreature(oPC,Gold - GetGoldPieceValue(oNewHotArmor));
        SendMessageToPC(oPC, "Sorry but you have to buy a new armor.");
        GiveGoldToCreature(oPC,Gold );
    }
}
//////////////////////////////////////////////////////////////
///having a copy of this since in cannot include the inc_rules here
///Riddler! We need to find a way to calculate the ammo value and suchful-Aez
//////////////////////////////////////////////////////////////
int GetTotalPlayerGOLD( object oPlayer ,int nIPRemove)
{
    int nCount, nTotalCost = 0;
    object oItem;

    // Calculate the total cost of items in the creature's
    // repository
    oItem = GetFirstItemInInventory(oPlayer);
    while ( GetIsObjectValid(oItem) == TRUE )
    {
        if (GetItemHasItemProperty(oItem, ITEM_PROPERTY_TRAP) == FALSE)
        {
            if( GetIsAmmoMaker(  oItem ) )
            {
                 GetAmmoMakerValue( oItem);
            }
            else
            {
                nTotalCost += GetGoldPieceValue(oItem);
            }
        }
    oItem = GetNextItemInInventory(oPlayer);
    if(nIPRemove == TRUE)
    // remove temporary effects  //
    IPRemoveAllItemProperties(oItem,  DURATION_TYPE_TEMPORARY);
    }

    // Now iterate through each inventory slot and compute
    // the cost of the item (if one exists in that slot)
    // - BKH - Jun/09/02
    for ( nCount = 0; nCount < NUM_INVENTORY_SLOTS; nCount++ )
    {
        oItem = GetItemInSlot(nCount,oPlayer);
        if ( GetIsObjectValid(oItem) )
        {
            nTotalCost += GetGoldPieceValue(oItem);
            //remove temporary effects
            IPRemoveAllItemProperties(oItem,  DURATION_TYPE_TEMPORARY);

        }
    }
    return nTotalCost;
}

///////////////////////////////////////
//      REMOVE FORT RING +10         //
///////////////////////////////////////
void RemoveFort10Ring(object oPC);
void RemoveFort10Ring(object oPC)
{
object oItem = GetFirstItemInInventory(oPC);
        while(GetIsObjectValid(oItem))
        {
            //find the rings
            if( GetTag(oItem) == "new_fort_10" )
            {
                int Gold = GetGoldPieceValue(oItem);
                DestroyObject(oItem);
                GiveGoldToCreature(oPC,Gold);
            }
            oItem = GetNextItemInInventory(oPC);
        }
        // Now iterate through each inventory slot and do the same
        int nCount;
        for ( nCount = 0; nCount < NUM_INVENTORY_SLOTS; nCount++ )
        {
                oItem = GetItemInSlot(nCount,oPC);
                if (  GetTag(oItem) == "new_fort_10"  )
                                {
                    int Gold = GetGoldPieceValue(oItem);
                    DestroyObject(oItem);
                    GiveGoldToCreature(oPC,Gold);
                }
        }
        DelayCommand(12.3,SendMessageToPC(oPC, "All your Fort Ring + 10have been removed!."));
}

///////////////////////////////////////
//      REMOVE +12 Gloves //
///////////////////////////////////////
void RemoveBadGloves(object oPC);
void RemoveBadGloves(object oPC)
{
object oItem = GetFirstItemInInventory(oPC);
        while(GetIsObjectValid(oItem))
        {
            //find the gloves
            if( GetTag(oItem) == "SuperiorGlovesofConcentration" || GetTag(oItem) == "SuperiorGlovesofDiscipline" || GetTag(oItem) == "SuperiorGlovesofSpellcraft" )
            {
                int Gold = GetGoldPieceValue(oItem);
                DestroyObject(oItem);
                GiveGoldToCreature(oPC,Gold);
            }
            oItem = GetNextItemInInventory(oPC);
        }
        // Now iterate through each inventory slot and do the same
        int nCount;
        for ( nCount = 0; nCount < NUM_INVENTORY_SLOTS; nCount++ )
        {
                oItem = GetItemInSlot(nCount,oPC);
                if( GetTag(oItem) == "SuperiorGlovesofConcentration" || GetTag(oItem) == "SuperiorGlovesofDiscipline" || GetTag(oItem) == "SuperiorGlovesofSpellcraft" )
                                {
                    int Gold = GetGoldPieceValue(oItem);
                    DestroyObject(oItem);
                    GiveGoldToCreature(oPC,Gold);
                }
        }
        DelayCommand(12.3,SendMessageToPC(oPC, "All your + 12 Gloves have been removed."));
}
///////////////////////////////////////
//      REMOVE Old Scythe //
///////////////////////////////////////
void RemoveOldScythe(object oPC);
void RemoveOldScythe(object oPC)
{
object oItem = GetFirstItemInInventory(oPC);
        while(GetIsObjectValid(oItem))
        {
            //find the scythe
            if( GetTag(oItem) == "NW_WPLSC001" )
            {
                int Gold = GetGoldPieceValue(oItem);
                DestroyObject(oItem);
                GiveGoldToCreature(oPC,Gold);
            }
            oItem = GetNextItemInInventory(oPC);
        }
        // Now iterate through each inventory slot and do the same
        int nCount;
        for ( nCount = 0; nCount < NUM_INVENTORY_SLOTS; nCount++ )
        {
                oItem = GetItemInSlot(nCount,oPC);
                if( GetTag(oItem) == "NW_WPLSC001" )
                                {
                    int Gold = GetGoldPieceValue(oItem);
                    DestroyObject(oItem);
                    GiveGoldToCreature(oPC,Gold);
                }
        }
        DelayCommand(12.3,SendMessageToPC(oPC, "Your scythe has been removed and you have been refunded."));
}
///////////////////////////////////////
//      REMOVE Excess Heal Rings //
///////////////////////////////////////
void RemoveExcessHealRings(object oPC);
void RemoveExcessHealRings(object oPC)
{
object oItem = GetFirstItemInInventory(oPC);
int nHealRings = 0;
        while(GetIsObjectValid(oItem))
        {
            //find the scythe
            if( GetTag(oItem) == "X0_IT_MRING012" )
            {
                nHealRings = nHealRings + 1;
                if (nHealRings > 5)
                {
                  int Gold = GetGoldPieceValue(oItem);
                  DestroyObject(oItem);
                  GiveGoldToCreature(oPC,Gold);
                }
            }
            oItem = GetNextItemInInventory(oPC);
        }
        // Now iterate through each inventory slot and do the same
        int nCount;
        for ( nCount = 0; nCount < NUM_INVENTORY_SLOTS; nCount++ )
        {
                oItem = GetItemInSlot(nCount,oPC);
                if( GetTag(oItem) == "X0_IT_MRING012" )
                {
                   nHealRings = nHealRings + 1;
                   if (nHealRings > 5)
                   {
                     int Gold = GetGoldPieceValue(oItem);
                     DestroyObject(oItem);
                     GiveGoldToCreature(oPC,Gold);
                   }
                }
        }
        DelayCommand(12.3,SendMessageToPC(oPC, "If you had more than 5 heal rings, the excess rings have been removed and you have been refunded."));
}
///////////////////////////////////////
//Charge system
//This system is based on charge for specific item.
//Such class only item or dex/ac item
//
//HERE THE LIST
//1 : Barbarian
//2 : Bard
//3 : Cleric
//4 : Druid
//5 : Fighter
//6 : Monk
//7 : Paladin
//8 : Ranger
//9 : Rogue
//10 : Sorcerer
//11 : Wizard
//12 : ShadowDancer
//13 : Harper scout
//14 : Arcane Archer
//15 : Assassin
//16 ; Blackguard
//17 : Champion of torm
//18 : Weapon master
//19 : Pale master
//20 : Shifter
//21 : Dwarven defender
//22 : Red dragon disciple
//23 : Purple Dragon knight
//24 : 25 UMD none cleric
//25 : 20 UMD none wiz/sorc
//26 : Sorc/Wiz only
//27 : Fighter/Ranger/Barb only
//28 : Bard/Ranger/Rogue/Assassin
//29 : Paladin/CoT/Cleric Only
//30 : Lowy AC dex armor
//31 : Lowy AC dex armor, Ranger only
//32 : Lowy AC dex armor, Bard only
//33 : Lowy AC dex armor, Barbarian only
//34 : GM/DM only // NOT DONE YET
///////////////////////////////////////
void UpdateChargeSystem(object oPC);
void UpdateChargeSystem(object oPC)
{
object oItem = GetFirstItemInInventory(oPC);
while(GetIsObjectValid(oItem))
    {
    //Barbarian Item
    if((GetTag(oItem) == "RageGear1" ) ||
        (GetTag(oItem) == "RageGear2" ) ||
        (GetTag(oItem) == "RageGear3" ) ||
        (GetTag(oItem) == "RageGear4" ) ||
        (GetTag(oItem) == "RageGear5" ))
        {
        SetItemCharges(oItem, 1);
        }
    //Bard Item
    if((GetTag(oItem) == "NW_IT_MGLOVE001" ) ||
        (GetTag(oItem) == "nw_it_mglove011" ) ||
        (GetTag(oItem) == "nw_it_eglove011" ))
        {
        SetItemCharges(oItem, 2);
        }
    //Cleric Item
    if((GetTag(oItem) == "NW_IT_MRING007" ) ||
        (GetTag(oItem) == "NW_IT_MBELT001" ))
        {
        SetItemCharges(oItem, 3);
        }
    //Druid Item
    if((GetTag(oItem) == "NW_WDBMQS007" ) ||
        (GetTag(oItem) == "NaturesMane" ) ||
        (GetTag(oItem) == "TreantRoot" ) ||
        (GetTag(oItem) == "NW_MAARCL030" )||
        (GetTag(oItem) == "GirdleofNaturesFury" )||
        (GetTag(oItem) == "GreatOakCloak" )||
        (GetTag(oItem) == "ShapeChanger" )||
        (GetTag(oItem) == "NaturesWrap" )||
        (GetTag(oItem) == "NaturesCrown" ))
        {
        SetItemCharges(oItem, 4);
        }
    //Wizard Item
    if((GetTag(oItem) == "NW_CLOTH008" ) ||
        (GetTag(oItem) == "X1_IT_MRING001" ) ||
        (GetTag(oItem) == "NW_ARMHE008" ))
        {
        SetItemCharges(oItem, 10);
        }
    //Sorcerer Item
    if((GetTag(oItem) == "NW_CLOTH005" ) ||
        (GetTag(oItem) == "X1_IT_MRING002" ) ||
        (GetTag(oItem) == "WizardsMantle" ) ||
        (GetTag(oItem) == "AmuletofPower" ))
        {
        SetItemCharges(oItem, 11);
        }
    //Scout Item
    if((GetTag(oItem) == "ScoutsBoots" ) ||
        (GetTag(oItem) == "ScoutsEyes" ))
        {
        SetItemCharges(oItem, 13);
        }
    //Assassin Item
    if((GetTag(oItem) == "AssassinsGem" ) ||
        (GetTag(oItem) == "BracersoftheViper" ) ||
        (GetTag(oItem) == "AssassinsLust" ))
        {
        SetItemCharges(oItem, 15);
        }
    //Blackguard Item
    if((GetTag(oItem) == "BlackKnightsShade" ) ||
        (GetTag(oItem) == "X0_MAARCL018" ) ||
        (GetTag(oItem) == "SilentDarkPlate" ))
        {
        SetItemCharges(oItem, 16);
        }
    //Shifter Item
    if((GetTag(oItem) == "NW_WMGST003" ) ||
        (GetTag(oItem) == "ShiftersCrown" ))
        {
        SetItemCharges(oItem, 20);
        }
    //PDK Item
    if((GetTag(oItem) == "KnightsShield" ) ||
        (GetTag(oItem) == "PurpleCrown" ))
        {
        SetItemCharges(oItem, 23);
        }
    //25 UMD none cleric item
    if((GetTag(oItem) == "NW_WMGST006" ))
        {
        SetItemCharges(oItem, 24);
        }
    //20 UMD none wiz/sorc Item
    if((GetTag(oItem) == "NW_WMGST004" ) ||
        (GetTag(oItem) == "NW_WMGST003" ))
        {
        SetItemCharges(oItem, 25);
        }
    //Sorc/Wiz only Item
    if((GetTag(oItem) == "NW_MCLOTH003" ) ||
        (GetTag(oItem) == "NW_MCLOTH004" ) ||
        (GetTag(oItem) == "NW_MCLOTH001" ) ||
        (GetTag(oItem) == "NW_MCLOTH002" ))
        {
        SetItemCharges(oItem, 26);
        }
    //Fighter/Ranger/Barb only Item
    if((GetTag(oItem) == "BootsoftheRageClan4" ) ||
        (GetTag(oItem) == "BootsoftheRageClan5" ))
        {
        SetItemCharges(oItem, 27);
        }
    //Bard/Ranger/Rogue/Assassin item
    if((GetTag(oItem) == "GlovesoftheSteadyHand" ))
        {
        SetItemCharges(oItem, 28);
        }
    //Paladin/CoT/Cleric Only item
    if((GetTag(oItem) == "x2_cus_armoroffaith" ))
        {
        SetItemCharges(oItem, 29);
        }
    //Lowy AC dex armor Item
    if((GetTag(oItem) == "NW_MAARCL083" ) ||
        (GetTag(oItem) == "X0_MAARCL003" ) ||
        (GetTag(oItem) == "X0_MAARCL004" ) ||
        (GetTag(oItem) == "NW_MAARCL043" ) ||
        (GetTag(oItem) == "NW_MAARCL072" ) ||
        (GetTag(oItem) == "NW_MAARCL044" ) ||
        (GetTag(oItem) == "NW_MAARCL084" ) ||
        (GetTag(oItem) == "X0_MAARCL001" ) ||
        (GetTag(oItem) == "X0_MAARCL002" ) ||
        (GetTag(oItem) == "NW_MAARCL034" ) ||
        (GetTag(oItem) == "NW_MAARCL045" ) ||
        (GetTag(oItem) == "NW_MAARCL075" ) ||
        (GetTag(oItem) == "NW_MAARCL087" ) ||
        (GetTag(oItem) == "X0_MAARCL005" ) ||
        (GetTag(oItem) == "X0_MAARCL006" ) ||
        (GetTag(oItem) == "NW_MAARCL047" ) ||
        (GetTag(oItem) == "NW_MAARCL070" ) ||
        (GetTag(oItem) == "NW_MAARCL082" ) ||
        (GetTag(oItem) == "X0_MAARCL007" ) ||
        (GetTag(oItem) == "X0_MAARCL008" ) ||
        (GetTag(oItem) == "NW_CLOTH004" ) ||
        (GetTag(oItem) == "NW_MAARCL084" ) ||
        (GetTag(oItem) == "NW_MCLOTH017" ) ||
        (GetTag(oItem) == "NW_MAARCL004" ) ||
        (GetTag(oItem) == "NW_MAARCL033" ) ||
        (GetTag(oItem) == "NW_MAARCL071" ) ||
        (GetTag(oItem) == "resolute" ) ||
        (GetTag(oItem) == "SquiresDefense" ) ||
        (GetTag(oItem) == "BattleOutfit" ) ||
        (GetTag(oItem) == "GreaterBattleOutfit" ))
        {
        SetItemCharges(oItem, 30);
        }
    //Lowy AC dex armor, Ranger only Item
    if((GetTag(oItem) == "RangersPadding1" ) ||
        (GetTag(oItem) == "RangersPadding2" ) ||
        (GetTag(oItem) == "RangersPadding3" ) ||
        (GetTag(oItem) == "RangersPadding4" ) ||
        (GetTag(oItem) == "RangersPadding5" ))
        {
        SetItemCharges(oItem, 31);
        }
    //Lowy AC dex armor, Bard only Item
    if((GetTag(oItem) == "SongstersDelight" ) ||
        (GetTag(oItem) == "PerformersOutfit1" ) ||
        (GetTag(oItem) == "PerformersOutfit2" ) ||
        (GetTag(oItem) == "PerformersOutfit3" ) ||
        (GetTag(oItem) == "PerformersOutfit4" ) ||
        (GetTag(oItem) == "PerformersOutfit5" ))
        {
        SetItemCharges(oItem, 32);
        }

    oItem = GetNextItemInInventory(oPC);
    }
}
