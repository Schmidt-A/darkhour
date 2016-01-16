void main()
{
    int iPCCount = GetLocalInt(OBJECT_SELF, "iPCCount");
    SetLocalInt(OBJECT_SELF, "iPCCount", iPCCount+1);
}
