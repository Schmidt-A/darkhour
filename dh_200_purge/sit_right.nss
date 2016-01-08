// Sit on placeable chairs and invis placeable object chairs by Thanatos the Loonie
// Player will face correct direction
// Use this script in your placeable's OnUsed Event (And don't forget to make the placeable Usable - LOL)
// Jul 7, 2004
// NWVault.ign.com title:
// A simple sit on any placeable script (with adjustable and correct facing when sitting on Invisible Placeables on Tileset chairs / beds)
// ...
// LOL.. so I can't seem to write short titles... LOLOLOL.. oh well

void main()
{
    object oPlayer = GetLastUsedBy ();
    object oChair = OBJECT_SELF;
    object oArea = GetArea(oChair);
    object oFakeChair = GetLocalObject(oChair, "oFakeChair"); //Previously created FakeChair

    if(!GetIsObjectValid(oPlayer))return; //Doubt that this will happen... but, who knows...

    float fChair = GetFacing(oChair);
    vector vChair = GetPosition(oChair);
    vector vFakeChair = vChair;

    //Reason why people end up facing the wrong direction is because placeables must be close to ground level
    vFakeChair.z = IntToFloat(FloatToInt(vChair.z));

    //If the object is already close to ground level... no need to create a fake chair
    if((vChair.z + 0.01 > vFakeChair.z) && (vChair.z - 0.01 < vFakeChair.z))
        oFakeChair = oChair;

    //Fake Chair needed
    if(vChair.z < 0.0)vFakeChair.z -= 1.0;

    //If no fake chair, create one.
    location lFakeChair = Location(oArea,vFakeChair,fChair);
    if((oFakeChair != oChair) && !GetIsObjectValid(oFakeChair))
        oFakeChair = CreateObject(OBJECT_TYPE_PLACEABLE,"plc_invisobj",lFakeChair,FALSE);

    SetLocalObject(oChair,"oFakeChair",oFakeChair);

    //Is someone already sitting?
    if(GetIsObjectValid(GetSittingCreature(oFakeChair)))return;

    //Sit on the Fake Chair :)
    AssignCommand(oPlayer, ActionSit(oFakeChair));
}
