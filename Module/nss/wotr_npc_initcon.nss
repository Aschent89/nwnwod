#include "tokenizer_inc"

void main()
{
    object oNPC = OBJECT_SELF;

    string rName = GetLocalString(oNPC,"#WOTR_NPC_RUMOR_NAME_1");
    string rDesc = GetLocalString(oNPC,"#WOTR_NPC_RUMOR_TEXT_1");

    SetCustomToken(2001,rName);
    SetCustomToken(3001,rDesc);

    string sName = GetLocalString(oNPC,"#WOTR_NPC_KNOWS_NAME");
    string sDesc = GetLocalString(oNPC,"#WOTR_NPC_KNOWS_DESC");

    SetCustomToken(2002,sName);

    int sub = FindSubString(sDesc,"<HESHE>");
    if(sub!=-1) {
        object oNPC2 = GetLocalObject(GetModule(),sName);
        int delta = GetStringLength(sDesc)-(sub+7);

        int gender = GetGender(oNPC2);
        switch(gender) {
            case GENDER_MALE: {
                    string left = GetStringLeft(sDesc,sub-1);
                    string heshe = "he";
                    if(sub==0) heshe = "He";
                    string right = GetStringRight(sDesc,delta);
                    sDesc = left+heshe+right;
                    break;
                    }
            case GENDER_FEMALE: {
                    string left = GetStringLeft(sDesc,sub-1);
                    string heshe = "she";
                    if(sub==0) heshe = "She";
                    string right = GetStringRight(sDesc,delta);
                    sDesc = left+heshe+right;
                    break;
                    }
        }
    }
    SetCustomToken(3002,sDesc);

    string pDesc = GetLocalString(oNPC,"#WOTR_NPC_PROFESSION_DESC");
    SetCustomToken(2003,pDesc);

}
