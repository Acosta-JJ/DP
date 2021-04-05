module timer(input wire clk, input wire [5:0] umbral, input wire [1:0] basetiempo, output wire timer_end);
    input wire senal;
    n_clk ondasw(clk, basetiempo, senal);
    counter conotador(senal, umbral, timer_end);
endmodule
//Debido a decisiones de diseño para configurar el timer habrá que hacer una operación de salida al registro 4;
// Cuyos 6 bits más significativos son el umbral y los 2 bits menos significativos la base de tiempo 