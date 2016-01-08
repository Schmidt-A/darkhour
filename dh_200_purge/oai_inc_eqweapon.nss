////////////////////////////////////////////////////////////////////////////////
//
//  Olander's AI
//  oai_inc_eqweapon
//  by Don Anderson
//  dandersonru@msn.com
//
//  Equip Appropriate Weaopns
//  Originally Jasperre's 'j_inc_equipweapo'
//
//  This will use the set weapons, especially good
//  for duel wielding and ranged weapon choosing, and shields!
//
////////////////////////////////////////////////////////////////////////////////

// Equip the weapon appropriate to enemy and position
// Will also pick up your weapon if disarmed.
void EquipAppropriateWeapons(object oTarget);
void EquipAppropriateWeapons(object oTarget)
{
    object oRanged = GetLocalObject(OBJECT_SELF, "DW_RANGED");
    int iRanged = GetIsObjectValid(oRanged);
    object oRight = (GetItemInSlot(INVENTORY_SLOT_RIGHTHAND));
    object oPrimary = GetLocalObject(OBJECT_SELF, "DW_PRIMARY");
    int iPrimary = GetIsObjectValid(oPrimary);
    object oSecondary = GetLocalObject(OBJECT_SELF, "DW_SECONDARY");
    int iSecondary = GetIsObjectValid(oSecondary);
    object oShield = GetLocalObject(OBJECT_SELF, "DW_SHIELD");
    int iShield = GetIsObjectValid(oShield);
    object oTwoHanded = GetLocalObject(OBJECT_SELF, "DW_TWO_HANDED");
    int iTwoHanded = GetIsObjectValid(oTwoHanded);
    object oLeft = (GetItemInSlot(INVENTORY_SLOT_LEFTHAND));
    object oEnemy = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, OBJECT_SELF, 1, CREATURE_TYPE_IS_ALIVE, TRUE);

    //Disarmed and Loss Stuff
    if(iRanged &&
      !GetIsObjectValid(GetItemPossessor(oRanged)) &&
      GetDistanceToObject(oTarget) > 4.0 &&
      GetDistanceToObject(oRanged) > 0.0)
    {
      ActionPickUpItem(oRanged);
    }
    else if(iRanged &&
      GetIsObjectValid(GetItemPossessor(oRanged)) &&
      GetItemPossessor(oRanged) != OBJECT_SELF)
    {
      DeleteLocalObject(OBJECT_SELF, "DW_RANGED");
      iRanged = FALSE;
    }
    else if(!iPrimary && iTwoHanded &&
      !GetIsObjectValid(GetItemPossessor(oTwoHanded)) &&
      GetDistanceToObject(oTwoHanded) < 3.0 &&
      GetDistanceToObject(oTwoHanded) > 0.0)
    {
      ActionPickUpItem(oTwoHanded);
    }
    else if(iTwoHanded && GetItemPossessor(oTwoHanded) != OBJECT_SELF)
    {
      DeleteLocalObject(OBJECT_SELF, "DW_TWO_HANDED");
      iTwoHanded = FALSE;
    }
    else if(iPrimary && !iTwoHanded &&
      !GetIsObjectValid(GetItemPossessor(oPrimary)) &&
      GetDistanceToObject(oPrimary) < 3.0 &&
      GetDistanceToObject(oPrimary) > 0.0)
    {
      ActionPickUpItem(oPrimary);
    }
    else if(iPrimary && GetItemPossessor(oPrimary) != OBJECT_SELF)
    {
      DeleteLocalObject(OBJECT_SELF, "DW_PRIMARY");
      iPrimary = FALSE;
    }
    if(iPrimary)
    {
      if(GetItemPossessor(oSecondary) != OBJECT_SELF)
      {
        DeleteLocalObject(OBJECT_SELF, "DW_SECONDARY");
        iSecondary = FALSE;
      }
      if(GetItemPossessor(oShield) != OBJECT_SELF)
      {
        DeleteLocalObject(OBJECT_SELF, "DW_SHIELD");
        iShield = FALSE;
      }
    }

    //Equiping Stuff
    if(iRanged &&
      (GetDistanceToObject(oEnemy) > 3.0 ||
      (!iPrimary && !iTwoHanded &&
      !GetHasFeat(FEAT_IMPROVED_UNARMED_STRIKE) &&
      !GetHasFeat(FEAT_WEAPON_PROFICIENCY_CREATURE))))
    { //what the previous mess says is that unless we have a primary weapon,
      //creature weapon, or decent fists, use our ranged weapon.
      if(oRight != oRanged)
      {
        ActionEquipItem(oRanged, INVENTORY_SLOT_RIGHTHAND);
      }
      if(!GetHasFeat(FEAT_POINT_BLANK_SHOT) &&
        GetAttackTarget(oEnemy) != OBJECT_SELF &&
        GetDistanceToObject(oEnemy) < 3.0)
      {
        ActionMoveAwayFromObject(oEnemy, TRUE, 10.0);
      }
      return;
    }
    else if(iTwoHanded)
    {
      if(oRight != oTwoHanded)
      {
        ActionEquipItem(oTwoHanded, INVENTORY_SLOT_RIGHTHAND);
      }
      return;
    }
    else if(iPrimary)
    {
      if(oRight != oPrimary)
      {
        ActionEquipItem(oPrimary, INVENTORY_SLOT_RIGHTHAND);
      }
      else return;
      if(iSecondary && (oLeft != oSecondary))
      {
        ActionEquipItem(oSecondary, INVENTORY_SLOT_LEFTHAND);
      }
      else if(!iSecondary && iShield && (oLeft != oShield))
      {
        ActionEquipItem(oShield, INVENTORY_SLOT_LEFTHAND);
      }
      return;
    }
    else
    {
      ActionEquipMostDamagingMelee();
    }
}

//void main(){}
