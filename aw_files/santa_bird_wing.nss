#include "bodypart_inc"
#include "aps_include"
void main()
{
object oPC = GetPCSpeaker();

    int nModP = 1;
    int nPart = nModP?NWNX_BODYPART_WING:NWNX_BODYPART_TAIL;
    int nType = 6;

    SetBodyPart(oPC,nPart,nType);

     // Antiworld Persistant wings////
    SetPersistentInt(oPC,"WingsModel",nType,15,"Wings");

    int nApp = GetAppearanceType(oPC);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,
        EffectVisualEffect(VFX_FNF_STRIKE_HOLY), oPC, 1.5);
    SetCreatureAppearanceType(oPC,APPEARANCE_TYPE_WILL_O_WISP);
    DelayCommand(1.0,SetCreatureAppearanceType(oPC,nApp));
    ActionCastSpellAtLocation(SPELL_MASS_BLINDNESS_AND_DEAFNESS,GetLocation(oPC));
}
