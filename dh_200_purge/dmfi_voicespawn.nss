void main()
{
ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(EffectEthereal()),OBJECT_SELF);
effect eGhost = EffectCutsceneGhost();
eGhost = SupernaturalEffect(eGhost);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, eGhost, OBJECT_SELF);
}
