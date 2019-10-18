////////////////////////////////////////////////////////////////////////////////
//  Olander's Realistic Systems - Conversation Check Time
//  ors_conv_time
//  By Don Anderson
//  dandersonru@msn.com
//
//  This gives you the Current Time and Day
//
////////////////////////////////////////////////////////////////////////////////

void main()
{
    object oPC = GetPCSpeaker();
    object oMod = GetModule();

    //This is YOUR Module Minutes to Hour Setting
    int nMPH = GetLocalInt(GetModule(),"MPH");

    //Determine the Day and Time
    int nMinute     = GetTimeMinute();
    int nHour       = GetTimeHour();
    int nDay        = GetCalendarDay();
    int nMonth      = GetCalendarMonth();
    int nYear       = GetCalendarYear();

    string sMinute;
    string sDay;
    string sDay1 = "Sunday ";
    string sDay2 = "Monday ";
    string sDay3 = "Tuesday ";
    string sDay4 = "Wednesday ";
    string sDay5 = "Thursday ";
    string sDay6 = "Friday ";
    string sDay7 = "Saturday ";

    string sNth;
    string s1st  = "st ";
    string s2nd  = "nd ";
    string s3rd  = "rd ";
    string s4th  = "th ";

    if(nDay == 1) sNth = s1st;
    else if(nDay == 2) sNth = s2nd;
    else if(nDay == 3) sNth = s3rd;
    else sNth = s4th;

    string sMonth;
    string sMonth1  = GetLocalString(oMod,"MONTH1");
    string sMonth2  = GetLocalString(oMod,"MONTH2");
    string sMonth3  = GetLocalString(oMod,"MONTH3");
    string sMonth4  = GetLocalString(oMod,"MONTH4");
    string sMonth5  = GetLocalString(oMod,"MONTH5");
    string sMonth6  = GetLocalString(oMod,"MONTH6");
    string sMonth7  = GetLocalString(oMod,"MONTH7");
    string sMonth8  = GetLocalString(oMod,"MONTH8");
    string sMonth9  = GetLocalString(oMod,"MONTH9");
    string sMonth10 = GetLocalString(oMod,"MONTH10");
    string sMonth11 = GetLocalString(oMod,"MONTH11");
    string sMonth12 = GetLocalString(oMod,"MONTH12");

    string sDayOf = "Day Of ";

    //28 Day Cycle
    switch(nDay)
    {
      case 1: sDay = sDay1; break;
      case 2: sDay = sDay2; break;
      case 3: sDay = sDay3; break;
      case 4: sDay = sDay4; break;
      case 5: sDay = sDay5; break;
      case 6: sDay = sDay6; break;
      case 7: sDay = sDay7; break;
      case 8: sDay = sDay1; break;
      case 9: sDay = sDay2; break;
      case 10: sDay = sDay3; break;
      case 11: sDay = sDay4; break;
      case 12: sDay = sDay5; break;
      case 13: sDay = sDay6; break;
      case 14: sDay = sDay7; break;
      case 15: sDay = sDay1; break;
      case 16: sDay = sDay2; break;
      case 17: sDay = sDay3; break;
      case 18: sDay = sDay4; break;
      case 19: sDay = sDay5; break;
      case 20: sDay = sDay6; break;
      case 21: sDay = sDay7; break;
      case 22: sDay = sDay1; break;
      case 23: sDay = sDay2; break;
      case 24: sDay = sDay3; break;
      case 25: sDay = sDay4; break;
      case 26: sDay = sDay5; break;
      case 27: sDay = sDay6; break;
      case 28: sDay = sDay7; break;
    }

    //12 Month Cycle
    switch(nMonth)
    {
      case 1: sMonth = sMonth1; break;
      case 2: sMonth = sMonth2; break;
      case 3: sMonth = sMonth3; break;
      case 4: sMonth = sMonth4; break;
      case 5: sMonth = sMonth5; break;
      case 6: sMonth = sMonth6; break;
      case 7: sMonth = sMonth7; break;
      case 8: sMonth = sMonth8; break;
      case 9: sMonth = sMonth9; break;
      case 10: sMonth = sMonth10; break;
      case 11: sMonth = sMonth11; break;
      case 12: sMonth = sMonth12; break;
    }

    //Make Complete String
    string sComplete = sDay +"the "+ IntToString(nDay) + sNth + sDayOf + sMonth + "of Year " +IntToString(nYear);

    //If 2 Minutes per Hour only show Top and Bottom of Hours
    if(nMPH == 2)
    {
      //Set Top half of the hour
      if(nMinute == 0)
      {
        nMinute = 0;
        sMinute = IntToString(nMinute) + "0";
      }

      //Set Bottom half of the hour
      else if(nMinute == 1)
      {
        nMinute = 30;
        sMinute = IntToString(nMinute);
      }
    }

    //If More than 2 Minutes
    if(nMPH >= 4)
    {
      //Now we convert Minute Values to Proper Minutes
      int nMinCalc  = 60/nMPH;
      int nMConv    = nMinute * nMinCalc;//To Show the Minutes Properly
      int nTop      = 0;
      int nBottom   = 30;

      nMinute = nMConv;

      //Set Top of the Hour and Play 2 Gongs
      if(nMinute == 0)
      {
        nMinute = 0;
        sMinute = IntToString(nMinute) + "0";
      }

      //Set all other Minutes
      if(nMinute >= 1)
      {
        if(nMinute < 10)
        {
          sMinute = "0" +IntToString(nMinute);
        }
        else
        {
          sMinute = IntToString(nMinute);
        }
      }
    }

    //Set AM or PM from 24 Hour Clock
    if (nHour == 0)
    {
      nHour = 12;
      SpeakString(IntToString(nHour)+ ":" +(sMinute)+ " AM  " +sComplete);
    }
    if (nHour >= 1 && nHour <= 11)
    {
      SpeakString(IntToString(nHour)+":"+(sMinute)+" AM  " +sComplete);
    }
    if (nHour == 12)
    {
      nHour = 12;
      SpeakString(IntToString(nHour)+":"+(sMinute)+" PM  " +sComplete);
    }
    if (nHour > 12 && nHour <= 23)
    {
      nHour = nHour - 12;
      SpeakString(IntToString(nHour)+":"+(sMinute)+" PM  " +sComplete);
    }


}
