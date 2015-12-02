// tow_doorbash
// Scripted By: Demon X
// For: Antiworld
// This script is placed on the team doors OnDamaged event.
void main()
{
object oDoor = OBJECT_SELF;
object oPC = GetLastDamager(oDoor);
if((GetAbilityModifier(ABILITY_STRENGTH,oPC)+d20(1))>= 15)
{
AssignCommand(oDoor,ActionOpenDoor(oDoor));
DelayCommand(2.0,AssignCommand(oDoor,ActionCloseDoor(oDoor)));
FloatingTextStringOnCreature("Strength Check Passed.",oPC,FALSE);
}
else
FloatingTextStringOnCreature("Strength Check Failed.",oPC,FALSE);
}
