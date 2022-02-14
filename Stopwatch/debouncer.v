module debouncing(
    input   clk,
    input   i_button,
    output  o_button
);	// debouncing
    parameter	LIMIT = 1_000_000;		
    reg		prev_state = 1'b0;
    reg [20:0]	cnt = 0;		

    always @(posedge clk) begin
        if ( (i_button != prev_state) && (cnt < LIMIT) )
            cnt <= cnt + 1;

        else if (cnt == LIMIT) begin
            cnt <= 0;
            prev_state <= i_button;
        end

        else
            cnt <= 0;
    end

    assign o_button = prev_state;

endmodule
