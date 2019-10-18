//   remember to set the levers initial variable of  Activated to 0

void main()
{
int a = GetLocalInt(OBJECT_SELF,"Activated");
if (a == 0)
{
    AssignCommand((OBJECT_SELF),ActionPlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE));
    SetLocalInt(OBJECT_SELF, "Activated", 1);
    location lBed1 = Location(GetArea(OBJECT_SELF),Vector(16.29f,65.88f,0.0),0.0);
    CreateObject(OBJECT_TYPE_PLACEABLE,"zep_pinetr8",lBed1,FALSE,"set61");
    location lBed2 = Location(GetArea(OBJECT_SELF),Vector(30.45f,67.93f,0.0),0.0);
    CreateObject(OBJECT_TYPE_PLACEABLE,"zep_tree001",lBed2,FALSE,"set62");
    location lBed3 = Location(GetArea(OBJECT_SELF),Vector(12.60f,61.52f,0.0),0.0);
    CreateObject(OBJECT_TYPE_PLACEABLE,"zep_pinetr9",lBed3,FALSE,"set63");
    location lBed4 = Location(GetArea(OBJECT_SELF),Vector(22.42f,64.46f,0.0),0.0);
    CreateObject(OBJECT_TYPE_PLACEABLE,"zep_pinetr9",lBed4,FALSE,"set64");
    location lBed5 = Location(GetArea(OBJECT_SELF),Vector(36.04f,65.77f,0.0),0.0);
    CreateObject(OBJECT_TYPE_PLACEABLE,"zep_pinetr9",lBed5,FALSE,"set65");
    location lBed6 = Location(GetArea(OBJECT_SELF),Vector(17.04f,60.81f,0.0),0.0);
    CreateObject(OBJECT_TYPE_PLACEABLE,"zep_pinetr17",lBed6,FALSE,"set66");
    location lBed7 = Location(GetArea(OBJECT_SELF),Vector(19.63f,66.97f,0.0),0.0);
    CreateObject(OBJECT_TYPE_PLACEABLE,"zep_pinetr17",lBed7,FALSE,"set67");
    location lBed8 = Location(GetArea(OBJECT_SELF),Vector(27.13f,65.85f,0.0),0.0);
    CreateObject(OBJECT_TYPE_PLACEABLE,"zep_pinetr17",lBed8,FALSE,"set68");
    location lBed9 = Location(GetArea(OBJECT_SELF),Vector(32.58f,63.89f,0.0),0.0);
    CreateObject(OBJECT_TYPE_PLACEABLE,"zep_pinetr17",lBed9,FALSE,"set69");
}
if (a == 1)
{
  AssignCommand((OBJECT_SELF),ActionPlayAnimation(ANIMATION_PLACEABLE_ACTIVATE));
  SetLocalInt(OBJECT_SELF, "Activated", 0);
  object oBed1 = GetNearestObjectByTag ("set61");
  DestroyObject(oBed1);
  object oBed2 = GetNearestObjectByTag ("set62");
  DestroyObject(oBed2);
  object oBed3 = GetNearestObjectByTag ("set63");
  DestroyObject(oBed3);
  object oBed4 = GetNearestObjectByTag ("set64");
  DestroyObject(oBed4);
  object oBed5 = GetNearestObjectByTag ("set65");
  DestroyObject(oBed5);
  object oBed6 = GetNearestObjectByTag ("set66");
  DestroyObject(oBed6);
  object oBed7 = GetNearestObjectByTag ("set67");
  DestroyObject(oBed7);
  object oBed8 = GetNearestObjectByTag ("set68");
  DestroyObject(oBed8);
  object oBed9 = GetNearestObjectByTag ("set69");
  DestroyObject(oBed9);
}
}
