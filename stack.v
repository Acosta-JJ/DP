module stack(input wire clk, reset, push, pop, input wire[9:0] inpush, output reg[9:0] outpop);
reg [9:0] pila[0:15]; //Pila de 10 bits (0-1023) con 16 posiciones
reg [3:0] sp;

initial
  begin
    sp = 4'b0000;
  end

always @ (push, pop, reset) begin
	  if(reset) begin
		    sp = 0;
      end

      if (push) begin
        sp = sp + 4'b0001;
        pila[sp] = inpush;
      end
	  
	  if (pop) begin
        outpop = pila[sp] + 10'b0000000001;
		    sp = sp - 4'b0001;
        
      end
end


endmodule