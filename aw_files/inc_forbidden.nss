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
//:: Moved to inc_rules to reduce number of includes - riddler
//:://////////////////////////////////////////////
/*
 //#include "item_enhancement"
 int GetTotalPlayerGOLD( object oPlayer );

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
  //  if (GetItemHasItemProperty(oItem, ITEM_PROPERTY_HOLY_AVENGER) == TRUE)
  //  {
      //  if (!(GetClassByPosition(1, oPlayer) == CLASS_TYPE_PALADIN ||
      //        GetClassByPosition(2, oPlayer) == CLASS_TYPE_PALADIN ||
      //        GetClassByPosition(3, oPlayer) == CLASS_TYPE_PALADIN))
      //  {
      //      int Gold = GetGoldPieceValue(oItem);
      //      DestroyObject(oItem);
      //      GiveGoldToCreature(oPlayer,Gold);
      //      SendMessageToPC(oPlayer, "Only True Paladins may have a Holy Avenger.");
      //  }
    //}
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
int GetTotalPlayerGOLD( object oPlayer )
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
        }
    }
    return nTotalCost;
}
*/
