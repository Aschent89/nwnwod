//   remember to set the levers initial variable of  Activated to 0

void main()
{
int a = GetLocalInt(OBJECT_SELF,"Activated");

if (a == 0)
{
    AssignCommand((OBJECT_SELF),ActionPlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE));
    SetLocalInt(OBJECT_SELF, "Activated", 1);
    location lBed1 = Location(GetArea(OBJECT_SELF),Vector(6.0f,57.0f,0.0),90.0);
    CreateObject(OBJECT_TYPE_PLACEABLE,"zep_screen011",lBed1,FALSE,"bed1");
    location lBed2 = Location(GetArea(OBJECT_SELF),Vector(11.0f,57.0f,0.0),90.0);
    CreateObject(OBJECT_TYPE_PLACEABLE,"zep_screen011",lBed2,FALSE,"bed2");
    location lBed3 = Location(GetArea(OBJECT_SELF),Vector(16.0f,57.0f,0.0),90.0);
    CreateObject(OBJECT_TYPE_PLACEABLE,"zep_screen011",lBed3,FALSE,"bed3");
    location lBed4 = Location(GetArea(OBJECT_SELF),Vector(21.0f,57.0f,0.0),90.0);
    CreateObject(OBJECT_TYPE_PLACEABLE,"zep_screen011",lBed4,FALSE,"bed4");
     location lBed5 = Location(GetArea(OBJECT_SELF),Vector(26.0f,57.0f,0.0),90.0);
    CreateObject(OBJECT_TYPE_PLACEABLE,"zep_screen011",lBed5,FALSE,"bed5");
    location lBed6 = Location(GetArea(OBJECT_SELF),Vector(31.0f,57.0f,0.0),90.0);
    CreateObject(OBJECT_TYPE_PLACEABLE,"zep_screen011",lBed6,FALSE,"bed6");
     location lBed7 = Location(GetArea(OBJECT_SELF),Vector(36.0f,57.0f,0.0),90.0);
    CreateObject(OBJECT_TYPE_PLACEABLE,"zep_screen011",lBed7,FALSE,"bed7");
    location lBed8 = Location(GetArea(OBJECT_SELF),Vector(41.0f,57.0f,0.0),90.0);
    CreateObject(OBJECT_TYPE_PLACEABLE,"zep_screen011",lBed8,FALSE,"bed8");
    location lBed9 = Location(GetArea(OBJECT_SELF),Vector(46.0f,57.0f,0.0),90.0);
    CreateObject(OBJECT_TYPE_PLACEABLE,"zep_screen011",lBed9,FALSE,"bed9");
    location lBed10 = Location(GetArea(OBJECT_SELF),Vector(6.0f,57.0f,2.9),90.0);
    CreateObject(OBJECT_TYPE_PLACEABLE,"zep_screen011",lBed10,FALSE,"bed10");
    location lBed11 = Location(GetArea(OBJECT_SELF),Vector(11.0f,57.0f,2.9),90.0);
    CreateObject(OBJECT_TYPE_PLACEABLE,"zep_screen011",lBed11,FALSE,"bed11");
    location lBed12 = Location(GetArea(OBJECT_SELF),Vector(16.0f,57.0f,2.9),90.0);
    CreateObject(OBJECT_TYPE_PLACEABLE,"zep_screen011",lBed12,FALSE,"bed12");
    location lBed13 = Location(GetArea(OBJECT_SELF),Vector(21.0f,57.0f,2.9),90.0);
    CreateObject(OBJECT_TYPE_PLACEABLE,"zep_screen011",lBed13,FALSE,"bed13");
     location lBed14 = Location(GetArea(OBJECT_SELF),Vector(26.0f,57.0f,2.9),90.0);
    CreateObject(OBJECT_TYPE_PLACEABLE,"zep_screen011",lBed14,FALSE,"bed14");
    location lBed15 = Location(GetArea(OBJECT_SELF),Vector(31.0f,57.0f,2.9),90.0);
    CreateObject(OBJECT_TYPE_PLACEABLE,"zep_screen011",lBed15,FALSE,"bed15");
     location lBed16 = Location(GetArea(OBJECT_SELF),Vector(36.0f,57.0f,2.9),90.0);
    CreateObject(OBJECT_TYPE_PLACEABLE,"zep_screen011",lBed16,FALSE,"bed16");
    location lBed17 = Location(GetArea(OBJECT_SELF),Vector(41.0f,57.0f,2.9),90.0);
    CreateObject(OBJECT_TYPE_PLACEABLE,"zep_screen011",lBed17,FALSE,"bed17");
    location lBed18 = Location(GetArea(OBJECT_SELF),Vector(46.0f,57.0f,2.9),90.0);
    CreateObject(OBJECT_TYPE_PLACEABLE,"zep_screen011",lBed18,FALSE,"bed18");
}
if (a == 1)
{
  AssignCommand((OBJECT_SELF),ActionPlayAnimation(ANIMATION_PLACEABLE_ACTIVATE));
  SetLocalInt(OBJECT_SELF, "Activated", 0);
  object oBed1 = GetNearestObjectByTag ("bed1");
  DestroyObject(oBed1);
  object oBed2 = GetNearestObjectByTag ("bed2");
  DestroyObject(oBed2);
  object oBed3 = GetNearestObjectByTag ("bed3");
  DestroyObject(oBed3);
  object oBed4 = GetNearestObjectByTag ("bed4");
  DestroyObject(oBed4);
  object oBed5 = GetNearestObjectByTag ("bed5");
  DestroyObject(oBed5);
  object oBed6 = GetNearestObjectByTag ("bed6");
  DestroyObject(oBed6);
  object oBed7 = GetNearestObjectByTag ("bed7");
  DestroyObject(oBed7);
  object oBed8 = GetNearestObjectByTag ("bed8");
  DestroyObject(oBed8);
  object oBed9 = GetNearestObjectByTag ("bed9");
  DestroyObject(oBed9);
  object oBed10 = GetNearestObjectByTag ("bed10");
  DestroyObject(oBed10);
  object oBed11 = GetNearestObjectByTag ("bed11");
  DestroyObject(oBed11);
  object oBed12 = GetNearestObjectByTag ("bed12");
  DestroyObject(oBed12);
  object oBed13 = GetNearestObjectByTag ("bed13");
  DestroyObject(oBed13);
  object oBed14 = GetNearestObjectByTag ("bed14");
  DestroyObject(oBed14);
  object oBed15 = GetNearestObjectByTag ("bed15");
  DestroyObject(oBed15);
  object oBed16 = GetNearestObjectByTag ("bed16");
  DestroyObject(oBed16);
  object oBed17 = GetNearestObjectByTag ("bed17");
  DestroyObject(oBed17);
  object oBed18 = GetNearestObjectByTag ("bed18");
  DestroyObject(oBed18);
}
}
