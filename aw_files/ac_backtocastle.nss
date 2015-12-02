////// When a player use the Portal "Back to base" /////

#include "inc_bs_module"

void PortBackToCastle(object  oPlayer);
void PortBackToCastle(object  oPlayer)
{
   //remove all effects
    effect eEffect = GetFirstEffect(oPlayer);
    while ( GetIsEffectValid(eEffect))
    {
         if ( GetTag(GetEffectCreator(eEffect)) == "BackToCastle")
         {
            RemoveEffect(oPlayer, eEffect);
         }
    eEffect = GetNextEffect(oPlayer);
    }
AssignCommand(oPlayer,ClearAllActions(TRUE));
MovePlayerToSpawn(oPlayer);
}
// all things when you use the back to castle portal
void ApplyAllPains(object  oPlayer);
void ApplyAllPains(object  oPlayer)
{
 //effect eStoneEffect = EffectPetrify();

        effect eVis = EffectVisualEffect(VFX_IMP_SLEEP);
        effect eSleep =  SupernaturalEffect(EffectSleep());
        if (GetIsImmune(oPlayer, IMMUNITY_TYPE_SLEEP) == FALSE)
            {
                effect eMind = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_NEGATIVE);
                effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);

                effect eLink = EffectLinkEffects(eSleep, eMind);
                eLink = EffectLinkEffects(eLink, eDur);
                effect eLink2 = EffectLinkEffects(eLink, eVis);
                AssignCommand(OBJECT_SELF, ApplyEffectToObject(DURATION_TYPE_TEMPORARY,SupernaturalEffect(eLink2),oPlayer,19.0));
            }
            else
            // * even though I am immune apply just the sleep effect for the immunity message
            // * and then use a petrify effect instead
            {
                 effect eStoneEffect = SupernaturalEffect(EffectPetrify());
                 AssignCommand(OBJECT_SELF,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, SupernaturalEffect(eStoneEffect), oPlayer,19.0));
            }

        effect eKnockdown = EffectParalyze();
        if (GetIsImmune(oPlayer, IMMUNITY_TYPE_PARALYSIS) || GetIsImmune(oPlayer, IMMUNITY_TYPE_MIND_SPELLS))
        {
            eKnockdown = EffectCutsceneImmobilize();
        }
        AssignCommand(OBJECT_SELF,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,SupernaturalEffect(eKnockdown), oPlayer,19.0));
         RemoveBuffs(oPlayer);
}

void main()
{
object oPlayer = GetLastUsedBy();
 object oPortal = OBJECT_SELF;
    int nTeam = GetPlayerTeam(oPlayer);
    int nEnemyTeam = 3 - nTeam;
    string szEnemyHasFlag = "oHasFlag_" + IntToString(nEnemyTeam);
    if (oPlayer == GetLocalObject(GetModule(), szEnemyHasFlag))
    {
         ActionSpeakString("You cannot enter the castle while you are still holding the flag!");
         AssignCommand(oPlayer, ActionMoveAwayFromObject(GetObjectByTag("backtobase")));
         return;
    }
    else
    {
        if( GetTag(GetArea(oPlayer)) != "arena_"+IntToString(GetLocalInt(GetModule(),"nRound")) ||  GetLocalInt(oPlayer,"UsingBackToCastle") )
        {
            MovePlayerToSpawn(oPlayer);
            return;
        }

       AssignCommand(oPlayer,ActionSpeakString("<c3³>I'm a free Level: "+IntToString(GetHitDice(oPlayer))+" "+GetTeamColour(GetPlayerTeam(oPlayer))+" "+ GetTeamName(GetPlayerTeam(oPlayer))+"</c><c3³> KILL</c>!",TALKVOLUME_SHOUT));
       DelayCommand(4.5,SetLocalInt(oPlayer,"UsingBackToCastle",1));

       //Make the player to lie on the floor and freeze them
       AssignCommand(oPlayer,ActionPlayAnimation(ANIMATION_LOOPING_DEAD_FRONT, 1.0, 5.0f));
       DelayCommand(2.5,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectVisualEffect(VFX_DUR_FREEZE_ANIMATION),oPlayer,20.0));

       DelayCommand(3.0,ApplyAllPains(oPlayer));

        //Delay the visualeffect ZZzzZZZzz
        DelayCommand(0.1, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_SLEEP), oPlayer));
        DelayCommand(2.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_SLEEP), oPlayer));
        DelayCommand(4.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_SLEEP), oPlayer));
        FloatingTextStringOnCreature("You must wait 20 seconds before you go back to your castle!", oPlayer, FALSE);

        //Port them to castle
        DelayCommand(23.0,PortBackToCastle(oPlayer));
        //would maybe nicer to just apply permanents effects,without delay, tracking the creator( the portal) and then delay a function to remove the effects and to port to castle)
       }

}


