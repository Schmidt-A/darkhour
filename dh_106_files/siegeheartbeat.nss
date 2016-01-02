void main()
{
int iCount = GetLocalInt(OBJECT_SELF, "startcount");
int iTotal = GetLocalInt(OBJECT_SELF, "total");
if(iCount < 0)
    {
    iTotal += 6;
    SetLocalInt(OBJECT_SELF, "total", iTotal);
    }
if(iTotal >= 40)
    {
    SetLocalInt(OBJECT_SELF, "total", 0);
    SetLocalInt(OBJECT_SELF, "startcount", 0);
    SetLocalInt(OBJECT_SELF, "isloaded", 1);
    SetLocalInt(OBJECT_SELF, "isloading", 0);
    SpeakString("The cannon is loaded.");
    }
int iDestroy1 = GetLocalInt(GetModule(), "destroycannon1");
int iDestroy2 = GetLocalInt(GetModule(), "destroycannon2");
int iDestroy3 = GetLocalInt(GetModule(), "destroycannon3");
string sTag = GetTag(OBJECT_SELF);
if((iDestroy1 == 1) && (sTag == "CustomCannon1"))
    {
    DestroyObject(OBJECT_SELF);
    SetLocalInt(GetModule(), "destroycannon1", 0);
    SetLocalInt(GetModule(), "cannon1placed", 0);
    }
if((iDestroy2 == 1) && (sTag == "CustomCannon2"))
    {
    DestroyObject(OBJECT_SELF);
    SetLocalInt(GetModule(), "destroycannon2", 0);
    SetLocalInt(GetModule(), "cannon2placed", 0);
    }
if((iDestroy3 == 1) && (sTag == "CustomCannon3"))
    {
    DestroyObject(OBJECT_SELF);
    SetLocalInt(GetModule(), "destroycannon3", 0);
    SetLocalInt(GetModule(), "cannon3placed", 0);
    }
if((GetTag(OBJECT_SELF) == "CustomCannon1") && GetNearestObjectByTag("CustomCannonTarget1", OBJECT_SELF) != OBJECT_INVALID)
    {
    object oTarget = GetNearestObjectByTag("CustomCannonTarget1", OBJECT_SELF);
    AssignCommand(OBJECT_SELF, SetFacingPoint(GetPosition(oTarget)));
    }
if((GetTag(OBJECT_SELF) == "CustomCannon2")  && GetNearestObjectByTag("CustomCannonTarget2", OBJECT_SELF) != OBJECT_INVALID)
    {
    object oTarget = GetNearestObjectByTag("CustomCannonTarget2", OBJECT_SELF);
    AssignCommand(OBJECT_SELF, SetFacingPoint(GetPosition(oTarget)));
    }
if((GetTag(OBJECT_SELF) == "CustomCannon3")  && GetNearestObjectByTag("CustomCannonTarget2", OBJECT_SELF) != OBJECT_INVALID)
    {
    object oTarget = GetNearestObjectByTag("CustomCannonTarget3", OBJECT_SELF);
    AssignCommand(OBJECT_SELF, SetFacingPoint(GetPosition(oTarget)));
    }
}
