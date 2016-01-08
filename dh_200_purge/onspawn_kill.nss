// This will, on creature spawn, kill it and leave a corpse that is selectable but unraiseable/undestroyable.

void main()
{ ExecuteScript( "nw_c2_default9", OBJECT_SELF);

  SetIsDestroyable( FALSE, FALSE, TRUE);
  effect eSuicide = EffectLinkEffects( EffectDeath(), EffectDamage( GetMaxHitPoints() +11, DAMAGE_TYPE_MAGICAL, DAMAGE_POWER_ENERGY));
  ApplyEffectToObject( DURATION_TYPE_INSTANT, eSuicide, OBJECT_SELF);
}

