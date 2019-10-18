//   remember to set the levers initial variable of  Activated to 0

void main()
{
int a = GetLocalInt(OBJECT_SELF,"Activated");
if (a == 0)
{
    SetLocalInt(OBJECT_SELF, "Activated", 1);
    AssignCommand((OBJECT_SELF),ActionPlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE));
    location lBed1 = Location(GetArea(OBJECT_SELF),Vector(15.33f,65.72f,0.0),270.0);
    CreateObject(OBJECT_TYPE_PLACEABLE,"zep_house001",lBed1,FALSE,"set41");
    location lBed2 = Location(GetArea(OBJECT_SELF),Vector(24.51f,65.53f,0.0),0.0);
    CreateObject(OBJECT_TYPE_PLACEABLE,"zep_house001",lBed2,FALSE,"set42");
    location lBed3 = Location(GetArea(OBJECT_SELF),Vector(33.59f,65.40f,0.0),90.0);
    CreateObject(OBJECT_TYPE_PLACEABLE,"zep_house001",lBed3,FALSE,"set43");
    location lBed4 = Location(GetArea(OBJECT_SELF),Vector(19.00f,60.00f,0.0),270.0);
    CreateObject(OBJECT_TYPE_PLACEABLE,"plc_well",lBed4,FALSE,"set44");
    location lBed5 = Location(GetArea(OBJECT_SELF),Vector(29.25f,61.74f,0.0),0.0);
    CreateObject(OBJECT_TYPE_PLACEABLE,"plc_lamppost",lBed5,FALSE,"set45");
    location lBed6 = Location(GetArea(OBJECT_SELF),Vector(14.28f,62.06f,0.0),180.0);
    CreateObject(OBJECT_TYPE_PLACEABLE,"zep_doors009",lBed6,FALSE,"set46");
    location lBed7 = Location(GetArea(OBJECT_SELF),Vector(25.64f,62.37f,0.0),180.0);
    CreateObject(OBJECT_TYPE_PLACEABLE,"zep_doors009",lBed7,FALSE,"set47");
    location lBed8 = Location(GetArea(OBJECT_SELF),Vector(31.90f,61.79f,0.0),180.0);
    CreateObject(OBJECT_TYPE_PLACEABLE,"zep_doors009",lBed8,FALSE,"set48");

}
if (a == 1)
{
  AssignCommand((OBJECT_SELF),ActionPlayAnimation(ANIMATION_PLACEABLE_ACTIVATE));
  SetLocalInt(OBJECT_SELF, "Activated", 0);
  object oBed1 = GetNearestObjectByTag ("set41");
  DestroyObject(oBed1);
  object oBed2 = GetNearestObjectByTag ("set42");
  DestroyObject(oBed2);
  object oBed3 = GetNearestObjectByTag ("set43");
  DestroyObject(oBed3);
  object oBed4 = GetNearestObjectByTag ("set44");
  DestroyObject(oBed4);
  object oBed5 = GetNearestObjectByTag ("set45");
  DestroyObject(oBed5);
  object oBed6 = GetNearestObjectByTag ("set46");
  DestroyObject(oBed6);
  object oBed7 = GetNearestObjectByTag ("set47");
  DestroyObject(oBed7);
  object oBed8 = GetNearestObjectByTag ("set48");
  DestroyObject(oBed8);


}
}
