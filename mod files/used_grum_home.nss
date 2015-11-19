void main()
{
object oPC = GetLastUsedBy();
if(GetLocked(OBJECT_SELF) == FALSE)
    {
    AssignCommand(oPC, ClearAllActions(TRUE));
    object oDestination = GetObjectByTag("Grum_Entrance_WP");
    location lLocation = GetLocation(oDestination);
    AssignCommand(oPC, JumpToLocation(lLocation));
    DelayCommand(5.0, SetLocked(OBJECT_SELF, TRUE));
    }
}
