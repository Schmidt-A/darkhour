int StartingConditional()
{
object oPC = GetPCSpeaker();

if (GetItemPossessedBy(oPC, "hlslang_10") == OBJECT_INVALID) return TRUE;

return FALSE;
}
