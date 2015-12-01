             void main()
{

object oPC = GetEnteringObject();

if (!GetIsPC(oPC)) return;

int DoOnce = GetLocalInt(oPC, GetTag(OBJECT_SELF));

SetLocalInt(oPC, GetTag(OBJECT_SELF), TRUE);

FloatingTextStringOnCreature("*You look into the distance and all you see is a stretch of greyness, bleak and dull. You feel compelled to not go this way.*", oPC);

}
