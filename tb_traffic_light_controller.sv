module tb_traffic_light_controller;

    logic clk, rst, config_mode, maint_mode;
    logic [1:0] switches;
    logic [7:0] red_time, yellow_time, green_time;
    logic red_light, yellow_light, green_light;

    traffic_light_controller dut (
        .clk(clk),
        .rst(rst),
        .config_mode(config_mode),
        .maint_mode(maint_mode),
        .switches(switches),
        .red_time(red_time),
        .yellow_time(yellow_time),
        .green_time(green_time),
        .red_light(red_light),
        .yellow_light(yellow_light),
        .green_light(green_light)
    );

    // Clock generation
    always #5 clk = ~clk;

    initial begin
        // Initialize inputs
        clk = 0; rst = 1; config_mode = 0; maint_mode = 0;
        switches = 2'b00;
        red_time = 8'd5; yellow_time = 8'd2; green_time = 8'd3;

        // Reset the design
        #10 rst = 0;

        // Normal operation
        #100;
        // Enter maintenance mode
        maint_mode = 1;
        switches = 2'b01; // Yellow light on
        #50 switches = 2'b10; // Green light on
        #50 switches = 2'b00; // All off
        #50 maint_mode = 0;

        // Reconfigure durations
        red_time = 8'd10; yellow_time = 8'd3; green_time = 8'd7;
        #200;
        $stop;
    end
endmodule