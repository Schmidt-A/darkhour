#include "inc_bs_module"
void main()
{


    object oPC= GetItemActivator();
    int nPCTeam = GetLocalInt(oPC, "nTeam");
    int nEnemyTeam = 3 - nPCTeam;
    object oVictim = GetFirstPC();

    BroadcastMessage("<cëLÊ>" + GetName(oPC) + " of " + GetTeamName(nPCTeam) + " used the Penguinizor!! </c>");

    while ( GetIsObjectValid(oVictim)   )
    {
       if ( !GetIsDM(oVictim) && (nEnemyTeam == GetLocalInt(oVictim, "nTeam" )))
       {
           effect ePengy = EffectPolymorph(POLYMORPH_TYPE_PENGUIN, TRUE);
           effect eVisual = EffectVisualEffect(VFX_IMP_POLYMORPH);
           ApplyEffectToObject(DURATION_TYPE_INSTANT,eVisual,oVictim);
           ePengy = SupernaturalEffect(ePengy);
           ApplyEffectToObject(DURATION_TYPE_TEMPORARY, ePengy, oVictim, 60.0);
           FloatingTextStringOnCreature("<c.ÍŽ>Pen<c³uç>gy <cHç>ru<cHËQ>lez!!</c>",oVictim,FALSE);
        }
        oVictim = GetNextPC();
    }
}
