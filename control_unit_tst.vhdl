ENTITY control_unit_tst IS
  generic(n: integer := 8);
END control_unit_tst;

ARCHITECTURE t OF control_unit_tst IS
  COMPONENT control_unit IS
    generic(tp: TIME := 5 ns; n: integer := 8);
    port(clk, rst, bgn, q_0, q_m1: in bit;
         c0, c1, c2, c3, c4, c5, c6, stop: out bit);
  END COMPONENT;

  SIGNAL clk_s, rst_s, bgn_s, q_0_s, q_m1_s : bit;
  SIGNAL c0_s, c1_s, c2_s, c3_s, c4_s, c5_s, c6_s, stop_s : bit;

BEGIN

  
  eticheta1: control_unit PORT MAP (clk => clk_s, rst => rst_s, bgn => bgn_s, q_0 => q_0_s, q_m1 => q_m1_s,
                                    c0 => c0_s, c1 => c1_s, c2 => c2_s, c3 => c3_s, c4 => c4_s, c5 => c5_s, c6 => c6_s, stop => stop_s);

  clk_process: PROCESS
  BEGIN
    clk_s <= '0';
    WAIT FOR 50 ns;
    clk_s <= '1';
    WAIT FOR 50 ns;
  END PROCESS;

 
  rst_s <= '0', '1' AFTER 10 ns;
  bgn_s <= '1' AFTER 20 ns, '0' AFTER 100 ns, '1' AFTER 2700 ns, '0' AFTER 2800 ns;
  q_0_s <= '0', '1' AFTER 2700 ns;
  q_m1_s <= '1', '0' AFTER 2700 ns;
  
  

END t;


