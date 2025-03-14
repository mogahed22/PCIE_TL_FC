module transaction_pending_buffer#(
    parameter DATA_WIDTH = 8,  // Width of each data word //size of credit
    parameter FIFO_DEPTH = 16  // Depth of the FIFO (number of entries) //number of credits
)(
    input wire clk,            // Clock signal
    input wire rst_n,          // Active-low reset
    input wire wr_en,          // Write enable
    input wire rd_en,          // Read enable
    input wire [DATA_WIDTH-1:0] data_in, // Data input
    output reg [DATA_WIDTH-1:0] data_out, // Data output
    output wire full,          // FIFO full flag
    output wire empty          // FIFO empty flag
    output reg [DATA_WIDTH-1:0] credit_consumed;
    output reg [DATA_WIDTH-1:0] ptlp;
);

reg [DATA_WIDTH-1:0] mem [FIFO_DEPTH-1:0];
reg [$clog2(FIFO_DEPTH)-1:0]wr_ptr;
reg [$clog2(FIFO_DEPTH)-1:0]rd_ptr;

reg [DATA_WIDTH-1:0] ptlp;

assign full = (ptlp==FIFO_DEPTH);
assign empty = (ptlp ==0);

always @(posedge clk or negedge rst_n) begin
   if (!rst_n)begin
    ptlp<=0;
    wr_ptr<=0;
   end 
   else if (!full && wr_en ) begin
    mem[wr_ptr]<=data_in;
    wr_ptr<=wr_ptr+1;
    ptlp<=ptlp+1;
   end
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n)begin
        ptlp<=0;
        rd_ptr<=0;
    end
    else if(!empty && rd_en)begin
        data_out<=mem[rd_ptr];
        rd_ptr<=rd_ptr+1;
        ptlp<=ptlp-1;
        credit_consumed<=credit_consumed+1;
    end
end

endmodule