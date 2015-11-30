void main()
{
ActionPlayAnimation(ANIMATION_PLACEABLE_ACTIVATE,1.0,1.0);
ActionPlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE,1.0,1.0);
int iState = GetLocalInt(OBJECT_SELF, "currentstate");
int iReady = GetLocalInt(OBJECT_SELF, "isready");
if(iReady == 0)
    {
    if(iState == 0)
        {
        FloatingTextStringOnCreature("Barriers have been raised at map points 1 and 2.", GetLastUsedBy());
        CreateObject(OBJECT_TYPE_PLACEABLE, "magicalbarrie061", GetLocation(GetWaypointByTag("barriertrapwp1")), FALSE, "CustBarrTrap1");
        CreateObject(OBJECT_TYPE_PLACEABLE, "magicalbarrie061", GetLocation(GetWaypointByTag("barriertrapwp2")), FALSE, "CustBarrTrap2");
        CreateObject(OBJECT_TYPE_PLACEABLE, "magicalbarrie061", GetLocation(GetWaypointByTag("barriertrapwp3")), FALSE, "CustBarrTrap3");
        CreateObject(OBJECT_TYPE_PLACEABLE, "magicalbarrie061", GetLocation(GetWaypointByTag("barriertrapwp4")), FALSE, "CustBarrTrap4");
        CreateObject(OBJECT_TYPE_PLACEABLE, "magicalbarrie061", GetLocation(GetWaypointByTag("barriertrapwp5")), FALSE, "CustBarrTrap5");
        CreateObject(OBJECT_TYPE_PLACEABLE, "magicalbarrie061", GetLocation(GetWaypointByTag("barriertrapwp6")), FALSE, "CustBarrTrap6");
        SetLocalInt(OBJECT_SELF, "currentstate", 1);
        }else if(iState == 1)
            {
            FloatingTextStringOnCreature("Barriers have been removed at map points 1 and 2.", GetLastUsedBy());
            DestroyObject(GetNearestObjectByTag("CustBarrTrap1", OBJECT_SELF));
            DestroyObject(GetNearestObjectByTag("CustBarrTrap2", OBJECT_SELF));
            DestroyObject(GetNearestObjectByTag("CustBarrTrap3", OBJECT_SELF));
            DestroyObject(GetNearestObjectByTag("CustBarrTrap4", OBJECT_SELF));
            DestroyObject(GetNearestObjectByTag("CustBarrTrap5", OBJECT_SELF));
            DestroyObject(GetNearestObjectByTag("CustBarrTrap6", OBJECT_SELF));
            SetLocalInt(OBJECT_SELF, "isready", 1);
            DelayCommand(30.0, SetLocalInt(OBJECT_SELF, "isready", 0));
            DelayCommand(30.0, FloatingTextStringOnCreature("The Barriers trap is now ready.", GetLastUsedBy()));
            }
    }else if(iReady == 1)
        {
        FloatingTextStringOnCreature("This trap is not yet ready.", GetLastUsedBy());
        }
}
