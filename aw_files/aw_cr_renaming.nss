void main()
{
object oPC = GetPCSpeaker();
SetLocalInt(oPC, "nModify",1);
OpenInventory(oPC,oPC);
}
