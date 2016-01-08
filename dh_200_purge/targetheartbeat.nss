void main()
{
int iDestroy1 = GetLocalInt(GetModule(), "destroytarget1");
int iDestroy2 = GetLocalInt(GetModule(), "destroytarget2");
int iDestroy3 = GetLocalInt(GetModule(), "destroytarget3");
string sTag = GetTag(OBJECT_SELF);
if((iDestroy1 == 1) && (sTag == "CustomCannonTarget1"))
    {
    SetUseableFlag(OBJECT_SELF, 1);
    DestroyObject(OBJECT_SELF);
    SetLocalInt(GetModule(), "destroytarget1", 0);
    SetLocalInt(GetModule(), "target1placed", 0);
    }
if((iDestroy2 == 1) && (sTag == "CustomCannonTarget2"))
    {
    SetUseableFlag(OBJECT_SELF, 1);
    DestroyObject(OBJECT_SELF);
    SetLocalInt(GetModule(), "destroytarget2", 0);
    SetLocalInt(GetModule(), "target2placed", 0);
    }
if((iDestroy3 == 1) && (sTag == "CustomCannonTarget3"))
    {
    SetUseableFlag(OBJECT_SELF, 1);
    DestroyObject(OBJECT_SELF);
    SetLocalInt(GetModule(), "destroytarget3", 0);
    SetLocalInt(GetModule(), "target3placed", 0);
    }
}
