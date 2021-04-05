`timescale 1 ns / 10 ps

module cpu_tb;


reg clk, reset, inter;
wire [7:0] s, s1, s2, s3, e, e1, e2, e3;



// generación de reloj clk
always //siempre activo, no hay condición de activación
begin
  clk = 1'b1;
  #30;
  clk = 1'b0;
  #30;

end


// instanciación del procesador
cpu micpu(clk, reset, inter, e, e1, e2, e3, s, s1, s2, s3);

initial
begin
  $dumpfile("cpu_tb.vcd");
  $dumpvars;
  reset = 1;  //a partir del flanco de subida del reset empieza el funcionamiento normal
  inter = 0;
  #10;
  reset = 0;  //bajamos el reset
  #51;
  inter = 1;
  #60;
  inter = 0;
  
end



initial
begin

  #(30*60);  //Esperamos 30 ciclos o 30 instrucciones
  $finish;
end
  assign e = 00000000;
  assign e1 = 1;
  assign e2 = 00000000;
  assign e3 = 00000000;
 


endmodule