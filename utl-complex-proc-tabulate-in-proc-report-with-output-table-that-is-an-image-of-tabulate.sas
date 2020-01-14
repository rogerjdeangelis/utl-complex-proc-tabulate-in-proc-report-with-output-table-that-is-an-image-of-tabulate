Complex proc tabulate in proc report with output table that is an image of tabulate                                                                
                                                                                                                                                   
github                                                                                                                                             
https://tinyurl.com/yx6wcjgo                                                                                                                       
https://github.com/rogerjdeangelis/utl-complex-proc-tabulate-in-proc-report-with-output-table-that-is-an-image-of-tabulate                         
                                                                                                                                                   
SAS Forum                                                                                                                                          
https://tinyurl.com/qqguse2                                                                                                                        
https://communities.sas.com/t5/SAS-Programming/two-dimensional-report-with-2-varaibles-in-y-and-one-in-X/m-p/616843                                
                                                                                                                                                   
I think you have painted yourself into a corner.                                                                                                   
I don't think it is possible to weight one variable and not the other in tabulate.                                                                 
                                                                                                                                                   
Your code does not specify weights for both interest and sumloan but tabulate weights both..                                                       
                                                                                                                                                   
Below is a solution that produces an output table with the same form as tabulate, so will                                                          
never be painted into a corner.                                                                                                                    
                                                                                                                                                   
SOPABOX ON                                                                                                                                         
It is a little messy because there is a bug in the proc report ods datasets.                                                                       
It does not create compound intuitive names like 'proc corresp'.                                                                                   
The ods output dataset is the same as the out= dataset.                                                                                            
I think SAS should do what it does with proc print and say that the ods output                                                                     
is not supported in proc report?                                                                                                                   
SOAPBOX OFF                                                                                                                                        
                                                                                                                                                   
*_                   _                                                                                                                             
(_)_ __  _ __  _   _| |_                                                                                                                           
| | '_ \| '_ \| | | | __|                                                                                                                          
| | | | | |_) | |_| | |_                                                                                                                           
|_|_| |_| .__/ \__,_|\__|                                                                                                                          
        |_|                                                                                                                                        
;                                                                                                                                                  
                                                                                                                                                   
Data have;                                                                                                                                         
 length xcr $32;                                                                                                                                   
 informat MODEL $2. Team $2.;                                                                                                                      
 input ID MODEL Team SUMLOAN interest LenghtLoan;                                                                                                  
 ll = ifc (LenghtLoan <= 365, "LE","GT");                                                                                                          
 xcr=cats(model,ll);                                                                                                                               
 wi=interest*sumloan;  /* weighted interest */                                                                                                     
 sl=sumloan;                                                                                                                                       
 drop sumloan interest lenghtloan;                                                                                                                 
cards4;                                                                                                                                            
1 A W 10 2.4 180                                                                                                                                   
2 A Y 20 2.3 180                                                                                                                                   
4 A X 40 7.8 720                                                                                                                                   
9 A X 90 4.1 3650                                                                                                                                  
10 A Y 100 5.2 180                                                                                                                                 
11 A X 110 4.8 180                                                                                                                                 
12 A W 120 2.7 720                                                                                                                                 
18 A X 180 2.9 3650                                                                                                                                
19 A Y 190 4.1 3650                                                                                                                                
20 A W 200 3.9 3650                                                                                                                                
3 B X 30 3.4 180                                                                                                                                   
5 B Y 50 8.1 720                                                                                                                                   
6 B X 60 2.5 3650                                                                                                                                  
7 B X 70 2.6 3650                                                                                                                                  
8 B X 80 2.7 3650                                                                                                                                  
13 B X 130 2.8 720                                                                                                                                 
14 B W 140 3.9 720                                                                                                                                 
15 B X 150 9.6 180                                                                                                                                 
16 B Y 160 8.3 180                                                                                                                                 
17 B X 170 4.7 3650                                                                                                                                
;;;;                                                                                                                                               
run;quit;                                                                                                                                          
                                                                                                                                                   
I renamed some variables and calculated weighted interest.                                                                                         
                                                                                                                                                   
Note model x loanlength(trasformed)                                                                                                                
                                                                                                                                                   
  AGT = A x Above 365  (greater than or equal to 365)                                                                                              
  ALE = A x Below 365  (less than or equal to 365)                                                                                                 
  BGT = B x Above 365                                                                                                                              
  BLE = B x Below 365                                                                                                                              
                                                                                                                                                   
  WI = weihghted interest                                                                                                                          
  LL = loanlength                                                                                                                                  
  SL = sumloan                                                                                                                                     
                                                                                                                                                   
