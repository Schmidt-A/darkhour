void main()
{

object oPC = GetEnteringObject();

if (!GetIsPC(oPC)) return;

int DoOnce = GetLocalInt(oPC, GetTag (OBJECT_SELF));

if (DoOnce==TRUE) return;

SetLocalInt(oPC, GetTag(OBJECT_SELF), TRUE);

FloatingTextStringOnCreature("The main square of Fyn Island becomes apparent as the long bridge comes to a relieving end. Though something seems off here... there is a strange shortage of undead, and dead for that matter. Whatever happened here is beyond you, but you best keep moving...", oPC);

}
