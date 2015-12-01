int StartingConditional()
{
object oCheck = GetObjectByTag("dm_spawner_easy");
if(oCheck == OBJECT_INVALID)
    {
    return TRUE;
    }
return FALSE;
}
