ENTITY control_unit IS
  generic(tp:TIME:=5ns);
  port(clk, rst_b, bgn, q_0, q_m1, count7: in bit;
       c0, c1, c2, c3, c4, c5, c6, stop: out bit);
END control_unit;

ARCHITECTURE control_unit_architecture OF control_unit IS
  TYPE states IS (S0, S1, S2, S3, S4, S5, S6, S7, S8, S9);
  SIGNAL present_state, next_state: states:=S0;

BEGIN
  
proc_clock: PROCESS(clk)
BEGIN
	IF clk='0' AND clk'EVENT THEN
		present_state <= next_state;
	END IF;
END PROCESS proc_clock;

avansare_stare: PROCESS (present_state, bgn, q_0, q_m1, count7) 
	--VARIABLE count: integer:=0;
BEGIN
    case present_state is
      when S0 =>
        if bgn = '1' then
          next_state <= S1;
        else
          next_state <= S0;
        end if;

      when S1 =>
        c0 <= '1' after tp;
        next_state <= S2;
        
      when S2 =>
        c1 <= '1' after tp;
        c0 <= '0' after tp;
        next_state <= S3;

      when S3 =>
        c1 <= '0' after tp;
        c4 <= '0' after tp;
        
        if (q_0 = '0' and q_m1 = '1') then
          next_state <= S4;
        elsif (q_0 = '1' and q_m1 = '0') then
          next_state <= S5;
        else
          next_state <= S6;
        end if;

      when S4 =>
        c2 <= '1' after tp;
        c1 <= '0' after tp;
        next_state <= S6;

      when S5 =>
        c2 <= '1' after tp;
        c3 <= '1' after tp;
        --c1 <= '0' after tp;
        next_state <= S6;

      when S6 =>
        c4 <= '1' after tp;
        c2 <= '0' after tp;
        c3 <= '0' after tp;
        if count7 = '0' then
          next_state <= S3;
        else
          next_state <= S7;
        end if;

      when S7 =>
        c5 <= '1' after tp;
        c4 <= '0' after tp;
        next_state <= S8;

      when S8 =>
        c6 <= '1' after tp;
        c5 <= '0' after tp;
        next_state <= S9;

      when S9 =>
        stop <= '1' after tp;
        c6 <= '0' after tp;
        next_state <= S0;

      when others =>
        next_state <= S0; 
    end case;
    
  END PROCESS;

END control_unit_architecture;

