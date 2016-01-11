// Wrapper for the Dark Hour module

// Cleaned up by Zunath on July 26, 2007

void main()
{
    // Setting the variables
    object oPC = GetItemActivator();
    object oItem = GetItemActivated();
    object oTarget = GetItemActivatedTarget();
    string sItemTag = GetTag(oItem);
    string sItemResRef = GetResRef(GetItemActivated());
    object oTarget2;
    // DEMON X ADD -- holy, didn't know you guys weren't using Tag based Scripting... Much more Useful!
    // Vision -- What is this, the stone age? ;)
    ExecuteScript("ac_"+sItemTag, oPC);
    // DM Item Modifier
    if(sItemTag == "DM_Item_Manipulator")
    {
        if(GetIsObjectValid(oTarget) == TRUE && GetObjectType(oTarget) == OBJECT_TYPE_ITEM)
        {
            SetLocalObject(oPC, "TARGETED_ITEM", oTarget);
            AssignCommand(oPC, ActionStartConversation(oPC, "dm_wand_item", TRUE, FALSE));
            return;
        }
        else
            SendMessageToPC(oPC, "That is not a valid item");

        return;
    }

//  ExecuteScript("dmfi_activate", GetItemActivator());
    if(sItemTag == "td_it_quillpen")
        {
        ExecuteScript("td_it_quillpen", oPC);
        return;
        }
    else if(sItemTag == "dmfi_pc_follow")
        {
            if (GetIsObjectValid(oTarget))
            {
                FloatingTextStringOnCreature("Now following "+ GetName(oTarget),oPC, FALSE);
                DelayCommand(2.0f, AssignCommand(oPC, ActionForceFollowObject(oTarget, 2.0f)));
            }
            return;
        }
    else if(sItemTag == "scavenger")
        {
        ExecuteScript("use_scavenger", oPC);
        return;
        }
    else if(sItemTag == "ExtraScavenger")
        {
        ExecuteScript("use_scavenger", oPC);
        return;
        }
    else if(GetStringLeft(sItemResRef, 13) == "artifactpiece")
        {
        ExecuteScript("artifact_join", oPC);
        return;
        }
    else if(GetStringLeft(sItemTag, 13) == "tradeablecraf")
        {
        object oCrafting = GetItemPossessedBy(oPC, "craftingitem");
        int iAmount = GetLocalInt(oCrafting, "crafting");
        if(GetStringRight(sItemTag, 3) == "100")
            {
            SetLocalInt(oCrafting, "crafting", iAmount + 100);
            iAmount = GetLocalInt(oCrafting, "crafting");
            SendMessageToPC(oPC, "You now have " + IntToString(iAmount) + " crafting points.");
            return;
            }
        else if(GetStringRight(sItemTag, 3) == "200")
            {
            SetLocalInt(oCrafting, "crafting", iAmount + 200);
            iAmount = GetLocalInt(oCrafting, "crafting");
            SendMessageToPC(oPC, "You now have " + IntToString(iAmount) + " crafting points.");
            return;
            }
        else if(GetStringRight(sItemTag, 3) == "500")
            {
            SetLocalInt(oCrafting, "crafting", iAmount + 500);
            iAmount = GetLocalInt(oCrafting, "crafting");
            SendMessageToPC(oPC, "You now have " + IntToString(iAmount) + " crafting points.");
            return;
            }
        }
    ExecuteScript("create_candle", oPC);
    ExecuteScript("create_wbread", oPC);
    ExecuteScript("disease_clear", oPC);
    ExecuteScript("tanto_seppuku", oPC);
    ExecuteScript("purify_spoils", oPC);
    ExecuteScript("forage_remedy", oPC);
    ExecuteScript("soul_banisher", oPC);

    // Added by Zunath on August 2, 2007
    ExecuteScript("dm_pc_list", oPC);
    // End added by Zunath on August 2, 2007

    //Any script that initiates a conversation with the PC is in __Pipes
    //EDIT: Any conversation scripts have been moved below
    if (sItemTag == "DMBootWand")
    {
        ExecuteScript("dmbootwand", GetItemActivator());
        return;
    }
    if (sItemTag == "restfixer")
    {
      ExecuteScript("dm_restfixer", GetItemActivator());
      return;
    }
    if (sItemTag == "tradeablecraftin")
    {
        ExecuteScript("cr_tradeadd", GetItemActivator());
        return;
    }



    //Planar Anchor Script, teleports PC to
    //Temporal Plane for resting, and then returns to their previous location
    else if (sItemTag == "temporalplane")
    {
        ExecuteScript("temporalplane", GetItemActivator());
        return;
    }
    else if (sItemTag == "professionbaker")
    {
        ExecuteScript("prof_baker_uniqu", GetItemActivator());
        return;
    }
    else if (sItemTag == "professioncook")
    {
        ExecuteScript("prof_cook", GetItemActivator());
        return;
    }

    //FACTIONS:::::::::::::::::::::::::
    else if (sItemTag == "goredleader")
    {
        ExecuteScript("create_goredo", GetItemActivator());
        return;
    }
    else if (sItemTag == "ironleader")
    {
        ExecuteScript("create_ironwallo", GetItemActivator());
        return;
    }
    else if (sItemTag == "societyleader")
    {
        ExecuteScript("create_societyo", GetItemActivator());
        return;
    }
    else if (sItemTag == "goredswordso") AssignCommand(oPC, ActionStartConversation(oPC, "factiongored", TRUE));
    else if (sItemTag == "societyo") AssignCommand(oPC, ActionStartConversation(oPC, "factiontrade", TRUE));
    else if (sItemTag == "ironwallo") AssignCommand(oPC, ActionStartConversation(oPC, "factioniron", TRUE));

    //Profession Scripts
    else if (sItemTag == "professioncarp")
    {
        ExecuteScript("prof_carp_uniqu", GetItemActivator());
        return;
    }
    else if (sItemTag == "profzcguard")
    {
        ExecuteScript("prof_zcguard_uni", GetItemActivator());
        return;
    }
    else if (sItemTag == "professionstrat")
    {
        ExecuteScript("prof_strat_uniqu", GetItemActivator());
        return;
    }
    else if (sItemTag == "professionmedic")
    {
        ExecuteScript("prof_medic_uniqu", GetItemActivator());
        return;
    }
    else if (sItemTag == "professionbutch")
    {
        ExecuteScript("prof_butcher_uni", GetItemActivator());
        return;
    }
    // Desolate Recall
    else if (sItemTag == "desolaterecall")
    {
        ExecuteScript("sanctuary_rec", GetItemActivator());
        return;
    }


    //Change: The musical instruments were using silent conversations, old method was
    //Used instead of below
    oTarget2 = oPC;
    if (sItemTag == "ZEP_PIPES2")
    {
        AssignCommand(oTarget2, ActionStartConversation(oPC, "pipe"));
        return;
    }
    else if (sItemTag == "ZEP_TAMBOURINE2")
    {
        AssignCommand(oTarget2, ActionStartConversation(oPC, "tamborine"));
        return;
    }
    else if (sItemTag == "ZEP_LUTE2")
    {
        AssignCommand(oTarget2, ActionStartConversation(oPC, "lute"));
        return;
    }
    else if (sItemTag == "ZEP_FLUTE2")
    {
        AssignCommand(oTarget2, ActionStartConversation(oPC, "flute"));
        return;
    }
    else if (sItemTag == "ZEP_HARP2")
    {
        AssignCommand(oTarget2, ActionStartConversation(oPC, "harp"));
        return;
    }
    else if (sItemTag == "ZEP_DRUMS2")
    {
        AssignCommand(oTarget2, ActionStartConversation(oPC, "drums"));
        return;
    }
    //__pipes script assimilated into this block, All Conversations (Silent) are located here:
    else if (sItemTag == "professionpc") AssignCommand(oPC, ActionStartConversation(oPC, "profession", TRUE));
    else if (sItemTag == "alchbook001")
        {
        if (GetItemPossessedBy(oPC, "CraftingNecklace") != OBJECT_INVALID)
            {
            return;
            }
        AssignCommand(oPC, ActionStartConversation(oPC, "newalchemy", TRUE));
        }
    else if (sItemTag == "BarricadeCreator") AssignCommand(oPC, ActionStartConversation(oPC, "barricadecreatio", TRUE));
    else if (sItemTag == "DyeKit") AssignCommand(oPC, ActionStartConversation(oPC, "dye_dyekit", TRUE));
    else if (sItemTag == "telestone")
        {
        AssignCommand(oPC, ActionStartConversation(oPC, "telestoneconvers", TRUE));
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDispelMagicAll(40), oPC);
        }
     if(GetTag(GetItemActivated())=="SubdualModeTog")
        AssignCommand(GetItemActivator(),ActionStartConversation(GetItemActivator(),"subdualconv",TRUE));

}
