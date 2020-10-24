`timescale 1ns / 1ps

module joydecoder (
  input wire clk,
  input wire joy_data,
  output wire joy_clk,
  output wire joy_load_n,
  output wire joy1up,
  output wire joy1down,
  output wire joy1left,
  output wire joy1right,
  output wire joy1fire1,
  output wire joy1fire2,
  output wire joy2up,
  output wire joy2down,
  output wire joy2left,
  output wire joy2right,
  output wire joy2fire1,
  output wire joy2fire2
  );

  reg hsync_s;
  reg [7:0] clkdivider = 8'h00;
  assign joy_clk = clkdivider[1];
  always @(posedge clk) begin
    clkdivider <= clkdivider + 8'd1;
  end

  reg [15:0] joyswitches = 16'hFFFF;
  assign joy1up    = joyswitches[7];
  assign joy1down  = joyswitches[6];
  assign joy1left  = joyswitches[5];
  assign joy1right = joyswitches[4];
  assign joy1fire1 = joyswitches[3];
  assign joy1fire2 = joyswitches[2];
  assign joy2up    = joyswitches[15];
  assign joy2down  = joyswitches[14];
  assign joy2left  = joyswitches[13];
  assign joy2right = joyswitches[12];
  assign joy2fire1 = joyswitches[11];
  assign joy2fire2 = joyswitches[10];

  reg [3:0] state = 4'd0;
  assign joy_load_n = ~(state == 4'd0);

  always @(negedge joy_clk) begin
    state <= state + 4'd1;
    case (state)
      4'd0:  joyswitches[0]  <= joy_data;
      4'd1:  joyswitches[1]  <= joy_data;
      4'd2:  joyswitches[2]  <= joy_data;
      4'd3:  joyswitches[3]  <= joy_data;
      4'd4:  joyswitches[4]  <= joy_data;
      4'd5:  joyswitches[5]  <= joy_data;
      4'd6:  joyswitches[6]  <= joy_data;
      4'd7:  joyswitches[7]  <= joy_data;
      4'd8:  joyswitches[8]  <= joy_data;
      4'd9:  joyswitches[9]  <= joy_data;
      4'd10: joyswitches[10] <= joy_data;
      4'd11: joyswitches[11] <= joy_data;
      4'd12: joyswitches[12] <= joy_data;
      4'd13: joyswitches[13] <= joy_data;
      4'd14: joyswitches[14] <= joy_data;
      4'd15: joyswitches[15] <= joy_data;
    endcase
  end
endmodule