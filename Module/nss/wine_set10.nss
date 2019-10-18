//   remember to set the levers initial variable of  Activated to 0

void main()
{
int a = GetLocalInt(OBJECT_SELF,"Activated");
if (a == 0)
{
    AssignCommand((OBJECT_SELF),ActionPlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE));
    SetLocalInt(OBJECT_SELF, "Activated", 1);
    location lBed1 = Location(GetArea(OBJECT_SELF),Vector(20.99f,59.86f,0.0),180.0);
    CreateObject(OBJECT_TYPE_PLACEABLE,"zep_throwrug020",lBed1,FALSE,"set101");
    location lBed2 = Location(GetArea(OBJECT_SELF),Vector(28.95f,59.87f,0.0),180.0);
    CreateObject(OBJECT_TYPE_PLACEABLE,"zep_throwrug020",lBed2,FALSE,"set102");
    location lBed3 = Location(GetArea(OBJECT_SELF),Vector(18.50f,61.00f,0.0),180.0);
    CreateObject(OBJECT_TYPE_PLACEABLE,"zep_chairs007",lBed3,FALSE,"set103");
    location lBed4 = Location(GetArea(OBJECT_SELF),Vector(31.50f,61.00f,0.0),0.0);
    CreateObject(OBJECT_TYPE_PLACEABLE,"zep_chairs007",lBed4,FALSE,"set104");
    location lBed5 = Location(GetArea(OBJECT_SELF),Vector(21.00f,63.50f,0.0),90.0);
    CreateObject(OBJECT_TYPE_PLACEABLE,"zep_chairs007",lBed5,FALSE,"set105");
    location lBed6 = Location(GetArea(OBJECT_SELF),Vector(24.00f,63.50f,0.0),90.0);
    CreateObject(OBJECT_TYPE_PLACEABLE,"zep_chairs007",lBed6,FALSE,"set106");
    location lBed7 = Location(GetArea(OBJECT_SELF),Vector(26.00f,63.50f,0.0),90.0);
    CreateObject(OBJECT_TYPE_PLACEABLE,"zep_chairs007",lBed7,FALSE,"set107");
    location lBed8 = Location(GetArea(OBJECT_SELF),Vector(29.00f,63.50f,0.0),90.0);
    CreateObject(OBJECT_TYPE_PLACEABLE,"zep_chairs007",lBed8,FALSE,"set108");
    location lBed9 = Location(GetArea(OBJECT_SELF),Vector(25.00f,61.00f,0.0),180.0);
    CreateObject(OBJECT_TYPE_PLACEABLE,"zep_tables001",lBed9,FALSE,"set109");
    location lBed10 = Location(GetArea(OBJECT_SELF),Vector(24.20f,61.50f,1.11),0.0);
    CreateObject(OBJECT_TYPE_PLACEABLE,"zep_pie002",lBed10,FALSE,"set1010");
    location lBed11 = Location(GetArea(OBJECT_SELF),Vector(23.40f,61.00f,1.11),0.0);
    CreateObject(OBJECT_TYPE_PLACEABLE,"zep_bread",lBed11,FALSE,"set1011");
    location lBed12 = Location(GetArea(OBJECT_SELF),Vector(25.50f,61.00f,1.11),0.0);
    CreateObject(OBJECT_TYPE_PLACEABLE,"zep_bottle002",lBed12,FALSE,"set1012");
    location lBed13 = Location(GetArea(OBJECT_SELF),Vector(27.00f,61.00f,1.11),0.0);
    CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fruit001",lBed13,FALSE,"set1013");
}
if (a == 1)
{
  AssignCommand((OBJECT_SELF),ActionPlayAnimation(ANIMATION_PLACEABLE_ACTIVATE));
  SetLocalInt(OBJECT_SELF, "Activated", 0);
  object oBed1 = GetNearestObjectByTag ("set101");
  DestroyObject(oBed1);
  object oBed2 = GetNearestObjectByTag ("set102");
  DestroyObject(oBed2);
  object oBed3 = GetNearestObjectByTag ("set103");
  DestroyObject(oBed3);
  object oBed4 = GetNearestObjectByTag ("set104");
  DestroyObject(oBed4);
  object oBed5 = GetNearestObjectByTag ("set105");
  DestroyObject(oBed5);
  object oBed6 = GetNearestObjectByTag ("set106");
  DestroyObject(oBed6);
  object oBed7 = GetNearestObjectByTag ("set107");
  DestroyObject(oBed7);
  object oBed8 = GetNearestObjectByTag ("set108");
  DestroyObject(oBed8);
  object oBed9 = GetNearestObjectByTag ("set109");
  DestroyObject(oBed9);
  object oBed10 = GetNearestObjectByTag ("set1010");
  DestroyObject(oBed10);
  object oBed11 = GetNearestObjectByTag ("set1011");
  DestroyObject(oBed11);
  object oBed12 = GetNearestObjectByTag ("set1012");
  DestroyObject(oBed12);
  object oBed13 = GetNearestObjectByTag ("set1013");
  DestroyObject(oBed13);
}
}
