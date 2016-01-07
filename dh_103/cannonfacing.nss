void main()
{
if(GetTag(OBJECT_SELF) == "CustomCannon1")
    {
    float fFacing = GetFacingFromLocation(GetLocation(GetNearestObjectByTag("CustomCannonTarget1")));
    AssignCommand(OBJECT_SELF, SetFacing(fFacing));
    }
if(GetTag(OBJECT_SELF) == "CustomCannon2")
    {
    float fFacing = GetFacingFromLocation(GetLocation(GetNearestObjectByTag("CustomCannonTarget2")));
    AssignCommand(OBJECT_SELF, SetFacing(fFacing));
    }
if(GetTag(OBJECT_SELF) == "CustomCannon3")
    {
    float fFacing = GetFacingFromLocation(GetLocation(GetNearestObjectByTag("CustomCannonTarget3")));
    AssignCommand(OBJECT_SELF, SetFacing(fFacing));
    }
}
