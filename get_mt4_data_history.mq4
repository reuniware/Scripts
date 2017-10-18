//+------------------------------------------------------------------+
//|                                                 get_mq4_data_history.mq4 |
//|                     Copyright 2017, investdata.000webhostapp.com |
//|                             https://ichimoku-expert.blogspot.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2017, investdata.000webhostapp.com"
#property link      "https://ichimoku-expert.blogspot.com"
#property version   "1.00"
#property strict

bool disable=true;
int OnInit()
  {
  if (disable==true) return(INIT_SUCCEEDED);

   int maxIndex=100000;
   ENUM_TIMEFRAMES workingPeriod=PERIOD_CURRENT;

   MqlRates rates[];
   ArraySetAsSeries(rates,true);
   int copied=CopyRates(Symbol(),workingPeriod,0,maxIndex,rates);
   if(copied>0)
     {
      Print(EnumToString(workingPeriod)+" : Bars copied: "+copied);
      string format="open = %G, high = %G, low = %G, close = %G, volume = %d";
      string out;
      int size=fmin(copied,maxIndex);
      printf("size = "+size);
      for(int i=0;i<size;i++)
        {
         out=i+":"+TimeToString(rates[i].time);
         out=out+" "+StringFormat(format,
                                  rates[i].open,
                                  rates[i].high,
                                  rates[i].low,
                                  rates[i].close,
                                  rates[i].tick_volume);
         //Print(out);
        }
     }
   else Print("Failed to get history data for the symbol ",Symbol());

   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
   /*if (reason==3){
      printf("deinit reason = REASON_CHARTCHANGE");
   }*/
   
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void OnTick()
  {
  }
//+------------------------------------------------------------------+
//| Timer function                                                   |
//+------------------------------------------------------------------+

void OnTimer()
  {
  }
//+------------------------------------------------------------------+
//| Tester function                                                  |
//+------------------------------------------------------------------+
double OnTester()
  {
//---
   double ret=0.0;
//---

//---
   return(ret);
  }
//+------------------------------------------------------------------+
//| ChartEvent function                                              |
//+------------------------------------------------------------------+
void OnChartEvent(const int id,
                  const long &lparam,
                  const double &dparam,
                  const string &sparam)
  {
//---

  }
//+------------------------------------------------------------------+
