//--------------------------------------------------------------------------
//      Antiworld custom spellhook: Casting spells from items/scrolls will be only possible with limitation:
//      Same spell: once every 18 seconds
//      Same Spell: To a maximum usage of (yourlevel/10) every respawn
//
//------------------------------------------------------------------------------
#include "x2_inc_switches"
#include "inc_bs_module"
void main()
{
   if (GetIsObjectValid(GetSpellCastItem()) && GetIsPC(GetSpellTargetObject()))
   {
      if (GetSpellTargetObject() == OBJECT_SELF || 3-GetPlayerTeam(GetSpellTargetObject()) == GetPlayerTeam(OBJECT_SELF) )
      {
         object SpellTracker = GetLocalObject(OBJECT_SELF,"spelltracker");
         int nUses = GetLocalInt(SpellTracker,"Uses"+IntToString(GetSpellId()) );
         if (nUses < GetHitDice(OBJECT_SELF) / 10 )  //if has some uses of this spell left
         {
            int nLastUse = GetLocalInt(SpellTracker,"LastUse"+IntToString(GetSpellId()));
            int nNow = FloatToInt(HoursToSeconds(GetCalendarDay()*24 + GetTimeHour())) + GetTimeMinute()*60 + GetTimeSecond();
            //SendMessageToPC(OBJECT_SELF,"LastUse: " + IntToString(nLastUse) + " Now:" + IntToString(nNow));
            if (abs(nNow - nLastUse) < 18)
            {
               FloatingTextStringOnCreature("<c.ÍŽ>You must wait 18 seconds to use the same spell from an item!</c>",OBJECT_SELF,FALSE);
               SetModuleOverrideSpellScriptFinished(); //return FALSE
               return;
            }

            //update on the player the usage of that spell
            SetLocalInt(SpellTracker,"Uses"+IntToString(GetSpellId()),nUses+1);
            if (GetSpellId() == 73 || GetSpellId() == 99 ||GetSpellId() == 169)
            {
                    SetLocalInt(SpellTracker,"LastUse"+IntToString(73),nNow);
                    SetLocalInt(SpellTracker,"LastUse"+IntToString(99),nNow);
                    SetLocalInt(SpellTracker,"LastUse"+IntToString(169),nNow);
            }
            else
            {
                    SetLocalInt(SpellTracker,"LastUse"+IntToString(GetSpellId()),nNow);
            }
         }
         else
         {
            FloatingTextStringOnCreature("<câC>You have no more uses of this spell!</c>",OBJECT_SELF,FALSE);
            SetModuleOverrideSpellScriptFinished(); //return FALSE
         }
      }
   }
}

