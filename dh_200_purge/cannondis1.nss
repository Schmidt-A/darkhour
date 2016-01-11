void main()
{
if(GetLocalInt(GetModule(), "disablecannon1") == 0)
    {
    SetLocalInt(GetModule(), "disablecannon1", 1);
    SendMessageToPC(GetPCSpeaker(), "Cannon 1 is now disabled.");
    }else
        {
        SetLocalInt(GetModule(), "disablecannon1", 0);
        SendMessageToPC(GetPCSpeaker(), "Cannon 1 is now enabled.");
        }
}
