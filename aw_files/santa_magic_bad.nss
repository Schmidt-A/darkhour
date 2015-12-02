void main()
{
object oSanta = OBJECT_SELF;
object oPC = GetPCSpeaker();
 //Visual effect
ActionCastFakeSpellAtLocation(SPELL_INFERNO,GetLocation(oPC));
//ActionCastFakeSpellAtLocation(SPELL_MASS_BLINDNESS_AND_DEAFNESS,GetLocation(oPC));
}
