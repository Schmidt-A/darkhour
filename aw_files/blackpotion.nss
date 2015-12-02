#include "inc_bs_module"
void main()
{
//makes all enemyes to sleep for 10 seconds
object oPC= GetItemActivator();
int nPCTeam = GetLocalInt(oPC, "nTeam");
int nEnemyTeam = 3 - nPCTeam;
string sMessage = "<cëLÊ>"+GetName(oPC) + " of " + GetTeamName(nPCTeam) +
                        " used the Black Potion!! </c>";

                         BroadcastMessage(sMessage);
                         AssignCommand (oPC, PlaySound("as_pl_whislte2"));
object oPlayer = GetFirstPC();
    while ( GetIsObjectValid(oPlayer) == TRUE  )
    {

        if (nEnemyTeam == GetLocalInt(oPlayer, "nTeam" ))
         {

               //Make the player to lie on the floor and freeze them
               AssignCommand(oPlayer,ActionPlayAnimation(ANIMATION_LOOPING_DEAD_FRONT, 1.0,11.5f));
               DelayCommand(2.0,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectVisualEffect(VFX_DUR_FREEZE_ANIMATION),oPlayer,8.0f));

        effect eVis = EffectVisualEffect(VFX_IMP_SLEEP);
        effect eSleep =  SupernaturalEffect(EffectSleep());
        if (GetIsImmune(oPlayer, IMMUNITY_TYPE_SLEEP) == FALSE)
            {
                effect eMind = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_NEGATIVE);
                effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);

                effect eLink = EffectLinkEffects(eSleep, eMind);
                eLink = EffectLinkEffects(eLink, eDur);
                effect eLink2 = EffectLinkEffects(eLink, eVis);
                DelayCommand(2.2,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink2,oPlayer,8.5f));
            }
            else
            // * even though I am immune apply just the sleep effect for the immunity message
            // * and then use a petrify effect instead
            {
                effect eStoneEffect = SupernaturalEffect(EffectPetrify());
                DelayCommand(2.0,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eStoneEffect, oPlayer, 8.5f));
            }

        effect eKnockdown = EffectParalyze();
        if (GetIsImmune(oPlayer, IMMUNITY_TYPE_PARALYSIS) || GetIsImmune(oPlayer, IMMUNITY_TYPE_MIND_SPELLS))
        {
            eKnockdown = EffectCutsceneImmobilize();
        }
        DelayCommand(2.0,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eKnockdown, oPlayer, 8.5f));
        //Delay the visualeffect ZZzzZZZzz
        DelayCommand(0.1, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_SLEEP), oPlayer));
        DelayCommand(2.0 + Random(2), ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_SLEEP), oPlayer));
        DelayCommand(4.0 + Random(2), ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_SLEEP), oPlayer));
                                /*
              effect eVis = EffectVisualEffect(VFX_IMP_SLEEP);
              effect eSleepEffect = EffectSleep();

              ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis, oPC, 180.0f);
              ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSleepEffect, oPC, 180.0f);

              DelayCommand(0.1,AssignCommand(oPlayer, ActionPlayAnimation(ANIMATION_LOOPING_DEAD_FRONT, 1.0f, 12.0f)));
              DelayCommand(0.1, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_SLEEP), oPlayer));
              DelayCommand(2.0 + Random(2), ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_SLEEP), oPlayer));
              DelayCommand(4.0 + Random(2), ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_SLEEP), oPlayer));
              */
              DelayCommand(2.50,FadeToBlack(oPlayer));
              DelayCommand(10.0,FadeFromBlack(oPlayer));
        }
        oPlayer = GetNextPC();
    }

}

