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
iTotal = GetLocalInt(oMiner, "adamtotal") - 100;
SetLocalInt(oMiner, "adamtotal", iTotal);
CreateItemOnObject("x2_it_adaplate", oPC);
}
