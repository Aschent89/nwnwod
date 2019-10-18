//   remember to set the levers initial variable of  Activated to 0

void main()
{
int a = GetLocalInt(OBJECT_SELF,"Activated");
if (a == 0)
{
    AssignCommand((OBJECT_SELF),ActionPlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE));
    SetLocalInt(OBJECT_SELF, "Activated", 1);
    location lBed1 = Location(GetArea(OBJECT_SELF),Vector(26.00f,58.00f,0.0),199.0);
    CreateObject(OBJECT_TYPE_CREATURE,"zep_oxwithplow",lBed1,FALSE,"set121");
    location lBed2 = Location(GetArea(OBJECT_SELF),Vector(16.50f,65.00f,0.0),0.0);
    CreateObject(OBJECT_TYPE_PLACEABLE,"zep_flrdesgns002",lBed2,FALSE,"set122");
    location lBed3 = Location(GetArea(OBJECT_SELF),Vector(21.84f,65.00f,0.0),0.0);
    CreateObject(OBJECT_TYPE_PLACEABLE,"zep_flrdesgns002",lBed3,FALSE,"set123");
    location lBed4 = Location(GetArea(OBJECT_SELF),Vector(16.50f,59.70f,0.0),0.0);
    CreateObject(OBJECT_TYPE_PLACEABLE,"zep_flrdesgns002",lBed4,FALSE,"set124");
    location lBed5 = Location(GetArea(OBJECT_SELF),Vector(21.84f,59.70f,0.0),0.0);
    CreateObject(OBJECT_TYPE_PLACEABLE,"zep_flrdesgns002",lBed5,FALSE,"set125");

    location lBed6 = Location(GetArea(OBJECT_SELF),Vector(15.65f,58.30f,0.0),0.0);
    CreateObject(OBJECT_TYPE_PLACEABLE,"zep_pumpkinpatch",lBed6,FALSE,"set126");
    location lBed7 = Location(GetArea(OBJECT_SELF),Vector(19.00f,58.30f,0.0),0.0);
    CreateObject(OBJECT_TYPE_PLACEABLE,"zep_pumpkinpatch",lBed7,FALSE,"set127");
    location lBed8 = Location(GetArea(OBJECT_SELF),Vector(22.80f,58.30f,0.0),0.0);
    CreateObject(OBJECT_TYPE_PLACEABLE,"zep_pumpkinpatch",lBed8,FALSE,"set128");
    location lBed9 = Location(GetArea(OBJECT_SELF),Vector(14.40f,62.20f,0.0),0.0);
    CreateObject(OBJECT_TYPE_PLACEABLE,"zep_pumpkinpatch",lBed9,FALSE,"set129");
    location lBed10 = Location(GetArea(OBJECT_SELF),Vector(18.87f,62.20f,0.0),0.0);
    CreateObject(OBJECT_TYPE_PLACEABLE,"zep_pumpkinpatch",lBed10,FALSE,"set1210");
    location lBed11 = Location(GetArea(OBJECT_SELF),Vector(23.85f,62.20f,0.0),0.0);
    CreateObject(OBJECT_TYPE_PLACEABLE,"zep_pumpkinpatch",lBed11,FALSE,"set1211");

    location lBed12 = Location(GetArea(OBJECT_SELF),Vector(14.70f,66.40f,0.0),90.0);
    CreateObject(OBJECT_TYPE_PLACEABLE,"zep_scarecrow001",lBed12,FALSE,"set1212");
    location lBed13 = Location(GetArea(OBJECT_SELF),Vector(24.12f,67.00f,0.0),90.0);
    CreateObject(OBJECT_TYPE_PLACEABLE,"x0_boulder",lBed13,FALSE,"set1213");
    location lBed14 = Location(GetArea(OBJECT_SELF),Vector(29.11f,67.00f,0.0),90.0);
    CreateObject(OBJECT_TYPE_PLACEABLE,"x0_boulder",lBed14,FALSE,"set1214");

    location lBed15 = Location(GetArea(OBJECT_SELF),Vector(30.25f,63.10f,0.0),138.0);
    CreateObject(OBJECT_TYPE_PLACEABLE,"zep_wheelbarrel",lBed15,FALSE,"set1215");
    location lBed16 = Location(GetArea(OBJECT_SELF),Vector(37.75f,57.00f,0.0),180.0);
    CreateObject(OBJECT_TYPE_PLACEABLE,"zep_well001",lBed16,FALSE,"set1216");
    location lBed17 = Location(GetArea(OBJECT_SELF),Vector(35.00f,65.00f,0.0),0.0);
    CreateObject(OBJECT_TYPE_PLACEABLE,"zep_house001",lBed17,FALSE,"set1217");
    location lBed18 = Location(GetArea(OBJECT_SELF),Vector(33.58f,61.72f,0.0),180.0);
    CreateObject(OBJECT_TYPE_PLACEABLE,"zep_doors009",lBed18,FALSE,"set1218");
}
if (a == 1)
{
  AssignCommand((OBJECT_SELF),ActionPlayAnimation(ANIMATION_PLACEABLE_ACTIVATE));
  SetLocalInt(OBJECT_SELF, "Activated", 0);
  object oBed1 = GetNearestObjectByTag ("set121");
  DestroyObject(oBed1);
  object oBed2 = GetNearestObjectByTag ("set122");
  DestroyObject(oBed2);
  object oBed3 = GetNearestObjectByTag ("set123");
  DestroyObject(oBed3);
  object oBed4 = GetNearestObjectByTag ("set124");
  DestroyObject(oBed4);
  object oBed5 = GetNearestObjectByTag ("set125");
  DestroyObject(oBed5);
  object oBed6 = GetNearestObjectByTag ("set126");
  DestroyObject(oBed6);
  object oBed7 = GetNearestObjectByTag ("set127");
  DestroyObject(oBed7);
  object oBed8 = GetNearestObjectByTag ("set128");
  DestroyObject(oBed8);
  object oBed9 = GetNearestObjectByTag ("set129");
  DestroyObject(oBed9);
  object oBed10 = GetNearestObjectByTag ("set1210");
  DestroyObject(oBed10);
  object oBed11 = GetNearestObjectByTag ("set1211");
  DestroyObject(oBed11);
  object oBed12 = GetNearestObjectByTag ("set1212");
  DestroyObject(oBed12);
  object oBed13 = GetNearestObjectByTag ("set1213");
  DestroyObject(oBed13);
  object oBed14 = GetNearestObjectByTag ("set1214");
  DestroyObject(oBed14);
  object oBed15 = GetNearestObjectByTag ("set1215");
  DestroyObject(oBed15);
  object oBed16 = GetNearestObjectByTag ("set1216");
  DestroyObject(oBed16);
  object oBed17 = GetNearestObjectByTag ("set1217");
  DestroyObject(oBed17);
  object oBed18 = GetNearestObjectByTag ("set1218");
  DestroyObject(oBed18);





}
}
