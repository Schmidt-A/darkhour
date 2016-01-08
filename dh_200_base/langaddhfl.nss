void main()
{
object oPC = GetPCSpeaker();
CreateItemOnObject("hlslang_3", oPC);
int iCount = GetLocalInt(oPC, "langamount");
iCount -= 1;
SetLocalInt(oPC, "langamount", iCount);
}
