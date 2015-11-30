void main()

{

  object oChair = OBJECT_SELF;

  if(!GetIsObjectValid(GetSittingCreature(oChair)))

  {

    AssignCommand(GetLastUsedBy(), ActionSit(oChair));

  }

}
