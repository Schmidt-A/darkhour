// tow_teamdoors
// Scripted By: Demon X
// For: Antiworld
// This script is placed upon the team doors OnFailToOpen event.
void main()
{
object oDoor = OBJECT_SELF;
object oPC = GetClickingObject();
int nDoorTeam = GetLocalInt(oDoor,"nTeam");
int nTeam = GetLocalInt(oPC,"nTeam");
if(nTeam == nDoorTeam)
{
AssignCommand(oDoor,ActionOpenDoor(oDoor));
DelayCommand(2.0,AssignCommand(oDoor,ActionCloseDoor(oDoor)));
}
else
{
FloatingTextStringOnCreature("You must bash this door to enter.",oPC);
}
}
