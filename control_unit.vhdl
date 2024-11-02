ENTITY control_unit IS
  generic(tp:TIME:=5ns; n: integer:=8);
  port(clk, rst, bgn, q_0, q_m1: in bit;
       c0, c1, c2, c3, c4, c5, c6, stop: out bit);
END control_unit;

ARCHITECTURE control_unit_architecture OF control_unit IS
  TYPE states IS (S0, S1, S2, S3, S4, S5, S6, S7, S8, S9);
  SIGNAL present_state, next_state: states:=S0;

BEGIN
  
proc_clock: PROCESS(clk)
BEGIN
	IF clk='1' AND clk'EVENT THEN
		present_state <= next_state;
	END IF;
END PROCESS proc_clock;

avansare_stare: PROCESS (present_state, bgn, q_0, q_m1) 
	VARIABLE count: integer:=0;
BEGIN
    case present_state is
      when S0 =>
        stop <= '0' after tp;
        if bgn = '1' then
          next_state <= S1;
        else
          next_state <= S0;
        end if;

      when S1 => --A=0, Q[-1]=0, COUNT=0, M=INBUS
        count:=0;
        c0 <= '1' after tp;
        next_state <= S2;
        
      when S2 => --Q=INBUS
        c0 <= '0' after tp;
        c1 <= '1' after tp;
        next_state <= S3;

      when S3 => --decidem in ce stare vom merge (SCAN)
        c1 <= '0' after tp;
        c4 <= '0' after tp;
        
        if q_0 = '0' and q_m1 = '1' then
          next_state <= S4;
        elsif q_0 = '1' and q_m1 = '0' then
          next_state <= S5;
        else
          next_state <= S6;
        end if;

      when S4 => --A+M
        c1 <= '0' after tp;
        c2 <= '1' after tp;
        next_state <= S6;

      when S5 => --A-M
        c2 <= '1' after tp;
        c3 <= '1' after tp;
        next_state <= S6;

      when S6 => --SHIFT
        c4 <= '1' after tp;
        c2 <= '0' after tp;
        c3 <= '0' after tp;
        count:=count+1;
        if count < 7 then
          next_state <= S3;
        elsif count = 7 then
          next_state <= S7;
        end if;

      when S7 => --OUTBUS = A; Q[0]=0
        c4 <= '0' after tp;
        c5 <= '1' after tp;
        next_state <= S8;

      when S8 => --OUTBUS = Q[7:0]
        c5 <= '0' after tp;
        c6 <= '1' after tp;
        next_state <= S9;

      when S9 => --STOP
        c6 <= '0' after tp;
        stop <= '1' after tp;
        next_state <= S0;

      when others =>
        next_state <= S0; 
    end case;
    
  END PROCESS;

END control_unit_architecture;

