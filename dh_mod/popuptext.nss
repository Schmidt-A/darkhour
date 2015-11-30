void main()
{

object oPC = GetEnteringObject();

if (!GetIsPC(oPC)) return;

int DoOnce = GetLocalInt(oPC, GetTag (OBJECT_SELF));

if (DoOnce==TRUE) return;

SetLocalInt(oPC, GetTag(OBJECT_SELF), TRUE);

FloatingTextStringOnCreature("Before you, lay the vast Sazzan Plains. In the south you note the vast desert, sandy dunes dominating the horizon. From left to right, the plains dominate from the western side of the island, stopping only to the immensity of the Spire. And to the east, a slow progression down to the stormglass coastline..", oPC);

}
