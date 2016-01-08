//::///////////////////////////////////////////////
//:: FileName pchighintandwis
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 4/20/2007 7:42:32 PM
//:://////////////////////////////////////////////
int StartingConditional()
{
    if(!(GetAbilityScore(GetPCSpeaker(), ABILITY_INTELLIGENCE) > 19))
        return FALSE;
    if(!(GetAbilityScore(GetPCSpeaker(), ABILITY_WISDOM) > 19))
        return FALSE;

    return TRUE;
}
