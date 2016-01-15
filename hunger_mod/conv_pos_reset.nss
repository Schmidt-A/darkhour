#include "_incl_conv"
void main()
{
    object oPC = GetPCSpeaker();
    DeleteLocalInt(oPC, "iConvPos");
}
