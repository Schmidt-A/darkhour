void main()
{
    int nBurn = GetLocalInt(OBJECT_SELF,"burn");
    if (nBurn >= 120)
    {
        DestroyObject(OBJECT_SELF);
    }
    else
    {
        SetLocalInt(OBJECT_SELF,"burn",nBurn + 1);
    }
}
