int StartingConditional()
{
if (GetLocalInt(GetModule(), "target1placed") == 0) return FALSE;

return TRUE;
}
