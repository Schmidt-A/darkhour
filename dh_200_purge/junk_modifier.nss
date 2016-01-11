void main()
{
    int nModifier = GetLocalInt(OBJECT_SELF,"modifier");
    if (nModifier > 0)
    {
        SetLocalInt(OBJECT_SELF,"modifier",nModifier - 1);
    }
//Be sure to add any new junksearches to use_scavenger script, else it will not work
}
