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
iTotal = GetLocalInt(oMiner, "irontotal") - 40;
SetLocalInt(oMiner, "irontotal", iTotal);
CreateItemOnObject("arhe002", oPC);
}
