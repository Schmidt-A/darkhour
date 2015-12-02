int StartingConditional()
{
//object oSanta = OBJECT_SELF;
object oPC = GetPCSpeaker();
string sName = GetPCPlayerName(oPC);
int nPoints = GetLocalInt(oPC, sName);
    int iResult;

    iResult = (nPoints >=6 && nPoints <= 12);
    return iResult;
}
