int StartingConditional()
{
object oPC = GetPCSpeaker();

if (GetItemPossessedBy(oPC, "hlslang_7") == OBJECT_INVALID) return TRUE;

return FALSE;
}