WORK.HAVE total obs=20                                                                                                                             
                                                                                                                                                   
   XCR    MODEL    TEAM    ID    LL     WI      SL                                                                                                 
                                                                                                                                                   
   ALE      A       W       1    LE      24     10                                                                                                 
   ALE      A       Y       2    LE      46     20                                                                                                 
   AGT      A       X       4    GT     312     40                                                                                                 
   AGT      A       X       9    GT     369     90                                                                                                 
   ALE      A       Y      10    LE     520    100                                                                                                 
   ALE      A       X      11    LE     528    110                                                                                                 
   AGT      A       W      12    GT     324    120                                                                                                 
   AGT      A       X      18    GT     522    180                                                                                                 
   AGT      A       Y      19    GT     779    190                                                                                                 
   AGT      A       W      20    GT     780    200                                                                                                 
   BLE      B       X       3    LE     102     30                                                                                                 
   BGT      B       Y       5    GT     405     50                                                                                                 
   BGT      B       X       6    GT     150     60                                                                                                 
   BGT      B       X       7    GT     182     70                                                                                                 
   BGT      B       X       8    GT     216     80                                                                                                 
   BGT      B       X      13    GT     364    130                                                                                                 
   BGT      B       W      14    GT     546    140                                                                                                 
   BLE      B       X      15    LE    1440    150                                                                                                 
   BLE      B       Y      16    LE    1328    160                                                                                                 
   BGT      B       X      17    GT     799    170                                                                                                 
                                                                                                                                                   
*            _               _                                                                                                                     
  ___  _   _| |_ _ __  _   _| |_                                                                                                                   
 / _ \| | | | __| '_ \| | | | __|                                                                                                                  
| (_) | |_| | |_| |_) | |_| | |_                                                                                                                   
 \___/ \__,_|\__| .__/ \__,_|\__|                                                                                                                  
                |_|                                                                                                                                
;                                                                                                                                                  
                                                                                                                                                   
This is the same as 'proc tabulate but weights just interest and is a SAS table                                                                    
                                                                                                                                                   
Althoug the names are criptic they are easy to program.                                                                                            
                                                                                                                                                   
WANT total obs=3                                                                                                                                   
                                                                                                                                                   
 TEAM    AGTN*   AGTSL*   AGTWI*   ALEN    ALESL    ALEWI    BGTN    BGTSL    BGTWI    BLEN    BLESL    BLEWI                                      
                                                                                                                                                   
  W        2      320      552       1       10       24       1      140     546.0      .        .         .                                      
  X        3      310      401       1      110      528       5      510     342.2      2      180       771                                      
  Y        1      190      779       2      120      283       1       50     405.0      1      160      1328                                      
                                                                                                                                                   
AGTN    = MODEL=A  LOANLENGTH GT 365  N                                                                                                            
AGTSL   = MODEL=A  LOANLENGTH GT 365  SUM SUMLOAN                                                                                                  
AGTWI   = MODEL=A  LOANLENGTH GT 365  WEIGHTED SUM OF INTEREST                                                                                     
                                                                                                                                                   
*          _       _   _                                                                                                                           
 ___  ___ | |_   _| |_(_) ___  _ __                                                                                                                
/ __|/ _ \| | | | | __| |/ _ \| '_ \                                                                                                               
\__ \ (_) | | |_| | |_| | (_) | | | |                                                                                                              
|___/\___/|_|\__,_|\__|_|\___/|_| |_|                                                                                                              
                                                                                                                                                   
;                                                                                                                                                  
                                                                                                                                                   
* run this to get the bogus _CXX_ names in the output dataset;                                                                                     
                                                                                                                                                   
proc report data=have nowd missing out= want;                                                                                                      
   cols team xcr, (n sl wi);                                                                                                                       
   define team / group;                                                                                                                            
   define sl   / sum  "sl";                                                                                                                        
   define wi   / mean "wi";                                                                                                                        
   define xcr  / across;                                                                                                                           
run;quit;                                                                                                                                          
                                                                                                                                                   
Unfortunaely the output dataset looks like                                                                                                         
                                                                                                                                                   
Up to 40 obs from WANT total obs=3                                                                                                                 
                                                                                                                                                   
 TEAM    _C2_    _C3_    _C4_    _C5_    _C6_    _C7_    _C8_    _C9_    _C10_    _C11_    _C12_    _C13_                                          
                                                                                                                                                   
  W        2      320     552      1       10      24      1      140    546.0      .         .         .                                          
  X        3      310     401      1      110     528      5      510    342.2      2       180       771                                          
  Y        1      190     779      2      120     283      1       50    405.0      1       160      1328                                          
                                                                                                                                                   
                                                                                                                                                   
The reoirt looks like                                                                                                                              
                                                                                                                                                   
                    AGT                              ALE                              BGT                              BLE                         
