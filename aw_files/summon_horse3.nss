#include "x3_inc_horse"

void main()
{
    object oPC = GetPCSpeaker();
    location lTarget = GetLocation(oPC);
    int horse = Random(2)+1;
    object oNightmare;
    switch (horse)
    {
        case 1:  oNightmare = CreateObject(OBJECT_TYPE_CREATURE,"nightmare001",lTarget,TRUE);break;
        case 2:  oNightmare = CreateObject(OBJECT_TYPE_CREATURE,"nightmare002",lTarget,TRUE);break;
        default: oNightmare = CreateObject(OBJECT_TYPE_CREATURE,"nightmare001",lTarget,TRUE);break;
    }
    int voice = Random(3)+1;
    switch (voice)
    {
        case 1:  DelayCommand(2.6,PlayVoiceChat(VOICE_CHAT_BATTLECRY1, oNightmare));break;
        case 2:  DelayCommand(2.6,PlayVoiceChat(VOICE_CHAT_BATTLECRY1, oNightmare)); break;
        case 3:  DelayCommand(2.6,PlayVoiceChat(VOICE_CHAT_BATTLECRY2, oNightmare)); break;
        default: DelayCommand(2.6,PlayVoiceChat(VOICE_CHAT_BATTLECRY3, oNightmare));break;
    }
    DelayCommand(1.2,AssignCommand(oNightmare, PlayAnimation(ANIMATION_FIREFORGET_TAUNT)));
    DelayCommand(5.6,AssignCommand(oNightmare, PlaySound("c_horse_slct")));
}
