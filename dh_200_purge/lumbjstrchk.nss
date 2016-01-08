int StartingConditional()
{
    if(!(GetAbilityScore(GetPCSpeaker(), ABILITY_STRENGTH) > 15))
        return FALSE;

    return TRUE;
}
