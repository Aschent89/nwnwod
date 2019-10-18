//   remember to set the levers initial variable of  Activated to 0

void main()
{
int a = GetLocalInt(OBJECT_SELF,"Activated");
if (a == 0)
{
    AssignCommand((OBJECT_SELF),ActionPlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE));
    SetLocalInt(OBJECT_SELF, "Activated", 1);
    location lBed1 = Location(GetArea(OBJECT_SELF),Vector(17.26f,63.91f,-0.5),0.0);
    CreateObject(OBJECT_TYPE_PLACEABLE,"zep_lowwater",lBed1,FALSE,"set11");
    location lBed2 = Location(GetArea(OBJECT_SELF),Vector(15.57f,65.29f,0.0),202.0);
    CreateObject(OBJECT_TYPE_PLACEABLE,"zep_ship001",lBed2,FALSE,"set12");
    location lBed3 = Location(GetArea(OBJECT_SELF),Vector(30.40f,67.0f,0.0),0.0);
    CreateObject(OBJECT_TYPE_PLACEABLE,"x0_treepalm",lBed3,FALSE,"set13");
    location lBed4 = Location(GetArea(OBJECT_SELF),Vector(36.65f,66.97f,0.0),330.0);
    CreateObject(OBJECT_TYPE_PLACEABLE,"x0_treepalm",lBed4,FALSE,"set14");
     location lBed5 = Location(GetArea(OBJECT_SELF),Vector(38.54f,57.59f,0.0),233.0);
    CreateObject(OBJECT_TYPE_PLACEABLE,"x0_treepalm",lBed5,FALSE,"set15");

}
if (a == 1)
{
  AssignCommand((OBJECT_SELF),ActionPlayAnimation(ANIMATION_PLACEABLE_ACTIVATE));
  SetLocalInt(OBJECT_SELF, "Activated", 0);
  object oBed1 = GetNearestObjectByTag ("set11");
  DestroyObject(oBed1);
  object oBed2 = GetNearestObjectByTag ("set12");
  DestroyObject(oBed2);
  object oBed3 = GetNearestObjectByTag ("set13");
  DestroyObject(oBed3);
  object oBed4 = GetNearestObjectByTag ("set14");
  DestroyObject(oBed4);
  object oBed5 = GetNearestObjectByTag ("set15");
  DestroyObject(oBed5);
}
}
