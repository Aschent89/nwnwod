void CreatePortalBinding1();

void CreatePortalBinding2();

void CreatePortalBinding3();

void CreatePortalBinding4();

void CreatePortalBinding5();

void CreatePortal1();

void CreatePortal2();

void CreatePortal3();

void CreatePortal4();

void CreatePortal5();
////////////////////////////////////////////////////////////////////////////////
///////////////// VARIABLES ////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
object oPC = GetLastSpeaker();
location lPC = GetLocation( oPC );
string sTag1 = GetName( oPC ) + "_" + GetPCPublicCDKey(oPC);
string sTag2 = "Binding1";
string sTag3 = "Binding2";
string sTag4 = "Binding3";
string sTag5 = "Binding4";
string sTag6 = "Binding5";
////////////////////////////////////////////////////////////////////////////////
void CreatePortalBinding1()
{
    location lBinding1 = GetCampaignLocation(sTag1, sTag2, oPC);
    object oPortal = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_portal", lBinding1);
    DestroyObject(oPortal, 20.0);
}
////////////////////////////////////////////////////////////////////////////////
void CreatePortalBinding2()
{
    location lBinding2 = GetCampaignLocation(sTag1, sTag3, oPC);
    object oPortal = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_portal", lBinding2);
    DestroyObject(oPortal, 20.0);
}
////////////////////////////////////////////////////////////////////////////////
void CreatePortalBinding3()
{
    location lBinding3 = GetCampaignLocation(sTag1, sTag4, oPC);
    object oPortal = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_portal", lBinding3);
    DestroyObject(oPortal, 20.0);
}
////////////////////////////////////////////////////////////////////////////////
void CreatePortalBinding4()
{
    location lBinding4 = GetCampaignLocation(sTag1, sTag5, oPC);
    object oPortal = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_portal", lBinding4);
    DestroyObject(oPortal, 20.0);
}
////////////////////////////////////////////////////////////////////////////////
void CreatePortalBinding5()
{
    location lBinding5 = GetCampaignLocation(sTag1, sTag6, oPC);
    object oPortal = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_portal", lBinding5);
    DestroyObject(oPortal, 20.0);
}
////////////////////////////////////////////////////////////////////////////////
void CreatePortal1()
{
    object oPortal = CreateObject(OBJECT_TYPE_PLACEABLE, "portal001", lPC);
    DestroyObject(oPortal, 15.0);
}
////////////////////////////////////////////////////////////////////////////////
void CreatePortal2()
{
    object oPortal = CreateObject(OBJECT_TYPE_PLACEABLE, "portal002", lPC);
    DestroyObject(oPortal, 15.0);
}
////////////////////////////////////////////////////////////////////////////////
void CreatePortal3()
{
    object oPortal = CreateObject(OBJECT_TYPE_PLACEABLE, "portal003", lPC);
    DestroyObject(oPortal, 15.0);
}
////////////////////////////////////////////////////////////////////////////////
void CreatePortal4()
{
    object oPortal = CreateObject(OBJECT_TYPE_PLACEABLE, "portal004", lPC);
    DestroyObject(oPortal, 15.0);
}
////////////////////////////////////////////////////////////////////////////////
void CreatePortal5()
{
    object oPortal = CreateObject(OBJECT_TYPE_PLACEABLE, "portal005", lPC);
    DestroyObject(oPortal, 15.0);
}
////////////////////////////////////////////////////////////////////////////////
