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

    // This is here for now until we refactor the scavenger.
    else if(sItemTag == "scavenger" || sItemTag == "ExtraScavenger")
    {
        ExecuteScript("use_scavenger", oPC);
        return;
    }
    // forage_remedy is gone. If we're keeping that for rangers/druids, 
    // we need to think about that.
    // I also don't think the soul_banisher is every used.

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
