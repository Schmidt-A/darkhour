void main()
{
object oPC = GetPCSpeaker();
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
SendMessageToPC(oPC, "You now have an iron total of: " + IntToString(iIrontotal));
SendMessageToPC(oPC, "You now have a mithral total of: " + IntToString(iMithtotal));
SendMessageToPC(oPC, "You now have an adamantine total of: " + IntToString(iAdamtotal));
}
