#include "inc_bs_module"
#include "aw_include"

void main()
{
    object oItem = GetModuleItemAcquired();
    object oPlayer = GetItemPossessor(oItem);


    if (GetIsPC(oPlayer))
    {
        //save a local int on items so to clean the stores
        SetLocalInt(oItem, "PCItem", 1);

        if (!GetLocalInt(oPlayer, "DoneLogin"))
        {
            return;
        }

        SetIdentified(oItem, TRUE);

        string sTag = GetTag(oItem);

           if (sTag == "X0_IT_MRING012")
           {
              int nHealRings = 0;
              //Now lets find how many heal rings there are in the inventory.
              object oHealRings = GetFirstItemInInventory(oPlayer);
                  while(GetIsObjectValid(oHealRings))
                  {
                  //find the Rings
                   if( GetTag(oHealRings) == "X0_IT_MRING012" )
                   {
                      nHealRings = nHealRings + 1;
                   }
                   oHealRings = GetNextItemInInventory(oPlayer);
                  }
                  // Now iterate through each inventory slot and do the same
                 int nCount;
                 for ( nCount = 0; nCount < NUM_INVENTORY_SLOTS; nCount++ )
                 {
                 oHealRings = GetItemInSlot(nCount,oPlayer);
                  if( GetTag(oHealRings) == "X0_IT_MRING012" )
                  {
                     nHealRings = nHealRings + 1;
                  }
                 }
              if (nHealRings > 5)
              {
               int Gold = GetGoldPieceValue(oItem);
               DestroyObject(oItem);
               GiveGoldToCreature(oPlayer,Gold);
               DelayCommand(1.0,SendMessageToPC(oPlayer, "You may purchase no more than 5 healing rings."));
              }
           }
        itemproperty ipLoop = GetFirstItemProperty(oItem);
        //Loop for as long as the ipLoop variable is valid
        while (GetIsItemPropertyValid(ipLoop))
        {
            int nType = GetItemPropertyType(ipLoop);
            if (nType ==ITEM_PROPERTY_USE_LIMITATION_ALIGNMENT_GROUP)
            {
                RemoveItemProperty(oItem, ipLoop);
            }

            if (nType == ITEM_PROPERTY_HASTE)
            {
                RemoveItemProperty(oItem,ipLoop);
                SendMessageToPC(oPlayer, "Sorry, Haste items are no longer allowed.");
            }

            if (nType == ITEM_PROPERTY_TRAP)
            {
                int nTraps = GetTrapsAcquired(oPlayer);
                if (nTraps >= DAILY_TRAP_LIMIT)
                {
                    GiveGoldToCreature(oPlayer, GetGoldPieceValue(oItem));
                    DestroyObject(oItem);
                    SendMessageToPC(oPlayer, "You cannot get any more traps today.");
                    SendMessageToPC(oPlayer, "You have recovered some of the value of the trap.");
                }
                else
                {
                    nTraps++;
                    SetTrapsAcquired(oPlayer, nTraps);
                    SendMessageToPC(oPlayer, "You may acquire "
                                             + IntToString(DAILY_TRAP_LIMIT - nTraps)
                                             + " more traps today.");
                }
                break;
            }
            ipLoop = GetNextItemProperty(oItem);
        }

        if (FindSubString(GetStringLowerCase(sTag), "maker") != -1)
        {
            AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyLimitUseByAlign(IP_CONST_ALIGNMENTGROUP_CHAOTIC), oItem);
            AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyLimitUseByAlign(IP_CONST_ALIGNMENTGROUP_EVIL), oItem);
            AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyLimitUseByAlign(IP_CONST_ALIGNMENTGROUP_GOOD), oItem);
            AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyLimitUseByAlign(IP_CONST_ALIGNMENTGROUP_LAWFUL), oItem);
            AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyLimitUseByAlign(IP_CONST_ALIGNMENTGROUP_NEUTRAL), oItem);
        }

        /////Dragon Power and immunity ring Specail/////
        // Temp= tempimmunering  FAKE= fakeimmunering ORIGINAL = immunityring
        if (sTag ==  "tempimmunering")
        {
            if ( GetLocalObject(oItem, "killer") == oPlayer)
            {
                DestroyObject(oItem);
                if (GetItemPossessedBy(oPlayer, "immunityring") == OBJECT_INVALID)
                {
                    CreateItemOnObject("immunityring", oPlayer);
                }
                else
                {
                    FloatingTextStringOnCreature("You already have an immunity ring", oPlayer, FALSE);
                }

            }
            else if ( GetLocalObject(oItem, "killer") != oPlayer)
            {
                DestroyObject(oItem);
                CreateItemOnObject("fakeimmunering", oPlayer);
            }
        }
        // Temp= tempdragonpower  FAKE= fakedragonpower ORIGINAL = dragonspower
        if (sTag ==  "tempdragonpower" )
        {
            if ( GetLocalObject(oItem, "killer") == oPlayer)
            {
                DestroyObject(oItem);
                if (GetItemPossessedBy(oPlayer, "dragonspower") == OBJECT_INVALID)
                {
                    CreateItemOnObject("dragonspower", oPlayer);
                }
                else
                {
                    FloatingTextStringOnCreature("You already have a dragon power amulet", oPlayer, FALSE);
                }

            }
            else if ( GetLocalObject(oItem, "killer") != oPlayer)
            {
                DestroyObject(oItem);
                CreateItemOnObject("fakedragonpower", oPlayer);
            }
        }
    }
    else //item is acquired by the module, or by a DM or by a NPC?
    {
          if (GetTag(oItem) == "NW_IT_GOLD001")
          {
                DestroyObject(oItem);
                if (GetIsGMNormalChar(oPlayer))
                {
                    FloatingTextStringOnCreature("Gold dropped", oPlayer, FALSE);
                }
          }

    }
}
