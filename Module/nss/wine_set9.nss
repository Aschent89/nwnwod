//   remember to set the levers initial variable of  Activated to 0

void main()
{
int a = GetLocalInt(OBJECT_SELF,"Activated");
if (a == 0)
{
    AssignCommand((OBJECT_SELF),ActionPlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE));
    SetLocalInt(OBJECT_SELF, "Activated", 1);
    location lBed1 = Location(GetArea(OBJECT_SELF),Vector(15.00f,61.50f,0.0),0.0);
    CreateObject(OBJECT_TYPE_PLACEABLE,"zep_column005",lBed1,FALSE,"set91");
    location lBed2 = Location(GetArea(OBJECT_SELF),Vector(20.00f,70.00f,0.0),0.0);
    CreateObject(OBJECT_TYPE_PLACEABLE,"zep_column005",lBed2,FALSE,"set92");
    location lBed3 = Location(GetArea(OBJECT_SELF),Vector(30.00f,70.00f,0.0),0.0);
    CreateObject(OBJECT_TYPE_PLACEABLE,"zep_column005",lBed3,FALSE,"set93");
    location lBed4 = Location(GetArea(OBJECT_SELF),Vector(35.00f,61.50f,0.0),0.0);
    CreateObject(OBJECT_TYPE_PLACEABLE,"zep_column005",lBed4,FALSE,"set94");
    location lBed5 = Location(GetArea(OBJECT_SELF),Vector(25.00f,60.00f,0.0),90.0);
    CreateObject(OBJECT_TYPE_PLACEABLE,"zep_throwrug026",lBed5,FALSE,"set95");
    location lBed6 = Location(GetArea(OBJECT_SELF),Vector(18.50f,63.00f,0.0),130.0);
    CreateObject(OBJECT_TYPE_PLACEABLE,"plc_lecturn",lBed6,FALSE,"set96");
    location lBed7 = Location(GetArea(OBJECT_SELF),Vector(31.50f,63.00f,0.0),0.0);
    CreateObject(OBJECT_TYPE_PLACEABLE,"plc_diviningpl",lBed7,FALSE,"set97");
    location lBed8 = Location(GetArea(OBJECT_SELF),Vector(25.00f,65.00f,0.0),90.0);
    CreateObject(OBJECT_TYPE_PLACEABLE,"zep_altarcloth",lBed8,FALSE,"set98");
    location lBed9 = Location(GetArea(OBJECT_SELF),Vector(26.20f,65.00f,0.0),0.0);
    CreateObject(OBJECT_TYPE_PLACEABLE,"plc_birdbath",lBed9,FALSE,"set99");
    location lBed10 = Location(GetArea(OBJECT_SELF),Vector(23.00f,65.00f,0.0),0.0);
    CreateObject(OBJECT_TYPE_PLACEABLE,"zep_incense",lBed10,FALSE,"set910");
    location lBed11 = Location(GetArea(OBJECT_SELF),Vector(22.00f,68.00f,0.0),90.0);
    CreateObject(OBJECT_TYPE_PLACEABLE,"plc_statue1",lBed11,FALSE,"set911");
    location lBed12 = Location(GetArea(OBJECT_SELF),Vector(28.00f,68.00f,0.0),90.0);
    CreateObject(OBJECT_TYPE_PLACEABLE,"plc_statue1",lBed12,FALSE,"set912");
    location lBed13 = Location(GetArea(OBJECT_SELF),Vector(25.00f,68.00f,0.0),90.0);
    CreateObject(OBJECT_TYPE_PLACEABLE,"plc_gong",lBed13,FALSE,"set913");
}
if (a == 1)
{
  AssignCommand((OBJECT_SELF),ActionPlayAnimation(ANIMATION_PLACEABLE_ACTIVATE));
  SetLocalInt(OBJECT_SELF, "Activated", 0);
  object oBed1 = GetNearestObjectByTag ("set91");
  DestroyObject(oBed1);
  object oBed2 = GetNearestObjectByTag ("set92");
  DestroyObject(oBed2);
  object oBed3 = GetNearestObjectByTag ("set93");
  DestroyObject(oBed3);
  object oBed4 = GetNearestObjectByTag ("set94");
  DestroyObject(oBed4);
  object oBed5 = GetNearestObjectByTag ("set95");
  DestroyObject(oBed5);
  object oBed6 = GetNearestObjectByTag ("set96");
  DestroyObject(oBed6);
  object oBed7 = GetNearestObjectByTag ("set97");
  DestroyObject(oBed7);
  object oBed8 = GetNearestObjectByTag ("set98");
  DestroyObject(oBed8);
  object oBed9 = GetNearestObjectByTag ("set99");
  DestroyObject(oBed9);
  object oBed10 = GetNearestObjectByTag ("set910");
  DestroyObject(oBed10);
  object oBed11 = GetNearestObjectByTag ("set911");
  DestroyObject(oBed11);
  object oBed12 = GetNearestObjectByTag ("set912");
  DestroyObject(oBed12);
  object oBed13 = GetNearestObjectByTag ("set913");
  DestroyObject(oBed13);
}
}
