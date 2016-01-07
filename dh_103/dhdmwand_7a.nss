int StartingConditional()
{
object oCheck = GetObjectByTag("dm_spawner_sira");
if(oCheck == OBJECT_INVALID)
    {
    return TRUE;
    }
return FALSE;
}
