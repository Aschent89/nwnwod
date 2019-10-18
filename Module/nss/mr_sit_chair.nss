//If your trying to modify another sit script, this line below needs to be at
//the very top of the script
#include "toy_source"

void main()
{
    object oPlayer = GetLastUsedBy ();

    //And these three lines of code need to be just another neither the variable
    //defining the player, but before anything else.
    if (GetLocalInt(oPlayer, "COLLAR_NO_SIT")) {
        ToyStopSit(oPlayer);
        return; }

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
