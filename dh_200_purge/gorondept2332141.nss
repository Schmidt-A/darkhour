void main()
{

object oPC = GetEnteringObject();

if (!GetIsPC(oPC)) return;

int DoOnce = GetLocalInt(oPC, GetTag (OBJECT_SELF));

if (DoOnce==TRUE) return;

SetLocalInt(oPC, GetTag(OBJECT_SELF), TRUE);

FloatingTextStringOnCreature("Through the darkness emerges a throne among the massive halls of the Ismail Palace. There, hanging from a rope, lay what looks to be the corpse of a dwarf. Or in this case, Duergar. Behind him written in his very own blood is the symbol of Imithril. Below, at the foot, is a message. Written in common, oddly enough. It reads..'Such is the fate of all who defy Lloth'..", oPC);

}
