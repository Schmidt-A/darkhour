void main()
{
    object oPC = GetEnteringObject();

    if(!GetIsPC(oPC))
        return;

    string sMsg = GetLocalString(OBJECT_SELF, "sMsg");
    FloatingTextStringOnCreature(sMsg, oPC);
}
