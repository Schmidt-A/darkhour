void main()
{
object oUser = GetPCSpeaker();
        if(!GetIsObjectValid(GetItemPossessedBy(oUser, "appearancesaver")) )
        {
           object oSpawn = CreateItemOnObject("appearancesaver", oUser,1);
        }
        else
        {
            FloatingTextStringOnCreature("You already have one, silly!", oUser);
        }
}
