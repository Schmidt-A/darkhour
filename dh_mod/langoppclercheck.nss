int StartingConditional()
{
object oPC = GetPCSpeaker();

if((GetLevelByClass(CLASS_TYPE_CLERIC, oPC) > 0) && GetAbilityModifier(ABILITY_INTELLIGENCE, oPC) > 0) return FALSE;

return TRUE;
}
