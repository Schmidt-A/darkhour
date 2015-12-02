void main()
{
object oPC = GetPCSpeaker();
 SetLocalInt(oPC, "nModify",2);
 OpenInventory(oPC,oPC);
}
