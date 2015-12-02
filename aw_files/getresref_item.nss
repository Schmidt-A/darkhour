void main()
{
    object oTarget = GetItemActivatedTarget();

    object oPC = GetItemActivator();

    FloatingTextStringOnCreature("Item ResRef: "+ GetResRef(oTarget),oPC,FALSE);
    FloatingTextStringOnCreature("Item TAG: "+GetTag(oTarget),oPC,FALSE);

}
