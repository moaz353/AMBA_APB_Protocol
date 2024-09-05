module AMBA_APB ( pclk , prst_n , pADDr , psel , penable , pWRITE ,
                pWDATA , pSTRB , pREADY , pRDATA );

parameter ADDr_WIDTH  = 8 ;
parameter Data_WIDTH  = 32 ; 
parameter pSTRB_WIDTH = ( Data_WIDTH / 8 ) ; // width = 4  ;
parameter mem_length  = 256 ;  

// fsm 
parameter IDEAL  = 2'b00  ; 
parameter SETUP  = 2'b01  ; 
parameter ACCESS = 2'b10  ; 

//inputs
input  pclk , prst_n ; 
input  psel , penable , pWRITE  ;
input  [ ADDr_WIDTH-1 : 0 ] pADDr  ; 
input  [ Data_WIDTH-1 : 0 ] pWDATA ; 
input  [ pSTRB_WIDTH-1 : 0 ] pSTRB ; 

// outputs 
output reg pREADY  ;  
output  [ Data_WIDTH-1 : 0 ] pRDATA ; 

// fsm 
reg [1:0] cs , ns ; 

// memory
RAM #(.ADDr_WIDTH(ADDr_WIDTH),.mem_WIDTH(Data_WIDTH),.mem_length(mem_length))
    BLK ( .clk(pclk) , .rst_n(prst_n) , .ADDr(pADDr) , .enable(penable) , .wr_rd(pWRITE) ,
                .wr_DATA(pWDATA)  , .rd_DATA(pRDATA) , .pSTRB(pSTRB) );

// state_memory 
always @(posedge pclk) begin
    if(~prst_n) 
        cs <= IDEAL ; 
    else 
        cs <= ns ; 
end

// state transitions
always @(*) begin

    if (~prst_n) 
        ns = IDEAL ; 

    else begin 
    
        case(cs) 
            
            // ideal 
            IDEAL : begin      
                if (psel) 
                    ns = SETUP ;   // to setup state 
                else 
                    ns = IDEAL ; 
            end
            
            // setup 
            SETUP : begin
                if( psel && penable  )
                    ns = ACCESS ; // to access state 
                else if (~psel) 
                    ns = IDEAL ; // to ideal state 
                else 
                    ns = SETUP ; 
            end
            
            // access 
            ACCESS : begin
                if(~psel) 
                    ns = IDEAL ; // to ideal 
                else if (psel && ~penable) 
                    ns = SETUP ; 
                else 
                    ns = ACCESS ; 
            end
            default : ns = IDEAL ; 
        endcase
    end

end

// output block 
always @(cs) begin

    if (~prst_n) begin 
        pREADY  = 0 ; 
    end 
    else begin 
        case (cs)
            IDEAL : begin 
                pREADY  = 0 ; 
            end 
            SETUP : begin 
                pREADY  = 0 ;  
            end
            ACCESS : begin 
                pREADY     = 1 ; 
            end
            default : begin 
                pREADY     = 0 ;
            end
        endcase
    end
end

endmodule 
