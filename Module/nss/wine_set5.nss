//   remember to set the levers initial variable of  Activated to 0

void main()
{
int a = GetLocalInt(OBJECT_SELF,"Activated");
if (a == 0)
{
    AssignCommand((OBJECT_SELF),ActionPlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE));
    SetLocalInt(OBJECT_SELF, "Activated", 1);
    location lBed1 = Location(GetArea(OBJECT_SELF),Vector(20.00f,61.00f,0.0),0.0);
    CreateObject(OBJECT_TYPE_PLACEABLE,"zep_skinpole001",lBed1,FALSE,"set51");
    location lBed2 = Location(GetArea(OBJECT_SELF),Vector(26.00f,58.50f,0.0),270.0);
    CreateObject(OBJECT_TYPE_PLACEABLE,"zep_campfr001",lBed2,FALSE,"set52");
    location lBed3 = Location(GetArea(OBJECT_SELF),Vector(22.85f,58.62f,0.0),180.0);
    CreateObject(OBJECT_TYPE_PLACEABLE,"zep_logsit001",lBed3,FALSE,"set53");
    location lBed4 = Location(GetArea(OBJECT_SELF),Vector(29.36f,58.38f,0.0),0.0);
    CreateObject(OBJECT_TYPE_PLACEABLE,"zep_logsit001",lBed4,FALSE,"set54");
    location lBed5 = Location(GetArea(OBJECT_SELF),Vector(36.12f,61.26f,0.0),24.0);
    CreateObject(OBJECT_TYPE_PLACEABLE,"zep_tent006",lBed5,FALSE,"set55");

}
if (a == 1)
{
  AssignCommand((OBJECT_SELF),ActionPlayAnimation(ANIMATION_PLACEABLE_ACTIVATE));
  SetLocalInt(OBJECT_SELF, "Activated", 0);
  object oBed1 = GetNearestObjectByTag ("set51");
  DestroyObject(oBed1);
  object oBed2 = GetNearestObjectByTag ("set52");
  DestroyObject(oBed2);
  object oBed3 = GetNearestObjectByTag ("set53");
  DestroyObject(oBed3);
  object oBed4 = GetNearestObjectByTag ("set54");
  DestroyObject(oBed4);
  object oBed5 = GetNearestObjectByTag ("set55");
  DestroyObject(oBed5);
}
}
