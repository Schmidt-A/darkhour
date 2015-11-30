void main()
{

object oPC = GetEnteringObject();

if (!GetIsPC(oPC)) return;

int DoOnce = GetLocalInt(oPC, GetTag (OBJECT_SELF));

if (DoOnce==TRUE) return;

SetLocalInt(oPC, GetTag(OBJECT_SELF), TRUE);

FloatingTextStringOnCreature("As you step through the broken grate a sudden current takes your feet and you slide down what seems to be a set of pipes! 'Whoooaaaa!' you say as you fly down with the flowing water, and out the pipe. Down onto the hard floor below. Yeowch!", oPC);

}
