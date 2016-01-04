void main()
{

object oPC = GetEnteringObject();

if (!GetIsPC(oPC)) return;

int DoOnce = GetLocalInt(oPC, GetTag (OBJECT_SELF));

if (DoOnce==TRUE) return;

SetLocalInt(oPC, GetTag(OBJECT_SELF), TRUE);

FloatingTextStringOnCreature("It looks like some sort of structure above recently fell here and destroyed what was the bridge. Perhaps there is a way around? However... To stray from the path in the underdark is to welcome the dangers that lurk in the shadows...", oPC);

}
