module RAM ( clk , rst_n , ADDr , enable , wr_rd ,
                wr_DATA  , rd_DATA ,pSTRB );

parameter ADDr_WIDTH  = 8   ;
parameter mem_WIDTH  = 32  ; 
parameter mem_length  = 256 ; 
parameter pSTRB_WIDTH = ( mem_WIDTH / 8 ) ; // width = 4  ;

input  clk , rst_n ; 
input  enable , wr_rd  ;


input  [ ADDr_WIDTH-1 : 0 ] ADDr  ; 
input  [ mem_WIDTH-1 : 0 ] wr_DATA ;
input  [ pSTRB_WIDTH-1 : 0 ] pSTRB ; 


output reg [ mem_WIDTH-1 : 0 ] rd_DATA ; 

reg [ mem_WIDTH-1 : 0 ] mem [ mem_length-1 : 0 ] ; 

always @(posedge clk) begin
    if(~rst_n)
        rd_DATA <= 0 ; 
    else begin 
        if(~enable)
            rd_DATA <= 0 ; 
        else begin 
            if(wr_rd) begin
                        if(pSTRB[0])   mem[ADDr] [7  : 0 ] <= wr_DATA[ 7  : 0  ] ; 
                        if(pSTRB[1])   mem[ADDr] [15 : 8 ] <= wr_DATA[ 15 : 8  ] ; 
                        if(pSTRB[2])   mem[ADDr] [23 : 16] <= wr_DATA[ 23 : 16 ] ; 
                        if(pSTRB[3])   mem[ADDr] [31 : 24] <= wr_DATA[ 31 : 24 ] ; 
            end
            else 
                rd_DATA <= mem[ADDr] ; 
        end
    end
end
    
endmodule