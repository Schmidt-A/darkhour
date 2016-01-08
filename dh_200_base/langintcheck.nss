int StartingConditional()
{
object oPC = GetPCSpeaker();

if (GetLocalInt(oPC, "langamount") > 0) return FALSE;

return TRUE;
}
