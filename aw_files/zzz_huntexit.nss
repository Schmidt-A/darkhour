
void main()
{
object oPC = GetExitingObject();

    effect eLook = GetFirstEffect(oPC); //STRIP BUFFS!
    while(GetIsEffectValid(eLook))
    {

        RemoveEffect(oPC, eLook);
        eLook = GetNextEffect(oPC);
    }
}
