void main()
{
object oPC = OBJECT_SELF;
object oPet = GetNearestObjectByTag("Amenhotep");
int iUnsummon = GetLocalInt(oPC, "hasamenhotep");
if(iUnsummon == 1)
    {
    RemoveHenchman(oPC, oPet);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_UNSUMMON), GetLocation(oPet));
    SendMessageToPC(oPC, "This summoning has reached its duration.");
    DestroyObject(oPet);
    SetLocalInt(oPC, "hasamenhotep", 0);
    }
}
