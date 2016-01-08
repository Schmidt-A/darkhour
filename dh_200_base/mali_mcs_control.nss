void main()
{
   location lOrb = GetLocation(GetNearestObjectByTag("MCS_ORB"));

   object oPC = GetLastUsedBy();
   AssignCommand(oPC, JumpToLocation(lOrb));
   AssignCommand(oPC, ActionStartConversation(oPC, "mali_mcs", TRUE, FALSE));
}
