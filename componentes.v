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

module timerd(input clk, reset,  enable, input wire [1:0] base, input wire [5:0] umbral, output reg clock_out);
  parameter mili = 2'b00;
  parameter deci = 2'b01;
  parameter sec = 2'b10;
  parameter min = 2'b11;
	reg [7:0] base_th;
	always @(enable) 
		if (enable)  base_th <= {base,umbral};
	reg[27:0] counter = 28'd0;
	reg[27:0] divisor;
	always @(base_th[7:6])
	begin
		case (base_th[7:6])
			2'b00: 
				begin
					divisor = 20;
				end
			2'b01: 
        begin
					divisor = 2000;
        end
			2'b10:
        begin
					divisor = 20000;
        end
			2'b11: 
        begin
					divisor = 1200000;
        end
		default:
			begin
	
			end
		endcase
	end

	reg [5:0] temp = 6'b000000;
	always @(posedge clk)
	begin
		if (counter % divisor == 0) 
			begin
				temp = temp + 6'b000001;
				clock_out = 1'b1;
			end
		else
			begin
				clock_out = 1'b0;
				temp = temp;
			end
		if (temp == base_th[5:0]) 
			begin
				temp = 6'b000000;
			end
		else
			begin
				clock_out = 1'b0;
			end

		counter <= counter + 28'd1;
	end
endmodule

module keylogger(
    output wire [7:0] salida,
    input [7:0] entrada, 
    input write_enable,
    input clk
);
    reg [7:0] keylogger [0:255];
    reg [7:0] direccion = 8'b00000000;
    always @(*) begin
        if (write_enable && direccion <= 8'b11111111) begin
            keylogger[direccion] <= entrada;
            direccion = direccion + 8'b00000001;
        end else begin
            keylogger[direccion] <= entrada;
            direccion = 8'b00000000;
        end
    end

assign salida = keylogger[direccion];

endmodule