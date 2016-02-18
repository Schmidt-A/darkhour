/* Written as an interface to deal with the data made persistent on a
 * character's PC Token item. There are a few things that are duplicated
 * but they make using the interface a lot more coherent. */

#include "x3_inc_string"
#include "x0_i0_stringlib"
#include "colors_inc"
#include "nwnx_funcs"

string TOKEN_VAR = "oPCToken";
string TOKEN_TAG = "token_pc";

// ----------------- Private Functions ----------------------
void SetIntValue(object oPC, string sField, int iValue)
{
    object oPCToken = GetLocalObject(oPC, TOKEN_VAR);

    SetLocalInt(oPCToken, sField, iValue);

    SetLocalObject(oPC, TOKEN_VAR, oPCToken);
}

void UpdateIntValue(object oPC, string sField, int iAmount)
{
    object oPCToken = GetLocalObject(oPC, TOKEN_VAR);
    int iLocalInt = GetLocalInt(oPCToken, sField);

    SetLocalInt(oPCToken, sField, iLocalInt + iAmount);

    SetLocalObject(oPC, TOKEN_VAR, oPCToken);
}

int GetIntValue(object oPC, string sField)
{
    object oPCToken = GetLocalObject(oPC, TOKEN_VAR);
    return GetLocalInt(oPCToken, sField);
}

void SetStringValue(object oPC, string sField, string sValue)
{
    object oPCToken = GetLocalObject(oPC, TOKEN_VAR);

    SetLocalString(oPCToken, sField, sValue);

    SetLocalObject(oPC, TOKEN_VAR, oPCToken);
}

void UpdateStringValue(object oPC, string sField, string sValue, string sDelim = " ")
{
    object oPCToken = GetLocalObject(oPC, TOKEN_VAR);
    string sLastString = GetLocalString(oPCToken, sField);

    if(sLastString != "")
        SetLocalString(oPCToken, sField, sLastString + sDelim + sValue);
    else
        SetLocalString(oPCToken, sField, sValue);

    SetLocalObject(oPC, TOKEN_VAR, oPCToken);
}

string GetStringValue(object oPC, string sField)
{
    object oPCToken = GetLocalObject(oPC, TOKEN_VAR);
    return GetLocalString(oPCToken, sField);
}

void SetObjectValue(object oPC, string sField, object oTag)
{
    object oPCToken = GetLocalObject(oPC, TOKEN_VAR);

    SetLocalObject(oPCToken, sField, oTag);

    SetLocalObject(oPC, TOKEN_VAR, oPCToken);
}

object GetObjectValue(object oPC, string sField)
{
    object oPCToken = GetLocalObject(oPC, TOKEN_VAR);
    return GetLocalObject(oPCToken, sField);
}

string GetFirstName(object oPC)
{
    /* I couldn't seem to get the string tokenizer to work so
     * I'm doing it in this weird way. */
    string sName;
    string sFullName = GetName(oPC);
    int iSpace       = FindSubString(sFullName, " ");

    // No space in their name - first name is their whole name
    if(iSpace < 0)
        sName = sFullName;
    else
        sName = GetStringLeft(sFullName, iSpace);

    return sName;
}

void InitializeFlag(object oPC, string sField, int bFlag=TRUE)
{
    object oPCToken = GetLocalObject(oPC, TOKEN_VAR);
    SetLocalInt(oPCToken, sField, bFlag);
    SetLocalObject(oPC, TOKEN_VAR, oPCToken);
}


// ----------------- Core Functions ---------------------------
void PCDSetupNewToken(object oPC)
{
    object oPCToken = CreateItemOnObject(TOKEN_TAG, oPC);

    // TODO: Put subrace stuff here
    // What other data should we set up here?
    SetLocalString(oPCToken, "sName", GetFirstName(oPC));
    SetLocalFloat(oPCToken, "fSatisfaction", 100.0);
    SetLocalInt(oPCToken, "bDead", FALSE);

    SetLocalObject(oPC, TOKEN_VAR, oPCToken);
}

void PCDCacheToken(object oPC)
{
    SetLocalObject(oPC, TOKEN_VAR, GetItemPossessedBy(oPC, TOKEN_TAG));
}

void PCDDebugOutput(object oPC)
{
    object oPCToken = GetLocalObject(oPC, TOKEN_VAR);
    SendMessageToPC(oPC, DumpLocalVariables(oPCToken));
}

int PCDHasToken(object oPC)
{
    object oPCToken = GetLocalObject(oPC, TOKEN_VAR);
    if (oPCToken == OBJECT_INVALID)
        return FALSE;
    return TRUE;
}


// ----------------- PC Data Retrival Functions ---------------

