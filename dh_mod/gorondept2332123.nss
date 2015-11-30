void main()
{

object oPC = GetEnteringObject();

if (!GetIsPC(oPC)) return;

int DoOnce = GetLocalInt(oPC, GetTag (OBJECT_SELF));

if (DoOnce==TRUE) return;

SetLocalInt(oPC, GetTag(OBJECT_SELF), TRUE);

FloatingTextStringOnCreature("As you pass through the halls, the corridors suddenly expand vastly, and the ceiling rises to invisible extents. Around you, despite the darkness, you can see pillars of a hundred feet, rising up into the above darkness. This continues into the darkness ahead, the pillars a testament to the might of the Duergar empire of Ismail.", oPC);

}
