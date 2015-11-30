void main()
{

object oPC = GetEnteringObject();

if (!GetIsPC(oPC)) return;

int DoOnce = GetLocalInt(oPC, GetTag (OBJECT_SELF));

if (DoOnce==TRUE) return;

SetLocalInt(oPC, GetTag(OBJECT_SELF), TRUE);

FloatingTextStringOnCreature("Ahead you spot what looks to be a crashed wagon upon the road and a seemingly large concentration of both the dead, and the undead. Perhaps an alternate route would be wise.", oPC);

}
