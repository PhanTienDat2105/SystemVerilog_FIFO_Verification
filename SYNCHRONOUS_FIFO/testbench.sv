`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/14/2026 12:51:49 PM
// Design Name: 
// Module Name: testbench
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tb_FIFO;
logic rst;
logic clk;
logic wr_en;
logic rd_en;
logic [7:0] din;
logic [7:0] dout;
logic full;
logic empty;
logic [7:0] expected;
FIFO dut(.rst(rst), .clk(clk), .wr_en(wr_en),.rd_en(rd_en), .din(din),.dout(dout),.full(full),.empty(empty));
always #5 clk = ~clk;
byte q[$];

task write_fifo(logic [7:0] data);
begin
@(posedge clk);
wr_en = 1;
din = data;
@(posedge clk);
q.push_back(data);
wr_en = 0;
end
endtask

task read_fifo();
begin
@(posedge clk);
rd_en = 1;
@(posedge clk);
expected = q.pop_front();
assert(dout == expected)
$display("PASS dout=%h expected=%h",dout, expected);
else 
$error("FAIL dout=%h expected=%h",dout, expected);
rd_en=0;
end
endtask

initial begin
 clk   = 0;   rst   = 1; wr_en = 0;
 rd_en = 0;
 din   = 0;
 #10;
 rst = 0;
 write_fifo(8'b0000_1111);
 write_fifo(8'b1010_1111);
 write_fifo(8'b0000_1100);
 
 read_fifo();
 read_fifo();
 read_fifo();
 #20;
 $finish;
 end
 
 initial begin
 $monitor("time = %0t wr_en = %b rd_en = %b din=%b dout = %b full=%b empty = %b", $time, wr_en, rd_en, din,dout,full,empty);
 end


endmodule
