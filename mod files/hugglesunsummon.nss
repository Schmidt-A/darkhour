void main()
{
object oPC = OBJECT_SELF;
object oPet = GetObjectByTag("huggles");
int iUnsummon = GetLocalInt(oPC, "hashuggles");
if(iUnsummon == 1)
    {
    RemoveHenchman(oPC, oPet);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_UNSUMMON), GetLocation(oPet));
    SendMessageToPC(oPC, "This summoning has reached its duration.");
    DestroyObject(oPet);
    SetLocalInt(oPC, "hashuggles", 0);
    }
}
