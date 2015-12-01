int StartingConditional()
{
object oPC = GetPCSpeaker();
int iTotal = 0;
object oMiner;
if(GetItemPossessedBy(oPC, "professionminerh") != OBJECT_INVALID)
    {
    oMiner = GetItemPossessedBy(oPC, "professionminerh");
    }
    else
        {
        oMiner = GetItemPossessedBy(oPC, "profminerl");
        }
iTotal = GetLocalInt(oMiner, "irontotal");
if (iTotal < 40) return FALSE;

return TRUE;
}

