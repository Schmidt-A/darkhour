void main()
{
    ActionCastSpellAtObject(SPELL_LESSER_SPELL_MANTLE, OBJECT_SELF, METAMAGIC_NONE, TRUE, 0,  PROJECTILE_PATH_TYPE_DEFAULT, TRUE);
    DelayCommand(1.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDispelMagicAll(40), OBJECT_SELF));
}
