void main()
{
if(GetLocalInt(GetModule(), "disablecannon3") == 0)
    {
    SetLocalInt(GetModule(), "disablecannon3", 1);
    SendMessageToPC(GetPCSpeaker(), "Cannon 3 is now disabled.");
    }else
        {
        SetLocalInt(GetModule(), "disablecannon3", 0);
        SendMessageToPC(GetPCSpeaker(), "Cannon 3 is now enabled.");
        }
}
