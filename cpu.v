module cpu(input wire clk, reset, interrupcion, input wire [7:0] e, e1, e2, e3, output wire [7:0] s, s1, s2, s3);

wire [5:0] opcode;
wire z, s_inc, s_inm, we3, wez, push, pop, s_pop, write_enable, s_load, s_cargaes, s_interrupcion, write_key;
wire [2:0] op_alu;

uc unidad_de_control(opcode, z, interrupcion,clock_out, s_inc, s_inm, we3, wez, push, pop, s_pop,write_enable, s_load, we_es,s_cargaes, s_interrupcion,enable, write_key, op_alu);
cd camino_de_datos(e, e1, e2, e3, clk, reset, s_inc, s_inm, we3, wez, push, pop, s_pop, write_enable, s_load, we_es,s_cargaes, s_interrupcion, enable, write_key, op_alu, z,clock_out,opcode ,s, s1, s2, s3);

endmodule
