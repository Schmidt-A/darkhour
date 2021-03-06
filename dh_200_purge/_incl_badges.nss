#include "_incl_xp"
#include "_incl_pc_data"
#include "nwnx_odbc"
#include "x3_inc_string"
#include "x0_i0_stringlib"

void RefreshBadges(object oPC);

string GetBadgeTagsFromDB(object oPC)
{
    //Get their DB char id
    string sCharId = PCDCharID(oPC);
    string sBadgeList = "";

    //Get all badges that the pc has
    SQLExecDirect("SELECT tag FROM badge_table WHERE badge_id = " +
        "(SELECT badge_id FROM char_badge_many WHERE char_id = " + sCharId + ");");

    while(SQLFetch() == SQL_SUCCESS)
    {
        string sTag = SQLGetData(1);
        sBadgeList = sBadgeList + " " + sTag;
    }

    return sBadgeList;
}


string GetBadgeEntriesFromDB(object oPC)
{
    //GET CHARACTER ID FROM oPC
    string sCharId;
    string sCharId = PCDCharID(oPC);

    //Get all badges that the pc has
    SQLExecDirect("SELECT entry FROM badge_table WHERE badge_id = " +
        "(SELECT badge_id FROM char_badge_many WHERE char_id = " + sCharId + ");");
    while(SQLFetch() == SQL_SUCCESS)
    {
        string sEntry = SQLGetData(1);
        string sBadgeList = sBadgeList + " " + sEntry;
    }

    return sBadgeList;
}

void AddBadgeToDB(string sBadgeTag, object oPC, int bHasXP)
{
    string sHasXP;
    if (bHasXP)
    {
        sHasXP = "TRUE";
    }
    else
    {
        sHasXP = "FALSE";
    }

    string sCharId = PCDCharID(oPC);

    SQLExecDirect("INSERT INTO char_badge_many (char_id, badge_id, has_xp) " +
        "VALUES (" + sCharId +
            "(SELECT id FROM badge_table WHERE tag = " + sBadgeTag + ")" +
        sHasXP + ");");

    if (SQLFetch() == SQL_FAILURE)
    {
        //LOG IT
    }
}

void HasBadge(string sBadgeTag, object oPC)
{
    string sBadgeList = PCDBadgeList(oPC);

    //If it's an empty string like this, that means they don't have the local int
    //If so, we should refresh their badgelist
    if (sBadgeList == "")
    {
        RefreshBadges(oPC);
    }

    if (StringParse(sBadgeTag, " "))
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }

}


void AddBadgeJournal(string sBadgeTag, object oPC)
{
    //Strategy one
    //Each badge is a separate tag, allowing each badge to collapse,
    //  Takes up lots of space in the main journal
    AddJournalQuestEntry(sBadgeTag, 1, oPC, FALSE);


    //Strategy two
    //Each badge is an entry within the BADGE category
    //  Takes up less space in the main journal
    //  Harder to scroll through the badge list
    /*

    AddJournalQuestEntry("BADGE", sEntry, oPC, FALSE);
    */
}

void AddBadge(string sBadgeTag, object oPC, string sBadgeName, int iExp)
{
    //should it check has badge in here?
    // TODO: Probably

    FloatingTextStringOnCreature("You receieved a new badge, " + sBadgeName + "!", oPC, FALSE);
    GiveXPToCreatureDH(oPC, iExp, "XP_BADGE");

    AddBadgeJournal(sBadgeTag, oPC);
    AddBadgeToDB(sBadgeTag, oPC, TRUE);

    //Add to their local string
    PCDAddBadge(oPC, sBadgeTag);
}

void AddCustomBadge(object oPC, int iExp, string sName)
{
    FloatingTextStringOnCreature("You receieved a new badge, " + sBadgeName + "!", oPC, FALSE);
    GiveXPToCreatureDH(oPC, iExp, "XP_BADGE");

    //Maybe we shouldn't care about that custom shit, we just wanna let them award exp
    //AddBadgeToDB(sName, oPC, TRUE, TRUE);
}

void RefreshBadges(object oPC)
{
    string sBadgeList = GetBadgeTagsFromDB(oPC);

    //This adds a placeholder to their local string
    //
    if (sBadgeList == "")
    {
        //Should the placeholder value be different?
        sBadgeList = " ";
    }
    else
    {
        struct sStringTokenizer sBadgeTokens = GetStringTokenizer(sBadgeList, " ");
        while (HasMoreTokens(sBadgeTokens))
        {
            string sTag = GetNextToken(sBadgeTokens);
            AddBadgeJournal(sTag, oPC);

            sBadgeTokens = AdvanceToNextToken(sBadgeTokens);
        }
    }
    PCDSetBadgeList(oPC, sBadgeList);
}

