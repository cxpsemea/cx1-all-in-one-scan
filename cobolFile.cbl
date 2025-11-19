1      IDENTIFICATION DIVISION.                                               
2      PROGRAM-ID. TEST8.                                                     
3      DATA DIVISION.                                                         
4      WORKING-STORAGE SECTION.                                               
5       01 USER-INPUT     PIC X(50).                                          
6       01 CMD-STRING     PIC X(200).                                         
7       01 CMD-LEN        PIC S9(9)V9(4) COMP-3.                              
8                                                                             
9      PROCEDURE DIVISION.                                                    
10         DISPLAY 'Enter command:'                                           
11         ACCEPT USER-INPUT                                                  
12         MOVE USER-INPUT TO CMD-STRING                                      
13         MOVE FUNCTION LENGTH(CMD-STRING) TO CMD-LEN                        
14         CALL "QCMDEXC" USING CMD-STRING CMD-LEN                            
14         CALL "SYSTEM" USING CMD-STRING CMD-LEN                            
15         STOP RUN.                                                          
