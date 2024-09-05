module AMBA_APB_tb ; 


//inputs
reg  pclk , prst_n ; 
reg  psel , penable , pWRITE  ;
reg  [ 7 : 0 ] pADDr  ; 
reg  [ 31: 0 ] pWDATA ; 
reg  [ 3 : 0 ] pSTRB ; 

// outputs 
wire pREADY  ; 
wire [ 31 : 0 ] pRDATA ;

AMBA_APB  DUT ( .pclk(pclk) , .prst_n(prst_n) , .pADDr(pADDr) , .psel(psel) , .penable(penable) , .pWRITE(pWRITE) ,
                .pWDATA(pWDATA) , .pSTRB(pSTRB) , .pREADY(pREADY) , .pRDATA(pRDATA) ); 
            

initial begin
    pclk = 0 ; 
    forever #2 pclk = ~pclk ; 
end

initial begin 
    $readmemb("mem.dat",DUT.BLK.mem) ;
    prst_n  = 0 ; 
    psel    = 0 ; 
    penable = 0 ; 
    pADDr   = 0 ; 
    pWDATA  = 0 ; 
    pSTRB   = 0 ; 

    @(negedge pclk) ; 

    prst_n = 1 ; 

    pADDr  = 250 ; 
    pSTRB  = 4'b0001 ; 
    psel   = 1  ; 
    pWRITE = 1  ;    // write op ;   
    @(negedge pclk ) ; 

    penable = 1 ; 
    pWDATA  = 239  ; //= 8'h000000EF ;
    @(negedge pclk) ; 



    penable = 0 ;
    pSTRB   = 4'b0010 ; 
    @(negedge pclk) ;  

    penable = 1 ; 
    pWDATA  =48640 ; // = 8'h0000BE00 ; 
    @(negedge pclk) ; 

    
    penable = 0 ;
    pSTRB   = 4'b1100 ; 
    @(negedge pclk) ; 

    penable = 1 ; 
    pWDATA  =215941120 ; //  = 8'hACDF0000 ; 
    @(negedge pclk) ; 


    penable = 0 ;
    psel    = 0 ;
    @(negedge pclk) ; 

    

    psel  = 1 ; 
    pADDr = 250 ;
    pWDATA = 0 ; 
    pWRITE = 0 ; 
    pSTRB  = 0 ; 
    @(negedge pclk) ; 


    penable = 1 ; 
    @(negedge pclk) ; 
    repeat(5) begin 
        @(negedge pclk ) ; 
    end 
    
$stop ; 
end
endmodule 


