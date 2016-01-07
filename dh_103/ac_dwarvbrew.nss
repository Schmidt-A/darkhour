void main()
{
object oPC = GetItemActivator();
int iMod = d8();
int iUses = GetLocalInt(oPC, "brewuses");
iUses += 1;
SetLocalInt(oPC, "brewuses", iUses);
float fTime = IntToFloat(Random(200) + 50);
effect eFall = EffectKnockdown();
effect eStr = EffectAbilityIncrease(ABILITY_STRENGTH, iMod);
effect eCon = EffectAbilityIncrease(ABILITY_CONSTITUTION, iMod);
effect eInt = EffectAbilityDecrease(ABILITY_INTELLIGENCE, iMod);
effect eWis = EffectAbilityDecrease(ABILITY_WISDOM, iMod);
effect eDex = EffectAbilityDecrease(ABILITY_DEXTERITY, iMod);
effect eWill = EffectSavingThrowDecrease(SAVING_THROW_WILL, iMod, SAVING_THROW_TYPE_NONE);
effect eRef = EffectSavingThrowDecrease(SAVING_THROW_REFLEX, iMod, SAVING_THROW_TYPE_NONE);
effect eDaze = EffectDazed();
if(FortitudeSave(oPC, 2, SAVING_THROW_FORT) == 0)
    {
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eFall, oPC, fTime);
    fTime = fTime / 3;
    SendMessageToPC(oPC, "You have been knocked down.");
    }
if(FortitudeSave(oPC, 2, SAVING_THROW_FORT) == 0)
    {
    DelayCommand(1.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDaze, oPC, fTime));
    fTime = fTime / 3;
    SendMessageToPC(oPC, "You have been dazed.");
    }
DelayCommand(1.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eStr, oPC, fTime));
SendMessageToPC(oPC, "Your strength has greatly increased.");
DelayCommand(1.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eCon, oPC, fTime));
SendMessageToPC(oPC, "Your constitution has greatly increased.");
DelayCommand(1.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eInt, oPC, fTime));
SendMessageToPC(oPC, "Your intelligence has been greatly decreased.");
DelayCommand(1.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDex, oPC, fTime));
SendMessageToPC(oPC, "Your dexterity has been greatly decreased.");
DelayCommand(1.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eWis, oPC, fTime));
SendMessageToPC(oPC, "Your wisdom has been greatly decreased.");
DelayCommand(1.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eWill, oPC, fTime));
SendMessageToPC(oPC, "Your willpower has been greatly decreased.");
DelayCommand(1.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRef, oPC, fTime));
SendMessageToPC(oPC, "Your reflexes have been greatly decreased.");
DelayCommand(500.0, ExecuteScript("brewrecover", oPC));
if(iUses == 1)
    {
    DelayCommand(3.0, SendMessageToPC(oPC, "You are now feeling the effects of this brew."));
    }
else if(iUses == 2)
    {
    DelayCommand(3.0, SendMessageToPC(oPC, "You have yet to recover from the last time you drank this. You should really wait before drinking another."));
    }
else if(iUses == 3)
    {
    DelayCommand(3.0, SendMessageToPC(oPC, "You have taken far too much of this brew, you are now feeling adverse effects. You should definitely wait some time before drinking another."));
    EffectDamage(GetCurrentHitPoints(oPC) / 2, DAMAGE_TYPE_ACID, DAMAGE_POWER_NORMAL);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectPoison(POISON_MEDIUM_SPIDER_VENOM), oPC, 120.0);
    }
else if(iUses == 4)
    {
    DelayCommand(3.0, SendMessageToPC(oPC, "You have severely overdosed on this brew, your heart has stopped."));
    DelayCommand(4.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDeath(), oPC));
    }
}
