//   remember to set the levers initial variable of  Activated to 0

void main()
{
int a = GetLocalInt(OBJECT_SELF,"Activated");
if (a == 0)
{

    SetLocalInt(OBJECT_SELF, "Activated", 1);
    AssignCommand((OBJECT_SELF),ActionPlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE));
    location lBed1 = Location(GetArea(OBJECT_SELF),Vector(18.90f,59.71f,0.0),270.0);
    CreateObject(OBJECT_TYPE_PLACEABLE,"zep_throwrug025",lBed1,FALSE,"set31");
    location lBed2 = Location(GetArea(OBJECT_SELF),Vector(30.96f,59.71f,0.0),270.0);
    CreateObject(OBJECT_TYPE_PLACEABLE,"zep_throwrug025",lBed2,FALSE,"set32");
    location lBed3 = Location(GetArea(OBJECT_SELF),Vector(24.94f,59.79f,0.0),270.0);
    CreateObject(OBJECT_TYPE_PLACEABLE,"zep_throwrug020",lBed3,FALSE,"set33");
    location lBed4 = Location(GetArea(OBJECT_SELF),Vector(24.94f,67.85f,0.0),270.0);
    CreateObject(OBJECT_TYPE_PLACEABLE,"zep_throwrug020",lBed4,FALSE,"set34");
    location lBed5 = Location(GetArea(OBJECT_SELF),Vector(20.90f,65.92f,0.0),90.0);
    CreateObject(OBJECT_TYPE_PLACEABLE,"x0_sphinxstatue",lBed5,FALSE,"set35");
    location lBed6 = Location(GetArea(OBJECT_SELF),Vector(28.70f,65.92f,0.0),90.0);
    CreateObject(OBJECT_TYPE_PLACEABLE,"x0_sphinxstatue",lBed6,FALSE,"set36");
    location lBed7 = Location(GetArea(OBJECT_SELF),Vector(23.47f,68.46f,0.0),90.0);
    CreateObject(OBJECT_TYPE_PLACEABLE,"zep_chairs003",lBed7,FALSE,"set37");
    location lBed8 = Location(GetArea(OBJECT_SELF),Vector(26.39f,68.46f,0.0),90.0);
    CreateObject(OBJECT_TYPE_PLACEABLE,"zep_chairs003",lBed8,FALSE,"set38");
    location lBed9 = Location(GetArea(OBJECT_SELF),Vector(20.0f,70.0f,0.0),0.0);
    CreateObject(OBJECT_TYPE_PLACEABLE,"plc_candelabra",lBed9,FALSE,"set39");
    location lBed10 = Location(GetArea(OBJECT_SELF),Vector(30.0f,70.0f,0.0),0.0);
    CreateObject(OBJECT_TYPE_PLACEABLE,"plc_candelabra",lBed10,FALSE,"set310");

}
if (a == 1)
{
  AssignCommand((OBJECT_SELF),ActionPlayAnimation(ANIMATION_PLACEABLE_ACTIVATE));
  SetLocalInt(OBJECT_SELF, "Activated", 0);
  object oBed1 = GetNearestObjectByTag ("set31");
  DestroyObject(oBed1);
  object oBed2 = GetNearestObjectByTag ("set32");
  DestroyObject(oBed2);
  object oBed3 = GetNearestObjectByTag ("set33");
  DestroyObject(oBed3);
  object oBed4 = GetNearestObjectByTag ("set34");
  DestroyObject(oBed4);
  object oBed5 = GetNearestObjectByTag ("set35");
  DestroyObject(oBed5);
  object oBed6 = GetNearestObjectByTag ("set36");
  DestroyObject(oBed6);
  object oBed7 = GetNearestObjectByTag ("set37");
  DestroyObject(oBed7);
  object oBed8 = GetNearestObjectByTag ("set38");
  DestroyObject(oBed8);
  object oBed9 = GetNearestObjectByTag ("set39");
  DestroyObject(oBed9);
  object oBed10 = GetNearestObjectByTag ("set310");
  DestroyObject(oBed10);




}
}
