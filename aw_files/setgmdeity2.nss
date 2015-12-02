void main()
{

    object oDm = GetPCSpeaker();
    object oPlayer = GetLocalObject(oDm, "oMyTarget");

         SetDeity(oPlayer,"GM");
         FloatingTextStringOnCreature(GetPCPlayerName(oPlayer)+" ["+GetName(oPlayer)+"] Deity set to be GameMaster.",oDm, FALSE);

         effect eVis = EffectVisualEffect(VFX_DUR_SANCTUARY);
         effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
         effect eSanc = EffectEthereal();
         effect eLink = EffectLinkEffects(eVis, eSanc);
         eLink = EffectLinkEffects(eLink, eDur);
         eLink = SupernaturalEffect(eLink);
         ApplyEffectToObject(DURATION_TYPE_PERMANENT, eLink, oPlayer);
}


