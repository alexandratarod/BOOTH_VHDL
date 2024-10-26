ENTITY control_unit_tst IS
END control_unit_tst;

ARCHITECTURE t OF control_unit_tst IS
    COMPONENT control_unit
        generic(tp:TIME:=5ns);
        port(clk, rst_b, bgn, q_0, q_m1, count7: in bit;
             c0, c1, c2, c3, c4, c5, c6, stop: out bit);
    END COMPONENT;
    SIGNAL clk_s, rst_b_s, bgn_s, q_0_s, q_m1_s, count7_s: bit := '0';
    SIGNAL c0_s, c1_s, c2_s, c3_s, c4_s, c5_s, c6_s, stop_s: bit;
    CONSTANT tp : TIME := 5 ns;
    
BEGIN
   
    eticheta1: control_unit PORT MAP(
            clk => clk_s, rst_b => rst_b_s, bgn => bgn_s, q_0 => q_0_s, q_m1 => q_m1_s, count7 => count7_s,
            c0 => c0_s, c1 => c1_s, c2 => c2_s, c3 => c3_s, c4 => c4_s, c5 => c5_s, c6 => c6_s, stop => stop_s);
    
  PROCESS
  BEGIN
    clk_s <= '0'; 
    wait for 50 ns;
    clk_s <= '1'; 
    wait for 50 ns;
  END PROCESS;

  rst_b_s <= '0' after 0 ns, '1' after 50 ns;
  bgn_s <= '0' after 0 ns, '1' after 100 ns, '0' after 200 ns;

  q_0_s <= '0' after 100 ns, '1' after 200 ns, '0' after 300 ns;
  q_m1_s <= '1' after 100 ns, '0' after 200 ns, '1' after 300 ns;
  count7_s <= '0' after 150 ns, '1' after 250 ns, '0' after 350 ns;

END t;

