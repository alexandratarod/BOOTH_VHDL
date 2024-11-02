ENTITY shift_register_a_q IS
  generic(tp: time := 5 ns; n: integer := 8);
  port(
      data_in: in bit_vector(n-1 downto 0);
      load_a, load_q, shift, clk, rst: in bit;                  
      data_out: out bit_vector(2*n downto 0) 
  );
END shift_register_a_q;

ARCHITECTURE shift_register_a_q_architecture OF shift_register_a_q IS
  signal register_content: bit_vector(2*n downto 0); 
BEGIN
  PROCESS(clk, rst)
  BEGIN
    if rst='0' then
      register_content <= "00000000000000000";
    elsif clk = '1' then  
      if load_a = '1' then 
        register_content(2*n downto n+1) <= data_in;
      elsif load_q = '1' then
        register_content(n downto 1) <= data_in;
      elsif shift = '1' then
        -- deplasare aritmetica la dreapta
        register_content <= register_content(2*n) & register_content(2*n downto 1);
      end if;
    end if;
  END PROCESS;
  
  data_out <= register_content;

END shift_register_a_q_architecture;
