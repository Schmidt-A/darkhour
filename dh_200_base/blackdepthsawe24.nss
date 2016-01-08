void main()
{

object oPC = GetEnteringObject();

if (!GetIsPC(oPC)) return;

int DoOnce = GetLocalInt(oPC, GetTag (OBJECT_SELF));

if (DoOnce==TRUE) return;

SetLocalInt(oPC, GetTag(OBJECT_SELF), TRUE);

FloatingTextStringOnCreature("After a boring, mind-blowing hour of being lowered on the loud mechanism, your ears ring with imminent damage, and you wearily take a step off of the platform. As all weight is brought from the platform, it begins automatically ascending back up. A nearby switch tells you that it could be resummoned rather easily.", oPC);

}
