// Cleaned up by some fag Zunath on July 26, 2007    <- Think you're old yet?

// Since we want to keep our activate scripts organized, we'll preface them
// all with "ac_". Since script resource names can only be 16 characters,
// if we have an item tag that is > 13 characters we'll have to truncate it.
string GetActivateScript(string sItemTag)
{
    if(GetStringLength(sItemTag) > 13)
        sItemTag = GetStringLeft(sItemTag, 13);
    sItemTag = GetStringLowerCase(sItemTag);

    return sItemTag;
}

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
    // Naiatis -- YOU'RE BOTH GAY
    // Tweek -- putting an end to this madness.
    ExecuteScript(GetActivateScript(sItemTag), OBJECT_SELF);
    else if(sItemTag == "scavenger" || sItemTag == "ExtraScavenger")
    {
        ExecuteScript("use_scavenger", oPC);
        return;
    }
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
