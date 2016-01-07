void main()
{
    object oTarget = GetNearestObjectByTag("TrapCrystal5");
    ActionCastSpellAtObject(SPELL_PHANTASMAL_KILLER, oTarget, METAMAGIC_NONE, TRUE, 0,  PROJECTILE_PATH_TYPE_DEFAULT, TRUE);
}
