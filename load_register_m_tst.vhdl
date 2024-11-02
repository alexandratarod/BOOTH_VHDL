ENTITY load_register_m_tst IS	
	generic( n: integer:=8);
END load_register_m_tst;

ARCHITECTURE t OF load_register_m_tst IS
  COMPONENT load_register_m IS
  generic(tp: time := 5 ns; n: integer := 8);
  port(
      data_in: in bit_vector(n-1 downto 0);
      load, clk, rst: in bit;                  
      data_out: out bit_vector(n-1 downto 0));
  END COMPONENT;
  signal data_in_s, data_out_s: bit_vector(7 downto 0);
  signal load_s, clk_s, rst_s: bit;
  
BEGIN
  
  eticheta1: load_register_m  PORT MAP ( data_in => data_in_s, load => load_s, clk => clk_s, rst => rst_s, data_out => data_out_s);
	
	PROCESS
  BEGIN
    clk_s <= '0'; 
    wait for 50 ns;
    clk_s <= '1'; 
    wait for 50 ns;
  END PROCESS;
  
  rst_s <= '0' AFTER 10 ns,
           '1' AFTER 40 ns;
  

  data_in_s <= "00000001" AFTER 0 ns, 
               "00000001" AFTER 50 ns, 
               "00000100" AFTER 200 ns, 
               "11110111" AFTER 400 ns,
               "11110101" AFTER 600 ns;

  load_s <= '0' AFTER 0 ns, 
            '1' AFTER 50 ns,
            '0' AFTER 250 ns,
            '1' AFTER 500 ns;

END t;
