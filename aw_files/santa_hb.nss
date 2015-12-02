void main()
{
    if (GetLocalInt(OBJECT_SELF,"santa_shout") == 1)
    {
        int n = GetLocalInt(OBJECT_SELF,"timer");
        if (n >= 40)
        {
            ActionSpeakString("Merry Christmas", TALKVOLUME_SHOUT);
            n = 0;
        }
        //SetLocalInt(OBJECT_SELF,"timer",n+1);
    }
     // just check this one out not sure if it will work...:D//
    ExecuteScript("nw_c2_default1",OBJECT_SELF);
}
