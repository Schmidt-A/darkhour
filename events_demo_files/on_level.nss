#include "_incl_bard"
#include "nwnx_funcs"

void main()
{
    // Tweek TODO: Put most of this in _incl_bard
    object oPC = GetPCLevellingUp();
    object oBardToken = GetItemPossessedBy(oPC, "bard_boosts");
    int iLastBardLevels = GetLocalInt(oBardToken, "iBardLevel");
    int iBardLevels = GetLevelByClass(CLASS_TYPE_BARD, oPC);

    // Not a bard level, don't care
    // TODO: Need to call refactored include function if it IS rather than isn't a bard level
    if(iBardLevels < 1 || iBardLevels == iLastBardLevels)
    {
        SendMessageToPC(oPC, "Wasn't a bard level");
        return;
    }

    // New multiclass bard
    if(iLastBardLevels == 0 && iBardLevels == 1)
        oBardToken = CreateItemOnObject("bard_boosts", oPC);

    SetLocalInt(oBardToken, "iBardLevel", iBardLevels);
    SendMessageToPC(oPC, "New bard levels: " + IntToString(GetLocalInt(oBardToken, "iBardLevel")));
    if(iBardLevels == 3 || iBardLevels == 6 ||
       (iLastBardLevels == 0 && iBardLevels == 1))
    {
        SetLocalInt(oBardToken, "iMaxBoosts",
                    GetLocalInt(oBardToken, "iMaxBoosts")+1);
        SendMessageToPC(oPC, "Max boosts: " +
                    IntToString(GetLocalInt(oBardToken, "iMaxBoosts")));
    }

    // TODO: probably need a way to provide this later if they increase their cha
    if(iBardLevels == 2 && GetAbilityScore(oPC, ABILITY_CHARISMA, TRUE) >= 14)
    {
        AddKnownFeat(oPC, FEAT_CURSE_SONG, 2);
        AddKnownFeat(oPC, FEAT_EXTRA_MUSIC, 2);
    }


    int iSkillBoosted = GetLocalInt(oBardToken, "iSkillID");
    int iSkillPoints = GetPCSkillPoints(oPC);
    SendMessageToPC(oPC, "iSkillID = " + IntToString(iSkillBoosted));
    if(iSkillBoosted && iSkillPoints > 0)
    {
        int iOldSkill = GetSkillRank(iSkillBoosted, oPC, TRUE);
        ModifySkillRank(oPC, iSkillBoosted, 1);
        SetPCSkillPoints(oPC, iSkillPoints-1);
        SendMessageToPC(oPC, IntToString(iSkillBoosted) + " increased from " + IntToString(iOldSkill) + " to " + IntToString(GetSkillRank(iSkillBoosted, oPC, TRUE)));
    }

    SetBardBoosts(oPC, oBardToken);

    if(iBardLevels == 4 || iBardLevels == 8)
    {
        SetLocalString(oPC, "sConvScript", "conv_bardskills");
        AssignCommand(oPC, ActionStartConversation(oPC, "bard_skills", FALSE));
    }
}
