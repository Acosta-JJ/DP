`timescale 1 us / 10 ps

module cpu_tb;


reg clk, reset, inter;
wire [7:0] s, s1, s2, s3, e, e1, e2, e3;



// generación de reloj clk
always //siempre activo, no hay condición de activación
begin
  //50MHz
  clk = 1'b1;
  #25;
  clk = 1'b0;
  #25;

end


// instanciación del procesador
cpu micpu(clk, reset, inter, e, e1, e2, e3, s, s1, s2, s3);

initial
begin
  $dumpfile("cpu_tb.vcd");
  $dumpvars;
  reset = 1;  //a partir del flanco de subida del reset empieza el funcionamiento normal
  #10;
  reset = 0;  //bajamos el reset

  
end



initial
begin

  #(50000*50);  
  $finish;
end
  assign e = 00000000;
  assign e1 = 1;
  assign e2 = 00000000;
  assign e3 = 00000000;
 


endmodule