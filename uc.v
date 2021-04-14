module uc(output reg [1:0] s_interrupcion, input wire [5:0] opcode, input wire z, interrupcion, clock_out,output reg s_inc, s_inm, we3, wez, push, pop, s_pop, write_enable, s_load, we_es,s_cargaes, enable,  output reg [2:0] op_alu);

parameter salto_absoluto = 6'b000011;
parameter salto_condicional_z = 6'b000001;
parameter salto_condicional_noz = 6'b000000;
parameter carga_inmediata = 6'b1010??;
parameter suma = 6'b0001??;
parameter resta = 6'b0010??;
parameter salto_sub = 6'b111100;
parameter retorno_sub = 6'b111101;
parameter guardar_memoria = 6'b0011??;
parameter cargar_memoria = 6'b0100??;
parameter entrada_es = 6'b0101??;
parameter salida_es = 6'b0110??;
parameter clk_conf = 6'b111110; // dejamos dos bits e usamos 8, 2 para base, 6 para umbral
parameter inversion = 6'b0111??;
parameter AND = 6'b1000??;
parameter OR = 6'b1001??;
parameter negar1 = 6'b1011??;
parameter negar2 = 6'b1100??;



always @(*) begin
    if (interrupcion) begin
                            s_inc = 1'b0;
                            s_inm = 1'b0;
                            we3 = 1'b0;
                            wez = 1'b0;
                            op_alu = 3'b000;
                            push = 1'b1;
                            pop = 1'b0;
                            s_pop = 1'b0;
                            write_enable = 1'b0;
                            s_load = 1'b0;
                            we_es = 1'b0;
                            s_cargaes = 1'b0; 
                            s_interrupcion =2'b01;
                            enable = 1'b0;
                            
    end else if (clock_out)begin
                            s_inc = 1'b0;
                            s_inm = 1'b0;
                            we3 = 1'b0;
                            wez = 1'b0;
                            op_alu = 3'b000;
                            push = 1'b1;
                            pop = 1'b0;
                            s_pop = 1'b0;
                            write_enable = 1'b0;
                            s_load = 1'b0;
                            we_es = 1'b0;
                            s_cargaes = 1'b0; 
                            s_interrupcion =2'b10;
                            enable = 1'b0;
    end else begin
                            
    casez (opcode)
        salto_sub:begin
                            s_inc = 1'b0;
                            s_inm = 1'b0;
                            we3 = 1'b0;
                            wez = 1'b0;
                            op_alu = 3'b000;
                            push = 1'b1;
                            pop = 1'b0;
                            s_pop = 1'b0;
                            write_enable = 1'b0;
                            s_load = 1'b0;
                            we_es = 1'b0;
                            s_cargaes = 1'b0;
                            s_interrupcion =2'b00;
                            enable = 1'b0;
                            
                        end
        retorno_sub:begin
                            s_inc = 1'b0;
                            s_inm = 1'b0;
                            we3 = 1'b0;
                            wez = 1'b0;
                            op_alu = 3'b000;
                            push = 1'b0;
                            pop = 1'b1;
                            s_pop = 1'b1;
                            write_enable = 1'b0;
                            s_load = 1'b0;
                            we_es = 1'b0;
                            s_cargaes = 1'b0;
                            s_interrupcion =2'b00;
                            enable = 1'b0;
                            
                        end
        salto_absoluto:begin
                            s_inc = 1'b0;
                            s_inm = 1'b0;
                            we3 = 1'b0;
                            wez = 1'b0;
                            op_alu = 3'b000;
                            push = 1'b0;
                            pop = 1'b0;
                            s_pop = 1'b0;
                            write_enable = 1'b0;
                            s_load = 1'b0;
                            we_es = 1'b0;
                            s_cargaes = 1'b0;
                            s_interrupcion =2'b00;
                            enable = 1'b0;
                            
                        end
        salto_condicional_z:begin
            if(z == 0) begin
                s_inc = 1'b0;
                s_inm = 1'b0;
                we3 = 1'b0;
                wez = 1'b1;
                op_alu = 3'b000;
                push = 1'b0;
                pop = 1'b0;
                s_pop = 1'b0;
                write_enable = 1'b0;
                s_load = 1'b0; 
                we_es = 1'b0;
                s_cargaes = 1'b0;
                s_interrupcion =2'b00;
                enable = 1'b0;
                
            end else begin
                s_inc = 1'b1;
                s_inm = 1'b0;
                we3 = 1'b0;
                wez = 1'b1;
                op_alu = 3'b000;
                push = 1'b0;
                pop = 1'b0;
                s_pop = 1'b0;
                write_enable = 1'b0;
                s_load = 1'b0;
                we_es = 1'b0;
                s_cargaes = 1'b0;
                s_interrupcion =2'b00;
                enable = 1'b0;
                
            end
            
        end
        salto_condicional_noz:begin
            if(z == 0) begin
                s_inc = 1'b1;
                s_inm = 1'b0;
                we3 = 1'b0;
                wez = 1'b1;
                op_alu = 3'b000;
                push = 1'b0;
                pop = 1'b0;
                s_pop = 1'b0;
                write_enable = 1'b0;
                s_load = 1'b0;
                we_es = 1'b0;
                s_cargaes = 1'b0;
                s_interrupcion =2'b00;
                enable = 1'b0;
                
            end else begin
                s_inc = 1'b0;
                s_inm = 1'b0;
                we3 = 1'b0;
                wez = 1'b1;
                op_alu = 3'b000;
                push = 1'b0;
                pop = 1'b0;
                s_pop = 1'b0;
                write_enable = 1'b0;
                s_load = 1'b0;
                we_es = 1'b0;
                s_cargaes = 1'b0;
                s_interrupcion =2'b00;
                enable = 1'b0;
                
            end
            
        end
        carga_inmediata: begin
            s_inc = 1'b1;
            s_inm = 1'b1;
            we3 = 1'b1;
            wez = 1'b0;
            op_alu = 3'b000;
            push = 1'b0;
            pop = 1'b0;
            s_pop = 1'b0;
            write_enable = 1'b0;
            s_load = 1'b0;
            we_es = 1'b0;
            s_cargaes = 1'b0; 
            s_interrupcion =2'b00;
            enable = 1'b0;
            
        end

        suma: begin
            s_inc = 1'b1;
            s_inm = 1'b0;
            we3 = 1'b1;
            wez = 1'b1;
            op_alu = 3'b010;
            push = 1'b0;
            pop = 1'b0;
            s_pop = 1'b0;
            write_enable = 1'b0;
            s_load = 1'b0;
            we_es = 1'b0;
            s_cargaes = 1'b0;
            s_interrupcion =2'b00;
            enable = 1'b0;
            
        end
        resta: begin
            s_inc = 1'b1;
            s_inm = 1'b0;
            we3 = 1'b1;
            wez = 1'b1;
            op_alu = 3'b011;
            push = 1'b0;
            pop = 1'b0;
            s_pop = 1'b0;
            write_enable = 1'b0;
            s_load = 1'b0;
            we_es = 1'b0;
            s_cargaes = 1'b0;
            s_interrupcion =2'b00;
            enable = 1'b0;
            
        end
        guardar_memoria: begin
            s_inc = 1'b1;
            s_inm = 1'b0;
            we3 = 1'b0;
            wez = 1'b0;
            op_alu = 3'b000;
            push = 1'b0;
            pop = 1'b0;
            s_pop = 1'b0;
            write_enable = 1'b1;
            s_load = 1'b0;
            we_es = 1'b0;
            s_cargaes = 1'b0;
            s_interrupcion =2'b00;
            enable = 1'b0;
            
            
        end
        cargar_memoria: begin
            s_inc = 1'b1;
            s_inm = 1'b0;
            we3 = 1'b1;
            wez = 1'b0;
            op_alu = 3'b000;
            push = 1'b0;
            pop = 1'b0;
            s_pop = 1'b0;
            write_enable = 1'b0;
            s_load = 1'b1;
            we_es = 1'b0;
            s_cargaes = 1'b0;
            s_interrupcion =2'b00;
            enable = 1'b0;
            
            
        end
        entrada_es: begin
            s_inc = 1'b1;
            s_inm = 1'b0;
            we3 = 1'b1;
            wez = 1'b0;
            op_alu = 3'b000;
            push = 1'b0;
            pop = 1'b0;
            s_pop = 1'b0;
            write_enable = 1'b0;
            s_load = 1'b0;
            we_es = 1'b0;
            s_cargaes = 1'b1;
            s_interrupcion =2'b00;
            enable = 1'b0;
            
            
        end
        salida_es: begin
            s_inc = 1'b1;
            s_inm = 1'b0;
            we3 = 1'b0;
            wez = 1'b0;
            op_alu = 3'b000;
            push = 1'b0;
            pop = 1'b0;
            s_pop = 1'b0;
            write_enable = 1'b0;
            s_load = 1'b0;
            we_es = 1'b1;
            s_cargaes = 1'b0;
            s_interrupcion =2'b00;
            enable = 1'b0;
            
            
        end
        clk_conf:begin
                            s_inc = 1'b1;
                            s_inm = 1'b0;
                            we3 = 1'b0;
                            wez = 1'b0;
                            op_alu = 3'b000;
                            push = 1'b0;
                            pop = 1'b0;
                            s_pop = 1'b0;
                            write_enable = 1'b0;
                            s_load = 1'b0;
                            we_es = 1'b0;
                            s_cargaes = 1'b0;
                            s_interrupcion =2'b00;
                            enable = 1'b1;
                            
                        end

        inversion: begin
            s_inc = 1'b1;
            s_inm = 1'b0;
            we3 = 1'b1;
            wez = 1'b1;
            op_alu = 3'b001;
            push = 1'b0;
            pop = 1'b0;
            s_pop = 1'b0;
            write_enable = 1'b0;
            s_load = 1'b0;
            we_es = 1'b0;
            s_cargaes = 1'b0;
            s_interrupcion =2'b00;
            enable = 1'b0;
        end
        
        AND: begin
            s_inc = 1'b1;
            s_inm = 1'b0;
            we3 = 1'b1;
            wez = 1'b1;
            op_alu = 3'b100;
            push = 1'b0;
            pop = 1'b0;
            s_pop = 1'b0;
            write_enable = 1'b0;
            s_load = 1'b0;
            we_es = 1'b0;
            s_cargaes = 1'b0;
            s_interrupcion =2'b00;
            enable = 1'b0;
            
        end
        OR: begin
            s_inc = 1'b1;
            s_inm = 1'b0;
            we3 = 1'b1;
            wez = 1'b1;
            op_alu = 3'b101;
            push = 1'b0;
            pop = 1'b0;
            s_pop = 1'b0;
            write_enable = 1'b0;
            s_load = 1'b0;
            we_es = 1'b0;
            s_cargaes = 1'b0;
            s_interrupcion =2'b00;
            enable = 1'b0;
            
        end
        negar1: begin
            s_inc = 1'b1;
            s_inm = 1'b0;
            we3 = 1'b1;
            wez = 1'b1;
            op_alu = 3'b110;
            push = 1'b0;
            pop = 1'b0;
            s_pop = 1'b0;
            write_enable = 1'b0;
            s_load = 1'b0;
            we_es = 1'b0;
            s_cargaes = 1'b0;
            s_interrupcion =2'b00;
            enable = 1'b0;
        end
        
          negar2: begin
            s_inc = 1'b1;
            s_inm = 1'b0;
            we3 = 1'b1;
            wez = 1'b1;
            op_alu = 3'b111;
            push = 1'b0;
            pop = 1'b0;
            s_pop = 1'b0;
            write_enable = 1'b0;
            s_load = 1'b0;
            we_es = 1'b0;
            s_cargaes = 1'b0;
            s_interrupcion =2'b00;
            enable = 1'b0;
            
        
          end
        default: begin
            s_inc = 1'b0;
            s_inm = 1'b0;
            we3 = 1'b0;
            wez = 1'b0;
            op_alu = 3'b000;
            push = 1'b0;
            pop = 1'b0;
            s_pop = 1'b0;
            write_enable = 1'b0;
            s_load = 1'b0;
            we_es = 1'b0;
            s_cargaes = 1'b0; 
            s_interrupcion =2'b00;
            enable = 1'b0;
            
        end
    endcase
    end
end

endmodule
//añadir las operaciones alu
//interrupciones añadir un par mux4a1
//cambiar a direccionamiento indirecto por registro store load