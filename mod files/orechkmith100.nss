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
iTotal = GetLocalInt(oMiner, "mithtotal");
if (iTotal < 100) return FALSE;

return TRUE;
}

