void main()
{

object oPC = GetEnteringObject();

if (!GetIsPC(oPC)) return;

int DoOnce = GetLocalInt(oPC, GetTag (OBJECT_SELF));

if (DoOnce==TRUE) return;

SetLocalInt(oPC, GetTag(OBJECT_SELF), TRUE);

FloatingTextStringOnCreature("For some reason.. this sewer does not smell of sewer. Infact the smell of the falling water and mist uptake refreshes your nose in a way. It's peaceful down here. Too peaceful..", oPC);

}
