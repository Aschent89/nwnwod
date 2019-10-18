//   remember to set the levers initial variable of  Activated to 0

void main()
{
int a = GetLocalInt(OBJECT_SELF,"Activated");
if (a == 0)
{
    AssignCommand((OBJECT_SELF),ActionPlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE));
    SetLocalInt(OBJECT_SELF, "Activated", 1);
    location lBed1 = Location(GetArea(OBJECT_SELF),Vector(25.00f,60.00f,0.0),90.0);
    CreateObject(OBJECT_TYPE_PLACEABLE,"plc_altrneutral",lBed1,FALSE,"set111");
    location lBed2 = Location(GetArea(OBJECT_SELF),Vector(17.21f,58.98f,0.0),0.0);
    CreateObject(OBJECT_TYPE_PLACEABLE,"zep_stones001",lBed2,FALSE,"set112");
    location lBed3 = Location(GetArea(OBJECT_SELF),Vector(18.33f,62.98f,0.0),0.0);
    CreateObject(OBJECT_TYPE_PLACEABLE,"zep_stones001",lBed3,FALSE,"set113");
    location lBed4 = Location(GetArea(OBJECT_SELF),Vector(23.07f,65.83f,0.0),0.0);
    CreateObject(OBJECT_TYPE_PLACEABLE,"zep_stones001",lBed4,FALSE,"set114");
    location lBed5 = Location(GetArea(OBJECT_SELF),Vector(27.25f,65.64f,0.0),0.0);
    CreateObject(OBJECT_TYPE_PLACEABLE,"zep_stones001",lBed5,FALSE,"set115");
    location lBed6 = Location(GetArea(OBJECT_SELF),Vector(31.78f,63.18f,0.0),0.0);
    CreateObject(OBJECT_TYPE_PLACEABLE,"zep_stones001",lBed6,FALSE,"set116");
    location lBed7 = Location(GetArea(OBJECT_SELF),Vector(32.98f,59.24f,0.0),0.0);
    CreateObject(OBJECT_TYPE_PLACEABLE,"zep_stones001",lBed7,FALSE,"set117");
    location lBed8 = Location(GetArea(OBJECT_SELF),Vector(18.11f,61.25f,0.0),339.0);
    CreateObject(OBJECT_TYPE_PLACEABLE,"zep_stones009",lBed8,FALSE,"set118");
    location lBed9 = Location(GetArea(OBJECT_SELF),Vector(25.16f,65.70f,0.0),270.0);
    CreateObject(OBJECT_TYPE_PLACEABLE,"zep_stones009",lBed9,FALSE,"set119");
    location lBed10 = Location(GetArea(OBJECT_SELF),Vector(32.08f,61.25f,0.0),192.7);
    CreateObject(OBJECT_TYPE_PLACEABLE,"zep_stones009",lBed10,FALSE,"set1110");
}
if (a == 1)
{
  AssignCommand((OBJECT_SELF),ActionPlayAnimation(ANIMATION_PLACEABLE_ACTIVATE));
  SetLocalInt(OBJECT_SELF, "Activated", 0);
  object oBed1 = GetNearestObjectByTag ("set111");
  DestroyObject(oBed1);
  object oBed2 = GetNearestObjectByTag ("set112");
  DestroyObject(oBed2);
  object oBed3 = GetNearestObjectByTag ("set113");
  DestroyObject(oBed3);
  object oBed4 = GetNearestObjectByTag ("set114");
  DestroyObject(oBed4);
  object oBed5 = GetNearestObjectByTag ("set115");
  DestroyObject(oBed5);
  object oBed6 = GetNearestObjectByTag ("set116");
  DestroyObject(oBed6);
  object oBed7 = GetNearestObjectByTag ("set117");
  DestroyObject(oBed7);
  object oBed8 = GetNearestObjectByTag ("set118");
  DestroyObject(oBed8);
  object oBed9 = GetNearestObjectByTag ("set119");
  DestroyObject(oBed9);
  object oBed10 = GetNearestObjectByTag ("set1110");
  DestroyObject(oBed10);
}
}
