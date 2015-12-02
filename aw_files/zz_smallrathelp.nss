//The rat calls its friends!

void main()
{
if (GetLocalInt(OBJECT_SELF, "NoHelp") != TRUE) //Only 1 helper per round
{
object oAttacker = GetLastAttacker();
SpeakString("Squeak!!");
AssignCommand(OBJECT_SELF, ActionMoveAwayFromObject(oAttacker, TRUE));
location lAttacker = GetLocation(oAttacker);
CreateObject(OBJECT_TYPE_CREATURE, "brotherrat", lAttacker, TRUE);
SetLocalInt(OBJECT_SELF, "NoHelp", TRUE);
DelayCommand(RoundsToSeconds(1), DeleteLocalInt(OBJECT_SELF, "NoHelp"));
DelayCommand(RoundsToSeconds(1), AssignCommand(OBJECT_SELF, ActionRandomWalk() ) );
}
}
