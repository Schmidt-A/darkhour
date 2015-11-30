// DM Target Tool
// by Malishara
//:://////////////////////////////////////////////////////////

string ShowVector(vector vSomewhere)
{   string sVector = FloatToString(vSomewhere.x, 0, 2) + "x "
                   + FloatToString(vSomewhere.y, 0, 2) + "y "
                   + FloatToString(vSomewhere.z, 0, 2) + "z";
    return sVector;
}

void main()
{
    object oItemUser = OBJECT_SELF;
    object oTarget = GetSpellTargetObject();
    location lTarget = GetSpellTargetLocation();


    if(!GetIsObjectValid(oTarget))
    { string sTargetLoc = ShowVector(GetPositionFromLocation(lTarget));
      SendMessageToPC(oItemUser, "Targeted location " + sTargetLoc);
      SetLocalString(oItemUser, "DM_Tool_TargetLoc", sTargetLoc);
      return;
    }

    SetLocalObject(oItemUser, "DM_Tool_Target", oTarget);
    SendMessageToPC(oItemUser, "Targeted " + GetName(oTarget));

     if (GetHasInventory(oTarget) &&
        ((GetObjectType(oTarget) == OBJECT_TYPE_ITEM) ||
         (GetObjectType(oTarget) == OBJECT_TYPE_PLACEABLE)))
     { SetLocalObject(oItemUser, "oDM_Bag1", GetLocalObject(oItemUser, "oDM_Bag2"));
       SetLocalObject(oItemUser, "oDM_Bag2", oTarget);
     }

}
