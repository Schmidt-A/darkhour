void main()
{
object oPlayer = GetLastOpenedBy();
string sPlayer1 = GetPCPlayerName(oPlayer);
string sPlayer2 = GetLocalString(OBJECT_SELF,"PlayerName");

if(sPlayer1 == sPlayer2)
{
object oItem = GetFirstItemInInventory(OBJECT_SELF);
while(oItem != OBJECT_INVALID)
{
AssignCommand(OBJECT_SELF,ActionGiveItem(oItem,oPlayer));
oItem = GetNextItemInInventory();
}
}
}

