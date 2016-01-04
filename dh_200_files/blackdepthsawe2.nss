void main()
{

object oPC = GetEnteringObject();

if (!GetIsPC(oPC)) return;

int DoOnce = GetLocalInt(oPC, GetTag (OBJECT_SELF));

if (DoOnce==TRUE) return;

SetLocalInt(oPC, GetTag(OBJECT_SELF), TRUE);

FloatingTextStringOnCreature("It's.. so. C-C-..Co..Cold... You mumble under your freezing lips. The flower water next to you seems riddled with chunks of ice and slush, apparently the only thing keeping that water from being totally frozen is its viciously fast rate of movement..", oPC);

}
