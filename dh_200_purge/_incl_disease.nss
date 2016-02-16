/* This overall probably needs more work. I still don't like the application/
 * recovering scripts. */

#include "_incl_location"
#include "_incl_pc_data"
#include "nw_i0_generic"
#include "_incl_inventory"

// The actual DC ends up being BASE_DC + number of infection points
int BASE_DC = 12;
string APPLIER_TAG = "Disease_Applier";

// Messages that will be displayed to the PC at varying stages of the disease.
string MSG_2 = "The realization that the undead disease is spreading through " +
    "your veins sends a shiver down your spine.";
string MSG_5 = "Your limbs tremble. Your vision begins to blur. Your head feels " +
    "as if it's on fire. The plague continues to ravage your body.";
string MSG_8 = "You feel your very soul aching and burning in response to the " +
    "progressing infection. It cries out for respite. Your skin has become pale " +
    "and eerily translucent, allowing a glimpse at gangrenous blood coursing " +
    "through your veins. Between your shuddering and profuse sweating, you " +
    "begin to fear that the end is coming.";
string MSG_9 = "Your conciousness teeters on the edge of a dark abyss. Looking " +
    "below you see oblivion - thousands of souls that have met with the fate " +
    "that now stares you down. They scream up to you, begging for help, for " +
    "an end to their wretched half-life. You MUST deal with this sickness - it has nearly " +
    "claimed your soul to join the legion below. With mind elsewhere, clouded " +
    "eyes and fetid flesh, you are scarcely recognizeable from the walking " +
    "corpses all around.";

void CreateClone(object oPC, location lMirror);

void ReduceDiseaseEffects(object oPC, int iDisease);
void CureDisease(object oPC, int iHowMany=10);
void ApplyDisease(object oPC);
void HBDiseaseCheck(object oPC);


void CreateClone(object oPC, location lMirror)
{
    object oCopy1 = CopyObject(oPC, lMirror, OBJECT_INVALID, "PlayerZombie");

    //Move all items to their new zombie corpse
    TransferAllItems(oPC, oCopy1, FALSE, TRUE, TRUE);

    // MHADLEY -- Create zombie gear
    object oG1 = CreateItemOnObject("ZombieCloneBelt",oCopy1);
    DelayCommand(0.2,SetDroppableFlag(oG1, FALSE));
    DelayCommand(0.2,AssignCommand(oCopy1,ActionEquipItem(oG1,INVENTORY_SLOT_BELT)));
    object oG2 = CreateItemOnObject("it_crewps004",oCopy1);
    DelayCommand(0.4,SetDroppableFlag(oG2, FALSE));
    DelayCommand(0.4,AssignCommand(oCopy1,ActionEquipItem(oG2,INVENTORY_SLOT_CWEAPON_B)));
    object oG3 = CreateItemOnObject("nw_it_creitemunf001",oCopy1);
    DelayCommand(0.6,SetDroppableFlag(oG3, FALSE));
    DelayCommand(0.6,AssignCommand(oCopy1,ActionEquipItem(oG3,INVENTORY_SLOT_CARMOUR)));
    ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectMovementSpeedDecrease(75),oCopy1);
    int nLevel = LevelUpHenchman(oCopy1,CLASS_TYPE_UNDEAD);

    ChangeToStandardFaction(oCopy1, STANDARD_FACTION_HOSTILE);
    DelayCommand(2.0, AssignCommand(oCopy1, ClearAllActions()));
}


void ReduceDiseaseEffects(object oPC, int iDisease)
{
    object oApplier = GetObjectByTag(APPLIER_TAG);
    effect eEffect = GetFirstEffect(oPC);

    while(GetIsEffectValid(eEffect))
    {
        if(GetEffectCreator(eEffect) == oApplier)
            RemoveEffect(oPC, eEffect);
        eEffect = GetNextEffect(oPC);
    }

    /* This isn't great but it'll do for now. Redo this because we've removed
       all of the disease effects. */
    if(iDisease >= 2)
        ApplyDisease(oPC);
}

void CureDisease(object oPC, int iHowMany=10)
{
    if(!PCDIsDiseased(oPC))
    {
        FloatingTextStringOnCreature("There was no disease to cure", oPC, FALSE);
        return;
    }

    ApplyEffectToObject(DURATION_TYPE_INSTANT,
                        EffectVisualEffect(VFX_IMP_REMOVE_CONDITION), oPC);

    int iDisease = PCDGetDiseaseValue(oPC) - iHowMany;
    if(iDisease < 0)
        iDisease = 0;

    ReduceDiseaseEffects(oPC, iDisease);
    PCDSetDiseaseValue(oPC, iDisease);

    if(iDisease < 1)
        FloatingTextStringOnCreature("The plague was fully cured!", oPC, FALSE);
    else
        FloatingTextStringOnCreature("The plague's grip was lessened.", oPC, FALSE);
}

