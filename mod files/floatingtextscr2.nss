void main()
{

object oPC = GetEnteringObject();

if (!GetIsPC(oPC)) return;

int DoOnce = GetLocalInt(oPC, GetTag (OBJECT_SELF));

if (DoOnce==TRUE) return;

SetLocalInt(oPC, GetTag(OBJECT_SELF), TRUE);

FloatingTextStringOnCreature("As you trek along the large corridors, a chill runs down your spine. It was not by the hand of any kind of wind, but the cold and dry environment around you. You cannot help but recall tales of the underdark, and its folly...", oPC);

}
