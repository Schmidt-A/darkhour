#include "bodypart_inc"
////// Lab Lever ////// from wingery pack /////////////////
void main()
{
    object oPC = GetLastUsedBy();
    object oMasha = GetObjectByTag("Masha");
    int nPartSel = GetLocalInt(oMasha,"SELECTED_PART");

    string sTag = GetTag(OBJECT_SELF);

    if(sTag=="FL1") {
        int nPartApp = GetLocalInt(oMasha,"APPLIED_PART");
        int nOldType = GetLocalInt(oMasha,"OLD_TYPE");

        // Don't reapply
        if(nPartSel == nPartApp) {
            FloatingTextStringOnCreature("** click **",oPC, FALSE);
            return;
        }

        // Apply Selection
        if(nPartSel==0) {
            nPartSel=1;
            SetLocalInt(oMasha,"SELECTED_PART",1);
        }

        // record what we're going to do
        int nPartType = GetBodyPart(oMasha, nPartSel);
        int nTgtType = nPartType==0?1:0;
        SetLocalInt(oMasha,"APPLIED_PART",nPartSel);
        SetLocalInt(oMasha,"OLD_TYPE",nPartType);

        // change new part
        SetBodyPart(oMasha,nPartSel,nTgtType);
        FloatingTextStringOnCreature("Part "+IntToString(nPartSel)+
            " set to type "+IntToString(nTgtType)+" was "+
            IntToString(nPartType),oPC);

        if(nPartApp!=0) {
            // restore old part
            SetBodyPart(oMasha,nPartApp,nOldType);
        }

        // flashy effects
        int nApp = GetAppearanceType(oMasha);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_FNF_STRIKE_HOLY), oMasha, 1.5);
        SetCreatureAppearanceType(oMasha,APPEARANCE_TYPE_WILL_O_WISP);
        DelayCommand(1.0,SetCreatureAppearanceType(oMasha,nApp));

    } else {
        // if DNE set to value that would create a sane result
        if(nPartSel==0) nPartSel=NWNX_BODYPART_LOW-1;

        // Parts Selector
        if(sTag=="FL2") {
            ++nPartSel;
        } else
        if(sTag=="FL3") {
            --nPartSel;
        }

        // boundary conditions
        if(nPartSel>NWNX_BODYPART_HIGH) nPartSel=NWNX_BODYPART_LOW;
        if(nPartSel<NWNX_BODYPART_LOW) nPartSel=NWNX_BODYPART_HIGH;

        // persist
        SetLocalInt(oMasha,"SELECTED_PART",nPartSel);
        FloatingTextStringOnCreature("Selected: "+IntToString(nPartSel),oPC);
    }

}
