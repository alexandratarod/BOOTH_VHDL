ENTITY shift_register_tst IS	
	generic( n: integer:=17);
END shift_register_tst;

ARCHITECTURE t OF shift_register_tst IS
  COMPONENT shift_register IS
  generic(tp: time := 5 ns; n: integer := 17);
  port(
      data_in: in bit_vector(n-1 downto 0);
      load, shift, clk: in bit;                  
      data_out: out bit_vector(n-1 downto 0));
  END COMPONENT;
  signal data_in_s, data_out_s: bit_vector(16 downto 0);
  signal load_s, shift_s, clk_s: bit;
  
BEGIN
  
  eticheta1: shift_register  PORT MAP ( data_in => data_in_s, load => load_s, shift => shift_s, clk => clk_s, data_out => data_out_s);
	
	PROCESS
  BEGIN
    clk_s <= '0'; 
    wait for 50 ns;
    clk_s <= '1'; 
    wait for 50 ns;
  END PROCESS;

  --test pentru cazul in care consideram registrii A, Q si Q[-1] un singur registru pe care il shiftam
  data_in_s <= "00000000000000000" AFTER 0 ns, 
               "00000000000000001" AFTER 50 ns, 
               "00000000000000100" AFTER 200 ns, 
               "11110101000000000" AFTER 400 ns;

  load_s <= '0' AFTER 0 ns, 
            '1' AFTER 50 ns,
            '0' AFTER 100 ns, 
            '1' AFTER 250 ns,
            '0' AFTER 300 ns, 
            '1' AFTER 450 ns,
            '0' AFTER 500 ns;

  shift_s <= '0' AFTER 0 ns, 
             '1' AFTER 150 ns,
             '0' AFTER 200 ns, 
             '1' AFTER 350 ns,
             '0' AFTER 400 ns, 
             '1' AFTER 550 ns,
             '0' AFTER 600 ns;

END t;
	