void ApplyDisease(object oPC)
{
    object oApplier = GetObjectByTag(APPLIER_TAG);
    int iDisease = PCDGetDiseaseValue(oPC);
    int iAbility;
    effect eEffect;
    float fDuration;

    switch(iDisease)
    {
        case 2:
            iAbility = ABILITY_CONSTITUTION;
            break;
        case 3:
            iAbility = ABILITY_DEXTERITY;
            break;
        case 4:
            iAbility = ABILITY_STRENGTH;
            break;
        case 5:
            iAbility = ABILITY_INTELLIGENCE;
            break;
        case 6:
            iAbility = ABILITY_WISDOM;
            break;
        case 7:
            iAbility = ABILITY_CHARISMA;
            break;
        case 8:
            eEffect = SupernaturalEffect(EffectAbilityDecrease(ABILITY_STRENGTH, 2));
            AssignCommand(oApplier, ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect, oPC));

            eEffect = SupernaturalEffect(EffectAbilityDecrease(ABILITY_DEXTERITY, 2));
            AssignCommand(oApplier, ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect, oPC));

            eEffect = SupernaturalEffect(EffectAbilityDecrease(ABILITY_CONSTITUTION, 2));
            AssignCommand(oApplier, ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect, oPC));
            break;
        case 9:
            eEffect = EffectConfused();
            fDuration = IntToFloat(Random(60)+1);
            AssignCommand(oApplier,
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oPC,
                    fDuration));
            break;
        default:
            break;
    }

    if(iDisease < 8)
    {
        eEffect = SupernaturalEffect(EffectAbilityDecrease(iAbility, 2));
        AssignCommand(oApplier, ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect, oPC));
    }
}

void HBDiseaseCheck(object oPC)
{
    int iDisease = PCDGetDiseaseValue(oPC);
    if(iDisease < 1)
        return;

    string sMsg;

    // We'll only ever gain more disease if we're injured.
    if(GetCurrentHitPoints(oPC) < GetMaxHitPoints(oPC))
    {
        SetLocalInt(oPC,"heltimer", 0); // Can't bother trying to heal.
        int nDisTimer = GetLocalInt(oPC,"distimer") + 1;
        if (nDisTimer >= 5)
        {
            nDisTimer = 0;
            if (FortitudeSave(oPC,(BASE_DC + iDisease),SAVING_THROW_TYPE_DISEASE) == 0)
            {
                iDisease += 1;
                if (iDisease > 9)
                {
                    PCDSetZombied(oPC);
                    location lMirror = GetLocation(oPC);
                    DelayCommand(0.5,CreateClone(lMirror));

                    PortToWaypoint(oPC, "lostsoularrive");
                    DelayCommand(0.3,FloatingTextStringOnCreature("Your body has become a zombie.",oPC,FALSE));
                    DelayCommand(0.5,FloatingTextStringOnCreature("You are now a lost soul.",oPC,FALSE));
                }
                else
                {
                    ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_IMP_DISEASE_S),oPC);
                    ApplyDisease(oPC);
                    switch(iDisease)
                    {
                        case 2:
                            sMsg = MSG_2;
                            break;
                        case 5:
                            sMsg = MSG_5;
                            break;
                        case 8:
                            sMsg = MSG_8;
                            break;
                        case 9:
                            sMsg = MSG_9;
                            break;
                        default:
                            sMsg = "The disease continues to spread.";
                            break;

                    }
                    FloatingTextStringOnCreature(sMsg, oPC, FALSE);
                }
                PCDSetDiseaseValue(oPC, iDisease);
            }
            else
                FloatingTextStringOnCreature("You resist the disease for now...", oPC, FALSE);
        }
        SetLocalInt(oPC, "distimer", nDisTimer);
    }
    // Otherwise we can try to start healing from it.
    else if(GetCurrentHitPoints(oPC) >= GetMaxHitPoints(oPC))
    {
        SetLocalInt(oPC, "distimer", 0);
        int nHelTimer = GetLocalInt(oPC,"heltimer") + 1;
        if (nHelTimer >= 160)
        {
            nHelTimer = 0;
            if (FortitudeSave(oPC,(BASE_DC + iDisease), SAVING_THROW_TYPE_DISEASE) == 1)
            {
                iDisease -= 1;
                ReduceDiseaseEffects(oPC, iDisease);
                if (iDisease == 0)
                    sMsg = "The disease has completely passed.";
                else
                    sMsg = "The disease fades a little.";
            }
            else
                sMsg = "Your disease condition remains stable, but does not improve.";
            FloatingTextStringOnCreature(sMsg, oPC, FALSE);
            PCDSetDiseaseValue(oPC, iDisease);
        }
        SetLocalInt(oPC, "heltimer", nHelTimer);
    }
}
