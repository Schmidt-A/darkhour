int StartingConditional()
{
object oPC = GetPCSpeaker();

if (GetItemPossessedBy(oPC, "professioncarp") == OBJECT_INVALID) return FALSE;

return TRUE;
}
