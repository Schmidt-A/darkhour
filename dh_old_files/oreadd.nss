void main()
{
object oPC = GetPCSpeaker();
int iIron = 0;
int iMith = 0;
int iAdam = 0;
object oMiner;
if((GetItemPossessedBy(oPC, "professionminerh") == OBJECT_INVALID) && (GetItemPossessedBy(oPC, "profminerl") == OBJECT_INVALID))
    {
    SendMessageToPC(oPC, "You are not a miner, and cannot use this feature.");
    return;
    }
    else
        {
        if(GetItemPossessedBy(oPC, "professionminerh") != OBJECT_INVALID)
            {
            oMiner = GetItemPossessedBy(oPC, "professionminerh");
            }
        else
            {
            oMiner = GetItemPossessedBy(oPC, "profminerl");
            }
        }
int iIrontotal = GetLocalInt(oMiner, "irontotal");
int iMithtotal = GetLocalInt(oMiner, "mithtotal");
int iAdamtotal = GetLocalInt(oMiner, "adamtotal");
object oItem = GetFirstItemInInventory(oPC);
string sTag = GetTag(oItem);
while(GetIsObjectValid(oItem))
    {
    if(sTag == "ore_iron")
        {
        iIron += 1;
        DestroyObject(oItem);
        }
    else if(sTag == "ore_mith")
        {
        iMith += 1;
        DestroyObject(oItem);
        }
    else if(sTag == "ore_adam")
        {
        iAdam += 1;
        DestroyObject(oItem);
        }
    oItem = GetNextItemInInventory(oPC);
    sTag = GetTag(oItem);
    }
SetLocalInt(oMiner, "irontotal", iIron + iIrontotal);
SetLocalInt(oMiner, "mithtotal", iMith + iMithtotal);
SetLocalInt(oMiner, "adamtotal", iAdam + iAdamtotal);
iIrontotal = GetLocalInt(oMiner, "irontotal");
iMithtotal = GetLocalInt(oMiner, "mithtotal");
iAdamtotal = GetLocalInt(oMiner, "adamtotal");
DelayCommand(1.5, SendMessageToPC(oPC, "You now have an iron total of: " + IntToString(iIrontotal)));
DelayCommand(1.6, SendMessageToPC(oPC, "You now have a mithral total of: " + IntToString(iMithtotal)));
DelayCommand(1.7, SendMessageToPC(oPC, "You now have an adamantine total of: " + IntToString(iAdamtotal)));
}
