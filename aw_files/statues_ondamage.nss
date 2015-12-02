void main()
{
object oSelf = OBJECT_SELF;
object oPC = GetLastAttacker(oSelf);
effect eEffect = EffectDeath();
effect vEffect = EffectVisualEffect(VFX_FNF_GREATER_RUIN);
ActionSpeakString("You Dare Hit A God Now You Die", TALKVOLUME_TALK);
ApplyEffectToObject(DURATION_TYPE_INSTANT, vEffect, oPC);
DelayCommand(2.0, ApplyEffectToObject(DURATION_TYPE_PERMANENT,eEffect, oPC));
}
