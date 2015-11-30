int StartingConditional()
{
object oPC = GetPCSpeaker();

if (GetLocalInt(oPC, "deflangs") == 1) return FALSE;
if (GetLocalInt(oPC, "langamount") > 0) return TRUE;

return TRUE;
}
