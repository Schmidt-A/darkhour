void main()
{
object oPC = GetPCSpeaker();
object oTarget = GetWaypointByTag("telestone_trade");
location lLocation = GetLocation(oTarget);
DelayCommand(2.0, AssignCommand(oPC, ActionJumpToLocation(lLocation)));
ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_UNSUMMON), GetLocation(oPC));
}
