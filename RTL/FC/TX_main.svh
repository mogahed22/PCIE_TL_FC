module TX_elements_VC0#(
parameter TX_DATA_WIDTH=32;
parameter TX_FIFO_DEPTH=256;
);
(
    input wire clk,            // Clock signal
    input wire rst_n,          // Active-low reset
    input wire wr_en,          // Write enable
    input wire rd_en,          // Read enable
    input wire [DATA_WIDTH-1:0] data_in, // Data input
    output reg [DATA_WIDTH-1:0] data_out, // Data output
    output wire full,          // FIFO full flag
    output wire empty          // FIFO empty flag
    output reg [DATA_WIDTH-1:0] cc;
    output reg [DATA_WIDTH-1:0] p_tlp;
);

    buffer #(.DATA_WIDTH(TX_DATA_WIDTH),.FIFO_DEPTH(TX_FIFO_DEPTH)) Transaction_pending_buffer(clk,rst_n,wr_en,rd_en,data_in,data_out,full,empty,cc,p_tlp);
    
    reg [TX_DATA_WIDTH-1:0] cr;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)begin
            
        end
        else if()begin
            cr<= cc + p_tlp;
        end
    end
    
endmodule