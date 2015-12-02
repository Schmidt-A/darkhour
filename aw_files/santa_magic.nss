void main()
{
object oSanta = OBJECT_SELF;
object oPC = GetPCSpeaker();

ActionCastFakeSpellAtLocation(SPELL_MASS_BLINDNESS_AND_DEAFNESS,GetLocation(oPC));
}
