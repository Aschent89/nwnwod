//   remember to set the levers initial variable of  Activated to 0

void main()
{
int a = GetLocalInt(OBJECT_SELF,"Activated");
if (a == 0)
{
    AssignCommand((OBJECT_SELF),ActionPlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE));
    SetLocalInt(OBJECT_SELF, "Activated", 1);
    location lBed1 = Location(GetArea(OBJECT_SELF),Vector(12.50f,69.00f,0.0),0.0);
    CreateObject(OBJECT_TYPE_PLACEABLE,"zep_grasstuft001",lBed1,FALSE,"set71");
    location lBed2 = Location(GetArea(OBJECT_SELF),Vector(17.50f,69.00f,0.0),0.0);
    CreateObject(OBJECT_TYPE_PLACEABLE,"zep_grasstuft001",lBed2,FALSE,"set72");
    location lBed3 = Location(GetArea(OBJECT_SELF),Vector(22.50f,69.00f,0.0),0.0);
    CreateObject(OBJECT_TYPE_PLACEABLE,"zep_grasstuft001",lBed3,FALSE,"set73");
    location lBed4 = Location(GetArea(OBJECT_SELF),Vector(27.50f,69.00f,0.0),0.0);
    CreateObject(OBJECT_TYPE_PLACEABLE,"zep_grasstuft001",lBed4,FALSE,"set74");
    location lBed5 = Location(GetArea(OBJECT_SELF),Vector(32.50f,69.00f,0.0),0.0);
    CreateObject(OBJECT_TYPE_PLACEABLE,"zep_grasstuft001",lBed5,FALSE,"set75");
    location lBed6 = Location(GetArea(OBJECT_SELF),Vector(37.50f,69.00f,0.0),0.0);
    CreateObject(OBJECT_TYPE_PLACEABLE,"zep_grasstuft001",lBed6,FALSE,"set76");
    location lBed7 = Location(GetArea(OBJECT_SELF),Vector(12.50f,64.00f,0.0),0.0);
    CreateObject(OBJECT_TYPE_PLACEABLE,"zep_grasstuft001",lBed7,FALSE,"set77");
    location lBed8 = Location(GetArea(OBJECT_SELF),Vector(17.50f,64.00f,0.0),0.0);
    CreateObject(OBJECT_TYPE_PLACEABLE,"zep_grasstuft001",lBed8,FALSE,"set78");
    location lBed9 = Location(GetArea(OBJECT_SELF),Vector(22.50f,64.00f,0.0),0.0);
    CreateObject(OBJECT_TYPE_PLACEABLE,"zep_grasstuft001",lBed9,FALSE,"set79");
    location lBed10 = Location(GetArea(OBJECT_SELF),Vector(27.50f,64.00f,0.0),0.0);
    CreateObject(OBJECT_TYPE_PLACEABLE,"zep_grasstuft001",lBed10,FALSE,"set710");
    location lBed11 = Location(GetArea(OBJECT_SELF),Vector(32.50f,64.00f,0.0),0.0);
    CreateObject(OBJECT_TYPE_PLACEABLE,"zep_grasstuft001",lBed11,FALSE,"set711");
    location lBed12 = Location(GetArea(OBJECT_SELF),Vector(37.50f,64.00f,0.0),0.0);
    CreateObject(OBJECT_TYPE_PLACEABLE,"zep_grasstuft001",lBed12,FALSE,"set712");
    location lBed13 = Location(GetArea(OBJECT_SELF),Vector(12.50f,59.00f,0.0),0.0);
    CreateObject(OBJECT_TYPE_PLACEABLE,"zep_grasstuft001",lBed13,FALSE,"set713");
    location lBed14 = Location(GetArea(OBJECT_SELF),Vector(17.50f,59.00f,0.0),0.0);
    CreateObject(OBJECT_TYPE_PLACEABLE,"zep_grasstuft001",lBed14,FALSE,"set714");
    location lBed15 = Location(GetArea(OBJECT_SELF),Vector(22.50f,59.00f,0.0),0.0);
    CreateObject(OBJECT_TYPE_PLACEABLE,"zep_grasstuft001",lBed15,FALSE,"set715");
    location lBed16 = Location(GetArea(OBJECT_SELF),Vector(27.50f,59.00f,0.0),0.0);
    CreateObject(OBJECT_TYPE_PLACEABLE,"zep_grasstuft001",lBed16,FALSE,"set716");
    location lBed17 = Location(GetArea(OBJECT_SELF),Vector(32.50f,59.00f,0.0),0.0);
    CreateObject(OBJECT_TYPE_PLACEABLE,"zep_grasstuft001",lBed17,FALSE,"set717");
    location lBed18 = Location(GetArea(OBJECT_SELF),Vector(37.50f,59.00f,0.0),0.0);
    CreateObject(OBJECT_TYPE_PLACEABLE,"zep_grasstuft001",lBed18,FALSE,"set718");
}
if (a == 1)
{
  AssignCommand((OBJECT_SELF),ActionPlayAnimation(ANIMATION_PLACEABLE_ACTIVATE));
  SetLocalInt(OBJECT_SELF, "Activated", 0);
  object oBed1 = GetNearestObjectByTag ("set71");
  DestroyObject(oBed1);
  object oBed2 = GetNearestObjectByTag ("set72");
  DestroyObject(oBed2);
  object oBed3 = GetNearestObjectByTag ("set73");
  DestroyObject(oBed3);
  object oBed4 = GetNearestObjectByTag ("set74");
  DestroyObject(oBed4);
  object oBed5 = GetNearestObjectByTag ("set75");
  DestroyObject(oBed5);
  object oBed6 = GetNearestObjectByTag ("set76");
  DestroyObject(oBed6);
  object oBed7 = GetNearestObjectByTag ("set77");
  DestroyObject(oBed7);
  object oBed8 = GetNearestObjectByTag ("set78");
  DestroyObject(oBed8);
  object oBed9 = GetNearestObjectByTag ("set79");
  DestroyObject(oBed9);
  object oBed10 = GetNearestObjectByTag ("set710");
  DestroyObject(oBed10);
  object oBed11 = GetNearestObjectByTag ("set711");
  DestroyObject(oBed11);
  object oBed12 = GetNearestObjectByTag ("set712");
  DestroyObject(oBed12);
  object oBed13 = GetNearestObjectByTag ("set713");
  DestroyObject(oBed13);
  object oBed14 = GetNearestObjectByTag ("set714");
  DestroyObject(oBed14);
  object oBed15 = GetNearestObjectByTag ("set715");
  DestroyObject(oBed15);
  object oBed16 = GetNearestObjectByTag ("set716");
  DestroyObject(oBed16);
  object oBed17 = GetNearestObjectByTag ("set717");
  DestroyObject(oBed17);
  object oBed18 = GetNearestObjectByTag ("set718");
  DestroyObject(oBed18);

}
}
