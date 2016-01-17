void main()
{
    object oPC = GetLastDamager();
    // TODO: Check profession = miner down the road
    object oWeapon = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oPC);
    string sMsg = "Thanks to " + GetName(oPC) + "'s mining knowledge, you are able to " +
        "clear the blockage effectively.";

    if(GetTag(oWeapon) == "miner_pickaxe")
    {
        int iHits = GetLocalInt(OBJECT_SELF, "iHits");
        if(iHits >= 5)
        {
            ApplyEffectToObject(DURATION_TYPE_INSTANT,
                EffectVisualEffect(VFX_COM_CHUNK_STONE_MEDIUM), OBJECT_SELF);
            DestroyObject(OBJECT_SELF);
        }
        else if(iHits == 2)
        {
            sMsg = "With every blow from a miner's trusty pickaxe, the cave-in" +
                " boulders and debris begin to clear.";
            AssignCommand(OBJECT_SELF, ActionSpeakString(sMsg));
        }
        else if(!GetLocalInt(OBJECT_SELF, "bSpokeMiner"))
        {
            sMsg = "Thanks to some digging knowledge and the right tools for the " +
                "job, a few cracks begin to form in the boulder that blocks your " +
                " path.";
            AssignCommand(OBJECT_SELF, ActionSpeakString(sMsg));
            SetLocalInt(OBJECT_SELF, "bSpokeMiner", TRUE);
        }
        SetLocalInt(OBJECT_SELF, "iHits", iHits+1);
    }
    else if(!GetLocalInt(OBJECT_SELF, "bSpokeFail"))
    {
        sMsg = "Untrained hands and weapons ill-suited for the task make clearing " +
            "this rubble impossible.";
        AssignCommand(OBJECT_SELF, ActionSpeakString(sMsg));
        SetLocalInt(OBJECT_SELF, "bSpokeFail", TRUE);
    }
}
