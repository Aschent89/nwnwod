//These are the persistant store and persistant read functions to store the
//status of being a vampire. Currently they are just using the default nwn
//Campaign storage methods, feel free to change them as needed, make sure to
//keep the local sets though!!!

const string StorageFile = "FVampire";

void Vampire_Set_Int(object oPC, string varName, int toStore)
{
SetLocalInt(oPC, varName, toStore);
SetCampaignInt(StorageFile, varName, toStore, oPC);
}

void Vampire_Set_String(object oPC, string varName, string toStore)
{
SetLocalString(oPC, varName, toStore);
SetCampaignString(StorageFile, varName, toStore, oPC);
}

void Vampire_Set_Location(object oPC, string varName, location toStore)
{
SetLocalLocation(oPC, varName, toStore);
SetCampaignLocation(StorageFile, varName, toStore, oPC);
}

void Vampire_Read_Int(object oPC, string varName)
{
SetLocalInt(oPC, varName, GetCampaignInt(StorageFile, varName, oPC));
}

void Vampire_Read_String(object oPC, string varName)
{
SetLocalString(oPC, varName, GetCampaignString(StorageFile, varName, oPC));
}

void Vampire_Read_Location(object oPC, string varName)
{
SetLocalLocation(oPC, varName, GetCampaignLocation(StorageFile, varName, oPC));
}

void Vampire_Delete_Int(object oPC, string varName)
{
DeleteLocalInt(oPC, varName);
DeleteCampaignVariable(StorageFile, varName, oPC);
}

void Vampire_Delete_String(object oPC, string varName)
{
DeleteLocalString(oPC, varName);
DeleteCampaignVariable(StorageFile, varName, oPC);
}

void Vampire_Delete_Location(object oPC, string varName)
{
DeleteLocalLocation(oPC, varName);
DeleteCampaignVariable(StorageFile, varName, oPC);
}
