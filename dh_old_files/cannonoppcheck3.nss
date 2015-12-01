int StartingConditional()
{
if (GetLocalInt(GetModule(), "cannon3placed") == 0) return FALSE;

return TRUE;
}
