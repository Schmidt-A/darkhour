void main()
{
object oPC = GetLastUsedBy();
location lPort = GetLocalLocation(OBJECT_SELF,"PORTAL");
AssignCommand(oPC,ClearAllActions(TRUE));
DelayCommand(0.5f,AssignCommand(oPC,ActionJumpToLocation(lPort)));
}
