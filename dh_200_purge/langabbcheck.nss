int StartingConditional()
{
object oPC = GetPCSpeaker();

if (GetItemPossessedBy(oPC, "hlslang_11") == OBJECT_INVALID) return TRUE;

return FALSE;
}