TEAM          N         SL         WI          N         SL         WI          N         SL         WI          N         SL         WI           
  W           2        320        552          1         10         24          1        140        546          .          .          .           
  X           3        310        401          1        110        528          5        510      342.2          2        180        771           
  Y           1        190        779          2        120        283          1         50        405          1        160       1328           
                                                                                                                                                   
                                                                                                                                                   
We need to rename                                                                                                                                  
                                                                                                                                                   
STEP 1 (should see this in output window after running the report above)                                                                           
========================================================================                                                                           
                                                                                                                                                   
                    AGT                              ALE                              BGT                              BLE                         
TEAM          N         SL         WI          N         SL         WI          N         SL         WI          N         SL         WI           
                                                                                                                                                   
  W           2        320        552          1         10         24          1        140        546          .          .          .           
  X           3        310        401          1        110        528          5        510      342.2          2        180        771           
  Y           1        190        779          2        120        283          1         50        405          1        160       1328           
                                                                                                                                                   
STEP2 Type 'R3' in the prefix area of the AGT line                                                                                                 
==================================================                                                                                                 
                                                                                                                                                   
            AGT                              ALE                              BGT                              BLE                                 
            AGT                              ALE                              BGT                              BLE                                 
            AGT                              ALE                              BGT                              BLE                                 
      n         sl         wi          n         sl         wi          n         sl         wi          n         sl         wi                   
                                                                                                                                                   
Step 3 align ( all you need to do is insert blanks in each line to shift. It aligns autmatically)                                                  
=================================================================================================                                                  
                                                                                                                                                   
   AGT                              ALE                              BGT                              BLE                                          
             AGT                              ALE                              BGT                              BLE                                
                        AGT                              ALE                              BGT                              BLE                     
      N         SL         WI          N         SL         WI          N         SL         WI          N         SL         WI                   
                                                                                                                                                   
Step 4  use 'm' then 'o'(three times) in prefix area to overlay the then highlight and type cuth on the command line                               
=====================================================================================================================                              
                                                                                                                                                   
   AGTN AGTSL AGTWI ALEN ALESL ALEWI BGTN BGTSL BGTWI BLEN BLESL BLEWI                                                                             
                                                                                                                                                   
                                                                                                                                                   
Now lets create the rename statement                                                                                                               
                                                                                                                                                   
%array(old,values=2-13);  /* ( _c2_ - _c13_ */;                                                                                                    
%array(new,values=AGTN AGTSL AGTWI ALEN ALESL ALEWI BGTN BGTSL BGTWI BLEN BLESL BLEWI);                                                            
                                                                                                                                                   
%put &=oldn;                                                                                                                                       
%put &=newn;                                                                                                                                       
                                                                                                                                                   
data; %do_over(old new,phrase=%str(file print; put "_c?old_ = ?new";));run;quit;                                                                   
                                                                                                                                                   
* should see this in output window;                                                                                                                
                                                                                                                                                   
_c2_ = AGTN                                                                                                                                        
_c3_ = AGTSL                                                                                                                                       
_c4_ = AGTWI                                                                                                                                       
_c5_ = ALEN                                                                                                                                        
_c6_ = ALESL                                                                                                                                       
_c7_ = ALEWI                                                                                                                                       
_c8_ = BGTN                                                                                                                                        
_c9_ = BGTSL                                                                                                                                       
_c10_ = BGTWI                                                                                                                                      
_c11_ = BLEN                                                                                                                                       
_c12_ = BLESL                                                                                                                                      
_c13_ = BLEWI                                                                                                                                      
                                                                                                                                                   
* paste in into the report output dataset;                                                                                                         
                                                                                                                                                   
proc report data=have nowd missing out= want (rename=(                                                                                             
     _c2_ = AGTN                                                                                                                                   
     _c3_ = AGTSL                                                                                                                                  
     _c4_ = AGTWI                                                                                                                                  
     _c5_ = ALEN                                                                                                                                   
     _c6_ = ALESL                                                                                                                                  
     _c7_ = ALEWI                                                                                                                                  
     _c8_ = BGTN                                                                                                                                   
     _c9_ = BGTSL                                                                                                                                  
     _c10_ = BGTWI                                                                                                                                 
     _c11_ = BLEN                                                                                                                                  
     _c12_ = BLESL                                                                                                                                 
     _c13_ = BLEWI));                                                                                                                              
cols team xcr, (n sl wi);                                                                                                                          
define team / group;                                                                                                                               
define sl   / sum  "sl";                                                                                                                           
define wi   / mean "wi";                                                                                                                           
define xcr  / across;                                                                                                                              
run;quit;                                                                                                                                          
                                                                                                                                                   
                                                                                                                                                   
                                                                                                                                                   
