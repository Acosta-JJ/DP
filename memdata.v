module memdata(
    output wire [7:0] salida,
    input [7:0] direccion,
    input [7:0] entrada, 
    input write_enable,
    input clk
);
    reg [7:0] memoria [0:255];

    always @(*) begin
        if (write_enable) begin
            memoria[direccion] <= entrada;
        end
    end

assign salida = memoria[direccion];

endmodule