//::///////////////////////////////////////////////
//:: Lob Fireballs.nss
//::
//:://////////////////////////////////////////////
/*
        Here's a little script for a catapult that lobs the 'fireball' spell that I made a while ago to lob fireballs over a castle wall. Just put it in the onUsed script for the catapult, and place a bunch (8 in this case) of waypoints with tags "CATAPULT_0"

        Spell scripts aren't actually executed until the projectile strikes the target, so the damage should be synchronized with the explosion (and you get a nice arcing projectile so you can shoot over walls).
*/
//:://////////////////////////////////////////////
//:: Created By: Noel Borstad (BioWare)
//:: Created On: 7/6/02
//:://////////////////////////////////////////////

void main()
{
    object o = GetNearestObjectByTag( "CATAPULT_0", OBJECT_SELF, Random(5) + 1);
    location l = GetLocation( o );
    ActionCastSpellAtLocation(SPELL_FIREBALL, l, METAMAGIC_ANY, TRUE, PROJECTILE_PATH_TYPE_BALLISTIC);
}
