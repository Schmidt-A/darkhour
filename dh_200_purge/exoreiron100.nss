void main()
{
object oPC = GetPCSpeaker();
object oMiner;
int iTotal = 0;
if(GetItemPossessedBy(oPC, "professionminerh") != OBJECT_INVALID)
    {
    oMiner = GetItemPossessedBy(oPC, "professionminerh");
    }
    else
        {
        oMiner = GetItemPossessedBy(oPC, "profminerl");
        }
iTotal = GetLocalInt(oMiner, "irontotal") - 100;
SetLocalInt(oMiner, "irontotal", iTotal);
CreateItemOnObject("nw_aarcl007", oPC);
}
