void main()
{
object oPC = GetPCSpeaker();
location lTarget = GetLocation(GetWaypointByTag("DumaExitWP"));
if(GetRacialType(oPC) == RACIAL_TYPE_DWARF)
    {
    TakeGoldFromCreature(35, oPC, TRUE);
    }
    else
        {
        TakeGoldFromCreature(50, oPC, TRUE);
        }
ClearAllActions(TRUE);
DelayCommand(1.8, AssignCommand(oPC, ClearAllActions(TRUE)));
ActionCastFakeSpellAtObject(SPELL_NATURES_BALANCE, OBJECT_SELF, PROJECTILE_PATH_TYPE_DEFAULT);
DelayCommand(1.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_NATURES_BALANCE), oPC));
DelayCommand(2.0, AssignCommand(oPC, ActionJumpToLocation(lTarget)));
}
