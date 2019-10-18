//::///////////////////////////////////////////////
//:: Custom User Defined Event
//:: FileName: HourBell
//:://////////////////////////////////////////////
/*

OnHeartbeat script for an invisible object
The bell tolls every hour counting the time.

*/
//:://////////////////////////////////////////////
//:: Created By: Ayath The Loafer
//:: Created On: October 26th 2002
//:://////////////////////////////////////////////

void main()
{
    int nHour = GetTimeHour();
    //Purely for testing purposes
    //SpeakString(IntToString(nHour));

    if (nHour==0 && GetLocalInt(OBJECT_SELF,"Called_Time")!=nHour)
    {
        SetLocalInt(OBJECT_SELF,"Called_Time",0);
        DelayCommand(0.0,AssignCommand(OBJECT_SELF, PlaySound("as_cv_bell2")));
        DelayCommand(2.0,AssignCommand(OBJECT_SELF, PlaySound("as_cv_bell2")));
        DelayCommand(4.0,AssignCommand(OBJECT_SELF, PlaySound("as_cv_bell2")));
        DelayCommand(6.0,AssignCommand(OBJECT_SELF, PlaySound("as_cv_bell2")));
        DelayCommand(8.0,AssignCommand(OBJECT_SELF, PlaySound("as_cv_bell2")));
        DelayCommand(10.0,AssignCommand(OBJECT_SELF, PlaySound("as_cv_bell2")));
        DelayCommand(12.0,AssignCommand(OBJECT_SELF, PlaySound("as_cv_bell2")));
        DelayCommand(14.0,AssignCommand(OBJECT_SELF, PlaySound("as_cv_bell2")));
        DelayCommand(16.0,AssignCommand(OBJECT_SELF, PlaySound("as_cv_bell2")));
        DelayCommand(18.0,AssignCommand(OBJECT_SELF, PlaySound("as_cv_bell2")));
        DelayCommand(20.0,AssignCommand(OBJECT_SELF, PlaySound("as_cv_bell2")));
        DelayCommand(22.0,AssignCommand(OBJECT_SELF, PlaySound("as_cv_bell2")));
    }
    if (nHour==1 && GetLocalInt(OBJECT_SELF,"Called_Time")!=nHour)
    {
        SetLocalInt(OBJECT_SELF,"Called_Time",1);
        DelayCommand(0.0,AssignCommand(OBJECT_SELF, PlaySound("as_cv_bell2")));
    }
    if (nHour==2 && GetLocalInt(OBJECT_SELF,"Called_Time")!=nHour)
    {
        SetLocalInt(OBJECT_SELF,"Called_Time",2);
        DelayCommand(0.0,AssignCommand(OBJECT_SELF, PlaySound("as_cv_bell2")));
        DelayCommand(2.0,AssignCommand(OBJECT_SELF, PlaySound("as_cv_bell2")));
    }
    if (nHour==3 && GetLocalInt(OBJECT_SELF,"Called_Time")!=nHour)
    {
        SetLocalInt(OBJECT_SELF,"Called_Time",3);
        DelayCommand(0.0,AssignCommand(OBJECT_SELF, PlaySound("as_cv_bell2")));
        DelayCommand(2.0,AssignCommand(OBJECT_SELF, PlaySound("as_cv_bell2")));
        DelayCommand(4.0,AssignCommand(OBJECT_SELF, PlaySound("as_cv_bell2")));
    }
    if (nHour==4 && GetLocalInt(OBJECT_SELF,"Called_Time")!=nHour)
    {
        SetLocalInt(OBJECT_SELF,"Called_Time",4);
        DelayCommand(0.0,AssignCommand(OBJECT_SELF, PlaySound("as_cv_bell2")));
        DelayCommand(2.0,AssignCommand(OBJECT_SELF, PlaySound("as_cv_bell2")));
        DelayCommand(4.0,AssignCommand(OBJECT_SELF, PlaySound("as_cv_bell2")));
        DelayCommand(6.0,AssignCommand(OBJECT_SELF, PlaySound("as_cv_bell2")));
    }
    if (nHour==5 && GetLocalInt(OBJECT_SELF,"Called_Time")!=nHour)
    {
        SetLocalInt(OBJECT_SELF,"Called_Time",5);
        DelayCommand(0.0,AssignCommand(OBJECT_SELF, PlaySound("as_cv_bell2")));
        DelayCommand(2.0,AssignCommand(OBJECT_SELF, PlaySound("as_cv_bell2")));
        DelayCommand(4.0,AssignCommand(OBJECT_SELF, PlaySound("as_cv_bell2")));
        DelayCommand(6.0,AssignCommand(OBJECT_SELF, PlaySound("as_cv_bell2")));
        DelayCommand(8.0,AssignCommand(OBJECT_SELF, PlaySound("as_cv_bell2")));
    }
    if (nHour==6 && GetLocalInt(OBJECT_SELF,"Called_Time")!=nHour)
    {
        SetLocalInt(OBJECT_SELF,"Called_Time",6);
        DelayCommand(0.0,AssignCommand(OBJECT_SELF, PlaySound("as_cv_bell2")));
        DelayCommand(2.0,AssignCommand(OBJECT_SELF, PlaySound("as_cv_bell2")));
        DelayCommand(4.0,AssignCommand(OBJECT_SELF, PlaySound("as_cv_bell2")));
        DelayCommand(6.0,AssignCommand(OBJECT_SELF, PlaySound("as_cv_bell2")));
        DelayCommand(8.0,AssignCommand(OBJECT_SELF, PlaySound("as_cv_bell2")));
        DelayCommand(10.0,AssignCommand(OBJECT_SELF, PlaySound("as_cv_bell2")));
    }
    if (nHour==7 && GetLocalInt(OBJECT_SELF,"Called_Time")!=nHour)
    {
        SetLocalInt(OBJECT_SELF,"Called_Time",7);
        DelayCommand(0.0,AssignCommand(OBJECT_SELF, PlaySound("as_cv_bell2")));
        DelayCommand(2.0,AssignCommand(OBJECT_SELF, PlaySound("as_cv_bell2")));
        DelayCommand(4.0,AssignCommand(OBJECT_SELF, PlaySound("as_cv_bell2")));
        DelayCommand(6.0,AssignCommand(OBJECT_SELF, PlaySound("as_cv_bell2")));
        DelayCommand(8.0,AssignCommand(OBJECT_SELF, PlaySound("as_cv_bell2")));
        DelayCommand(10.0,AssignCommand(OBJECT_SELF, PlaySound("as_cv_bell2")));
        DelayCommand(12.0,AssignCommand(OBJECT_SELF, PlaySound("as_cv_bell2")));
    }
    if (nHour==8 && GetLocalInt(OBJECT_SELF,"Called_Time")!=nHour)
    {
        SetLocalInt(OBJECT_SELF,"Called_Time",8);
        DelayCommand(0.0,AssignCommand(OBJECT_SELF, PlaySound("as_cv_bell2")));
        DelayCommand(2.0,AssignCommand(OBJECT_SELF, PlaySound("as_cv_bell2")));
        DelayCommand(4.0,AssignCommand(OBJECT_SELF, PlaySound("as_cv_bell2")));
        DelayCommand(6.0,AssignCommand(OBJECT_SELF, PlaySound("as_cv_bell2")));
        DelayCommand(8.0,AssignCommand(OBJECT_SELF, PlaySound("as_cv_bell2")));
        DelayCommand(10.0,AssignCommand(OBJECT_SELF, PlaySound("as_cv_bell2")));
        DelayCommand(12.0,AssignCommand(OBJECT_SELF, PlaySound("as_cv_bell2")));
        DelayCommand(14.0,AssignCommand(OBJECT_SELF, PlaySound("as_cv_bell2")));
    }
    if (nHour==9 && GetLocalInt(OBJECT_SELF,"Called_Time")!=nHour)
    {
        SetLocalInt(OBJECT_SELF,"Called_Time",9);
        DelayCommand(0.0,AssignCommand(OBJECT_SELF, PlaySound("as_cv_bell2")));
        DelayCommand(2.0,AssignCommand(OBJECT_SELF, PlaySound("as_cv_bell2")));
        DelayCommand(4.0,AssignCommand(OBJECT_SELF, PlaySound("as_cv_bell2")));
        DelayCommand(6.0,AssignCommand(OBJECT_SELF, PlaySound("as_cv_bell2")));
        DelayCommand(8.0,AssignCommand(OBJECT_SELF, PlaySound("as_cv_bell2")));
        DelayCommand(10.0,AssignCommand(OBJECT_SELF, PlaySound("as_cv_bell2")));
        DelayCommand(12.0,AssignCommand(OBJECT_SELF, PlaySound("as_cv_bell2")));
        DelayCommand(14.0,AssignCommand(OBJECT_SELF, PlaySound("as_cv_bell2")));
        DelayCommand(16.0,AssignCommand(OBJECT_SELF, PlaySound("as_cv_bell2")));
    }
    if (nHour==10 && GetLocalInt(OBJECT_SELF,"Called_Time")!=nHour)
    {
        SetLocalInt(OBJECT_SELF,"Called_Time",10);
        DelayCommand(0.0,AssignCommand(OBJECT_SELF, PlaySound("as_cv_bell2")));
        DelayCommand(2.0,AssignCommand(OBJECT_SELF, PlaySound("as_cv_bell2")));
        DelayCommand(4.0,AssignCommand(OBJECT_SELF, PlaySound("as_cv_bell2")));
        DelayCommand(6.0,AssignCommand(OBJECT_SELF, PlaySound("as_cv_bell2")));
        DelayCommand(8.0,AssignCommand(OBJECT_SELF, PlaySound("as_cv_bell2")));
        DelayCommand(10.0,AssignCommand(OBJECT_SELF, PlaySound("as_cv_bell2")));
        DelayCommand(12.0,AssignCommand(OBJECT_SELF, PlaySound("as_cv_bell2")));
        DelayCommand(14.0,AssignCommand(OBJECT_SELF, PlaySound("as_cv_bell2")));
        DelayCommand(16.0,AssignCommand(OBJECT_SELF, PlaySound("as_cv_bell2")));
        DelayCommand(18.0,AssignCommand(OBJECT_SELF, PlaySound("as_cv_bell2")));
    }
    if (nHour==11 && GetLocalInt(OBJECT_SELF,"Called_Time")!=nHour)
    {
        SetLocalInt(OBJECT_SELF,"Called_Time",11);
        DelayCommand(0.0,AssignCommand(OBJECT_SELF, PlaySound("as_cv_bell2")));
        DelayCommand(2.0,AssignCommand(OBJECT_SELF, PlaySound("as_cv_bell2")));
        DelayCommand(4.0,AssignCommand(OBJECT_SELF, PlaySound("as_cv_bell2")));
        DelayCommand(6.0,AssignCommand(OBJECT_SELF, PlaySound("as_cv_bell2")));
        DelayCommand(8.0,AssignCommand(OBJECT_SELF, PlaySound("as_cv_bell2")));
        DelayCommand(10.0,AssignCommand(OBJECT_SELF, PlaySound("as_cv_bell2")));
        DelayCommand(12.0,AssignCommand(OBJECT_SELF, PlaySound("as_cv_bell2")));
        DelayCommand(14.0,AssignCommand(OBJECT_SELF, PlaySound("as_cv_bell2")));
        DelayCommand(16.0,AssignCommand(OBJECT_SELF, PlaySound("as_cv_bell2")));
        DelayCommand(18.0,AssignCommand(OBJECT_SELF, PlaySound("as_cv_bell2")));
        DelayCommand(20.0,AssignCommand(OBJECT_SELF, PlaySound("as_cv_bell2")));
    }
    if (nHour==12 && GetLocalInt(OBJECT_SELF,"Called_Time")!=nHour)
    {
        SetLocalInt(OBJECT_SELF,"Called_Time",12);
        DelayCommand(0.0,AssignCommand(OBJECT_SELF, PlaySound("as_cv_bell2")));
        DelayCommand(2.0,AssignCommand(OBJECT_SELF, PlaySound("as_cv_bell2")));
        DelayCommand(4.0,AssignCommand(OBJECT_SELF, PlaySound("as_cv_bell2")));
        DelayCommand(6.0,AssignCommand(OBJECT_SELF, PlaySound("as_cv_bell2")));
        DelayCommand(8.0,AssignCommand(OBJECT_SELF, PlaySound("as_cv_bell2")));
        DelayCommand(10.0,AssignCommand(OBJECT_SELF, PlaySound("as_cv_bell2")));
        DelayCommand(12.0,AssignCommand(OBJECT_SELF, PlaySound("as_cv_bell2")));
        DelayCommand(14.0,AssignCommand(OBJECT_SELF, PlaySound("as_cv_bell2")));
        DelayCommand(16.0,AssignCommand(OBJECT_SELF, PlaySound("as_cv_bell2")));
        DelayCommand(18.0,AssignCommand(OBJECT_SELF, PlaySound("as_cv_bell2")));
        DelayCommand(20.0,AssignCommand(OBJECT_SELF, PlaySound("as_cv_bell2")));
        DelayCommand(22.0,AssignCommand(OBJECT_SELF, PlaySound("as_cv_bell2")));
    }
    if (nHour==13 && GetLocalInt(OBJECT_SELF,"Called_Time")!=nHour)
    {
        SetLocalInt(OBJECT_SELF,"Called_Time",13);
        DelayCommand(0.0,AssignCommand(OBJECT_SELF, PlaySound("as_cv_bell2")));
    }
    if (nHour==14 && GetLocalInt(OBJECT_SELF,"Called_Time")!=nHour)
    {
        SetLocalInt(OBJECT_SELF,"Called_Time",14);
        DelayCommand(0.0,AssignCommand(OBJECT_SELF, PlaySound("as_cv_bell2")));
        DelayCommand(2.0,AssignCommand(OBJECT_SELF, PlaySound("as_cv_bell2")));
    }
    if (nHour==15 && GetLocalInt(OBJECT_SELF,"Called_Time")!=nHour)
    {
        SetLocalInt(OBJECT_SELF,"Called_Time",15);
        DelayCommand(0.0,AssignCommand(OBJECT_SELF, PlaySound("as_cv_bell2")));
        DelayCommand(2.0,AssignCommand(OBJECT_SELF, PlaySound("as_cv_bell2")));
        DelayCommand(4.0,AssignCommand(OBJECT_SELF, PlaySound("as_cv_bell2")));
    }
    if (nHour==16 && GetLocalInt(OBJECT_SELF,"Called_Time")!=nHour)
    {
        SetLocalInt(OBJECT_SELF,"Called_Time",16);
        DelayCommand(0.0,AssignCommand(OBJECT_SELF, PlaySound("as_cv_bell2")));
        DelayCommand(2.0,AssignCommand(OBJECT_SELF, PlaySound("as_cv_bell2")));
        DelayCommand(4.0,AssignCommand(OBJECT_SELF, PlaySound("as_cv_bell2")));
        DelayCommand(6.0,AssignCommand(OBJECT_SELF, PlaySound("as_cv_bell2")));
    }
    if (nHour==17 && GetLocalInt(OBJECT_SELF,"Called_Time")!=nHour)
    {
        SetLocalInt(OBJECT_SELF,"Called_Time",17);
        DelayCommand(0.0,AssignCommand(OBJECT_SELF, PlaySound("as_cv_bell2")));
        DelayCommand(2.0,AssignCommand(OBJECT_SELF, PlaySound("as_cv_bell2")));
        DelayCommand(4.0,AssignCommand(OBJECT_SELF, PlaySound("as_cv_bell2")));
        DelayCommand(6.0,AssignCommand(OBJECT_SELF, PlaySound("as_cv_bell2")));
        DelayCommand(8.0,AssignCommand(OBJECT_SELF, PlaySound("as_cv_bell2")));
    }
    if (nHour==18 && GetLocalInt(OBJECT_SELF,"Called_Time")!=nHour)
    {
        SetLocalInt(OBJECT_SELF,"Called_Time",18);
        DelayCommand(0.0,AssignCommand(OBJECT_SELF, PlaySound("as_cv_bell2")));
        DelayCommand(2.0,AssignCommand(OBJECT_SELF, PlaySound("as_cv_bell2")));
        DelayCommand(4.0,AssignCommand(OBJECT_SELF, PlaySound("as_cv_bell2")));
        DelayCommand(6.0,AssignCommand(OBJECT_SELF, PlaySound("as_cv_bell2")));
        DelayCommand(8.0,AssignCommand(OBJECT_SELF, PlaySound("as_cv_bell2")));
        DelayCommand(10.0,AssignCommand(OBJECT_SELF, PlaySound("as_cv_bell2")));
    }
    if (nHour==19 && GetLocalInt(OBJECT_SELF,"Called_Time")!=nHour)
    {
        SetLocalInt(OBJECT_SELF,"Called_Time",19);
        DelayCommand(0.0,AssignCommand(OBJECT_SELF, PlaySound("as_cv_bell2")));
        DelayCommand(2.0,AssignCommand(OBJECT_SELF, PlaySound("as_cv_bell2")));
        DelayCommand(4.0,AssignCommand(OBJECT_SELF, PlaySound("as_cv_bell2")));
        DelayCommand(6.0,AssignCommand(OBJECT_SELF, PlaySound("as_cv_bell2")));
        DelayCommand(8.0,AssignCommand(OBJECT_SELF, PlaySound("as_cv_bell2")));
        DelayCommand(10.0,AssignCommand(OBJECT_SELF, PlaySound("as_cv_bell2")));
        DelayCommand(12.0,AssignCommand(OBJECT_SELF, PlaySound("as_cv_bell2")));
    }
    if (nHour==20 && GetLocalInt(OBJECT_SELF,"Called_Time")!=nHour)
    {
        SetLocalInt(OBJECT_SELF,"Called_Time",20);
        DelayCommand(0.0,AssignCommand(OBJECT_SELF, PlaySound("as_cv_bell2")));
        DelayCommand(2.0,AssignCommand(OBJECT_SELF, PlaySound("as_cv_bell2")));
        DelayCommand(4.0,AssignCommand(OBJECT_SELF, PlaySound("as_cv_bell2")));
        DelayCommand(6.0,AssignCommand(OBJECT_SELF, PlaySound("as_cv_bell2")));
        DelayCommand(8.0,AssignCommand(OBJECT_SELF, PlaySound("as_cv_bell2")));
        DelayCommand(10.0,AssignCommand(OBJECT_SELF, PlaySound("as_cv_bell2")));
        DelayCommand(12.0,AssignCommand(OBJECT_SELF, PlaySound("as_cv_bell2")));
        DelayCommand(14.0,AssignCommand(OBJECT_SELF, PlaySound("as_cv_bell2")));
    }
    if (nHour==21 && GetLocalInt(OBJECT_SELF,"Called_Time")!=nHour)
    {
        SetLocalInt(OBJECT_SELF,"Called_Time",21);
        DelayCommand(0.0,AssignCommand(OBJECT_SELF, PlaySound("as_cv_bell2")));
        DelayCommand(2.0,AssignCommand(OBJECT_SELF, PlaySound("as_cv_bell2")));
        DelayCommand(4.0,AssignCommand(OBJECT_SELF, PlaySound("as_cv_bell2")));
        DelayCommand(6.0,AssignCommand(OBJECT_SELF, PlaySound("as_cv_bell2")));
        DelayCommand(8.0,AssignCommand(OBJECT_SELF, PlaySound("as_cv_bell2")));
        DelayCommand(10.0,AssignCommand(OBJECT_SELF, PlaySound("as_cv_bell2")));
        DelayCommand(12.0,AssignCommand(OBJECT_SELF, PlaySound("as_cv_bell2")));
        DelayCommand(14.0,AssignCommand(OBJECT_SELF, PlaySound("as_cv_bell2")));
        DelayCommand(16.0,AssignCommand(OBJECT_SELF, PlaySound("as_cv_bell2")));
    }
    if (nHour==22 && GetLocalInt(OBJECT_SELF,"Called_Time")!=nHour)
    {
        SetLocalInt(OBJECT_SELF,"Called_Time",22);
        DelayCommand(0.0,AssignCommand(OBJECT_SELF, PlaySound("as_cv_bell2")));
        DelayCommand(2.0,AssignCommand(OBJECT_SELF, PlaySound("as_cv_bell2")));
        DelayCommand(4.0,AssignCommand(OBJECT_SELF, PlaySound("as_cv_bell2")));
        DelayCommand(6.0,AssignCommand(OBJECT_SELF, PlaySound("as_cv_bell2")));
        DelayCommand(8.0,AssignCommand(OBJECT_SELF, PlaySound("as_cv_bell2")));
        DelayCommand(10.0,AssignCommand(OBJECT_SELF, PlaySound("as_cv_bell2")));
        DelayCommand(12.0,AssignCommand(OBJECT_SELF, PlaySound("as_cv_bell2")));
        DelayCommand(14.0,AssignCommand(OBJECT_SELF, PlaySound("as_cv_bell2")));
        DelayCommand(16.0,AssignCommand(OBJECT_SELF, PlaySound("as_cv_bell2")));
        DelayCommand(18.0,AssignCommand(OBJECT_SELF, PlaySound("as_cv_bell2")));
    }
    if (nHour==23 && GetLocalInt(OBJECT_SELF,"Called_Time")!=nHour)
    {
        SetLocalInt(OBJECT_SELF,"Called_Time",23);
        DelayCommand(0.0,AssignCommand(OBJECT_SELF, PlaySound("as_cv_bell2")));
        DelayCommand(2.0,AssignCommand(OBJECT_SELF, PlaySound("as_cv_bell2")));
        DelayCommand(4.0,AssignCommand(OBJECT_SELF, PlaySound("as_cv_bell2")));
        DelayCommand(6.0,AssignCommand(OBJECT_SELF, PlaySound("as_cv_bell2")));
        DelayCommand(8.0,AssignCommand(OBJECT_SELF, PlaySound("as_cv_bell2")));
        DelayCommand(10.0,AssignCommand(OBJECT_SELF, PlaySound("as_cv_bell2")));
        DelayCommand(12.0,AssignCommand(OBJECT_SELF, PlaySound("as_cv_bell2")));
        DelayCommand(14.0,AssignCommand(OBJECT_SELF, PlaySound("as_cv_bell2")));
        DelayCommand(16.0,AssignCommand(OBJECT_SELF, PlaySound("as_cv_bell2")));
        DelayCommand(18.0,AssignCommand(OBJECT_SELF, PlaySound("as_cv_bell2")));
        DelayCommand(20.0,AssignCommand(OBJECT_SELF, PlaySound("as_cv_bell2")));
    }
}
