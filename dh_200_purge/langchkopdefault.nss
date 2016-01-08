int StartingConditional()
{
object oPC = GetPCSpeaker();

if (GetLocalInt(oPC, "deflangs") == 1) return TRUE;
if (GetLocalInt(oPC, "langamount") > 0) return FALSE;

return FALSE;
}
