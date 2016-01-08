#include "_incl_subrace"
void main()
{
    object oPC = GetItemActivator();
    object oItem = GetItemActivated();
    string sRace = GetStringLowerCase(GetSubRace(oPC));
    string sLA = IntToString(GetLA(sRace));
    string sECL = IntToString(GetLocalInt(oItem, "iECL"));
    string sXPNeeded = IntToString(GetLocalInt(oItem, "iXPNeeded"));
    string sCumulative = IntToString(GetLocalInt(oItem, "iCumulativeXP"));

    SendMessageToPC(oPC, "You currently have " + sCumulative + " XP. Because your ECL is " + sECL + ", you need to reach " + sXPNeeded + " XP to level up.");
}
