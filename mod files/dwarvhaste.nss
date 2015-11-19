void main()
{
object oPC = GetEnteringObject();
if((GetIsPC(oPC) == TRUE) && (GetHasSpellEffect(SPELL_HASTE, oPC) == FALSE))
    {
    object oStatueOne = GetNearestObjectByTag("DwarvenSorceror");
    object oStatueTwo = GetNearestObjectByTag("DwarvenSorceror1");
    AssignCommand(oStatueOne, ActionPlayAnimation(ANIMATION_LOOPING_CONJURE2, 1.0, 1.0));
    AssignCommand(oStatueTwo, ActionPlayAnimation(ANIMATION_LOOPING_CONJURE2, 1.0, 1.0));
    DelayCommand(1.0, AssignCommand(oStatueOne, ActionCastSpellAtObject(SPELL_HASTE, oPC, METAMAGIC_NONE, TRUE, 0,  PROJECTILE_PATH_TYPE_DEFAULT, TRUE)));
    DelayCommand(1.0, AssignCommand(oStatueTwo, ActionCastSpellAtObject(SPELL_HASTE, oPC, METAMAGIC_NONE, TRUE, 0,  PROJECTILE_PATH_TYPE_DEFAULT, TRUE)));
    DelayCommand(2.0, RemoveEffect(oPC, EffectHaste()));
    DelayCommand(2.2, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectHaste(), oPC, 3600.0));
    }
}
