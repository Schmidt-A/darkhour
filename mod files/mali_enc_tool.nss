void main()
{
    object oPC = OBJECT_SELF;                     //The player character using the item
    object oTarget = GetSpellTargetObject();      //The target of the spell
    location lTarget = GetSpellTargetLocation();


    lTarget = (GetIsObjectValid(oTarget) ? GetLocation(oTarget) : GetSpellTargetLocation());

    SetLocalLocation(oPC, "lMCS_Spawn", lTarget);
    AssignCommand(oPC, ActionStartConversation(oPC, "enc_spawnmenu", TRUE, FALSE));

}
