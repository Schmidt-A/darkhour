int StartingConditional()
{
if (GetLocalInt(GetModule(), "target3placed") == 0) return FALSE;

return TRUE;
}
