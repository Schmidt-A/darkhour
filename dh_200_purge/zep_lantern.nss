// Lantern Item Tag-Based Script. TAG = ZEP_LANTERN
//:://///////////////////////////////////////////////
#include "x2_inc_switches"

void AddLight( object oCreature)
{ if( (GetStringLowerCase( GetTag( OBJECT_SELF)) != "zep_lantern") || !GetIsObjectValid( oCreature) || (GetObjectType( oCreature) != OBJECT_TYPE_CREATURE)) return;

  effect eLight = EffectVisualEffect( VFX_DUR_LIGHT_WHITE_10);
  ApplyEffectToObject( DURATION_TYPE_PERMANENT, SupernaturalEffect( eLight), oCreature);
}


void RemoveLight( object oCreature)
{ if( !GetIsObjectValid( oCreature) || (GetObjectType( oCreature) != OBJECT_TYPE_CREATURE)) return;

  effect eLight = GetFirstEffect( oCreature);
  while( GetIsEffectValid( eLight))
  { if( (GetEffectType( eLight) == EFFECT_TYPE_VISUALEFFECT) &&
        (GetEffectDurationType( eLight) == DURATION_TYPE_PERMANENT) &&
        (GetEffectSubType( eLight) == SUBTYPE_SUPERNATURAL) &&
        (!GetIsObjectValid( GetEffectCreator( eLight)) || (GetStringLowerCase( GetTag( GetEffectCreator( eLight))) == "zep_lantern")))
      RemoveEffect( oCreature, eLight);

    eLight = GetNextEffect( oCreature);
  }
}


void main()
{ switch( GetUserDefinedItemEventNumber())
  { case X2_ITEM_EVENT_EQUIP:
      { // The lantern was just equipped.
        object oEquipper = GetPCItemLastEquippedBy();
        object oLantern  = GetPCItemLastEquipped();
        if( !GetIsObjectValid( oEquipper) || !GetIsObjectValid( oLantern))
        { SetExecutedScriptReturnValue( X2_EXECUTE_SCRIPT_CONTINUE);
          return;
        }

        // Apply a light effect.
        RemoveLight( oEquipper);
        AssignCommand( oLantern, AddLight( oEquipper));
      }
      SetExecutedScriptReturnValue( X2_EXECUTE_SCRIPT_END);
      return;

    case X2_ITEM_EVENT_UNEQUIP:
      { // The item was just un-equipped.
        object oUnequipper = GetPCItemLastUnequippedBy();
        object oLantern    = GetPCItemLastUnequipped();
        if( !GetIsObjectValid( oUnequipper) || !GetIsObjectValid( oLantern))
        { SetExecutedScriptReturnValue( X2_EXECUTE_SCRIPT_CONTINUE);
          return;
        }

        // Remove light effect
        RemoveLight( oUnequipper);
      }
      SetExecutedScriptReturnValue( X2_EXECUTE_SCRIPT_END);
      return;

    case X2_ITEM_EVENT_UNACQUIRE:
      { // The item was just unacquired (dropped, sold, lost, etc).
        object oOldOwner = GetModuleItemLostBy();
        object oLantern  = GetModuleItemAcquired();
        object oNewOwner = GetItemPossessor( oLantern);
        if( !GetIsObjectValid( oOldOwner) || !GetIsObjectValid( oLantern))
        { SetExecutedScriptReturnValue( X2_EXECUTE_SCRIPT_CONTINUE);
          return;
        }

        // Remove light effect
        RemoveLight( oOldOwner);
      }
      SetExecutedScriptReturnValue( X2_EXECUTE_SCRIPT_END);
      return;
  }
SetExecutedScriptReturnValue( X2_EXECUTE_SCRIPT_CONTINUE);
}
