module cd(input wire [7:0] e, e1, e2, e3, input wire clk, reset, s_inc, s_inm, we3, wez, push, pop, s_pop, write_enable, s_load, we_es, s_cargaes, s_interrupcion, input wire [2:0] op_alu, output wire z, output wire [5:0] opcode, output wire [7:0] s, s1, s2, s3);
wire[7:0] rd1, rd2, salida_alu, wd3, salida_muxalu, salida_memdata, salida_muxmemdata, salida_mux4a1, sa, sa1 ,sa2 ,sa3;
wire zalu, timer_end;
wire [3:0] salida_deco;
wire [15:0] instruccion;
wire [9:0] dir, salida_muxizq, salida_sum, salida_muxpila, salida_pila, salida_muxinterrupcion;

alu alu_derecha(rd1, rd2, op_alu, salida_alu, zalu); 
ffd ffz(clk, reset, zalu, wez, z); 
regfile banco_registro(clk, we3, instruccion[11:8], instruccion[7:4], instruccion[3:0], wd3, rd1, rd2);
mux2 mux_alu(salida_alu, instruccion[11:4], s_inm, salida_muxalu);
memprog memoria_de_programa(clk, dir, instruccion);
mux2 #(10) mux_izquierda(instruccion[9:0], salida_sum, s_inc, salida_muxizq);
sum sumador(10'b0000000001, dir, salida_sum);
registro #(10) pc(clk, reset, salida_muxinterrupcion, dir);
mux2 #(10) mux_pila(salida_muxizq, salida_pila, s_pop, salida_muxpila);
stack pila(clk, reset, push, pop, dir, salida_pila);
memdata memoriadatos(salida_memdata, instruccion[5:0], salida_alu, write_enable, clk);
mux2 #(8) mux_memdata(salida_muxalu, salida_memdata, s_load, salida_muxmemdata);
dec24 deco24(instruccion[11:10], salida_deco);
registroes registro1(clk, reset, (salida_deco[0] & we_es), rd2, sa);
registroes registro2(clk, reset, (salida_deco[1] & we_es), rd2, sa1);
registroes registro3(clk, reset, (salida_deco[2] & we_es), rd2, sa2);
registroes registro4(clk, reset, (salida_deco[3] & we_es), rd2, sa3);
mux2 #(8) mux_es(salida_muxmemdata, salida_mux4a1, s_cargaes, wd3);
mux41 mux4a1(e, e1, e2, e3, instruccion[11], instruccion[10], salida_mux4a1); 
mux2 #(10) mux_interrupcion(salida_muxpila,10'b1110000100 , s_interrupcion, salida_muxinterrupcion);
timer temporizador(clk ,s3[7:2], s3[1:0], timer_end);

assign opcode = instruccion[15:10];
assign s = sa;
assign s1 = sa1; 
assign s2 = sa2;
assign s3 = sa3;

endmodule
