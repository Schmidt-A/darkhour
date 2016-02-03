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
    return "ac_" + sItemTag;
}

void main()
{
    object oPC = GetItemActivator();
    string sItemTag = GetTag(GetItemActivated());

    ExecuteScript(GetActivateScript(sItemTag), OBJECT_SELF);

    // Ideally we can get rid of this but for now we have to keep these
    // two extra cases.
    if(sItemTag == "scavenger" || sItemTag == "ExtraScavenger")
    {
        ExecuteScript("use_scavenger", oPC);
        return;
    }

    // NOT using some massive if string for this.
    string sInstruments = "ZEP_PIPES2 ZEP_TAMBOURINE2 ZEP_LUTE2 ZEP_FLUTE2 " +
                         "ZEP_HARP2 ZEP_DRUMS2";
    if(FindSubString(sInstruments, sItemTag) > -1)
    {
        string sConvo = GetSubString(sItemTag, 4, (GetStringLength(sItemTag)-5));
        sConvo = GetStringLowerCase(sConvo);
        AssignCommand(oPC, ActionStartConversation(oPC, sConvo));
        return;
    }
}
