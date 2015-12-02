void main()
{
object oPC = GetPCSpeaker();
SetLocalInt(oPC, "nModify",0);
OpenInventory(oPC,oPC);
}
