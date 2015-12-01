int StartingConditional()
{
if (GetLocalInt(GetModule(), "target2placed") == 0) return FALSE;

return TRUE;
}
