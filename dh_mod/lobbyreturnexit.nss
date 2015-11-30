void main()
{
object oPC = GetLastUsedBy();
AssignCommand(oPC,ClearAllActions());
DelayCommand(0.4f,AssignCommand(oPC,ActionJumpToLocation(GetLocalLocation(oPC,"ReturnToRestSpot"))));
}
