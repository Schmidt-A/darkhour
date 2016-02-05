#include "_incl_location"

void main()
{
    object oPC = GetLastUsedBy();

    // Hacky check to see if this is a brand new character or not.
    // TODO: should do something better here.
    if (!GetIsPC(oPC) || GetIsDM(oPC) || GetXP(oPC) > 0)
        return;

    /* Try the three different starting alleyways - make sure there's no PC
     * in them already. */
    int bPorted = PortToWPIfAreaIsEmpty(oPC, "kalaramdarkalley");
    if(!bPorted)
        bPorted = PortToWPIfAreaIsEmpty(oPC, "kalaramdarkalley1");
    if(!bPorted)
        bPorted = PortToWPIfAreaIsEmpty(oPC, "kalaramdarkalle3");

    // If there were no empty starting areas, let the player know
    FloatingTextStringOnCreature("All the starting paths are currently " +
            "occupied. Please try again in a minute or so.", oPC, FALSE);
}