int PCDIsDead(object oPC)
{
    object oPCToken = GetLocalObject(oPC, TOKEN_VAR);

    if(GetLocalInt(oPCToken, "bDead"))
        return TRUE;
    return FALSE;
}

int PCDIsDiseased(object oPC)
{
    object oPCToken = GetLocalObject(oPC, TOKEN_VAR);

    if(GetLocalInt(oPCToken, "iDisease") > 0)
        return TRUE;
    return FALSE;
}

int PCDGetDiseaseValue(object oPC)
{
    return GetIntValue(oPC, "iDisease");
}

int PCDCheckFlag(object oPC, string sField)
{
    object oPCToken = GetLocalObject(oPC, TOKEN_VAR);
    return GetLocalInt(oPCToken, sField);
}

string PCDGetFirstName(object oPC)
{
    return GetStringValue(oPC, "sName");
}

int PCDGetZombieKills(object oPC)
{
    return GetIntValue(oPC, "iZombieKills");
}

int PCDGetSurvivalTimes(object oPC)
{
    return GetIntValue(oPC, "iSurvivalTimes");
}

int PCDGetFrenzyKills(object oPC)
{
    return GetIntValue(oPC, "iFrenzyKills");
}

int PCDGetUsedOneChance(object oPC)
{
    return GetIntValue(oPC, "bOneChance");
}

int PCDIsZombied(object oPC)
{
    return GetIntValue(oPC, "bZombied");
}

string PCDCharID(object oPC)
{
    return GetStringValue(oPC, "char_id");
}

string PCDBadgeList(object oPC)
{
    return GetStringValue(oPC, "sBadgeList");
}

int PCDGetArtifactCount(object oPC)
{
    return GetIntValue(oPC, "iArtifacts");
}

int PCDGetVersion(object oPC)
{
    return GetIntValue(oPC, "iVersion");
}

string PCDGetFaction(object oPC)
{
    return GetStringValue(oPC, "sFaction");
}

// ----------------- PC Data Setter Functions ---------------
void PCDAddZombieKill(object oPC, int iKills=1)
{
    UpdateIntValue(oPC, "iZombieKills", iKills);
}

void PCDAddFrenzyKill(object oPC, int iFrenzyKills=1)
{
    UpdateIntValue(oPC, "iFrenzyKills", iFrenzyKills);
}

void PCDAddSurvivalTime(object oPC, int iSurvivalTimes=1)
{
    UpdateIntValue(oPC, "iSurvivalTimes", iSurvivalTimes);
}

void PCDAddArtifact(object oPC)
{
    UpdateIntValue(oPC, "iArtifacts", 1);
}

void PCDAddBadge(object oPC, string sBadgeTag)
{
    UpdateStringValue(oPC, "sBadgeList", sBadgeTag);
}

void PCDSetBadgeList(object oPC, string sNewList)
{
    SetStringValue(oPC, "sBadgeList", sNewList);
}

void PCDSetDiseaseValue(object oPC, int iAmount)
{
    SetIntValue(oPC, "iDisease", iAmount);
}

void PCDSetZombied(object oPC)
{
    SetIntValue(oPC, "bZombied", TRUE);
}

void PCDSetUnZombied(object oPC)
{
    SetIntValue(oPC, "bZombied", FALSE);
}

void PCDSetDead(object oPC)
{
    SetIntValue(oPC, "bDead", TRUE);
}

void PCDSetAlive(object oPC)
{
    SetIntValue(oPC, "bDead", FALSE);
}

void PCDSetUsedOneChance(object oPC)
{
    SetIntValue(oPC, "bOneChance", TRUE);
}

void PCDSetVersion(object oPC, int iVersion)
{
    SetIntValue(oPC, "iVersion", iVersion);
}

void PCDSetFaction(object oPC, string sFaction)
{
    SetStringValue(oPC, "sFaction", sFaction);
}

// ----------------- Profession Data Functions ----------------

string PCDGetProfession(object oPC)
{
    GetStringValue(oPC, "sProfession");
}

void PCDSetProfession(object oPC, string sProfession)
{
    SetStringValue(oPC, "sProfession", sProfession);
}

int PCDGetProfessionLevel(object oPC)
{
    GetIntValue(oPC, "iProfessionLevel");
}

void PCDSetProfessionLevel(object oPC, int iProfessionLevel)
{
    SetIntValue(oPC, "iProfessionLevel", iProfessionLevel);
}


// ----------------- Bard Data Functions ----------------------

string BOOST_SPEED      = "bBardSpeed";
string BOOST_BOTH       = "bBardBoth";
string BOOST_OFFENSE    = "bBardOffense";
string BOOST_DEFENSE    = "bBardDefense";
string BOOST_HEAL       = "bBardHeal";
string BOOST_SKILLS     = "bBardSkills";
string BOOST_CURSE      = "bBardCurse";
string BOOST_LINGERING  = "bBardLingering";

