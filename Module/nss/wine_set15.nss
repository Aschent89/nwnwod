//   remember to set the levers initial variable of  Activated to 0

void main()
{
int a = GetLocalInt(OBJECT_SELF,"Activated");
if (a == 0)
{
    AssignCommand((OBJECT_SELF),ActionPlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE));
    SetLocalInt(OBJECT_SELF, "Activated", 1);
    location lBed1 = Location(GetArea(OBJECT_SELF),Vector(17.00f,60.00f,0.0),10.0);
    CreateObject(OBJECT_TYPE_CREATURE,"zep_cactus001",lBed1,FALSE,"set151");
    location lBed2 = Location(GetArea(OBJECT_SELF),Vector(17.00f,66.40f,0.0),220.0);
    CreateObject(OBJECT_TYPE_PLACEABLE,"zep_cactus001",lBed2,FALSE,"set152");
    location lBed3 = Location(GetArea(OBJECT_SELF),Vector(25.00f,62.50f,0.0),300.0);
    CreateObject(OBJECT_TYPE_PLACEABLE,"zep_cactus001",lBed3,FALSE,"set153");
    location lBed4 = Location(GetArea(OBJECT_SELF),Vector(31.00f,63.50f,0.0),60.0);
    CreateObject(OBJECT_TYPE_PLACEABLE,"zep_cactus001",lBed4,FALSE,"set154");
    location lBed5 = Location(GetArea(OBJECT_SELF),Vector(35.00f,65.50f,0.0),150.0);
    CreateObject(OBJECT_TYPE_PLACEABLE,"zep_cactus001",lBed5,FALSE,"set155");
    location lBed6 = Location(GetArea(OBJECT_SELF),Vector(37.00f,58.40f,0.0),260.0);
    CreateObject(OBJECT_TYPE_PLACEABLE,"zep_cactus001",lBed6,FALSE,"set156");

    location lBed7 = Location(GetArea(OBJECT_SELF),Vector(22.70f,58.50f,0.0),70.0);
    CreateObject(OBJECT_TYPE_PLACEABLE,"x0_desertboulder",lBed7,FALSE,"set157");
    location lBed8 = Location(GetArea(OBJECT_SELF),Vector(33.00f,59.00f,0.0),80.0);
    CreateObject(OBJECT_TYPE_PLACEABLE,"x0_desertboulder",lBed8,FALSE,"set158");
    location lBed9 = Location(GetArea(OBJECT_SELF),Vector(38.00f,63.90f,0.0),90.0);
    CreateObject(OBJECT_TYPE_PLACEABLE,"x0_desertboulder",lBed9,FALSE,"set159");

    location lBed10 = Location(GetArea(OBJECT_SELF),Vector(13.00f,64.00f,0.0),100.0);
    CreateObject(OBJECT_TYPE_PLACEABLE,"x0_desertboulde2",lBed10,FALSE,"set1510");
    location lBed11 = Location(GetArea(OBJECT_SELF),Vector(20.00f,65.00f,0.0),190.0);
    CreateObject(OBJECT_TYPE_PLACEABLE,"x0_desertboulde2",lBed11,FALSE,"set1511");
    location lBed12 = Location(GetArea(OBJECT_SELF),Vector(29.00f,66.00f,0.0),290.0);
    CreateObject(OBJECT_TYPE_PLACEABLE,"x0_desertboulde2",lBed12,FALSE,"set1512");


}
if (a == 1)
{
  AssignCommand((OBJECT_SELF),ActionPlayAnimation(ANIMATION_PLACEABLE_ACTIVATE));
  SetLocalInt(OBJECT_SELF, "Activated", 0);
  object oBed1 = GetNearestObjectByTag ("set151");
  DestroyObject(oBed1);
  object oBed2 = GetNearestObjectByTag ("set152");
  DestroyObject(oBed2);
  object oBed3 = GetNearestObjectByTag ("set153");
  DestroyObject(oBed3);
  object oBed4 = GetNearestObjectByTag ("set154");
  DestroyObject(oBed4);
  object oBed5 = GetNearestObjectByTag ("set155");
  DestroyObject(oBed5);
  object oBed6 = GetNearestObjectByTag ("set156");
  DestroyObject(oBed6);
  object oBed7 = GetNearestObjectByTag ("set157");
  DestroyObject(oBed7);
  object oBed8 = GetNearestObjectByTag ("set158");
  DestroyObject(oBed8);
  object oBed9 = GetNearestObjectByTag ("set159");
  DestroyObject(oBed9);
  object oBed10 = GetNearestObjectByTag ("set1510");
  DestroyObject(oBed10);
  object oBed11 = GetNearestObjectByTag ("set1511");
  DestroyObject(oBed11);
  object oBed12 = GetNearestObjectByTag ("set1512");
  DestroyObject(oBed12);

}
}
