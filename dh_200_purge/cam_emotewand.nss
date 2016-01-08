//::///////////////////////////////////////////////
//:: Name: cam_emotewand
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Camera script for the emotewand.
*/
//:://////////////////////////////////////////////
//:: Created By: Samius Maximus
//:: Created On:
//:://////////////////////////////////////////////
#include "inc_camera"

void main()
{
    object oUser = GetPCSpeaker();

    GestaltCameraMove (0.0, 20.0, 0.0, 270.0, 5.0, 50.0, 2.0, 20.0, oUser, 0);
    PlayVoiceChat (VOICE_CHAT_HELLO, oUser);
}
