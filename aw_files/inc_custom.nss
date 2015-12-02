// Custom functions and features by Scott "Seira" Shepherd and Ryan "Gyr" Michaud
// The Journal is used to update players with the modules "Getting Started" Guide
// and state generic or customized server rules, news, and contact information.
// This is all up to individual DM's and server ops to customize with the journal editor.
// You will need to create entries using the name format je_title matching those shown below
// or create your own. They will be placed in order from top to bottom as the player views them.
#include "aps_include"
#include "bodypart_inc"
void MakeJournalEntry(object oPC)
{
    //object oPC = GetFirstPC();
    AddJournalQuestEntry("je_AboutServer", 1, oPC);
    AddJournalQuestEntry("je_GetStarted", 1, oPC);
    AddJournalQuestEntry("je_GetStarted2", 1, oPC);
    //AddJournalQuestEntry("je_GameInfo", 1, oPC);
    AddJournalQuestEntry("je_ServerRules", 1, oPC);
    AddJournalQuestEntry("je_pvprules", 1, oPC);
    //AddJournalQuestEntry("je_Behaviour Rules", 1, oPC);
    AddJournalQuestEntry("je_GameMasterList", 1, oPC);
    AddJournalQuestEntry("je_SpellChanges", 1, oPC);
    SendMessageToPC (oPC, "<cá&æ>Please check out your Journal!</c>");
    SendMessageToPC (oPC, "Visit us online at<cá&æ> www.antiworld.biz</c> and check out our forum!");
    if(GetIsDM(oPC) || (GetDeity(oPC) == "GM")) AddJournalQuestEntry("je_DmCode", 1, oPC);
}

void CheckItemID ()
{
    int nIdx = 0;
    object oPC = GetEnteringObject();
    object oInvItem = GetFirstItemInInventory(oPC);
    while(oInvItem != OBJECT_INVALID)
    {
        if (GetIdentified(oInvItem) == FALSE)
        {
            SetIdentified(oInvItem, TRUE);
        }
        oInvItem = GetNextItemInInventory(oPC);

    }
    oInvItem = GetItemInSlot(nIdx,oPC);
    while(oInvItem != OBJECT_INVALID)
    {
        if (GetIdentified(oInvItem) == FALSE)
        {
            SetIdentified(oInvItem, TRUE);
        }
        nIdx++;
        oInvItem = GetItemInSlot(nIdx,oPC);
    }
}
///Antiworld rule enforcing ///
string AntiworldRules(int nRule);


////////Antiworld Rules and text ////////////
string AntiworldRules(int nRule)
{
    return GetPersistentString(OBJECT_SELF,"Rule_"+IntToString(nRule),"RulesShouting");
}
//this don't edit the bic file.... so
// or we save in the db and "reapply" the none wings/tail every on enter...
//or we change so it use leto-script and boot and edit the bic
//
void RemoveWingsTailIfAny(object oPC);
void RemoveWingsTailIfAny(object oPC)
{
    //Check Wings
    int nPart = 29;
    if (GetBodyPart(oPC,nPart) != 0)
    {
        SetBodyPart(oPC,nPart,0);
    }
    int nApp = GetAppearanceType(oPC);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_IMP_HARM), oPC, 1.5);
    SetCreatureAppearanceType(oPC,APPEARANCE_TYPE_WILL_O_WISP);
    DelayCommand(1.0,SetCreatureAppearanceType(oPC,nApp));
    //Check Tail
    nPart = 28;
    if (GetBodyPart(oPC,nPart) != 0)
    {
        SetBodyPart(oPC,nPart,0);
    }
    nApp = GetAppearanceType(oPC);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_IMP_HARM), oPC, 1.5);
    SetCreatureAppearanceType(oPC,APPEARANCE_TYPE_WILL_O_WISP);
    DelayCommand(1.0,SetCreatureAppearanceType(oPC,nApp));
}

// Antiworld Persistant wings////
// check for wings/Tails ////////////
void SetPersistentWings(object oPC);

void SetPersistentWings(object oPC)
{
    int nType = GetPersistentInt(oPC,"WingsModel","Wings"); //Check Wings
    //if (nType != 0)
    //int nPart = 29;
    //int nWing = GetBodyPart(oPC,nPart);
    int nPart = 1;
    int nWing = GetCreatureWingType(oPC);
    if (nWing != nType)
    {
        //Do not reset RDD wings
        if (!((nType == 0) && (nWing == 4) && (GetLevelByClass(CLASS_TYPE_DRAGON_DISCIPLE, oPC) > 0)))
        {
            //SetBodyPart(oPC,nPart,nType);
            //int nApp = GetAppearanceType(oPC);
            //ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_FNF_STRIKE_HOLY), oPC, 1.5);
            //SetCreatureAppearanceType(oPC,APPEARANCE_TYPE_WILL_O_WISP);
            //DelayCommand(1.0,SetCreatureAppearanceType(oPC,nApp));
               SetCreatureWingType(nType, oPC);

        }
    }
    nType = GetPersistentInt(oPC,"TailModel","Wings");  //Check Tail
    //if (nType != 0)
    nPart = 28;
    if (GetBodyPart(oPC,nPart) != nType)
    {
        //SetBodyPart(oPC,nPart,nType);
        //int nApp = GetAppearanceType(oPC);
        //ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_FNF_STRIKE_HOLY), oPC, 1.5);
        //SetCreatureAppearanceType(oPC,APPEARANCE_TYPE_WILL_O_WISP);
        //DelayCommand(1.0,SetCreatureAppearanceType(oPC,nApp));
      SetCreatureTailType(nType, oPC);

    }
}




