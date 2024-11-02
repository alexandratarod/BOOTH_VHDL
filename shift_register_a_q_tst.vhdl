ENTITY shift_register_a_q_tst IS	
	generic( n: integer:=8);
END shift_register_a_q_tst;

ARCHITECTURE t OF shift_register_a_q_tst IS
  COMPONENT shift_register_a_q IS
  generic(tp: time := 5 ns; n: integer := 8);
  port(
      data_in: in bit_vector(n-1 downto 0);
      load_a, load_q, shift, clk, rst: in bit;                  
      data_out: out bit_vector(2*n downto 0) 
  );
  END COMPONENT;
  signal data_in_s: bit_vector(7 downto 0);
  signal data_out_s: bit_vector(16 downto 0);
  signal load_a_s, load_q_s, shift_s, clk_s, rst_s: bit;
  
BEGIN
  
  eticheta1: shift_register_a_q  PORT MAP ( data_in => data_in_s, load_a => load_a_s, load_q => load_q_s, shift => shift_s, clk => clk_s, rst => rst_s, data_out => data_out_s);
	
	PROCESS
  BEGIN
    clk_s <= '0'; 
    wait for 50 ns;
    clk_s <= '1'; 
    wait for 50 ns;
  END PROCESS;
  
  rst_s <= '0' AFTER 10 ns,
           '1' AFTER 25 ns;

  
               
  data_in_s <= "00000001" AFTER 0 ns, 
               "00000001" AFTER 25 ns, 
               "00000100" AFTER 300 ns, 
               "11110111" AFTER 400 ns;
               

  load_q_s <= '0' AFTER 0 ns, 
            '1' AFTER 50 ns,
            '0' AFTER 100 ns, 
            '1' AFTER 350 ns,
            '0' AFTER 400 ns;
            
            
  load_a_s <= '0' AFTER 0 ns, 
            '1' AFTER 150 ns,
            '0' AFTER 200 ns, 
            '1' AFTER 450 ns,
            '0' AFTER 500 ns; 
            

  shift_s <= '0' AFTER 0 ns, 
             '1' AFTER 250 ns,
             '0' AFTER 300 ns,  
             '1' AFTER 550 ns,
             '0' AFTER 600 ns;

END t;
