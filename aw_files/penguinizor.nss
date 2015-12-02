#include "inc_bs_module"
void main()
{
object oPC= GetItemActivator();
int nPCTeam = GetLocalInt(oPC, "nTeam");
int nEnemyTeam = 3 - nPCTeam;
string sMessage = "<cëLÊ>"+GetName(oPC) + " of " + GetTeamName(nPCTeam) +
                        " used the Penguinizor!! </c>";

                         BroadcastMessage(sMessage);

object oPlayer = GetFirstPC();
    while ( GetIsObjectValid(oPlayer) == TRUE  )
    {

        if (nEnemyTeam == GetLocalInt(oPlayer, "nTeam" ))
         {

           effect ePengy = EffectPolymorph(POLYMORPH_TYPE_PENGUIN, TRUE);
           effect eVisual = EffectVisualEffect(VFX_IMP_POLYMORPH);
           ApplyEffectToObject(DURATION_TYPE_INSTANT,eVisual,oPlayer);
           ePengy = SupernaturalEffect(ePengy);
           ApplyEffectToObject(DURATION_TYPE_TEMPORARY, ePengy, oPlayer, 60.0f);
           FloatingTextStringOnCreature("<c.ÍŽ>Pen<c³uç>gy <cHç>ru<cHËQ>lez!!</c>",oPlayer,FALSE);

        }
        oPlayer = GetNextPC();
    }

}

