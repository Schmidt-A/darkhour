void main()
{
//Declaration variable // Declaring variable
object oClicker;
oClicker = GetClickingObject();

object oTarget;
oTarget = GetTransitionTarget(OBJECT_SELF);

//Just jump
AssignCommand(oClicker,ClearAllActions());
AssignCommand(oClicker,JumpToObject(oTarget));

//Familiar part
object oHelper;
int x;


//I dont think there heachmen, but just in case
while (x != 6)
    {
    oHelper = GetAssociate(x,oClicker);
    if(GetIsObjectValid(oHelper))
        {
        AssignCommand(oHelper,ClearAllActions());
        AssignCommand(oHelper,JumpToObject(oTarget));
        }
    x = x + 1;
    }
}


