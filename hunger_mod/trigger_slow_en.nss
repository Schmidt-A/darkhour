void main()
{
    object oPC = GetEnteringObject();

    int iDC = GetLocalInt(OBJECT_SELF, "iDC");
    string sMsg = GetLocalString(OBJECT_SELF, "sMsg");

    if(ReflexSave(oPC, iDC) < 1)
    {
        ApplyEffectToObject(DURATION_TYPE_PERMANENT,
            EffectMovementSpeedDecrease(75), oPC);
        SendMessageToPC(oPC, sMsg);
    }
}
