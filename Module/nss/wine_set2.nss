//   remember to set the levers initial variable of  Activated to 0

void main()
{
int a = GetLocalInt(OBJECT_SELF,"Activated");
if (a == 0)
{
    AssignCommand((OBJECT_SELF),ActionPlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE));
    SetLocalInt(OBJECT_SELF, "Activated", 1);
    location lBed1 = Location(GetArea(OBJECT_SELF),Vector(23.00f,67.00f,0.0),0.0);
    CreateObject(OBJECT_TYPE_PLACEABLE,"zep_pinetr9",lBed1,FALSE,"set21");
    location lBed2 = Location(GetArea(OBJECT_SELF),Vector(16.50f,66.29f,0.0),0.0);
    CreateObject(OBJECT_TYPE_PLACEABLE,"zep_pinetr9",lBed2,FALSE,"set22");
    location lBed3 = Location(GetArea(OBJECT_SELF),Vector(12.20f,60.0f,0.0),0.0);
    CreateObject(OBJECT_TYPE_PLACEABLE,"zep_pinetr9",lBed3,FALSE,"set23");
    location lBed4 = Location(GetArea(OBJECT_SELF),Vector(32.86f,64.63f,0.0),60.0);
    CreateObject(OBJECT_TYPE_PLACEABLE,"zep_cabin001",lBed4,FALSE,"set24");
    location lBed5 = Location(GetArea(OBJECT_SELF),Vector(30.00f,60.00f,0.0),120.0);
    CreateObject(OBJECT_TYPE_PLACEABLE,"zep_orcaxe",lBed5,FALSE,"set25");
    location lBed6 = Location(GetArea(OBJECT_SELF),Vector(32.00f,59.00f,0.0),270.0);
    CreateObject(OBJECT_TYPE_PLACEABLE,"zep_woodpile01",lBed6,FALSE,"set26");
    location lBed7 = Location(GetArea(OBJECT_SELF),Vector(29.85f,62.92f,0.0),330.0);
    CreateObject(OBJECT_TYPE_PLACEABLE,"zep_doors009",lBed7,FALSE,"set27");

}
if (a == 1)
{
  AssignCommand((OBJECT_SELF),ActionPlayAnimation(ANIMATION_PLACEABLE_ACTIVATE));
  SetLocalInt(OBJECT_SELF, "Activated", 0);
  object oBed1 = GetNearestObjectByTag ("set21");
  DestroyObject(oBed1);
  object oBed2 = GetNearestObjectByTag ("set22");
  DestroyObject(oBed2);
  object oBed3 = GetNearestObjectByTag ("set23");
  DestroyObject(oBed3);
  object oBed4 = GetNearestObjectByTag ("set24");
  DestroyObject(oBed4);
  object oBed5 = GetNearestObjectByTag ("set25");
  DestroyObject(oBed5);
  object oBed6 = GetNearestObjectByTag ("set26");
  DestroyObject(oBed6);
  object oBed7 = GetNearestObjectByTag ("set27");
  DestroyObject(oBed7);
}
}
