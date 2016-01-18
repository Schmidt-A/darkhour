/* Applies a dramatic slow effect to any player failing their reflex save
 * upon entering the trigger. Needs three variables defined on the trigger:
 *      int iDC     - Saving throw DC to beat
 *      string sMsg - Message to be displayed to the PC if they fail the save. */

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
