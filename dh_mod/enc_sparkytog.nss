void main()
{
    object oArea = GetArea(OBJECT_SELF);
    int iDisabled = GetLocalInt(oArea, "iSparkyDisabled");

    iDisabled = abs(iDisabled - 1);
    SetLocalInt(oArea, "iSparkyDisabled", iDisabled);

    string sStatus = iDisabled ? "OFF" : "ON";
    SendMessageToPC(OBJECT_SELF, "Sparky Spawns are now " + sStatus);
}
