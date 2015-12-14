

#include "nw_i0_tool"
void RemoveXPFromParty(int nXP, object oPC, int bAllParty=TRUE)
{
    if (!bAllParty)
    {
        nXP=(GetXP(oPC)-nXP)>=0 ? GetXP(oPC)-nXP : 0;
        SetXP(oPC, nXP);
    }
    else
    {
        object oMember=GetFirstFactionMember(oPC, TRUE);

        while (GetIsObjectValid(oMember))
        {
            nXP=(GetXP(oMember)-nXP)>=0 ? GetXP(oMember)-nXP : 0;
            SetXP(oMember, nXP);
            oMember=GetNextFactionMember(oPC, TRUE);
        }
    }
}
void main()
{
    object oPC = GetPCLevellingUp();

    if (!GetIsPC(oPC))
        return;

    /* Tweek note:
       Got rid of all the level restriction stuff for now.
       We don't want to restrict people from leveling based on how many
       artifacts that they have.
       Also currently don't have any plans to restrict SD/Shfiter levels.
       We can update this later if we want any levelup restrictions. */
}

