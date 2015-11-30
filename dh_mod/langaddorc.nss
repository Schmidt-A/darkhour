void main()
{
object oPC = GetPCSpeaker();
CreateItemOnObject("hlslang_5", oPC);
int iCount = GetLocalInt(oPC, "langamount");
iCount -= 1;
SetLocalInt(oPC, "langamount", iCount);
}
