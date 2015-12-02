int StartingConditional()
{
object oPC = GetPCSpeaker();
    int iResult;

    iResult = (GetTag(GetArea(oPC)) == "jail");
    return iResult;
}
