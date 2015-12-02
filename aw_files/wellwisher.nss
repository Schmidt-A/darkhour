#include "inc_bs_module"
void wellwisher(object oUser, int nTeam )
{
       int nUserHP = GetMaxHitPoints(oUser);
       ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectTemporaryHitpoints(nUserHP),oUser,60.0);
       effect eVisual = EffectVisualEffect(VFX_IMP_HEALING_X);
       effect eHeal = EffectLinkEffects(EffectHeal(nUserHP), eVisual);
       ApplyEffectToObject(DURATION_TYPE_INSTANT,eHeal,oUser);
       object oPC = GetFirstPC();
       while(GetIsObjectValid(oPC))
        {
            if((oPC != oUser) &&  (GetRacialType(oPC) == RACIAL_TYPE_ELF) && GetPlayerTeam(oPC) == nTeam )
            {
                 int nLastUse = GetLocalInt(oPC,"wellwisher");
                 int nNow = FloatToInt(HoursToSeconds(GetCalendarDay()*24 + GetTimeHour())) + GetTimeMinute()*60 + GetTimeSecond();
                 if (abs(nNow - nLastUse) < 180)
                 {
                     return;
                 }
                 SetLocalInt(oPC,"wellwisher",nNow);
                 int nPCHP = GetMaxHitPoints(oPC);
                 ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectTemporaryHitpoints(nPCHP),oPC,180.0);
                 eHeal = EffectLinkEffects(EffectHeal(nPCHP), eVisual);
                 ApplyEffectToObject(DURATION_TYPE_INSTANT,eHeal,oPC);
                 FloatingTextStringOnCreature("<cÚýÝ>"+GetName(oUser)+" used Magic Card: Wellwisher, Creature - Elf.</c>",oUser, TRUE);
                 DelayCommand(0.8,FloatingTextStringOnCreature("<cÚýÝ>Max Hit point Doubled.</c>",oUser, TRUE));
            }
       oPC = GetNextPC();
       }
 }

void main()
{
object oUser = GetItemActivator();
int nTeam = GetPlayerTeam(oUser);
       DelayCommand(0.8,FloatingTextStringOnCreature("<c¤ßÎ>...Magic Card... </c>",oUser, TRUE));
       DelayCommand(1.6,FloatingTextStringOnCreature("<cÄóÎ>Creature - Elf</c>",oUser, TRUE));
       DelayCommand(2.4,FloatingTextStringOnCreature("<cÚýÝ>You gain 1 life for each Elf in play!</c>",oUser, TRUE));
       DelayCommand(0.8,BroadcastMessage("<c¤ßÎ>"+GetName(oUser)+" uses Magic Card: Creature - Elf: <<Close your ears to the voice of greed, and you can turn a gift for one into a gift for many.>></c>"));
       DelayCommand(1.8,wellwisher(oUser,nTeam));
       SetPlotFlag (GetItemActivated(),FALSE);
       DestroyObject(GetItemActivated(), 2.0f);
}


