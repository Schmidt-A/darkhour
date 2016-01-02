void main()
{
if(GetLocalInt(GetModule(), "disablecannon2") == 0)
    {
    SetLocalInt(GetModule(), "disablecannon2", 1);
    SendMessageToPC(GetPCSpeaker(), "Cannon 2 is now disabled.");
    }else
        {
        SetLocalInt(GetModule(), "disablecannon2", 0);
        SendMessageToPC(GetPCSpeaker(), "Cannon 2 is now enabled.");
        }
}
