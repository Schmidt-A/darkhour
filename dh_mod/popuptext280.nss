void main()
{

object oPC = GetEnteringObject();

if (!GetIsPC(oPC)) return;

int DoOnce = GetLocalInt(oPC, GetTag (OBJECT_SELF));

if (DoOnce==TRUE) return;

SetLocalInt(oPC, GetTag(OBJECT_SELF), TRUE);

FloatingTextStringOnCreature("Pits, endless, black pits. They say these pits surrounding The Spire go all the way down to the underdark, where pools of icy water lay waiting for those foolish enough to attempt to traverse these pits.", oPC);

}
