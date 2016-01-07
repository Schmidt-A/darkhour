void main()
{
    object oItem = GetItemActivated();
    object oPC = GetItemActivator();
    object oTarget = GetItemActivatedTarget();

    if(GetTag(oTarget) != "Spoiled")
    {
        SendMessageToPC(oUser,"You can only use the purifier on spoiled food.");
        return;
    }

    DestroyObject(oTarget);
    CreateItemOnObject("purifiedfood");
}
