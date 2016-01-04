void main()
{
    int iDirection = GetLocalInt(OBJECT_SELF, "iConvChoice");
    SetLocalInt(OBJECT_SELF, "DM_PAA_iDirection", iDirection);
}
