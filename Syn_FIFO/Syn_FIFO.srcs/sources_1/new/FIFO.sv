`timescale 1ns / 1ps
module FIFO(
input logic rst,
input logic clk,
input logic wr_en,
input logic rd_en,
input logic [7:0] din,

output logic empty,
output logic full, 
output logic [7:0] dout
    );
    
//memory
logic [7:0] mem[0:7]; //8 o nho moi o 8 bit: mem[0], mem[1], mem[2] .... mem[7]
 
//pointer: tro vao 8 o thi can 3 bit
logic [2:0] rd_ptr;
logic [2:0] wr_ptr;

//WRITE: If wr_en=1, then save din to mem
always_ff@(posedge clk or posedge rst) begin
if(rst) begin 
wr_ptr <= 0;
end
else begin 
//write: neu en=1, ghi khi not full
if(wr_en && !full) begin // khi full = 0 not full = 1, 1&&1=1
    mem[wr_ptr] <= din;
    wr_ptr <= wr_ptr + 1;
    end
    end 
    end
    
 // READ: khi co lenh read>> dout se read memory   
//READ: rd_en = 1 va empty trong > empty =1
always_ff@(posedge clk or posedge rst)begin
if(rst) begin
rd_ptr <= 0;
end
else begin
if(rd_en && !empty) begin
    dout <= mem[rd_ptr];
    rd_ptr <= rd_ptr + 1;
    end
    end
    end
    
    
 // COUNT
 /*so luong mem chua data co trong FIFO
 luc dau: count = 0
 wr_en = 1
 count = 1
 write tiep count = 2 count = 3
 read => count = 2
    */
 logic [3:0] count;   
 always_ff@(posedge clk or posedge rst) begin
 if(rst) begin count <= 0; end
 // 
 else if(wr_en && !full &&!(rd_en && !empty)) begin //write only 
 count <= count + 1; end
 else if(rd_en && !empty && !(wr_en && !full)) //read only
begin count <= count - 1; end
 else begin count <= count; end
 end
 
always_comb begin
if(count==0)
empty = 1;//trong
else empty = 0;

if(count == 8)
full = 1; else full = 0;
end 
endmodule
