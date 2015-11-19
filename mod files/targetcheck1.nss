int StartingConditional()
{
if (GetLocalInt(GetModule(), "target1placed") == 0) return TRUE;

return FALSE;
}
