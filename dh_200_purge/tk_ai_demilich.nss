//::///////////////////////////////////////////////
//:: tk_ai_demilich
//:: Custom combat ai for my demilich.
//:://////////////////////////////////////////////
/*
    This is not a real AI, just a few prepatory
    spells to show what can be done.
*/
//:://////////////////////////////////////////////
//:: Created by: The Krit
//:: Created on: May 10, 2007
//:://////////////////////////////////////////////


#include "x2_inc_switches"


void main()
{
    // Get the virtual parameter (primary target of combat).
    object oIntruder = GetCreatureOverrideAIScriptTarget();
    // Clear the virtual parameter (shouls always be called).
    ClearCreatureOverrideAIScriptTarget();

    // Let's instantly cast some protective spells to represent earlier preparations.
    ActionCastSpellAtObject(SPELL_FOXS_CUNNING, OBJECT_SELF, METAMAGIC_ANY, FALSE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE);
    ActionCastSpellAtObject(SPELL_MAGE_ARMOR, OBJECT_SELF, METAMAGIC_ANY, FALSE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE);
    ActionCastSpellAtObject(SPELL_PREMONITION, OBJECT_SELF, METAMAGIC_ANY, FALSE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE);

    // Signal that this AI script took care of the current combat round.
    //SetCreatureOverrideAIScriptFinished();
    // No, don't signal that in this script.

    // We only want this script to run once, so delete the local variable that
    // triggers it.
    DeleteLocalString(OBJECT_SELF, CREATURE_VAR_CUSTOM_AISCRIPT);
}
