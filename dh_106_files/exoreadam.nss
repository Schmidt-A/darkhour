void main()
{
object oPC = GetPCSpeaker();
int iTotal = 0;
object oItem = GetFirstItemInInventory(oPC);
string sTag = GetTag(oItem);
object oMiner;
if(GetItemPossessedBy(oPC, "professionminerh") != OBJECT_INVALID)
    {
    oMiner = GetItemPossessedBy(oPC, "professionminerh");
    }
    else
        {
        oMiner = GetItemPossessedBy(oPC, "profminerl");
        }
iTotal = GetLocalInt(oMiner, "adamtotal");
if(iTotal > 0)
    {
    GiveGoldToCreature(oPC, iTotal * 25);
    }
SetLocalInt(oMiner, "adamtotal", 0);
}
