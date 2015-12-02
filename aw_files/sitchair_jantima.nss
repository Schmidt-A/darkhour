void main()
{
    object oUser = GetLastUsedBy();
    string sName = GetPCPlayerName(oUser);
    object oChair=OBJECT_SELF;
    if (sName == "Jantima")  //I love you -- Vlad
    {
        AssignCommand(oUser,ActionSit(oChair));
        FloatingTextStringOnCreature("Welcome Jantima", oUser, FALSE);
    }
    else if (sName == "Vladiat0r")
    {
        AssignCommand(oUser,ActionSit(oChair));
        FloatingTextStringOnCreature("Welcome Vladiat0r", oUser, FALSE);
    }
    else
    {
        FloatingTextStringOnCreature("You are not allowed to use this", oUser, FALSE);
    }
}
