

#include "_incl_xp"

string GetBadgesFromDB(oPC)
{
    //GET CHARACTER ID FROM oPC

    //GET ALL BADGES FROM THE DB GOES HERE
    string sBadgeList = "";

    //CONCAT EACH BADGE FROM THE DB to sBadgeList

    return sBadgeList;
}

//Strategy one
//Each badge is a separate tag, allowing each badge to collapse, but taking up lots of space in the main journal
void AddBadgeJournal(string sBadgeTag, object oPC)
{
    AddJournalQuestEntry(sBadgeTag, 1, oPC, FALSE);
}

//Strategy two
//Each badge is an entry within the BADGE category, takes up less space in the main journal, but harder to scroll through the badge list


void AddBadgeToDB(string sBadgeTag, object oPC, int bHasXP, int bCustom)
{
    //Add the badge to the DB
}

void AddBadge(string sBadgeTag, object oPC, string sBadgeName, int iExp)
{   
    FloatingTextStringOnCreature("You receieved a new badge, " + sBadgeName + "!", oPC, FALSE);
    GiveXPToCreatureDH(oPC, iExp, "XP_BADGE");

    AddBadgeJournal(sBadgeTag, oPC);

    AddBadgeToDB(sBadgeTag, oPC, TRUE, FALSE);
}

void AddCustomBadge(object oPC, int iExp, string sName)
{
    FloatingTextStringOnCreature("You receieved a new badge, " + sBadgeName + "!", oPC, FALSE);
    GiveXPToCreatureDH(oPC, iExp, "XP_BADGE");

    AddBadgeToDB(sName, oPC, TRUE, TRUE);
}

void RefreshBadgeJournal(object oPC)
{
    string sBadgeList = GetBadgesFromDB(oPC);
    //for badge in sBadgeList, space delineated
        string sBadgeTag;
        //sBadgeTag = the result

        AddBadgeJournal(sBadgeTag, oPC);
        //

    //
}

