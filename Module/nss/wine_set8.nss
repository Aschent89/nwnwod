//   remember to set the levers initial variable of  Activated to 0

void main()
{
int a = GetLocalInt(OBJECT_SELF,"Activated");
if (a == 0)
{
    AssignCommand((OBJECT_SELF),ActionPlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE));
    SetLocalInt(OBJECT_SELF, "Activated", 1);
    location lBed1 = Location(GetArea(OBJECT_SELF),Vector(18.47f,61.02f,0.0),333.0);
    CreateObject(OBJECT_TYPE_PLACEABLE,"zep_screen010",lBed1,FALSE,"set81");
    location lBed2 = Location(GetArea(OBJECT_SELF),Vector(19.87f,60.41f,0.0),0.0);
    CreateObject(OBJECT_TYPE_PLACEABLE,"zep_plant003",lBed2,FALSE,"set82");
    location lBed3 = Location(GetArea(OBJECT_SELF),Vector(24.85f,60.44f,0.0),180.0);
    CreateObject(OBJECT_TYPE_PLACEABLE,"zep_throwrug014",lBed3,FALSE,"set83");
    location lBed4 = Location(GetArea(OBJECT_SELF),Vector(22.44f,61.56f,0.0),302.0);
    CreateObject(OBJECT_TYPE_PLACEABLE,"zep_bed02",lBed4,FALSE,"set84");
    location lBed5 = Location(GetArea(OBJECT_SELF),Vector(31.69f,62.30f,0.0),63.0);
    CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fireplace005",lBed5,FALSE,"set85");
    location lBed6 = Location(GetArea(OBJECT_SELF),Vector(31.41f,61.75f,0.0),0.0);
    CreateObject(OBJECT_TYPE_PLACEABLE,"plc_flamemedium",lBed6,FALSE,"set86");
    location lBed7 = Location(GetArea(OBJECT_SELF),Vector(24.83f,64.30f,0.0),0.0);
    CreateObject(OBJECT_TYPE_PLACEABLE,"plc_candelabra",lBed7,FALSE,"set87");
    location lBed8 = Location(GetArea(OBJECT_SELF),Vector(26.23f,64.09f,0.0),90.0);
    CreateObject(OBJECT_TYPE_PLACEABLE,"zep_desk03",lBed8,FALSE,"set88");
    location lBed9 = Location(GetArea(OBJECT_SELF),Vector(28.04f,63.80f,0.0),90.0);
    CreateObject(OBJECT_TYPE_PLACEABLE,"zep_mirror004",lBed9,FALSE,"set89");
}
if (a == 1)
{
  AssignCommand((OBJECT_SELF),ActionPlayAnimation(ANIMATION_PLACEABLE_ACTIVATE));
  SetLocalInt(OBJECT_SELF, "Activated", 0);
  object oBed1 = GetNearestObjectByTag ("set81");
  DestroyObject(oBed1);
  object oBed2 = GetNearestObjectByTag ("set82");
  DestroyObject(oBed2);
  object oBed3 = GetNearestObjectByTag ("set83");
  DestroyObject(oBed3);
  object oBed4 = GetNearestObjectByTag ("set84");
  DestroyObject(oBed4);
  object oBed5 = GetNearestObjectByTag ("set85");
  DestroyObject(oBed5);
  object oBed6 = GetNearestObjectByTag ("set86");
  DestroyObject(oBed6);
  object oBed7 = GetNearestObjectByTag ("set87");
  DestroyObject(oBed7);
  object oBed8 = GetNearestObjectByTag ("set88");
  DestroyObject(oBed8);
  object oBed9 = GetNearestObjectByTag ("set89");
  DestroyObject(oBed9);
}
}
