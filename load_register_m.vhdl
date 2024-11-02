ENTITY load_register_m IS
  generic(tp: time := 5 ns; n: integer := 8);
  port(
      data_in: in bit_vector(n-1 downto 0);
      load, clk, rst: in bit;                  
      data_out: out bit_vector(n-1 downto 0) 
  );
END load_register_m;

ARCHITECTURE load_register_m_architecture OF load_register_m IS
  signal register_content: bit_vector(n-1 downto 0); 
BEGIN
  PROCESS(clk, rst)
  BEGIN
    
    if rst = '0' then
      register_content <= x"00";
    elsif clk = '1' then  
      if load = '1' then 
        register_content <= data_in;
      end if;
    end if;
  END PROCESS;
  
  data_out <= register_content;

END load_register_m_architecture;
