int StartingConditional()
{
object oCheck = GetObjectByTag("DHDM_B_1");
if(oCheck != OBJECT_INVALID)
    {
    return TRUE;
    }
return FALSE;
}
