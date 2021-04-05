//Componentes varios

//Banco de registros de dos salidas y una entrada
module regfile(input  wire        clk, 
               input  wire        we3,           //se�al de habilitaci�n de escritura
               input  wire [3:0]  ra1, ra2, wa3, //direcciones de regs leidos y reg a escribir
               input  wire [7:0]  wd3, 			 //dato a escribir
               output wire [7:0]  rd1, rd2);     //datos leidos

  reg [7:0] regb[0:15]; //memoria de 16 registros de 8 bits de ancho

  initial
  begin
    $readmemb("regfile.dat",regb); // inicializa los registros a valores conocidos
  end  
  
  // El registro 0 siempre es cero
  // se leen dos reg combinacionalmente
  // y la escritura del tercero ocurre en flanco de subida del reloj
  
  always @(posedge clk)
    if (we3) regb[wa3] <= wd3;	
  
  assign rd1 = (ra1 != 0) ? regb[ra1] : 0;
  assign rd2 = (ra2 != 0) ? regb[ra2] : 0;

endmodule

//modulo sumador  
module sum(input  wire [9:0] a, b,
             output wire [9:0] y);

  assign y = a + b;

endmodule

//modulo registro para modelar el PC, cambia en cada flanco de subida de reloj o de reset
module registro #(parameter WIDTH = 8)
              (input wire             clk, reset,
               input wire [WIDTH-1:0] d, 
               output reg [WIDTH-1:0] q);

  always @(posedge clk, posedge reset)
    if (reset) q <= 0;
    else       q <= d;

endmodule

//modulo multiplexor, si s=1 sale d1, s=0 sale d0
module mux2 #(parameter WIDTH = 8)
             (input  wire [WIDTH-1:0] d0, d1, 
              input  wire             s, 
              output wire [WIDTH-1:0] y);

  assign y = s ? d1 : d0; 

endmodule

//Biestable para el flag de cero
//Biestable tipo D s�ncrono con reset as�ncrono por flanco y entrada de habilitaci�n de carga
module ffd(input wire clk, reset, d, carga, output reg q);

  always @(posedge clk, posedge reset)
    if (reset)
	    q <= 1'b0;
	  else
	    if (carga)
	      q <= d;

endmodule 

module dec24(input wire [1:0] entrada, output wire [3:0] salida);

assign salida[0] = ~entrada[1] & ~entrada[0];
assign salida[1] = ~entrada[1] & entrada[0];
assign salida[2] = entrada[1] & ~entrada[0];
assign salida[3] = entrada[1] & entrada[0];

endmodule

module registroes
              (input wire             clk, reset, we,
               input wire [7:0] d, 
               output reg [7:0] q);

  always @(*) begin
    if (reset) q <= 8'b00000000;
    else  if(we) 
    q = d;
    

  end
endmodule

module mux41 ( input wire [7:0] a, b, c, d, 
  input wire s1, s0,
  output wire [7:0] out); 
  assign out = s1 ? (s0 ? d : c) : (s0 ? b : a); 

endmodule

//Timer
module contador(input  wire clk,reset,
             output wire interrupcion);
reg salida;
reg [6:0] temp = 0;            
always @(posedge clk,posedge reset) begin
	if(reset) begin
		temp = 0;
	  end	  
	temp = temp + 1;
	if (temp === 6'b110010) begin
		salida = 1'b1;
	end
end  
assign interrupcion = salida;
endmodule