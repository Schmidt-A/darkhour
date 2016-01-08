void main()
{
int iCharges = GetLocalInt(OBJECT_SELF, "charges");
int iCount = GetLocalInt(OBJECT_SELF, "count") + 1;
if(iCount >= 100)
    {
    iCount = 0;
    iCharges += 1;
    }
SetLocalInt(OBJECT_SELF, "count", iCount);
SetLocalInt(OBJECT_SELF, "charges", iCharges);
}
