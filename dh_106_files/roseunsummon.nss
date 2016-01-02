void main()
{
object oPC = OBJECT_SELF;
object oPet = GetObjectByTag("RoseHorse");
int iUnsummon = GetLocalInt(oPC, "hasrose");
if(iUnsummon != 0)
    {
    RemoveHenchman(oPC, oPet);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_UNSUMMON), GetLocation(oPet));
    SendMessageToPC(oPC, "This summoning has reached its duration.");
    DestroyObject(oPet);
    SetLocalInt(oPC, "hasrose", 0);
    }
}
