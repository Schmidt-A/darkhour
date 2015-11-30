void main()
{
    int nModifier = GetLocalInt(OBJECT_SELF,"modifier");
    if (nModifier > 0)
    {
        SetLocalInt(OBJECT_SELF,"modifier",nModifier - 1);
    }
}