void PCDBardAddMaxBoosts(object oPC, int iAmount)
{
    UpdateIntValue(oPC, "iMaxBoosts", iAmount);
}

void PCDBardAddLevel(object oPC)
{
    UpdateIntValue(oPC, "iBardLevel", GetLevelByClass(CLASS_TYPE_BARD, oPC));
}

void PCDBardSetupBoost(object oPC, string sBoost)
{
    object oPCToken = GetLocalObject(oPC, TOKEN_VAR);

    int iActiveBoosts = GetLocalInt(oPCToken, "iBoosts");
    int iMaxBoosts = GetLocalInt(oPCToken, "iMaxBoosts");

    if(iActiveBoosts < iMaxBoosts)
    {
        SetLocalInt(oPCToken, sBoost, TRUE);
        SetLocalInt(oPCToken, "iBoosts", iActiveBoosts+1);
    }

    SetLocalObject(oPC, TOKEN_VAR, oPCToken);
}

int PCDBardGetSkillBoosted(object oPC)
{
    return GetIntValue(oPC, "iBardSkillID");
}

int PCDBardLevelChanged(object oPC, int iNewLevels)
{
    int iOldLevels = GetIntValue(oPC, "iBardLevel");
    if(iNewLevels > iOldLevels)
        return TRUE;
    return FALSE;
}

void PCDBardSetInitialized(object oPC)
{
    InitializeFlag(oPC, "bBardInitialized");
    UpdateIntValue(oPC, "bBardLevel", GetLevelByClass(CLASS_TYPE_BARD, oPC));
}

void PCDBardSetSkillBoosted(object oPC, int iSkillID)
{
    SetIntValue(oPC, "iBardSkillID", iSkillID);
}

// -------------- On Use Functions -----------------------

string DiseaseString(object oPC)
{
    int iDisease = PCDGetDiseaseValue(oPC);
    string sMsg  = ColorTokenBlue() + "No trace</c>";

    if(iDisease > 0 && iDisease <= 3)
        sMsg = ColorTokenYellow() + "Afflicted</c>";
    else if(iDisease > 3 && iDisease <= 6)
        sMsg = ColorTokenOrange() + "Seriously ill</c>";
    else if(iDisease > 6)
        sMsg = ColorTokenRed() + "Approaching the final stages</c>";

    return sMsg;
}

string BardString(object oPC)
{
    int iPerform = GetSkillRank(SKILL_PERFORM, oPC);
    string sMsg = "========== Bard Boosts ============\n";
    sMsg += "Active Boosts: " + IntToString(GetIntValue(oPC, "iMaxBoosts")) + "\n";
    if(PCDCheckFlag(oPC, BOOST_SPEED))
        sMsg += " - Allegro\n";
    if(PCDCheckFlag(oPC, BOOST_BOTH))
        sMsg += " - Duet\n";
    if(PCDCheckFlag(oPC, BOOST_OFFENSE))
        sMsg += " - Acceso\n";
    if(PCDCheckFlag(oPC, BOOST_DEFENSE))
        sMsg += " - Risoluto\n";
    if(PCDCheckFlag(oPC, BOOST_HEAL))
        sMsg += " - Vivacissimo\n";
    if(PCDCheckFlag(oPC, BOOST_SKILLS))
        sMsg += " - Delicato\n";
    if(PCDCheckFlag(oPC, BOOST_CURSE))
        sMsg += " - Morendo\n";
    if(PCDCheckFlag(oPC, BOOST_LINGERING))
        sMsg += " - Sostenuto\n";
    sMsg += "\n";

    return sMsg;
}

void PCDOnActivate(object oPC)
{
    string sSummary = ColorTokenWhite() + "========== General Stats ==========\n";
    sSummary += "Name:\t\t" + PCDGetFirstName(oPC) + "\n";
    sSummary += "Level:\t\t   " + IntToString(GetHitDice(oPC)) + "\n";
    sSummary += "Disease:\t </c>" + DiseaseString(oPC) + "\n\n";

    sSummary += ColorTokenWhite() + "Artifacts:\t" + IntToString(PCDGetArtifactCount(oPC)) + "\n";
    sSummary += "Kills:\t\t\t" + IntToString(PCDGetZombieKills(oPC)) + "\n";
    sSummary += "Frenzy Kills:\t" + IntToString(PCDGetFrenzyKills(oPC)) + "\n";
    sSummary += "Survival Time:\t" + IntToString(PCDGetSurvivalTimes(oPC)) + "\n\n";

    int iBardLevels = GetLevelByClass(CLASS_TYPE_BARD, oPC);
    if(iBardLevels > 0)
        sSummary += BardString(oPC);
    sSummary += "</c>";

    SendMessageToPC(oPC, sSummary);
}
