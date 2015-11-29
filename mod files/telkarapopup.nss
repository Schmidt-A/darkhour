void main()
{

object oPC = GetEnteringObject();

if (!GetIsPC(oPC)) return;

int DoOnce = GetLocalInt(oPC, GetTag (OBJECT_SELF));

if (DoOnce==TRUE) return;

SetLocalInt(oPC, GetTag(OBJECT_SELF), TRUE);

FloatingTextStringOnCreature("The Tel'kara swamp... the humidity of the area is immediately felt as you step towards the nearby bridges. This place was rumoured to once be the home of tribes upon tribes of powerful Lizardfolk.. A dangerous trek, no matter who you are.", oPC);

}
