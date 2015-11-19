void main()
{
object oPC = GetLastUsedBy();
object oDestination = GetObjectByTag("SewerExit1");
location lLocation = GetLocation(oDestination);
int iRoll = d20(1);
int iStrength = GetAbilityScore(oPC, ABILITY_STRENGTH);
int iTotal = iRoll + iStrength;
int iFire = GetLocalInt(OBJECT_SELF, "hasfired");
if(iFire != 5)
    {
    SendMessageToPC(oPC, GetName(oPC) + ": Strength Check; " + IntToString(iRoll) + " + " + IntToString(iStrength) + " = " + IntToString(iTotal) + " vs DC:30");
    if(iTotal >= 30)
        {
        SetLocalInt(OBJECT_SELF, "hasfired", 5);
        FloatingTextStringOnCreature("The grate has been lifted from place.", oPC);
        AssignCommand(oPC, JumpToLocation(lLocation));
        }else
            {
            FloatingTextStringOnCreature("You have failed to dislodge the grate.", oPC);
            }
    }else
        {
        AssignCommand(oPC, JumpToLocation(lLocation));
        }
}
