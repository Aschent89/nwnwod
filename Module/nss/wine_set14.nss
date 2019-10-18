//   remember to set the levers initial variable of  Activated to 0

void main()
{
int a = GetLocalInt(OBJECT_SELF,"Activated");
if (a == 0)
{
    AssignCommand((OBJECT_SELF),ActionPlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE));
    SetLocalInt(OBJECT_SELF, "Activated", 1);
    location lBed1 = Location(GetArea(OBJECT_SELF),Vector(20.00f,65.00f,0.0),90.0);
    CreateObject(OBJECT_TYPE_CREATURE,"x0_bookcase2",lBed1,FALSE,"set141");
    location lBed2 = Location(GetArea(OBJECT_SELF),Vector(23.00f,65.00f,0.0),90.0);
    CreateObject(OBJECT_TYPE_PLACEABLE,"x0_bookcase2",lBed2,FALSE,"set142");
    location lBed3 = Location(GetArea(OBJECT_SELF),Vector(26.00f,65.00f,0.0),90.0);
    CreateObject(OBJECT_TYPE_PLACEABLE,"x0_bookcase2",lBed3,FALSE,"set143");
    location lBed4 = Location(GetArea(OBJECT_SELF),Vector(29.00f,65.00f,0.0),90.0);
    CreateObject(OBJECT_TYPE_PLACEABLE,"x0_bookcase2",lBed4,FALSE,"set144");
    location lBed5 = Location(GetArea(OBJECT_SELF),Vector(32.00f,65.00f,0.0),90.0);
    CreateObject(OBJECT_TYPE_PLACEABLE,"x0_bookcase2",lBed5,FALSE,"set145");

    location lBed6 = Location(GetArea(OBJECT_SELF),Vector(20.44f,60.00f,0.0),90.0);
    CreateObject(OBJECT_TYPE_PLACEABLE,"zep_throwrug027",lBed6,FALSE,"set146");
    location lBed7 = Location(GetArea(OBJECT_SELF),Vector(26.00f,60.00f,0.0),0.0);
    CreateObject(OBJECT_TYPE_PLACEABLE,"x0_cauldron",lBed7,FALSE,"set147");
    location lBed8 = Location(GetArea(OBJECT_SELF),Vector(32.00f,60.00f,0.0),0.0);
    CreateObject(OBJECT_TYPE_PLACEABLE,"zep_pentagram002",lBed8,FALSE,"set148");
    location lBed9 = Location(GetArea(OBJECT_SELF),Vector(35.25f,63.00f,0.0),216.0);
    CreateObject(OBJECT_TYPE_PLACEABLE,"plc_alchapprtus",lBed9,FALSE,"set149");
    location lBed10 = Location(GetArea(OBJECT_SELF),Vector(21.70f,60.27f,0.0),0.0);
    CreateObject(OBJECT_TYPE_PLACEABLE,"zep_chairs006",lBed10,FALSE,"set1410");
    location lBed11 = Location(GetArea(OBJECT_SELF),Vector(19.00f,60.50f,0.0),90.0);
    CreateObject(OBJECT_TYPE_PLACEABLE,"zep_table003",lBed11,FALSE,"set1411");
    location lBed12 = Location(GetArea(OBJECT_SELF),Vector(19.21f,60.31f,0.9),90.0);
    CreateObject(OBJECT_TYPE_PLACEABLE,"zep_book003",lBed12,FALSE,"set1412");
    location lBed13 = Location(GetArea(OBJECT_SELF),Vector(18.31f,58.96f,0.9),0.0);
    CreateObject(OBJECT_TYPE_PLACEABLE,"x2_plc_cball",lBed13,FALSE,"set1413");

}
if (a == 1)
{
  AssignCommand((OBJECT_SELF),ActionPlayAnimation(ANIMATION_PLACEABLE_ACTIVATE));
  SetLocalInt(OBJECT_SELF, "Activated", 0);
  object oBed1 = GetNearestObjectByTag ("set141");
  DestroyObject(oBed1);
  object oBed2 = GetNearestObjectByTag ("set142");
  DestroyObject(oBed2);
  object oBed3 = GetNearestObjectByTag ("set143");
  DestroyObject(oBed3);
  object oBed4 = GetNearestObjectByTag ("set144");
  DestroyObject(oBed4);
  object oBed5 = GetNearestObjectByTag ("set145");
  DestroyObject(oBed5);
  object oBed6 = GetNearestObjectByTag ("set146");
  DestroyObject(oBed6);
  object oBed7 = GetNearestObjectByTag ("set147");
  DestroyObject(oBed7);
  object oBed8 = GetNearestObjectByTag ("set148");
  DestroyObject(oBed8);
  object oBed9 = GetNearestObjectByTag ("set149");
  DestroyObject(oBed9);
  object oBed10 = GetNearestObjectByTag ("set1410");
  DestroyObject(oBed10);
  object oBed11 = GetNearestObjectByTag ("set1411");
  DestroyObject(oBed11);
  object oBed12 = GetNearestObjectByTag ("set1412");
  DestroyObject(oBed12);
  object oBed13 = GetNearestObjectByTag ("set1413");
  DestroyObject(oBed13);

}
}
