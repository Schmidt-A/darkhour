void main()
{
    object oPC = GetEnteringObject();

    if(!GetIsPC(oPC))
        return;

    string sVarName = "seen_" + GetTag(OBJECT_SELF);
    if(GetLocalInt(oPC, sVarName))
        return;
    SetLocalInt(oPC, sVarName, TRUE);

    string sMsg = GetLocalString(OBJECT_SELF, "sMsg");
    FloatingTextStringOnCreature(sMsg, oPC);
}
