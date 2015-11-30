float GestaltGetDirection(object oTarget, object oPC)
{
    // Finds the compass direction from the PC to a target object
    vector vTarget = GetPosition(oTarget);
    vector vPC = GetPosition(oPC);
    vector vdTarget = (vTarget - vPC);
    float fDirection = VectorToAngle(vdTarget);
    return fDirection;
}
void GestaltFaceDirection(float fDirection, float fRange,float fPitch, object oPC, int iFace)
{
    // Turns the camera and/or the PC to face in a given direction
    // If iFace = 0 only the camera turns
    // If iFace = 1 both the camera and the PC turn
    // If iFace = 2 only the PC turns

    if (iFace < 2)
        AssignCommand(oPC,SetCameraFacing(fDirection,fRange,fPitch));
    if (iFace > 0)
        AssignCommand(oPC,SetFacing(fDirection));
}
void GestaltFaceTarget(object oTarget, float fRange,float fPitch, object oPC, int iFace)
{
    // Turns the camera and/or the PC to face a given target
    // If iFace = 0 only the camera turns
    // If iFace = 1 both the camera and the PC turn
    // If iFace = 2 only the PC turns

    float fDirection = GestaltGetDirection(oTarget,oPC);
    if (iFace < 2)
        AssignCommand(oPC,SetCameraFacing(fDirection,fRange,fPitch));
    if (iFace > 0)
        AssignCommand(oPC,SetFacing(fDirection));
}
float GestaltGetPanRate(float fDirection, float fDirection2, float fTicks, int iClockwise)
{
    // Calculates how far the camera needs to move each to tick to go from fDirection to fDirection2
    // in fTicks steps, correcting as necessary to account for clockwise or anti-clockwise movement

    float fdDirection;

    if (iClockwise == 0)
    {
        if (fDirection > fDirection2)
            fdDirection = ((fDirection2 + 360.0 - fDirection) / fTicks);
        else
            fdDirection = ((fDirection2 - fDirection) / fTicks);
    }
    if (iClockwise == 1)
    {
        if (fDirection2 > fDirection)
            fdDirection = ((fDirection2 - fDirection - 360.0) / fTicks);
        else
            fdDirection = ((fDirection2 - fDirection) / fTicks);
    }
    return fdDirection;
}
void GestaltCameraMove(float fDirection, float fRange, float fPitch, float fDirection2, float fRange2, float fPitch2, float fTime,float fFrameRate,object oPC,int iClockwise = 0)
{
// fDirection       initial direction (0.0 = due east)
// fRange           initial distance between player and camera
// fPitch           initial pitch (vertical tilt)
// fDirection2      finishing direction
// fRange2          finishing distance
// fPitch2          finishing tilt
// fTime            number of seconds it takes camera to complete movement
// fTicks           number of ticks during this time (governs how smooth the motion is)
// oPC              the PC you want to apply the camera movement to
// iClockwise       set to 1 if you want the camera to rotate clockwise, 0 for anti-clockwise

    float fCount = 0.0;
    float fDelay = 0.0;
    float fTicks = (fTime * fFrameRate);
    float fdTime = (fTime / fTicks);
    float fdDirection = GestaltGetPanRate(fDirection,fDirection2,fTicks,iClockwise);

    float fdRange = ((fRange2 - fRange) / fTicks);
    float fdPitch = ((fPitch2 - fPitch) / fTicks);
    while (fCount <= fTicks)
    {
        DelayCommand(fDelay,AssignCommand(oPC,SetCameraFacing(fDirection,fRange,fPitch)));
        fDirection = (fDirection + fdDirection);
        fPitch = (fPitch + fdPitch);
        fRange = (fRange + fdRange);
        fCount = (fCount + 1.0);
        fDelay = (fCount * fdTime);

        if (fDirection > 360.0)
            fDirection = (fDirection - 360.0);
    }
}
void GestaltCameraFace(object oStart, float fRange, float fPitch, object oEnd, float fRange2, float fPitch2, float fTime,float fFrameRate,object oPC,int iClockwise = 0,int iFace = 0)
{
// oStart           object to start movement facing
// fRange           initial distance between player and camera
// fPitch           initial pitch (vertical tilt)
// oEnd             object to finish movement facing
// fRange2          finishing distance
// fPitch2          finishing tilt
// fTime            number of seconds it takes camera to complete movement
// fTicks           number of ticks during this time (governs how smooth the motion is)
// oPC              the PC you want to apply the camera movement to
// iClockwise       set to 1 if you want the camera to rotate clockwise, 0 for anti-clockwise
// iFace            if this is set to 1, the PC will turn to face oEnd

    SetCameraMode(oPC,CAMERA_MODE_TOP_DOWN);

    float fCount = 0.0;
    float fDelay = 0.0;
    float fTicks = (fTime * fFrameRate);
    float fdTime = (fTime / fTicks);

    float fDirection = GestaltGetDirection(oStart,oPC);
    float fDirection2 = GestaltGetDirection(oEnd,oPC);

    float fdDirection = GestaltGetPanRate(fDirection,fDirection2,fTicks,iClockwise);

    float fdRange = ((fRange2 - fRange) / fTicks);
    float fdPitch = ((fPitch2 - fPitch) / fTicks);

    while (fCount <= fTicks)
    {
        DelayCommand(fDelay,GestaltFaceDirection(fDirection,fRange,fPitch,oPC,iFace));
        fDirection = (fDirection + fdDirection);
        fPitch = (fPitch + fdPitch);
        fRange = (fRange + fdRange);
        fCount = (fCount + 1.0);
        fDelay = (fCount * fdTime);

        if (fDirection > 360.0)
            fDirection = (fDirection - 360.0);
    }
}
void GestaltCameraTrack(object oTrack, float fRange, float fPitch, float fRange2, float fPitch2, float fTime,float fFrameRate,object oPC,int iFace = 0)
{
// oTrack           object to track the movement of
// fRange           initial distance between player and camera
// fPitch           initial pitch (vertical tilt)
// fRange2          finishing distance
// fPitch2          finishing tilt
// fTime            number of seconds it takes camera to complete movement
// fTicks           number of ticks during this time (governs how smooth the motion is)
// oPC              the PC you want to apply the camera movement to
// iFace            if this is set to 1, the PC will turn to face oEnd

    SetCameraMode(oPC,CAMERA_MODE_TOP_DOWN);

    float fCount = 0.0;
    float fDelay = 0.0;
    float fTicks = (fTime * fFrameRate);
    float fdTime = (fTime / fTicks);

    float fdRange = ((fRange2 - fRange) / fTicks);
    float fdPitch = ((fPitch2 - fPitch) / fTicks);

    while (fCount <= fTicks)
    {
        DelayCommand(fDelay,GestaltFaceTarget(oTrack,fRange,fPitch,oPC,iFace));
        fPitch = (fPitch + fdPitch);
        fRange = (fRange + fdRange);
        fCount = (fCount + 1.0);
        fDelay = (fCount * fdTime);
    }
}
