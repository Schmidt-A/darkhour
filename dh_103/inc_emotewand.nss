//::///////////////////////////////////////////////
//:: Name: inc_emotewand
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    An INCLUDE script to handle all EmoteWand
    functions.
*/
//:://////////////////////////////////////////////
//:: Created By: Samius Maximus
//:: Created On:
//:://////////////////////////////////////////////
object oPlayer = GetPCSpeaker();
int iRoll;

void Roll100()
{
    iRoll = d100();

    AssignCommand (oPlayer, ActionPlayAnimation (ANIMATION_LOOPING_GET_MID, 3.0, 3.0));
    DelayCommand (2.0, AssignCommand (oPlayer, SpeakString ("*Rolls a 100-sided die, and recieves a " + IntToString (iRoll) + ".*")));
}
void Roll10()
{
    iRoll = d10();

    AssignCommand (oPlayer, ActionPlayAnimation (ANIMATION_LOOPING_GET_MID, 3.0, 3.0));
    DelayCommand (2.0, AssignCommand (oPlayer, SpeakString ("*Rolls a 10-sided die, and recieves a " + IntToString (iRoll) + ".*")));
}
void Roll12()
{
    iRoll = d12();

    AssignCommand (oPlayer, ActionPlayAnimation (ANIMATION_LOOPING_GET_MID, 3.0, 3.0));
    DelayCommand (2.0, AssignCommand (oPlayer, SpeakString ("*Rolls a 12-sided die, and recieves a " + IntToString (iRoll) + ".*")));
}
void Roll20()
{
    iRoll = d20();

    AssignCommand (oPlayer, ActionPlayAnimation (ANIMATION_LOOPING_GET_MID, 3.0, 3.0));
    DelayCommand (2.0, AssignCommand (oPlayer, SpeakString ("*Rolls a 20-sided die, and recieves a " + IntToString (iRoll) + ".*")));
}
void Roll4()
{
    iRoll = d4();

    AssignCommand (oPlayer, ActionPlayAnimation (ANIMATION_LOOPING_GET_MID, 3.0, 3.0));
    DelayCommand (2.0, AssignCommand (oPlayer, SpeakString ("*Rolls a 4-sided die, and recieves a " + IntToString (iRoll) + ".*")));
}
void Roll6()
{
    iRoll = d6();

    AssignCommand (oPlayer, ActionPlayAnimation (ANIMATION_LOOPING_GET_MID, 3.0, 3.0));
    DelayCommand (2.0, AssignCommand (oPlayer, SpeakString ("*Rolls a 6-sided die, and recieves a " + IntToString (iRoll) + ".*")));
}
void Roll8()
{
    iRoll = d8();

    AssignCommand (oPlayer, ActionPlayAnimation (ANIMATION_LOOPING_GET_MID, 3.0, 3.0));
    DelayCommand (2.0, AssignCommand (oPlayer, SpeakString ("*Rolls an 8-sided die, and recieves a " + IntToString (iRoll) + ".*")));
}
void Dance()
{
    AssignCommand (oPlayer, ActionPlayAnimation (ANIMATION_FIREFORGET_VICTORY2));
    DelayCommand (3.0, AssignCommand (oPlayer, ActionPlayAnimation (ANIMATION_LOOPING_TALK_LAUGHING, 3.0, 2.0)));
    DelayCommand (3.0, AssignCommand (oPlayer, PlayVoiceChat (VOICE_CHAT_LAUGH)));
    DelayCommand (5.0, AssignCommand (oPlayer, ActionPlayAnimation (ANIMATION_FIREFORGET_VICTORY1)));
    DelayCommand (8.5, AssignCommand (oPlayer, ActionPlayAnimation (ANIMATION_FIREFORGET_VICTORY3)));
    DelayCommand (11.0, AssignCommand (oPlayer, ActionPlayAnimation (ANIMATION_LOOPING_GET_MID, 3.0, 2.0)));
    DelayCommand (14.5, AssignCommand (oPlayer, PlayVoiceChat (VOICE_CHAT_LAUGH)));
    DelayCommand (13.0, AssignCommand (oPlayer, ActionPlayAnimation (ANIMATION_FIREFORGET_VICTORY3)));
}
void Drunk()
{
    AssignCommand (oPlayer, ActionPlayAnimation (ANIMATION_LOOPING_PAUSE_DRUNK, 1.0, 10000.0));
}
void Meditate()
{
    AssignCommand (oPlayer, ActionPlayAnimation (ANIMATION_LOOPING_MEDITATE, 1.0, 10000.0));
}
void Read()
{
    AssignCommand (oPlayer, ActionPlayAnimation (ANIMATION_FIREFORGET_READ));
    DelayCommand (2.8, AssignCommand (oPlayer, ActionPlayAnimation (ANIMATION_FIREFORGET_READ)));
    DelayCommand (5.6, AssignCommand (oPlayer, ActionPlayAnimation (ANIMATION_FIREFORGET_READ)));
    DelayCommand (8.7, AssignCommand (oPlayer, ActionPlayAnimation (ANIMATION_FIREFORGET_READ)));
}
void Sit()
{
    AssignCommand (oPlayer, ActionPlayAnimation (ANIMATION_LOOPING_SIT_CROSS, 0.5, 10000.0));
}
void Worship()
{
    AssignCommand (oPlayer, ActionPlayAnimation (ANIMATION_LOOPING_WORSHIP, 1.0, 10000.0));
}
void TalkForceful()
{
    AssignCommand (oPlayer, ActionPlayAnimation (ANIMATION_LOOPING_TALK_FORCEFUL, 1.0, 4.0));
}
void TalkLaughing()
{
    AssignCommand (oPlayer, ActionPlayAnimation (ANIMATION_LOOPING_TALK_LAUGHING, 1.0, 4.0));
}
void TalkPleading()
{
    AssignCommand (oPlayer, ActionPlayAnimation (ANIMATION_LOOPING_TALK_PLEADING, 1.0, 4.0));
}
void TakeNap()
{
    effect eNap = EffectVisualEffect (VFX_IMP_SLEEP);

    ApplyEffectToObject (DURATION_TYPE_INSTANT, eNap, oPlayer, 1.0);
    AssignCommand (oPlayer ,ActionPlayAnimation (ANIMATION_LOOPING_DEAD_FRONT, 1.0, 10000.0));
}
void SingWhistle()
{
    effect eSong = EffectVisualEffect (VFX_DUR_BARD_SONG);

    ApplyEffectToObject (DURATION_TYPE_INSTANT, eSong, oPlayer, 1.0);
    DelayCommand (4.0, ApplyEffectToObject (DURATION_TYPE_INSTANT, eSong, oPlayer, 4.0));
    AssignCommand (oPlayer ,ActionPlayAnimation (ANIMATION_LOOPING_PAUSE2, 1.0, 3.0));
}
void Drink()
{
    AssignCommand (oPlayer, ActionPlayAnimation (ANIMATION_FIREFORGET_DRINK, 1.0, 2.0));
}
void Duck()
{
    AssignCommand (oPlayer, ActionPlayAnimation (ANIMATION_FIREFORGET_DODGE_DUCK, 1.0, 1.0));
}
void Dodge()
{
    AssignCommand (oPlayer, ActionPlayAnimation (ANIMATION_FIREFORGET_DODGE_SIDE, 1.0, 1.0));
}
void Steal()
{
    AssignCommand (oPlayer, ActionPlayAnimation (ANIMATION_FIREFORGET_STEAL, 0.8, 2.0));
}
void LayBack()
{
    AssignCommand (oPlayer, ActionPlayAnimation (ANIMATION_LOOPING_DEAD_BACK, 1.0, 10000.0));
}
void LayFacedown()
{
    AssignCommand (oPlayer, ActionPlayAnimation (ANIMATION_LOOPING_DEAD_FRONT, 1.0, 10000.0));
}
void Shiver()
{
    AssignCommand (oPlayer, ActionPlayAnimation (ANIMATION_LOOPING_SPASM, 1.0, 1.0));
}
void ScratchHead()
{
    AssignCommand (oPlayer, ActionPlayAnimation (ANIMATION_FIREFORGET_PAUSE_SCRATCH_HEAD, 0.7, 1.0));
}
void Salute()
{
    AssignCommand (oPlayer, ActionPlayAnimation (ANIMATION_FIREFORGET_SALUTE, 0.9, 1.0));
// + Seems to make things FAST. Didn't even happen! - doesn't seem to slow this one...
}
void Conjure1()
{
    AssignCommand (oPlayer, ActionPlayAnimation (ANIMATION_LOOPING_CONJURE1, 1.0, 20.0));
}
void Conjure2()
{
    AssignCommand (oPlayer, ActionPlayAnimation (ANIMATION_LOOPING_CONJURE2, 1.0, 20.0));
}
void FiddleWith()
{
    AssignCommand (oPlayer, ActionPlayAnimation (ANIMATION_LOOPING_GET_MID, 0.8, 10000.0));
}
void FiddleLow()
{
    AssignCommand (oPlayer, ActionPlayAnimation (ANIMATION_LOOPING_GET_LOW, 0.8, 10000.0));
}
