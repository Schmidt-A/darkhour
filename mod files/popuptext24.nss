void main()
{

object oPC = GetEnteringObject();

if (!GetIsPC(oPC)) return;

int DoOnce = GetLocalInt(oPC, GetTag (OBJECT_SELF));

if (DoOnce==TRUE) return;

SetLocalInt(oPC, GetTag(OBJECT_SELF), TRUE);

FloatingTextStringOnCreature("As you make your way into the huge temple room before you, a loud skittering sound overhead is heard- beneath the shadows and dust veiling the stone roof. The skittering speeds and suddenly a loud, gut-wrenching screeching is heard as a massive beast drops from the ceiling ahead. THUD! The ground shakes. And there, stand the Hirudean queen. Poised. For battle.", oPC);

}
