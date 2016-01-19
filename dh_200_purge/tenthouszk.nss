void main()
{
object oPC = OBJECT_SELF;
object oItem = GetItemPossessedBy(oPC, "zkxthous");
int iStack = GetItemStackSize(oItem);
if(iStack == 1)
    {
    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_DUR_AURA_PULSE_RED_BLACK), oPC);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_BEAM_HOLY), oPC);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_ELECTRIC_EXPLOSION), oPC);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_FNF_SCREEN_SHAKE), oPC, 3.0);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SUMMON_EPIC_UNDEAD), oPC);
    DelayCommand(1.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_DUR_AURA_PULSE_RED_WHITE), oPC));
    DelayCommand(1.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_FIRESTORM), oPC));
    DelayCommand(1.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_MYSTICAL_EXPLOSION), oPC));
    DelayCommand(1.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION), oPC));
    AssignCommand(GetModule(), SpeakString(GetName(oPC) + " has defeated ten thousand undead!", TALKVOLUME_SHOUT));
    }
if(GetItemPossessedBy(oPC, "badge51") == OBJECT_INVALID)
    {
    CreateItemOnObject("badge51", oPC);
    GiveXPToCreature(oPC, 100);
    }
}
