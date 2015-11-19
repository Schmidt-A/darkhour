int StartingConditional()
{
object oCheck = GetObjectByTag("DHDM_G_1");
if(oCheck != OBJECT_INVALID)
    {
    return TRUE;
    }
return FALSE;
}
