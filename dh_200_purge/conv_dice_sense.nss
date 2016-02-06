// One-off script because that dmfi_execute is hell to work with.

#include "dmfi_dmw_inc"

void main()
{
    object oPC = GetPCSpeaker();
    int iBroadcast = GetLocalInt(oPC, "dmfi_dicebag");
    int iRoll = Random(20) + 1;

    // Get the best modifier candidate. Either their "default" sense motive
    // (which is will save + wisdom mod), or their best social skill.
    int iMod = GetWillSavingThrow(oPC) + GetAbilityModifier(ABILITY_WISDOM, oPC);
    int iSkill = GetSkillRank(SKILL_BLUFF, oPC);
    if(iSkill > iMod)
        iMod = iSkill;
    iSkill = GetSkillRank(SKILL_INTIMIDATE, oPC);
    if(iSkill > iMod)
        iMod = iSkill;
    iSkill = GetSkillRank(SKILL_PERSUADE, oPC);
    if(iSkill > iMod)
        iMod = iSkill;

    int iTotal = iRoll + iMod;

    string sMsg = "Opposed Social Skill Check, Roll 1d20: " + IntToString(iRoll) +
                  " + Modifier: " + IntToString(iMod) +
                  " = Total: " + IntToString(iTotal);
    sMsg = ColorText(sMsg, "cyan");

    switch(iBroadcast)
    {
        case 1:
            // Shout channel
            AssignCommand(oPC, SpeakString(sMsg , TALKVOLUME_SHOUT));
            break;
        case 2:
            // Talk channel
            AssignCommand(oPC, SpeakString(sMsg));
            break;
        case 3:
            // DM channel
            AssignCommand(oPC, SpeakString( sMsg, TALKVOLUME_SILENT_SHOUT));
            break;
        default:
            // Private
            if (GetIsPC(oPC))
                SendMessageToPC(oPC, sMsg);
            break;
    }
}
