int StartingConditional()
{
if (GetLocalInt(GetModule(), "cannon1placed") == 0) return FALSE;

return TRUE;
}
