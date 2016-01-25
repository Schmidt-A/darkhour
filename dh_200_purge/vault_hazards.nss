/* These miserable-for-PCs vault additions written by Tweek 2016.
 * Info on how to use these is in vaultrun_hb. */
#include "_incl_location"

const int KALARAM   = 0;
const int ELEDHRETH = 1;
const int FAELOTH   = 2;
const int BARABAN   = 3;
const int ANNEDHEL  = 4;
const int SISPARA   = 5;

// Config options
const int ELED_NO_CAVEINS   = 3;
const int BARA_NO_WPS       = 3;
const int FORT_DC           = 14;
const int REFLEX_DC         = 12;
const float KD_DUR          = 4.0;

const string ROCK_PLACEABLE = "eled_boulder";
const string PUKE_PLACEABLE = "hazard_puke";
const string ELED_ROCK_WP   = "eled_cave_in";
const string BARA_PORT_WP   = "bar_vaultwp_";

/*-------------- Vault Handler Functions -----------*/
void BarabanVaultEffects(object oPC);
void FaelothVaultEffects(object oPC);
void KalaramVaultEffects(object oPC);
/*-------------- Baraban Functions -----------------*/
void VinesEffect(object oPC);
/*-------------- Eledhreth Functions ---------------*/
void    CaveIn();
void    CleanUpCaveIn();
object  CreateBoulder(int iWP);
/*-------------- Kalaram Functions -----------------*/
void VomitCheck(object oPC, string sMsg);
/*-------------- General Functions -----------------*/
void VaultSaveFail(object oPC, int iSave);


void BarabanVaultEffects(object oPC)
{
    if(ReflexSave(oPC, REFLEX_DC, SAVING_THROW_TYPE_NONE) < 1)
    {
        string sName = GetName(oPC);
        SendMessageToPC(oPC, "Fueled by the darkness of Siranda, strange roots " +
                "spring up from the ground and wrap around " + sName + "'s legs!" +
                " They must stop to hack themselves free!");
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, KD_DUR);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,
                    EffectVisualEffect(VFX_DUR_ENTANGLE), oPC, KD_DUR);
        int iChance = Random(10)+1;
        if(iChance == 1)
        {
            VinesEffect(oPC);
        }
    }
}

void FaelothVaultEffects(object oPC)
{
    if(ReflexSave(oPC, REFLEX_DC, SAVING_THROW_TYPE_NONE) < 1)
    {
        string sName = GetName(oPC);
        SendMessageToPC(oPC, sName + " fails to keep their footing and slips." +
                " Their joints ache for a short while after slamming into the " +
                "unforgiving icy floor.");
        VaultSaveFail(oPC, SAVING_THROW_REFLEX);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectKnockdown(), oPC, KD_DUR);
    }
    if(FortitudeSave(oPC, FORT_DC, SAVING_THROW_TYPE_NONE) < 1)
    {
        SendMessageToPC(oPC, "The frigid air of this frozen passage chills blood " +
                "and flesh alike.");
        effect eDamage = EffectDamage(5, DAMAGE_TYPE_COLD, DAMAGE_POWER_NORMAL);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oPC);
        ApplyEffectToObject(DURATION_TYPE_INSTANT,
                            EffectVisualEffect(VFX_IMP_FROST_S), oPC);
    }
}

void KalaramVaultEffects(object oPC)
{
    if(GetLocalInt(OBJECT_SELF, "iHBTicks") == GetLocalInt(OBJECT_SELF, "iHBInterval"))
    {
        string sMsg = GetName(oPC) + " is overwhelmed by the foul stench and " +
                "fetid fumes of the sewers. They can't keep themselves from " +
                "doubling over and throwing up.";
        VomitCheck(oPC, sMsg);
    }
    else
    {
        location lLoc = GetLocation(oPC);
        object oPuke = GetFirstObjectInShape(SHAPE_SPHERE, 10.0, lLoc, FALSE,
                                                        OBJECT_TYPE_PLACEABLE);
        while(GetIsObjectValid(oPuke))
        {
            if(GetResRef(oPuke) == PUKE_PLACEABLE)
            {
                string sName = GetName(oPC);
                if(!GetLocalInt(oPuke, sName))
                {
                    string sMsg = GetName(oPC) + " can't handle the disgusting pile " +
                            "of a companion's vomit nearby, driving them to be sick " +
                            "themselves.";
                    VomitCheck(oPC, sMsg);
                }
            }
            oPuke = GetNextObjectInShape(SHAPE_SPHERE, 10.0, lLoc);
        }
    }
}

void VinesEffect(object oPC)
{
    int iWP = Random(BARA_NO_WPS)+1;
    string sWPTag = BARA_PORT_WP + IntToString(iWP);

    string sMsg = "Though eventually able to free themselves, it is not " +
        "before the malign vines drag " + sName + " back to the entrance.";
    DelayCommand(KD_DUR, PortToWaypoint(oPC, sWPTag));
    DelayCommand(KD_DUR, SendMessageToPC(oPC, sMsg));
}

void CaveIn()
{
    int iWP1 = Random(ELED_NO_CAVEINS)+1;
    int iWP2 = Random(ELED_NO_CAVEINS)+1;
    while(iWP2 == iWP1)
        iWP2 = Random(ELED_NO_CAVEINS)+1;

    CreateBoulder(iWP1);
    CreateBoulder(iWP2);
}

void CleanUpCaveIn()
{
    object oObj = GetFirstObjectInArea();
    while(GetIsObjectValid(oObj))
    {
        if(GetResRef(oObj) == ROCK_PLACEABLE)
            DestroyObject(oObj);
        oObj = GetNextObjectInArea();
    }
}

object CreateBoulder(int iWP)
{
    string sWPTag = ELED_ROCK_WP + IntToString(iWP);
    object oObj = CreateObject(OBJECT_TYPE_PLACEABLE, ROCK_PLACEABLE,
                 GetLocation(GetObjectByTag(sWPTag)));
    return oObj;
}

void VomitCheck(object oPC, string sMsg)
{
    if(FortitudeSave(oPC, FORT_DC, SAVING_THROW_TYPE_NONE) < 1)
    {
        SendMessageToPC(oPC, sMsg);
        VaultSaveFail(oPC, SAVING_THROW_FORT);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectKnockdown(), oPC, KD_DUR);

        object oPuke = CreateObject(OBJECT_TYPE_PLACEABLE, PUKE_PLACEABLE,
                                    GetLocation(oPC));
        /* Our own vomit won't make us puke, so we don't get stuck in some barf loop */
        SetLocalInt(oPuke, GetName(oPC), 1);
        DelayCommand(120.0, DestroyObject(oPuke));
    }
}

void VaultSaveFail(object oPC, int iSave)
{
    // We'll be nice and not keep infinitely reducing saves.
    effect eLoop = GetFirstEffect(oPC);
    int bFullFort = TRUE;
    while(GetIsEffectValid(eLoop))
    {
       if(GetEffectType(eLoop) == EFFECT_TYPE_SAVING_THROW_DECREASE)
           bFullFort = FALSE;
       eLoop = GetNextEffect(oPC);
    }
    if(bFullFort)
    {
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,
                EffectSavingThrowDecrease(iSave, 2), oPC, 120.0);

    }
}
