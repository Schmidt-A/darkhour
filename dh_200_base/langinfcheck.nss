int StartingConditional()
{
object oPC = GetPCSpeaker();

if (GetItemPossessedBy(oPC, "hlslang_12") == OBJECT_INVALID) return TRUE;

return FALSE;
}
