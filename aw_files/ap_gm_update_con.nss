int StartingConditional()
{
object oPC;
oPC = GetLastSpeaker();
object oObject;
oObject = GetItemPossessedBy(oPC, "banplayer");
if(GetIsObjectValid(oObject))
    {
    if(GetItemCharges(oObject) == 0)
        {
        return TRUE;
        }
    }
return FALSE;
}
