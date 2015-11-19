//::///////////////////////////////////////////////
//:: FileName: tbx0_banjo01
//:://////////////////////////////////////////////
/*
    this script will cause pc to equip my banjo and
    do the play music animation

    call script from an item with item property:
    "unique power, self only - unlimited uses per day"

    (item should be restricted to be used only by
    human and half-elves, as they are the only ones
    the animation works for!)
*/
//:://////////////////////////////////////////////
//:: Created By: John Hawkins
//:: Created On: 04/04/2008
//:://////////////////////////////////////////////   plc_invisobj
void main()
{
    object oPC = OBJECT_SELF;

    // make sure user is correct phenotype and gender
    // to use playing animation...
    int iPheno = GetPhenoType(oPC);
    if (iPheno != 40) return;
    if (GetGender(oPC) != GENDER_MALE) return;

    // we can't play music with weapons equipped!
    object oLeft = GetItemInSlot(INVENTORY_SLOT_LEFTHAND,oPC);
    object oRight = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oPC);
    string sMessage = "*You cannot play music when you have other items in your hands!*";
    if(GetIsObjectValid(oLeft) || GetIsObjectValid(oRight))
    {
        AssignCommand(oPC,ClearAllActions());
        SendMessageToPC(oPC,sMessage);
        return;
    }

    // *everything checks out, continuing with function*

    // location to play sound from
    location lLoc = GetLocation(oPC);

    // create object to play sound
    object oSound = CreateObject(OBJECT_TYPE_PLACEABLE,"plc_invisobj",lLoc,FALSE,"TBX_SOUND_OBJ");

    // visual effect == banjo
    effect eVis = EffectVisualEffect(820);

    // sound to play with animation
    string sSound;
    int iSwitch = d100();
    if (iSwitch < 51) sSound = "as_cv_lute1";
    else sSound = "as_cv_lute1b";
    AssignCommand(oSound,DelayCommand(2.8,PlaySound(sSound)));
    AssignCommand(oSound,DelayCommand(7.8,PlaySound(sSound)));
    AssignCommand(oSound,DelayCommand(12.8,PlaySound(sSound)));
    AssignCommand(oSound,DelayCommand(17.8,PlaySound(sSound)));
    AssignCommand(oSound,DelayCommand(22.8,PlaySound(sSound)));
    AssignCommand(oSound,DelayCommand(27.8,PlaySound(sSound)));

    // make pc do the play music animation
    DelayCommand(1.0,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eVis,oPC,32.0));
    AssignCommand(oPC,ActionPlayAnimation(ANIMATION_LOOPING_CUSTOM1,1.0,30.0));
    DestroyObject(oSound,33.0);
}
