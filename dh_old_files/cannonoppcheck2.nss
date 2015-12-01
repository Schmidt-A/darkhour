int StartingConditional()
{
if (GetLocalInt(GetModule(), "cannon2placed") == 0) return FALSE;

return TRUE;
}
