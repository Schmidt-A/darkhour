/*
 Some notes as we proceed:
    - forage_remedy is gone. If we're keeping that for rangers/druids, 
    we need to think about that.
    - I also don't think the soul_banisher is every used. Removed.

 Tweek 2016 - massively refactored this.
*/


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
    object oPC = GetItemActivator();
    string sItemTag = GetTag(GetItemActivated());

    ExecuteScript(GetActivateScript(sItemTag), OBJECT_SELF);

    // This is here for now until we refactor the scavenger.
    if(sItemTag == "scavenger" || sItemTag == "ExtraScavenger")
    {
        ExecuteScript("use_scavenger", oPC);
        return;
    }

    // NOT using some massive switch statement or if string for this.
    string sInstruments = "ZEP_PIPES2 ZEP_TAMBOURINE2 ZEP_LUTE2 ZEP_FLUTE2 " +
                         "ZEP_HARP2 ZEP_DRUMS2";
    if(FindSubstring(sInstruments, sItemTag) > -1)
    {
        string sConvo = GetSubstring(sItemTag, 4, GetStringLength(sItemTag)-5);
        sConvo = GetStringLowerCase(sConvo);
        AssignCommand(oPC, ActionStartConversation(oPC, sConvo));
        return;
    }

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
