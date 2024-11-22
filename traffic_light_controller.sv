module traffic_light_controller (
    input clk,
    input rst,
    input config_mode,        // Configuration mode
    input maint_mode,         // Maintenance mode
    input [1:0] switches,     // Control colors in maintenance mode
    input [7:0] red_time,     // Configurable red duration
    input [7:0] yellow_time,  // Configurable yellow duration
    input [7:0] green_time,   // Configurable green duration
    output reg red_light,         // Red light signal
    output reg yellow_light,      // Yellow light signal
    output reg green_light        // Green light signal
);

    // State declaration
    localparam RED = 2'b00, YELLOW = 2'b01, GREEN = 2'b10;
    reg [1:0] current_state, next_state;
    reg [7:0] timer;

    // Sequential block
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            current_state <= RED;
            timer <= 8'd0;
        end else begin
            if (!maint_mode) begin
                current_state <= next_state;
                timer <= (timer == 8'd0) ? (
                            (current_state == RED) ? red_time :
                            (current_state == YELLOW) ? yellow_time :
                            green_time
                         ) : timer - 1;
            end
        end
    end

    // Combinational block
    always @* begin
        if (maint_mode) begin
            // Maintenance mode
            red_light = switches[0];
            yellow_light = switches[1];
            green_light = !switches[0] && !switches[1];
            next_state = current_state; // Hold state
        end else begin
            // Normal operation
            red_light = (current_state == RED);
            yellow_light = (current_state == YELLOW);
            green_light = (current_state == GREEN);

            case (current_state)
                RED: next_state = (timer == 8'd0) ? GREEN : RED;
                GREEN: next_state = (timer == 8'd0) ? YELLOW : GREEN;
                YELLOW: next_state = (timer == 8'd0) ? RED : YELLOW;
                default: next_state = RED;
            endcase
        end
    end
endmodule